package kr.co.hn.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.hn.util.ConnectionFactory;
import kr.co.hn.vo.AccountVO;
import kr.co.hn.vo.MemberVO;
import kr.co.hn.vo.TransactionVO;

public class OpenbankDAO {
	
	
	// 오픈뱅킹 등록하기
	public int register(String id, String password) {
		
		int result = -1;
		String sql = "insert into HN_OPEN_REGISTER(member_id, password) values(? , ?)";
		
		try(
			Connection conn = new ConnectionFactory().getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		){

			int loc = 1;
			pstmt.setString(loc++, id);
			pstmt.setString(loc++, password);
			
			result = pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	
	
	// 계좌 이체
	public boolean transfer(TransactionVO vo) {

		boolean isSuccess = false;

		try (Connection conn = new ConnectionFactory().getConnection();
				CallableStatement cs = conn.prepareCall("{call executeOpenPro(?, ?, ?, ?, ?, ?, ?, ?)}")
		) {
			
			/*
			    -- 상대 계좌 , 출금금액, 상대 은행코드, 상대 이름, 내 계좌, 출력값, 내 은행코드, 내 이름
    			executeOpenPro('111111-111111', 3000, '3000', '이해니','100015389838',OUTDATA, '1000', '이해니' );
			 */
			
			
			
			int loc = 1;
			cs.setString(loc++, vo.getTargetAccount());
			cs.setInt(loc++, vo.getTransAmount());
			cs.setString(loc++, vo.getTargetBank());
			cs.setString(loc++, vo.getTargetName());
			cs.setString(loc++, vo.getMyAccount());
			cs.registerOutParameter(loc++, java.sql.Types.NUMERIC); 
			cs.setString(loc++, vo.getMyBank());
			cs.setString(loc++, vo.getMyName());
            
            int count = cs.executeUpdate(); //실행
            int rtn = cs.getInt(6); //프로시저 실행후 OUT매개변수를 통해 반환되는값 가져오기
            
            System.out.println("count : " +count);
            System.out.println("rtn : " + rtn);
            
            if(rtn == 3){
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
	
	
	
	
	
	// 오픈 뱅크 비밀번호 확인하기
	public int checkPassword(String id, String password) {
		int result = -1;
		String sql = "select count(*) from HN_OPEN_REGISTER where MEMBER_ID = ? and PASSWORD = ? ";

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {

			int loc = 1;
			pstmt.setString(loc++, id);
			pstmt.setString(loc++, password);

			ResultSet rs = pstmt.executeQuery();

			rs.next();
			result = rs.getInt(1);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;

	}
	
	

	// 거래 내역 전체 조회
	public List<TransactionVO> selectAll(String account, String bankCode) {
		List<TransactionVO> list = new ArrayList<>();
		
		String sql = "";
		
		switch(bankCode) {
		case("1000"):
//			 --계좌번호 내역 조회하기(도희) 1000
//			 --거래유형 잔액, 상대방 이름, 거래금액, 거래날짜, 시간
			 sql =  "select * from (select type, balance, breakdown, amount, tra_date, "
			 + " to_char(tra_date, 'HH24:MI:SS') as tra_time "
			 + " from history@banker_bank where anum=? order by tra_date desc) order by tra_time desc ";
		
		break;
		case("2000"):
//			 --계좌번호로 내역 조회하기(충만) 2000
//			 --거래유형, 잔액, 상대방이름, 거래금액, 거래날짜, 거래시간

			 sql = " select * from (select type, balance ,receive_name as breakdown, "
			 + " remittance as amount, transfer_dt as tra_date, "
			 + " to_char(transfer_dt,'HH24:MI:SS') as tra_time "
			 + " from ACCOUNT_TRANSFER@CM_bank where acc_num=? "
			 + " order by transfer_dt desc) order by tra_time desc";


		break;
		case("3000"):
//			 --계좌번호로 거래내역 조회하기(초 단위)(해니)
//			 --거래유형, 잔액, 상대방이름, 거래금액, 거래날짜, 거래시간
			 sql =  "select * from (select trans_type as type ,my_balance as balance,target_name as breakdown, "
			 		+ " trans_amount as amount,trans_date as tra_date, "
			 		+ " to_char(trans_date,'HH24:MI:SS') as tra_time "
			 		+ " from HN_transaction where my_account = ? "
			 		+ " order by  trans_date desc) "
			 		+ " order by tra_time desc ";
			

		break;
		case("4000"):
//			 --계좌번호로 내역 조회하기(정환)
//			 --거래유형, 잔액, 상대방이름, 거래금액, 거래날짜, 거래시간
			 sql = "select * from (select DECODE(tr_code,1,'출금','입금') as type, "
			 + " my_balance as balance, to_name as breakdown, tran_money as amount "
			 + " , tran_dt as tra_date, to_char(tran_dt,'HH24:MI:SS') as tra_time "
			 + " from T_TRANSCATION@YB_bank where "
			 + " my_acc_num=? order by tran_dt desc) order by tra_time desc";

		}


		try (
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
		) {

			pstmt.setString(1, account);

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				TransactionVO vo = new TransactionVO();
				
				vo.setTransType(rs.getString(1));
				vo.setMyBalance(rs.getInt(2));
				vo.setTargetName(rs.getString(3));
				vo.setTransAmount(rs.getInt(4));
				vo.setTransDate(rs.getString(5));

				list.add(vo);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// 전화번호로 전체 은행 계좌 찾기
	public List<AccountVO> searchBytel(String tel) {
		List<AccountVO> list = new ArrayList<AccountVO>();

		StringBuilder sql = new StringBuilder();
		sql.append("select  account_num, bank_code, account_balance, product_name ");
		sql.append("    from account@cm_bank ");
		sql.append("    where id = (select id from t_member@cm_bank where tel1||tel2||tel3 = ?) ");
		sql.append("    union ");
		sql.append("    select acc_num, '4000', acc_bal, acc_type ");
		sql.append("    from t_account@yb_bank ");
		sql.append(
				"    where user_id = (select user_id from t_member@yb_bank where replace(user_phone, '-', '') = ?) ");
		sql.append("    union ");
		sql.append("    select anum, bank, balance, name ");
		sql.append("    from account@banker_bank ");
		sql.append("    where tel=? ");
		sql.append("    union ");
		sql.append("    select a.account, a.bank_code ,a.balance, c.type  ");
		sql.append("    from hn_account a, hn_member b, hn_acnt_type c ");
		sql.append("    where a.type_code = c.code and a.member_id = b.id and b.tel1||b.tel2||b.tel3=? ");

		try (Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());) {
			int loc = 1;
			pstmt.setString(loc++, tel);
			pstmt.setString(loc++, tel);
			pstmt.setString(loc++, tel);
			pstmt.setString(loc++, tel);

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {

				int start = 1;
				AccountVO vo = new AccountVO();
				vo.setAccount(rs.getString(start++));
				vo.setBankCode(rs.getString(start++));
				vo.setBalance(rs.getInt(start++));
				vo.setTypeCode(rs.getString(start++));
				list.add(vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
}
