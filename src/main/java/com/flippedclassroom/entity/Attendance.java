package com.flippedclassroom.entity;

/**
 * @author KEKE
 */
public class Attendance {
    private  int id;
    private  int klassSeminarId;
    private  int teamId;
    private  int teamOrder;
    private Boolean isPresent;
    private String reportName;
    private String reportUrl;
    private String pptName;
    private String pptUrl;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getKlassSeminarId() {
        return klassSeminarId;
    }

    public void setKlassSeminarId(int klassSeminarId) {
        this.klassSeminarId = klassSeminarId;
    }

    public int getTeamId() {
        return teamId;
    }

    public void setTeamId(int teamId) {
        this.teamId = teamId;
    }

    public int getTeamOrder() {
        return teamOrder;
    }

    public void setTeamOrder(int teamOrder) {
        this.teamOrder = teamOrder;
    }

    public Boolean getPresent() {
        return isPresent;
    }

    public void setPresent(Boolean present) {
        isPresent = present;
    }

    public String getReportName() {
        return reportName;
    }

    public void setReportName(String reportName) {
        this.reportName = reportName;
    }

    public String getReportUrl() {
        return reportUrl;
    }

    public void setReportUrl(String reportUrl) {
        this.reportUrl = reportUrl;
    }

    public String getPptName() {
        return pptName;
    }

    public void setPptName(String pptName) {
        this.pptName = pptName;
    }

    public String getPptUrl() {
        return pptUrl;
    }

    public void setPptUrl(String pptUrl) {
        this.pptUrl = pptUrl;
    }
}
