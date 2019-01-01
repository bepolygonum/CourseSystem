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
    }
}
