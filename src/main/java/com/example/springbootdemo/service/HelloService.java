package com.example.springbootdemo.service;

import org.springframework.stereotype.Service;

@Service
public class HelloService {

    public String getGreeting() {
        return "Hello from the service layer!";
    }
}
