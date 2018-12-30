package com.flippedclassroom.entity;

public class TeamStrategy {
    private int courseId;
    private int strategySerial;
    private String strategyName;
    private int strategyId;

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public int getStrategySerial() {
        return strategySerial;
    }

    public void setStrategySerial(int strategySerial) {
        this.strategySerial = strategySerial;
    }

    public String getStrategyName() {
        return strategyName;
    }

    public void setStrategyName(String strategyName) {
        this.strategyName = strategyName;
    }

    public int getStrategyId() {
        return strategyId;
    }

    public void setStrategyId(int strategyId) {
        this.strategyId = strategyId;
    }
}
