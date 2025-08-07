package com.example.basic.dto;

import lombok.Getter;

@Getter
public class MemoResponseDto {
    private final Long id;
    private final String content;
    private final String author;

    public MemoResponseDto(Long id, String content, String author) {
        this.id = id;
        this.content = content;
        this.author = author;
    }
}
