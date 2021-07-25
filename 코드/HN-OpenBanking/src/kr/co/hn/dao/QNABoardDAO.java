package kr.co.hn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.co.hn.util.ConnectionFactory;
import kr.co.hn.vo.QNABoradVO;

public class QNABoardDAO {
	
	/**
	 * 전체 row 수
	 * @return
	 */
	public int getTotalRowCnt() {
		String sql = "select count(*) from hn_qna";
		int total = 0;
		
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
		){
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			total = rs.getInt(1);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return total;
	}
	
	
	
	/**
	 * 현재 페이지 전체글 조회
	 * @return
	 */
	public List<QNABoradVO> selectAll(int startRow, int endRow) {
		
		List<QNABoradVO> list = new ArrayList<QNABoradVO>();
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT * FROM ( ");
		sql.append("    SELECT ");
		sql.append("        ROWNUM AS RN, NO ,GROUP_NO  , GROUP_DEPTH ,PARENT_NO , ");
		sql.append("       WRITER ,SUBJECT ,CONTENT ,TYPE ,VIEW_CNT ,to_char(REGDATE, 'yyyy-MM-dd') as regdate ");
		sql.append("    FROM hn_qna  ");
		sql.append("    START WITH PARENT_NO IS NULL ");
		sql.append("    CONNECT BY PRIOR NO = PARENT_NO ");
		sql.append("    ORDER SIBLINGS BY GROUP_NO DESC ");
		sql.append(" )WHERE RN BETWEEN ? AND ? ");
		
		
		
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		){
			
			
			int loc = 1;
			pstmt.setInt(loc++, startRow);
			pstmt.setInt(loc++, endRow);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				int no = rs.getInt("no");
				int groupNo = rs.getInt("group_no");
				int groupDepth = rs.getInt("GROUP_DEPTH");
				int parentNo = rs.getInt("PARENT_NO");
				String writer = rs.getString("WRITER");
				String subject = rs.getString("SUBJECT");
				String content = rs.getString("content");
				String type = rs.getString("TYPE");
				int viewCnt = rs.getInt("VIEW_CNT");
				String regdate = rs.getString("REGDATE");
				
				QNABoradVO vo = new QNABoradVO();
				vo.setNo(no);
				vo.setGroupNo(groupNo);
				vo.setGroupDepth(groupDepth);
				vo.setParentNo(parentNo);
				vo.setWriter(writer);
				vo.setSubject(subject);
				vo.setContent(content);
				vo.setType(type);
				vo.setViewCnt(viewCnt);
				vo.setRegdate(regdate);
				
				list.add(vo);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
		
	}
	
	/**
	 * 게시글 상세 조회
	 * @param no
	 * @return
	 */
	public QNABoradVO selectByNo(int no) {
		
		QNABoradVO vo = null;
		
		StringBuilder sql = new StringBuilder();
		sql.append("select NO ,GROUP_NO ,GROUP_DEPTH ,PARENT_NO , ");
		sql.append(" WRITER ,SUBJECT ,CONTENT ,TYPE ,VIEW_CNT ,to_char(REGDATE, 'yyyy-MM-dd') as regdate ");
		sql.append(" from hn_qna where no = ? order by group_no desc ");
		
		try(
			Connection conn = new ConnectionFactory().getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		) {
			pstmt.setInt(1, no);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo = new QNABoradVO();

				vo.setNo(rs.getInt("no"));
				vo.setSubject(rs.getString("subject"));
				vo.setWriter(rs.getString("writer"));
				vo.setContent(rs.getString("content"));
				vo.setViewCnt(rs.getInt("view_cnt"));
				vo.setRegdate(rs.getString("regdate"));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
	
	/**
	 * 조회수 증가
	 * @param no
	 * @return
	 */
	public int incrementViewCnt(int no) {
		
		String sql = "update hn_qna set view_cnt = view_cnt + 1 where no = ? ";
		int result = -1;
		
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
		){
			
			pstmt.setInt(1, no);
			result = pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int update(QNABoradVO vo) {
		
		String sql = "update hn_qna set subject = ? , content = ? where no = ? ";
		int result = -1;
		
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
		){
			
			int loc = 1;
			
			pstmt.setString(loc++, vo.getSubject());
			pstmt.setString(loc++, vo.getContent());
			pstmt.setInt(loc++, vo.getNo());
			
			result = pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	

	/**
	 * 질문 등록
	 * @param vo
	 * @return
	 */
	public int insertQ(QNABoradVO vo) {
		
		int result = -1;
		
		StringBuilder sql = new StringBuilder();
		sql.append("insert into hn_qna( ");
		sql.append("    no, group_no, parent_no, writer, subject, content ");
		sql.append(" )values( ");
		sql.append("    SEQ_HN_QNA.nextval, ");
		sql.append("    SEQ_HN_QNA.currval, ");
		sql.append("    null, ");
		sql.append("    ?, ?, ?) ");
		
		
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		){
			int loc = 1;
			pstmt.setString(loc++, vo.getWriter());
			pstmt.setString(loc++, vo.getSubject());
			pstmt.setString(loc++, vo.getContent());

			result = pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	/**
	 * 답변 등록
	 * @param vo
	 * @return
	 */
	public int insertA(QNABoradVO vo) {
		
		int result = -1;
		
		StringBuilder sql = new StringBuilder();
		sql.append("insert into hn_qna( ");
		sql.append("    no, group_no, group_depth ");
		sql.append("    , parent_no, writer, subject, content, type ");
		sql.append(" ) select ");
		sql.append("    	SEQ_HN_QNA.nextval, ");
		sql.append("    	group_no,  ");
		sql.append("    	group_depth + 1, ");
		sql.append("    	?, ?, ?, ?, 'A' ");
		sql.append(" from hn_qna  ");
		sql.append(" where no = ? ");
		
		
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		){
			
			int loc = 1;
			pstmt.setInt(loc++, vo.getGroupNo());
			pstmt.setString(loc++, vo.getWriter());
			pstmt.setString(loc++, vo.getSubject());
			pstmt.setString(loc++, vo.getContent());
			pstmt.setInt(loc++, vo.getGroupNo());
			
			pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	public boolean existChild(int no) {
		
		String sql = "select count(*) from hn_qna where parent_no = ? ";
		boolean result = false;
		
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
		){
			pstmt.setInt(1, no);
			
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			
			int cnt = rs.getInt(1);
			
			

			if(cnt > 0) {
				result = true;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	public int delete(int no) {
		String sql = "delete from hn_qna where no = ? ";
		int result = -1;
		
		try(
				Connection conn = new ConnectionFactory().getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
		){
			pstmt.setInt(1, no);
			
			result = pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
}
