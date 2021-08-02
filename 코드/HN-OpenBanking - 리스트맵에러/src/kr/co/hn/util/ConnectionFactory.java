package kr.co.hn.util;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * 드라이버 로딩, db접속, 연결객체 반환한다.
 * url, user, pw 정보가 변경되었을때 수정이 용이하도록 구성한 것이다.
 * @author HP
 *
 */
public class ConnectionFactory {
	public Connection getConnection() {
		
		Connection conn = null;
		
		try {
			// 1단계
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// 2단계
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "hr";
			String pw = "happy";
			
			conn = DriverManager.getConnection(url,user,pw);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
					
		return conn;
	}
}
