package com.example.basic.controller;

import com.example.basic.dto.UserRequestDto;
import com.example.basic.dto.UserResponseDto;
import com.example.basic.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/users")
public class UserController {

    private final UserService userService;

    @PostMapping
    public UserResponseDto create(@RequestBody UserRequestDto requestDto) {
        return userService.save(requestDto);
    }

    @GetMapping
    public List<UserResponseDto> getAll() {
        return userService.findAll();
    }

    @GetMapping("/{id}")
    public UserResponseDto getOne(@PathVariable Long id) {
        return userService.findOne(id);
    }

    @PutMapping("/{id}")
    public UserResponseDto update(@PathVariable Long id, @RequestBody UserRequestDto requestDto) {
        return userService.update(id, requestDto);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        userService.delete(id);
    }
}
