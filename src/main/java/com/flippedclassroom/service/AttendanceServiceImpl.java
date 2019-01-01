package com.flippedclassroom.service;

import com.flippedclassroom.dao.AttendanceDao;
import com.flippedclassroom.dao.CourseMemberLimitStrategyDao;
import com.flippedclassroom.entity.Attendance;
import com.flippedclassroom.entity.CourseMemberLimitStrategy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
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

    public Attendance getAttendanceByKlassSeminarIdAndTeamId(int id, int teamid) {
        return attendanceDao.getAttendanceByKlassSeminarIdAndTeamId(id,teamid);
    }

    public void upload(MultipartFile file, int klassSeminarId, int teamId,String type) {
        if(file.isEmpty()){
            return ;
        }
        String fileName = file.getOriginalFilename();
        String path = "D:\\\\test\\\\"+type+ "\\\\" + fileName ;
        File dest = new File(path);
        if(!dest.getParentFile().exists()){
            //判断文件父目录是否存在
            dest.getParentFile().mkdir();
        }
        try {
            file.transferTo(dest);
            if(type.equals("PPT")) {
                attendanceDao.uploadPPT(path ,fileName, klassSeminarId, teamId);
            }
            else {
                attendanceDao.uploadReport(path ,fileName,klassSeminarId,teamId);
            }
            //保存文件
            return ;
        } catch (IllegalStateException e) {
            e.printStackTrace();
            return;
        } catch (IOException e) {
            e.printStackTrace();
            return ;
        }

    }
}
