package com.example.basic.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.basic.entity.Member;

public interface MemberRepository extends JpaRepository<Member, Long> {
}