package com.example.basic.dto;

import com.example.basic.entity.User;
import lombok.Getter;

@Getter
public class UserResponseDto {
    private Long id;
    private String name;

    public UserResponseDto(Long id, String name) {
        this.id = id;
        this.name = name;
    }

    public UserResponseDto(User user) {
        this.id = user.getId();
        this.name = user.getName();
    }
}
