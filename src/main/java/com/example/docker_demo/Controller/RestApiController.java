package com.example.docker_demo.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RestApiController {

    @GetMapping("/hello")
    public String sayHello() {
        return "Hello, It is working, and indeed it is";
    }

}