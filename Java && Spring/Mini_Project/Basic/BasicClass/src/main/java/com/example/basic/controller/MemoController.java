package com.example.basic.controller;

import com.example.basic.dto.MemoRequestDto;
import com.example.basic.dto.MemoResponseDto;
import com.example.basic.service.MemoService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/memos")
public class MemoController {

    private final MemoService memoService;

    @PostMapping
    public MemoResponseDto create(@RequestBody MemoRequestDto requestDto) {
        return memoService.save(requestDto);
    }

    @GetMapping
    public List<MemoResponseDto> getAll() {
        return memoService.findAll();
    }

    @GetMapping("/{id}")
    public MemoResponseDto getOne(@PathVariable Long id) {
        return memoService.findOne(id);
    }

    @PutMapping("/{id}")
    public MemoResponseDto update(@PathVariable Long id, @RequestBody MemoRequestDto requestDto) {
        return memoService.update(id, requestDto);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        memoService.delete(id);
    }
}
