package kr.co.hn.util;

import java.sql.Connection;
import java.sql.Statement;

public class JDBCClose {
	public static void close(Connection conn, Statement pstmt) { // PreparedStatement는 Statement를 상속받기 때문에 묵시적 형변환

		// 5단계 : 자원해제
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if(conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
	
}
