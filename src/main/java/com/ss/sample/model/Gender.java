package com.ss.sample.model;

import java.util.stream.Stream;

public enum Gender {
    MALE('M'),
    FEMALE('F');

    private char genderValue;
    Gender(char g) {
        this.genderValue = g;
    }

    public char getGender() {
        return this.genderValue;
    }

    public static Gender getType(char value) {
        return Stream.of(Gender.values())
//                .filter(g -> g.getGender() == value)
                .filter(g -> g.getGender() == value)
                .findAny()
                .orElse(MALE);
    }
}
