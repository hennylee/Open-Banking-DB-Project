package kr.co.hn.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.co.hn.util.ConnectionFactory;
import kr.co.hn.vo.AccountVO;
import kr.co.hn.vo.TransactionVO;

public class TransferDAO {
	
	// 거래 내역 전체 조회
	public List<TransactionVO> selectAll(String account) {
		List<TransactionVO> list = new ArrayList<>();
		
		StringBuilder sql = new StringBuilder();
		sql.append("select MY_BALANCE, TARGET_NAME, TRANS_DATE, TRANS_AMOUNT, TRANS_TYPE ");
		sql.append(" from HN_TRANSACTION where MY_ACCOUNT = ? order by trans_no desc ");
		
		
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		){
			
			pstmt.setString(1, account);

			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				TransactionVO vo = new TransactionVO();
				
				int myBalance = rs.getInt("MY_BALANCE");
				String targetName = rs.getString("TARGET_NAME");
				String transDate =  rs.getString("TRANS_DATE");
				int transAmount = rs.getInt("TRANS_AMOUNT");
				String transType = rs.getString("TRANS_TYPE");
				
				vo.setMyBalance(myBalance);
				vo.setTargetName(targetName);
				vo.setTransDate(transDate);
				vo.setTransAmount(transAmount);
				vo.setTransType(transType);
				
				list.add(vo);
				
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	
	
	// 계좌 이체
	public boolean transfer(TransactionVO vo) {

		boolean isSuccess = false;

		try (Connection conn = new ConnectionFactory().getConnection();
				// 상대 계좌 , 출금금액, 상대 은행코드, 상대 이름, 내 계좌
				CallableStatement cs = conn.prepareCall("{call executePro(?, ?, ?, ?, ?, ?)}")
		) {
			
			int loc = 1;
			cs.setString(loc++, vo.getTargetAccount());
			cs.setInt(loc++, vo.getTransAmount());
			cs.setString(loc++, vo.getTargetBank());
			cs.setString(loc++, vo.getTargetName());
			cs.setString(loc++, vo.getMyAccount());
			cs.registerOutParameter(loc++, java.sql.Types.NUMERIC); 
            
            int count = cs.executeUpdate(); //실행
            int rtn = cs.getInt(6); //프로시저 실행후 OUT매개변수를 통해 반환되는값 가져오기
            System.out.println(count);
            System.out.println(rtn);
            if(rtn == 0){
            	isSuccess = true;
                System.out.println("성공!!!!!!");
            }else{
                System.out.println("실패!!!!!!");
            }
            

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return isSuccess;

	}

	// 계좌 비번 확인
	public int checkPassword(AccountVO vo) {
		int result = -1;
		String sql = "select count(*) from hn_account where account = ? and password = ? ";

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {

			int loc = 1;
			pstmt.setString(loc++, vo.getAccount());
			pstmt.setInt(loc++, vo.getPassword());

			ResultSet rs = pstmt.executeQuery();

			rs.next();
			result = rs.getInt(1);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;

	}

	
	
	
	
	public StringBuilder getAccountQuery(String bankCode) {
	      StringBuilder sql = new StringBuilder();
	      System.out.println(bankCode);
	      switch (bankCode) {
	      case "1000":
	         sql.append(" select holder name , type, bank from account@BANKER_BANK where anum= ? ");
	         break;
	      case "2000":
	         sql.append(" select name, product_name, bank_code from account@CM_BANK ");
	         sql.append(" where account_num = ? ");
	         break;
	      case "3000":
	         sql.append(" select b.name name, c.type, a.bank_code from hn_account a, hn_member b, hn_acnt_type c ");
	          sql.append( " where a.account= ? and a.member_id = b.id and a.Type_code = c.code ");
	         break;
	      case "4000":
	         sql.append(" select b.user_name name, a.acc_type, substr(a.acc_num,1,4) as bank_code ");
	         sql.append("  from t_account@YB_BANK a, t_member@YB_BANK b where a.acc_num = ? and a.user_id = b.user_id " );
	         break;
	      }
	      
	      return sql;
	   }
	
	
	
	
	
	
	
	
	
	
	
	// 상대 계좌 존재 여부 확인 & 상대 계좌주명 확인
	public String inquiryHolder(AccountVO vo) {
		String holder = "";
		StringBuilder sql = getAccountQuery(vo.getBankCode());
		


		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		) {

			pstmt.setString(1, vo.getAccount());

			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				holder = rs.getString("name");
				System.out.println("holder : " + holder);
			};
			

		} catch (Exception e) {
			e.printStackTrace();
		}

		return holder;
	}
}
