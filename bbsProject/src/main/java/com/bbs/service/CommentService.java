package com.bbs.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.bbs.domain.CommentDto;

public interface CommentService {
	// 댓글 작성
	@Transactional(rollbackFor = Exception.class)
	int write(CommentDto commentDto) throws Exception;
	// 댓글 조회(All)
	List<CommentDto> getList(Integer bno) throws Exception;
	// 댓글 조회
	CommentDto read(Integer cno) throws Exception;
	// 댓글 수정
	int modify(CommentDto commentDto) throws Exception;
	// 댓글 삭제
	@Transactional(rollbackFor = Exception.class)
	int remove(Integer cno, Integer bno, String commenter) throws Exception;
	// 댓글 갯수 조회
	int getCount(Integer bno) throws Exception;

}