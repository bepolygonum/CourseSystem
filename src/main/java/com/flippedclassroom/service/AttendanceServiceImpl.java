package com.flippedclassroom.service;

import com.flippedclassroom.dao.AttendanceDao;
import com.flippedclassroom.dao.CourseMemberLimitStrategyDao;
import com.flippedclassroom.entity.Attendance;
import com.flippedclassroom.entity.CourseMemberLimitStrategy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author KEKE
 */
@Service(value = "AttendanceService")
public class AttendanceServiceImpl{
    @Autowired
    AttendanceDao attendanceDao;

    public List<Attendance> getAttendanceByklassSeminarId(int klassSeminarId) {
        return attendanceDao.getAttendanceByKlassSeminarId(klassSeminarId);
    }
}
