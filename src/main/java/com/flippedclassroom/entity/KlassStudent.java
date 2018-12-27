package com.flippedclassroom.entity;

/**
 * @author KEKE
 * teamId无用
 */
public class KlassStudent {
    private int klassId;
    private int studentId;
    private int courseId;

    private int teamId;


    public int getKlassId() {
        return klassId;
    }

    public void setKlassId(int klassId) {
        this.klassId = klassId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public int getTeamId() {
        return teamId;
    }

    public void setTeamId(int teamId) {
        this.teamId = teamId;
    }


}
