package com.yxb.common.entity;

import java.util.List;

public class Page<T> {
    private List<T> data;
    private Integer totalSize;
    private Integer totalNo;
    private Integer pageNo;
    private Integer pageSize;

    public List<T> getData() {
        return data;
    }

    public void setData(List<T> data) {
        this.data = data;
    }

    public Integer getTotalSize() {
        return totalSize;
    }

    public void setTotalSize(Integer totalSize) {
        this.totalSize = totalSize;
    }

    public Integer getTotalNo() {
        return totalNo;
    }

    public void setTotalNo(Integer totalSize , Integer pageSize) {
        if (totalSize % pageSize == 0) this.totalNo = totalSize / pageSize;
        else this.totalNo = totalSize / pageSize + 1;
    }

    public Integer getPageNo() {
        return pageNo;
    }

    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }
}
