package com.example.basic.controller;

import com.example.basic.dto.MemberRequestDto;
import com.example.basic.dto.MemberResponseDto;
import com.example.basic.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/members")
public class MemberController {

    private final MemberService memberService;

    @PostMapping
    public MemberResponseDto create(@RequestBody MemberRequestDto memberRequestDto) {
        return memberService.save(memberRequestDto);
    }

    @GetMapping
    public List<MemberResponseDto> getAll() {
        return memberService.findAll();
    }

    @GetMapping("/{id}")
    public MemberResponseDto getOne(@PathVariable Long id) {
        return memberService.findOne(id);
    }

    @PutMapping("/{id}")
    public MemberResponseDto update(@PathVariable Long id, @RequestBody MemberRequestDto memberRequestDto) {
        return memberService.update(id, memberRequestDto);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        memberService.delete(id);
    }
}