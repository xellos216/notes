package com.example.basic.service;

import com.example.basic.dto.MemoRequestDto;
import com.example.basic.dto.MemoResponseDto;
import com.example.basic.entity.Memo;
import com.example.basic.repository.MemoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MemoService {
    private final MemoRepository memoRepository;

    @Transactional
    public MemoResponseDto save(MemoRequestDto requestDto) {
        Memo saved = memoRepository.save(new Memo(requestDto.getContent(), requestDto.getAuthor()));
        return new MemoResponseDto(saved.getId(), saved.getContent(), saved.getAuthor());
    }

    @Transactional(readOnly = true)
    public List<MemoResponseDto> findAll() {
        return memoRepository.findAll().stream()
                .map(m -> new MemoResponseDto(m.getId(), m.getContent(), m.getAuthor()))
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public MemoResponseDto findOne(Long id) {
        Memo memo = memoRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("해당 메모 ID 없음"));
        return new MemoResponseDto(memo.getId(), memo.getContent(), memo.getAuthor());
    }

    @Transactional
    public MemoResponseDto update(Long id, MemoRequestDto requestDto) {
        Memo memo = memoRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("해당 메모 ID 없음"));
        memo.update(requestDto.getContent(), requestDto.getAuthor());
        return new MemoResponseDto(memo.getId(), memo.getContent(), memo.getAuthor());
    }

    @Transactional
    public void delete(Long id) {
        if (!memoRepository.existsById(id)) {
            throw new IllegalArgumentException("해당 메모 ID 없음");
        }
        memoRepository.deleteById(id);
    }
}
