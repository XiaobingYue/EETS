package com.yxb.common.util;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.util.List;

/**
 * Created by yxb on 2018/4/28
 */
public class ExcelUtil {
    private static final Logger log = LoggerFactory.getLogger(ExcelUtil.class);

    public static Sheet parseExcel(MultipartFile file, int sheetNum) throws IOException, InvalidFormatException {
        if (file == null) {
            return null;
        }
        InputStream is = file.getInputStream();
        String version = (file.getOriginalFilename().endsWith(".xls") ? "2003" : "2007");//不同版本适用不同方式解析
        Sheet sheet;
        if("2003".equals(version)){
            POIFSFileSystem fs = new POIFSFileSystem(is);
            HSSFWorkbook wb = new HSSFWorkbook(fs);
            sheet = wb.getSheetAt(sheetNum);
        }else{
            XSSFWorkbook xwb = new XSSFWorkbook(is);
            sheet = xwb.getSheetAt(sheetNum);
        }
        return sheet;
    }

    public static String lrTrim(String str){
        if(StringUtils.isBlank(str)){
            return "";
        }
        return str.replaceAll(" ", "");
    }
}
