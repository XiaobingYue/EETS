package com.yxb.common.constant;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * 常量类
 * Created by yxb on 2018/4/28
 */
public class Const {

    /**
     * 未删除
     */
    public static final String ENABLE_1 = "1";

    /**
     * 已删除
     */
    public static final String UNENABLE_0 = "0";

    public static final String USER_COLUMN_HEADER_ACCOUNT = "账号";

    public static final String USER_COLUMN_HEADER_NAME = "姓名";

    public static final String USER_COLUMN_HEADER_EMAIL = "邮箱";

    public static final String USER_COLUMN_HEADER_SEX = "性别";

    public static final String USER_COLUMN_HEADER_PHONE = "手机号";

    /**
     * 性别：男
     */
    public static final String USER_SEX_MAN_1 = "1";

    /**
     * 性别：女
     */
    public static final String USER_SEX_WOMAN_0 = "0";

    public static final String UPLOAD_SYLLABUS_PATH = "/upload/syllabus";

    public static final String TEACH_TASK_CREATED = "1";

    public static final String TEACH_TASK_RELEASED = "2";

    public static final String TEACH_TASK_DELETED = "0";

    /**
     * 角色教师id
     */
    public static final Integer TEACHER_ROLE_ID = 9;

    /**
     * 学生ID
     */
    public static final Integer STUDENT_ROLE_ID = 5;

    /**
     * 角色教学副院长id
     */
    public static final Integer VICE_DEAN_OF_TEACHING = 14;

    public static final String EXAM_STATE_1 = "1";

    public static final String EXAM_STATE_2 = "2";

    public static final String EXAM_STATE_3 = "3";

    public static final String EXAM_STATE_4 = "4";

    public static final String EXAM_STATE_5 = "5";

    public static final Integer DEFAULT_STAFF_ROOM_ID = 1;


    public static void main (String[] args) throws ParseException {
       File file = new File("E:\\demo\\11");
       if(file.exists()) {
           System.out.println("file exists");
       } else {
           file.mkdirs();
       }
    }
}
