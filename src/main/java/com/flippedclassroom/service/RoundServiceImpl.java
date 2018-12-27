package com.flippedclassroom.service;

import com.flippedclassroom.dao.*;
import com.flippedclassroom.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @author KEKE
 */
@Service(value = "RoundService")
public class RoundServiceImpl  {
    @Autowired
    RoundDao roundDao;
    @Autowired
    RoundScoreDao roundScoreDao;
    @Autowired
    SeminarDao seminarDao;

    public List<RoundScore> getRoundScoreByCourseID(int courseId)
    {
        //根据课程id获得所有rounds
        List<Round> rounds = roundDao.getRoundByCourseID(courseId);
        //所有rounds的id集合
        List<Integer> roundIds=rounds.stream().map(Round::getId).collect(Collectors.toList());
        //某课程下所有rounds的成绩
        List<RoundScore> roundScores=roundScoreDao.getRoundScoreByRoundID(roundIds);
        return roundScores;
    }

    public List<Round> getRoundByCourseID(int courseId)
    {
        return roundDao.getRoundByCourseID(courseId);
    }


    public List<Seminar>  getSeminarByRoundID(List<Integer> roundIds,int courseId)
    {
        List<Seminar> seminars=seminarDao.getSeminarByRoundID(roundIds,courseId);
        //List<Integer> seminarIds=seminars.stream().map(Seminar::getId).collect(Collectors.toList());//某课程下所有seminar的id
        return seminars;
    }

}
