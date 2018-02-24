package com.yxb.dispacher.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DispacherController {

	@RequestMapping("/toindex.do")
	public String dologin() {
		return "index";
	}
}
