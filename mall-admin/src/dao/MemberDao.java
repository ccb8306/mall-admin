package dao;

import java.sql.*;
import commons.DBUtil;
import vo.*;
import java.util.*;

public class MemberDao {
	// 회원 리스트 --> 페이징 x,검색 x
	public ArrayList<Member> selectMemberList()throws Exception{
		ArrayList<Member> list = new ArrayList<Member>();

		DBUtil dbUtil = new DBUtil();	
		Connection conn = dbUtil.getConnection();
		String sql = "select member_email, member_name, member_date, member_state from member order by member_email asc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Member m = new Member();
			m.setMemberEmail(rs.getString("member_email"));
			m.setMemberName(rs.getString("member_name"));
			m.setMemberDate(rs.getString("member_date"));
			m.setMemberState(rs.getString("member_state"));
			list.add(m);
		}
		
		return list;
	}
	// 회원 리스트 --> 검색x
	public ArrayList<Member> selectMemberList(int currentPage, int rowPage)throws Exception{
		ArrayList<Member> list = new ArrayList<Member>();

		DBUtil dbUtil = new DBUtil();	
		Connection conn = dbUtil.getConnection();
		String sql = "select member_email, member_name, member_date, member_state from member order by member_date desc limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, (currentPage -1) * rowPage);
		stmt.setInt(2, rowPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Member m = new Member();
			m.setMemberEmail(rs.getString("member_email"));
			m.setMemberName(rs.getString("member_name"));
			m.setMemberDate(rs.getString("member_date"));
			m.setMemberState(rs.getString("member_state"));
			list.add(m);
		}
		
		return list;
	}
	
	// 회원 리스트 --> 이름 검색
	public ArrayList<Member> selectMemberListbyName(String memberName, int currentPage, int rowPage)throws Exception{
		ArrayList<Member> list = new ArrayList<Member>();

		DBUtil dbUtil = new DBUtil();	
		Connection conn = dbUtil.getConnection();
		String sql = "select member_email, member_name, member_date, member_state from member where member_name like ? order by member_date desc limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+memberName+"%");
		stmt.setInt(2, (currentPage -1) * rowPage);
		stmt.setInt(3, rowPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Member m = new Member();
			m.setMemberEmail(rs.getString("member_email"));
			m.setMemberName(rs.getString("member_name"));
			m.setMemberDate(rs.getString("member_date"));
			m.setMemberState(rs.getString("member_state"));
			list.add(m);
		}
		
		return list;
	}
	
	// 회원 리스트 --> 이메일 검색
	public ArrayList<Member> selectMemberListbyEmail(String memberEmail, int currentPage, int rowPage)throws Exception{
		ArrayList<Member> list = new ArrayList<Member>();

		DBUtil dbUtil = new DBUtil();	
		Connection conn = dbUtil.getConnection();
		String sql = "select member_email, member_name, member_date, member_state from member where member_email like ? order by member_date desc limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+memberEmail+"%");
		stmt.setInt(2, (currentPage -1) * rowPage);
		stmt.setInt(3, rowPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Member m = new Member();
			m.setMemberEmail(rs.getString("member_email"));
			m.setMemberName(rs.getString("member_name"));
			m.setMemberDate(rs.getString("member_date"));
			m.setMemberState(rs.getString("member_state"));
			list.add(m);
		}
		
		return list;
	}
	
	// 회원 상세보기
	public Member selectMemberOne(String memberEmail)throws Exception {
		Member m = null;
		DBUtil dbUtil = new DBUtil();	
		Connection conn = dbUtil.getConnection();
		String sql = "select member_email, member_name, member_date, member_state from member where member_email=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberEmail);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			m = new Member();
			m.setMemberEmail(rs.getString("member_email"));
			m.setMemberName(rs.getString("member_name"));
			m.setMemberDate(rs.getString("member_date"));
			m.setMemberState(rs.getString("member_state"));
		}
		
		return m;
	}
	
	// 회원 정보 수정
	public void updateMember(Member member)throws Exception{
		DBUtil dbUtil = new DBUtil();	
		Connection conn = dbUtil.getConnection();
		String sql = "update member set member_name=?, member_state=? where member_email=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, member.getMemberName());
		stmt.setString(2, member.getMemberState());
		stmt.setString(3, member.getMemberEmail());
		
		stmt.executeUpdate();
	}
	
	// 회원 리스트 최대 페이지 구하기 --> 검색 x
	public int getMemberEndPage(int rowPage)throws Exception {
		int endPage = 1;
		
		DBUtil dbUtil = new DBUtil();	
		Connection conn = dbUtil.getConnection();
		String sql = "select count(*) from member";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();

		if(rs.next()) {
			endPage = rs.getInt("count(*)");
			if(endPage%rowPage == 0)			
				endPage = (int)(endPage/rowPage);
			else
				endPage = (int)(endPage/rowPage) + 1;
			
		}	
		
		return endPage;
	}
	
	// 회원 리스트 최대 페이지 구하기 --> 이름 검색시
	public int getMemberEndPagebyName(String memberName, int rowPage)throws Exception {
		int endPage = 1;
		
		DBUtil dbUtil = new DBUtil();	
		Connection conn = dbUtil.getConnection();
		String sql = "select count(*) from member where member_name like ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+memberName+"%");
		
		ResultSet rs = stmt.executeQuery();

		if(rs.next()) {
			endPage = rs.getInt("count(*)");
			if(endPage%rowPage == 0)			
				endPage = (int)(endPage/rowPage);
			else
				endPage = (int)(endPage/rowPage) + 1;
			
		}	
		
		return endPage;
	}
	
	// 회원 리스트 최대 페이지 구하기 --> 이메일 검색시
	public int getMemberEndPagebyEmail(String memberEmail, int rowPage)throws Exception {
		int endPage = 1;
		
		DBUtil dbUtil = new DBUtil();	
		Connection conn = dbUtil.getConnection();
		String sql = "select count(*) from member where member_email like ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+memberEmail+"%");
		
		ResultSet rs = stmt.executeQuery();

		if(rs.next()) {
			endPage = rs.getInt("count(*)");
			if(endPage%rowPage == 0)			
				endPage = (int)(endPage/rowPage);
			else
				endPage = (int)(endPage/rowPage) + 1;
			
		}	
		
		return endPage;
	}

}
