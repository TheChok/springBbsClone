package com.bbs;

import java.sql.Connection;
import java.sql.DriverManager;

import org.springframework.beans.factory.annotation.Autowired;

import com.bbs.dao.BoardDao;


// MultiTester //
public class MultiTester {
	@Autowired
    private static BoardDao boardDao;
	
	// main //
	public static void main(String[] args) {
		// 데이터베이스 연결 상태 확인 
		
		Test1();
		
		
	} // End - main
	
	
	// Test - DB Connection//
	private static void Test1() {
		try {
			String dbURL 		= "jdbc:mysql://localhost:3305/springbasic?serverTimezone=UTC";
			String dbID 		= "castello";
			String dbPassword 	= "1q2w3e4r!";
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			Connection conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
			System.out.println(conn);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
} // End - MultiTester