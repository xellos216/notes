package com.example.basic.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@NoArgsConstructor
public class Memo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String content;

    private String author;

    public Memo(String content, String author) {
        this.content = content;
        this.author = author;
    }

    public void update(String content, String author) {
        this.content = content;
        this.author = author;
    }
}
