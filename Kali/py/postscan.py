#!/usr/bin/env python3
import argparse
import csv
import os
import socket
from concurrent.futures import ThreadPoolExecutor, as_completed
from datetime import datetime

DEFAULT_PORTS = "20-1024"


def identify_service(port, banner):
    b = (banner or "").lower()
    port_map = {
        22: "ssh",
        21: "ftp",
        23: "telnet",
        25: "smtp",
        80: "http",
        443: "https",
        3306: "mysql",
        5432: "postgresql",
        6379: "redis",
        11211: "memcached",
        27017: "mongodb",
    }
    if port in port_map:
        base = port_map[port]
    else:
        base = None

    if "ssh" in b or "openssh" in b:
        svc = "ssh"
    elif any(x in b for x in ("http/", "apache", "nginx", "tp-link", "router", "http")):
        svc = "http"
    elif "smtp" in b:
        svc = "smtp"
    elif "mysql" in b:
        svc = "mysql"
    elif "postgres" in b:
        svc = "postgresql"
    elif "redis" in b:
        svc = "redis"
    elif "memcached" in b:
        svc = "memcached"
    elif "mongodb" in b or "mongo" in b:
        svc = "mongodb"
    elif "ftp" in b:
        svc = "ftp"
    elif "imap" in b or "pop3" in b:
        svc = "mail"
    else:
        svc = base or ("unknown" if banner else "unknown")

    return svc


def scan_port(target, port, timeout):
    try:
        with socket.create_connection((target, port), timeout=timeout) as s:
            try:
                s.settimeout(0.5)
                banner = s.recv(1024).decode(errors="ignore").strip()
            except Exception:
                banner = ""
            svc = identify_service(port, banner)
            return port, True, banner, svc
    except Exception:
        return port, False, "", None


def parse_ports(s):
    out = set()
    if not s:
        return []
    for part in s.split(","):
        part = part.strip()
        if not part:
            continue
        if "-" in part:
            a, b = part.split("-", 1)
            try:
                a_i = int(a.strip())
                b_i = int(b.strip())
            except ValueError:
                continue
            if a_i > b_i:
                a_i, b_i = b_i, a_i
            out.update(range(max(1, a_i), min(65535, b_i) + 1))
        else:
            try:
                v = int(part)
            except ValueError:
                continue
            if 1 <= v <= 65535:
                out.add(v)
    return sorted(out)


def clamp_workers(requested):
    cpu = os.cpu_count() or 1
    recommended = max(10, cpu * 100)
    return min(requested, recommended)


def write_csv(path, target, open_ports):
    with open(path, "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["target", "port", "service", "banner"])
        for port, svc, banner in open_ports:
            w.writerow([target, port, svc, banner])


def main():
    p = argparse.ArgumentParser(
        description="Threaded port scanner with simple banner service ID"
    )
    p.add_argument("--target", "-t", required=True, help="target hostname or IP")
    p.add_argument(
        "--ports", "-p", default=DEFAULT_PORTS, help="ports (e.g. 22,80,443 or 1-1024)"
    )
    p.add_argument("--timeout", type=float, default=0.5, help="socket timeout seconds")
    p.add_argument("--workers", type=int, default=100, help="concurrent workers")
    p.add_argument("--out", help="output CSV file to save results")
    args = p.parse_args()

    ports = parse_ports(args.ports)
    if not ports:
        print("[!] No valid ports parsed. Exiting.")
        return

    workers = clamp_workers(args.workers)
    open_ports = []

    start = datetime.now()
    print(
        f"[+] Scanning {args.target} {len(ports)} ports with {workers} workers (timeout={args.timeout})"
    )

    try:
        with ThreadPoolExecutor(max_workers=workers) as ex:
            futures = {
                ex.submit(scan_port, args.target, port, args.timeout): port
                for port in ports
            }
            for fut in as_completed(futures):
                try:
                    port, is_open, banner, svc = fut.result()
                except Exception as e:
                    print(f"[!] Worker exception: {e}")
                    continue
                if is_open:
                    svc_text = svc or "unknown"
                    line = f"[+] {args.target}:{port} open  service={svc_text}"
                    if banner:
                        line += f"  banner: {banner!r}"
                    print(line)
                    open_ports.append((port, svc_text, banner))
    except KeyboardInterrupt:
        print("\n[!] Interrupted by user")
    finally:
        elapsed = datetime.now() - start
        print(f"[+] Done in {elapsed.total_seconds():.2f}s. Open: {len(open_ports)}")
        if args.out:
            try:
                write_csv(args.out, args.target, open_ports)
                print(f"[+] Results saved to {args.out}")
            except Exception as e:
                print(f"[!] Failed to write output file: {e}")


if __name__ == "__main__":
    main()
