package com.yxb.dispacher.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DispacherController {

	@RequestMapping("/toLogin.do")
	public String toLogin() {
		return "login";
	}

	@RequestMapping("/toIndex.do")
	public  String toIndex(){
        return  "index";
    }
}
