package com.yxb.multiManage.entity;

/**
 * 教研室实体
 *
 * Created by yxb on 2018/5/24
 */
public class StaffRoom {

    private Integer id;

    private String name;

    private Integer headerId;

    private String professionIds;

    private Long timestamp;

    private String state;

    private String headerName;

    public String getHeaderName() {
        return headerName;
    }

    public void setHeaderName(String headerName) {
        this.headerName = headerName;
    }

    public Integer getHeaderId() {
        return headerId;
    }

    public void setHeaderId(Integer headerId) {
        this.headerId = headerId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProfessionIds() {
        return professionIds;
    }

    public void setProfessionIds(String professionIds) {
        this.professionIds = professionIds;
    }

    public Long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Long timestamp) {
        this.timestamp = timestamp;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
