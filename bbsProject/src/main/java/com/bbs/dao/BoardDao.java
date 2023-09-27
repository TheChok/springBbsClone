package com.bbs.dao;

import java.util.List;
import java.util.Map;

import com.bbs.domain.BoardDto;
import com.bbs.domain.SearchCondition;

public interface BoardDao {
	
	int insert(BoardDto dto) throws Exception;
	BoardDto select(Integer bno) throws Exception;
	int update(BoardDto dto) throws Exception;
    int delete(Integer bno, String writer) throws Exception;
    
    int increaseViewCnt(Integer bno) throws Exception;

    List<BoardDto> selectPage(Map map) throws Exception;
    List<BoardDto> selectAll() throws Exception;
    int deleteAll() throws Exception;
    int count() throws Exception;

    List<BoardDto> searchSelectPage(SearchCondition sc) throws Exception;
    int searchResultCnt(SearchCondition sc) throws Exception;
    
    int updateCommentCnt(Integer bno, int cnt);
}
