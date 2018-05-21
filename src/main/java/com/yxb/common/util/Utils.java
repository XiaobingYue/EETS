package com.yxb.common.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by yxb on 2018/5/4
 */
public class Utils {

    private static final Logger log = LoggerFactory.getLogger(Utils.class);


    public static void download(String filename, HttpServletRequest request, HttpServletResponse response, String filePath) {
        File file;
        OutputStream os = null;
        BufferedInputStream fin = null;
        try {
            // fileName=new String(fileName.getBytes("gbk"),"iso-8859-1");
            response.setContentType("application/x-msdownload");
            response.setHeader("Content-Disposition", "attachment; filename=" + filename);
            // String downloadPath = filePath;
            file = new File(filePath);
            os = response.getOutputStream();
            // 下载文件
            // 设置响应头和下载保存的文件名
            if (file.exists()) {
                fin = new BufferedInputStream(new FileInputStream(file));
                // 文件太大时内存不能一次读出,要循环
                byte[] b = new byte[2048];// 太大下载慢
                int i;
                while ((i = fin.read(b)) > 0) {
                    os.write(b, 0, i);
                }
                os.flush();
                os.close();
                fin.close();
                os = null;
                fin = null;
            } else {
                response.setContentType("text/plain;charset=UTF-8");
                os.write("<script type=text/javascript>alert('您下载的文件已经不存在，请联系管理员重新上传，\\n请点击确定继续下载！');window.location.href='${APP_PATH}/toMain.do';</script>".getBytes("UTF-8"));
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        } finally {
            try {
                if (os != null) {
                    os.close();
                }
                if (fin != null) {
                    fin.close();
                }
                file = null;
            } catch (Exception e) {
                log.error(e.getMessage(), e);
            }
        }
    }

    /**
     * 按照特定格式获取获取七天的日期
     *
     * @param pattern 日期格式
     * @return List<String>
     */
    public static List<String> getRecentDate(String pattern) {
        List<String> dateList = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date());
            calendar.add(Calendar.DAY_OF_MONTH, -i);
            Date date = calendar.getTime();
            String str = new SimpleDateFormat(pattern).format(date);
            dateList.add(str);
        }
        return dateList;
    }
}
