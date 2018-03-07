package com.yxb.permission.entity;

import java.util.ArrayList;
import java.util.List;

public class Permission {

    private String id;
    private String name;
    private String url;
    private boolean open = true;
    private boolean checked = false;
    public int childSize = 0;
    private List<Permission> children = new ArrayList<Permission>();
    private List<Permission> childNodes = new ArrayList<Permission>();
    private String note;
    private String parentid;
    private String status;
    private String icon;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getParentid() {
        return parentid;
    }

    public void setParentid(String parentid) {
        this.parentid = parentid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isOpen() {
        return open;
    }

    public void setOpen(boolean open) {
        this.open = open;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    public int getChildSize() {
        return childSize;
    }

    public void setChildSize(int childSize) {
        this.childSize = childSize;
    }

    public List<Permission> getChildren() {
        return children;
    }

    public void setChildren(List<Permission> children) {
        this.children = children;
    }

    public List<Permission> getChildNodes() {
        return childNodes;
    }

    public void setChildNodes(List<Permission> childNodes) {
        this.childNodes = childNodes;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }
}
