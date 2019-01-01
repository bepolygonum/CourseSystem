package com.flippedclassroom.service;

import com.flippedclassroom.dao.*;
import com.flippedclassroom.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
    @Autowired
    CourseDao courseDao;

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

    public Round getRoundByRoundID(int roundId) {return roundDao.getRoundByRoundID(roundId);}

    public void updateRoundScoreByRoundIdTeamId(int roundId, int teamId,double totalScore,double preScore,double qaScore,double reportScore)
    {roundScoreDao.updateRoundScoreByRoundIdTeamId(roundId,teamId,totalScore,preScore,qaScore,reportScore);}

    public List<Double> computeModifyScore(Round round,List<SeminarScore> seminarScores,int courseId)
    {
        Course course=courseDao.getCourseByCourseID(courseId);
        List<Double> scores=new ArrayList<>();
        double d=0,presentationScore=0,questionScore=0,reScore=0,totalScore=0;
        if(round.getPresentationScoreMethod()==0)
        {
            for(int i=0;i<seminarScores.size();i++)
            {
                d += seminarScores.get(i).getPresentationScore();
            }
            d =d/seminarScores.size();
            presentationScore = (double) Math.round(d * 10) / 10;d=0;
        }
        else
        {
            for(int i=0;i<seminarScores.size();i++)
            {
                if(seminarScores.get(i).getPresentationScore()>d)
                { d=seminarScores.get(i).getPresentationScore();}
            }
            presentationScore = (double) Math.round(d * 10) / 10;d=0;
        }
        if(round.getQuestionScoreMethod()==0)
        {
            for(int i=0;i<seminarScores.size();i++)
            {
                d += seminarScores.get(i).getQuestionScore();
            }
            d =d/seminarScores.size();
            questionScore = (double) Math.round(d * 10) / 10;d=0;
        }
        else
        {
            for(int i=0;i<seminarScores.size();i++)
            {
                if(seminarScores.get(i).getQuestionScore()>d)
                { d=seminarScores.get(i).getQuestionScore();}
            }
            questionScore = (double) Math.round(d * 10) / 10;d=0;
        }
        if(round.getReportScoreMethod()==0)
        {
            for(int i=0;i<seminarScores.size();i++)
            {
                d += seminarScores.get(i).getReportScore();
            }
            d =d/seminarScores.size();
            reScore = (double) Math.round(d * 10) / 10;d=0;
        }
        else
        {
            for(int i=0;i<seminarScores.size();i++)
            {
                if(seminarScores.get(i).getReportScore()>d)
                { d=seminarScores.get(i).getReportScore();}
            }
            reScore = (double) Math.round(d * 10) / 10;
        }
        double pre=course.getPresentationPercentage()/100.0;
        double qa=course.getQuestionPercentage()/100.0;
        double re=course.getReportPercentage()/100.0;
        totalScore=presentationScore*pre+questionScore*qa+reScore*re;
        totalScore = (double) Math.round(totalScore * 10) / 10;
        scores.add(totalScore);
        scores.add(presentationScore);
        scores.add(questionScore);
        scores.add(reScore);
        return scores;
    }

    public void updateRoundByRoundId(int roundId,int presentationScoreMethod,int reportScoreMethod,int questionScoreMethod)
    {roundDao.updateRoundByRoundId(roundId,presentationScoreMethod,reportScoreMethod,questionScoreMethod);}


}
