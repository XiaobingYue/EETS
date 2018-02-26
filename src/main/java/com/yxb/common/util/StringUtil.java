package com.yxb.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class StringUtil {

	/**
	 * 将指定的日期按照指定格式转换为字符串
	 * @param date
	 * @param format
	 * @return
	 */
	public static String format( Date date, String format ) {
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format(date);
	}
	
	public static String getSystemtime() {
		return format(new Date(), "yyyy-MM-dd HH:mm:ss");
	}
	
	public static boolean isEmpty( String content ) {
		return content == null || "".equals(content.trim());
	}
	
	public static boolean isNotEmpty( String content ) {
		return !isEmpty(content);
	}
}
