package com.example.basic.service;

import com.example.basic.dto.MemberResponseDto;
import com.example.basic.dto.MemberRequestDto;
import com.example.basic.entity.Member;
import com.example.basic.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MemberService {
    private final MemberRepository memberRepository;

    @Transactional
    public MemberResponseDto save(MemberRequestDto requestDto) {
        Member saved = memberRepository.save(new Member(requestDto.getName()));
        return new MemberResponseDto(saved.getId(), saved.getName());
    }

    @Transactional(readOnly = true)
    public List<MemberResponseDto> findAll() {
        return memberRepository.findAll().stream()
                .map(m -> new MemberResponseDto(m.getId(), m.getName()))
                .collect(Collectors.toList());
    }

    @Transactional
    public MemberResponseDto update(Long id, MemberRequestDto requestDto) {
        Member member = memberRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("해당 ID 없음"));

        member.updateName(requestDto.getName());
        return new MemberResponseDto(member.getId(), member.getName());
    }

    @Transactional
    public void delete(Long id) {
        if (!memberRepository.existsById(id)) {
            throw new IllegalArgumentException("해당 ID 없음");
        }
        memberRepository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public MemberResponseDto findOne(Long id) {
        Member member = memberRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("해당 ID 없음"));
        return new MemberResponseDto(member.getId(), member.getName());
    }
}
