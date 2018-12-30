package com.flippedclassroom.dao;

import com.flippedclassroom.entity.KlassSeminar;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
/**
 * @author KEKE
 */
@Repository
public interface KlassSeminarDao {
    /**
     * get KlassSeminarID By KlassIdSeminarID
     * @param klassIds
     * @param seminarIds
     * @return
     */
    List<Integer> getKlassSeminarIDByKlassIdSeminarID(@Param("klassIds") List<Integer> klassIds, @Param("seminarIds") List<Integer> seminarIds);

    /**
     * get KlassSeminar By KlassIdSeminarID
     * @param klassIds
     * @param seminarIds
     * @return
     */
    List<KlassSeminar> getKlassSeminarByKlassIdSeminarID(@Param("klassIds") List<Integer> klassIds, @Param("seminarIds") List<Integer> seminarIds);

    /**
     * get KlassSeminarID By KlassId
     * @param klassId
     * @return
     */
    List getKlassSeminarIDByKlassId(@Param("0") int klassId);

    /**
     * get KlassSeminar By SeminarID
     * @param seminarIds
     * @return
     */
    List<KlassSeminar> getKlassSeminarBySeminarID(List<Integer> seminarIds);

    /**
     * getKlassSeminarRunning
     * @param klassIds
     * @return
     */
    List<KlassSeminar> getKlassSeminarRunning(List klassIds);

    /**
     *  getKlassSeminarByKlassIDSeminarID
     * @param klassId
     * @param seminaeId
     * @return
     */
    int getKlassSeminarByKlassIDSeminarID(@Param("0") int klassId, @Param("1") int seminaeId);
}
