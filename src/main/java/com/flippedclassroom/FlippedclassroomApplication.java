package com.flippedclassroom;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @author KEKE
 */
@SpringBootApplication
@MapperScan(basePackages = "com.flippedclassroom.dao")
public class FlippedclassroomApplication {

    public static void main(String[] args) {
        SpringApplication.run(FlippedclassroomApplication.class, args);
    }

}

