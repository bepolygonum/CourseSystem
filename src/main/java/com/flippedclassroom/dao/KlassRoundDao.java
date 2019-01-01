package com.flippedclassroom.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * @author DELL
 */
@Repository
public interface KlassRoundDao {

    void updateKlassRoundByRoundIdKlassId(@Param("0")int klassId,@Param("1")int roundId,@Param("2")int enrollNumber);

}
