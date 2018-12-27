package com.flippedclassroom.entity;

import java.sql.Timestamp;

/**
 * @author KEKE
 */
public class KlassSeminar {
    private int id;
    private int klassId;
    private int seminarId;
    private Timestamp reportDdl;
    private int status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getKlassId() {
        return klassId;
    }

    public void setKlassId(int klassId) {
        this.klassId = klassId;
    }

    public int getSeminarId() {
        return seminarId;
    }

    public void setSeminarId(int seminarId) {
        this.seminarId = seminarId;
    }

    public Timestamp getReportDdl() {
        return reportDdl;
    }

    public void setReportDdl(Timestamp reportDdl) {
        this.reportDdl = reportDdl;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }


}
