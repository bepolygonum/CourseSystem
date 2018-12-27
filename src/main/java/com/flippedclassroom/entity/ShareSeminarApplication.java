package com.flippedclassroom.entity;

/**
 * @author DELL
 */
public class ShareSeminarApplication {
    private int id;
    private int mainCourseId;
    private int subCourseId;
    private int subCourseTeacherId;
    private int status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMainCourseId() {
        return mainCourseId;
    }

    public void setMainCourseId(int mainCourseId) {
        this.mainCourseId = mainCourseId;
    }

    public int getSubCourseId() {
        return subCourseId;
    }

    public void setSubCourseId(int subCourseId) {
        this.subCourseId = subCourseId;
    }

    public int getSubCourseTeacherId() {
        return subCourseTeacherId;
    }

    public void setSubCourseTeacherId(int subCourseTeacherId) {
        this.subCourseTeacherId = subCourseTeacherId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
