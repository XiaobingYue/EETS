package com.yxb.common.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yxb.common.util.Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/downloadController")
public class DownloadController {

	private static final Logger log = LoggerFactory
			.getLogger(DownloadController.class);

	@RequestMapping("/download")
	public void download(String filename, HttpServletRequest request,
			HttpServletResponse response) {
		String exportDir = "download/";
		String path = request.getSession().getServletContext().getRealPath(exportDir);
		String filepath = path + File.separator + filename;
		Utils.download(filename, request, response,filepath);
	}
}
