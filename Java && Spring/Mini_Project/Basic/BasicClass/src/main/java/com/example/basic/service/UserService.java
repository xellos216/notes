package com.example.basic.service;

import com.example.basic.dto.UserRequestDto;
import com.example.basic.dto.UserResponseDto;
import com.example.basic.entity.User;
import com.example.basic.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;

    @Transactional
    public UserResponseDto save(UserRequestDto requestDto) {
        User user = new User(requestDto.getName());
        userRepository.save(user);
        return new UserResponseDto(user.getId(), user.getName());
    }

    @Transactional(readOnly = true)
    public List<UserResponseDto> findAll() {
        return userRepository.findAll().stream()
                .map(u -> new UserResponseDto(u.getId(), u.getName()))
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public UserResponseDto findOne(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new IllegalAccessError("해당 ID 없음"));
        return new UserResponseDto(user.getId(), user.getName());
    }

    @Transactional
    public UserResponseDto update(Long id, UserRequestDto requestDto) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new IllegalAccessError("해당 ID 없음"));

        user.updateName(requestDto.getName());
        return new UserResponseDto(user.getId(), user.getName());
    }

    @Transactional
    public void delete(Long id) {
        if (!userRepository.existsById(id)) {
            throw new IllegalAccessError("해당 ID 없음");
        }
        userRepository.deleteById(id);
    }
}
