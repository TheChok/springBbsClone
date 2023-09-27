package com.bbs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bbs.domain.Person;

@Controller
public class SimpleRestController {
	@GetMapping("/ajax")
    public String ajax() {
        return "ajax";
    }

    @PostMapping("/send")
    @ResponseBody
    public Person test(@RequestBody Person p) {
        System.out.println("p = " + p);
        p.setName("ABC");
        p.setAge(p.getAge() + 10);
        
        return p;
    }
    
    @GetMapping("/test")
    public String test() {
        return "test";
    }
}

/*
@RestController <- Controller 대신 RestController를 넣음.
public class SimpleRestController {

    @PostMapping("/send1")
    // @ResponseBody
    // @Controller 대신 @RestController 어노테이션이 들어가면 @ResponseBody 생략 가능
    public Person test1(@RequestBody Person p) {
        return p;
    }
    
    @PostMapping("/send2")
    public Person test2(@RequestBody Person p) {
    	// jackson-Databind 객체 변환을 위해 @RequestBody는 유지해야 함.
        return p;
    }
}
*/