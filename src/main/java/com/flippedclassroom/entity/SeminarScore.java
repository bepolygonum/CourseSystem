package com.flippedclassroom.entity;

/**
 * @author KEKE
 */
public class SeminarScore {
    private int klassSeminarId;
    private int teamId;
    private double totalScore;
    private double presentationScore;
    private double questionScore;
    private double reportScore;

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

    public double getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(double totalScore) {
        this.totalScore = totalScore;
    }

    public double getPresentationScore() {
        return presentationScore;
    }

    public void setPresentationScore(double presentationScore) {
        this.presentationScore = presentationScore;
    }

    public double getQuestionScore() {
        return questionScore;
    }

    public void setQuestionScore(double questionScore) {
        this.questionScore = questionScore;
    }

    public double getReportScore() {
        return reportScore;
    }

    public void setReportScore(double reportScore) {
        this.reportScore = reportScore;
    }

}
