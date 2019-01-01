package com.flippedclassroom.entity;


public class MemberLimitStrategy{
    private int id;
    private int minMember;
    private int maxMember;
    public boolean isValid(int number){
        if(number>minMember&& number<=maxMember)
            return true;
        else
            return false;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMinMember() {
        return minMember;
    }

    public void setMinMember(int minMember) {
        this.minMember = minMember;
    }

    public int getMaxMember() {
        return maxMember;
    }

    public void setMaxMember(int maxMember) {
        this.maxMember = maxMember;
    }
}
