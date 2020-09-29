package dao;

import java.sql.*;
import java.util.ArrayList;

import commons.DBUtil;
import vo.*;

public class NoticeDao {

	// 공지사항 리스트 --> 검색 x
	public ArrayList<Notice> selectNoticeList(int currentPage, int rowPage) throws Exception{
		ArrayList<Notice> list = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "select notice_id, notice_title, notice_content, notice_date from notice order by notice_date desc limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, (currentPage-1)*rowPage);
		stmt.setInt(2, rowPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeId(rs.getInt("notice_id"));
			n.setNoticeTitle(rs.getString("notice_title"));
			n.setNoticeContent(rs.getString("notice_content"));
			n.setNoticeDate(rs.getString("notice_date"));
			list.add(n);
		}
		conn.close();
		return list;
	}

	// 공지사항 리스트 --> 검색 o
	public ArrayList<Notice> selectNoticeListbySearch(String searchNotice, int currentPage, int rowPage) throws Exception{
		ArrayList<Notice> list = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "select notice_id, notice_title, notice_content, notice_date from notice where notice_title like ? order by notice_date desc limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchNotice+"%");
		stmt.setInt(2, (currentPage-1)*rowPage);
		stmt.setInt(3, rowPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeId(rs.getInt("notice_id"));
			n.setNoticeTitle(rs.getString("notice_title"));
			n.setNoticeContent(rs.getString("notice_content"));
			n.setNoticeDate(rs.getString("notice_date"));
			list.add(n);
		}
		conn.close();
		return list;
	}
	
	// 공지사항 상세보기
	public Notice selectNoticeOne(int noticeId)throws Exception {
		Notice n = new Notice();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select notice_id, notice_title, notice_content, notice_date from notice where notice_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeId);

		ResultSet rs = stmt.executeQuery();

		if(rs.next()) {
			n.setNoticeId(rs.getInt("notice_id"));
			n.setNoticeTitle(rs.getString("notice_title"));
			n.setNoticeContent(rs.getString("notice_content"));
			n.setNoticeDate(rs.getString("notice_date"));
		}

		conn.close();
		return n;		
	}
	
	// 공지사항 최대 페이지 구하기 --> 검색x
	public int getNoticeEndPage(int rowPage) throws Exception {
		int endPage = 1;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select count(*) from notice";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			endPage = rs.getInt("count(*)");
			if(endPage%rowPage == 0)			
				endPage = (int)(endPage/rowPage);
			else
				endPage = (int)(endPage/rowPage) + 1;
			
		}	
		
		conn.close();
		return endPage;
	}
	// 공지사항 최대 페이지 구하기 --> 검색 o
	public int getNoticeEndPagebySearch(String searchNotice, int rowPage) throws Exception {
		int endPage = 1;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select count(*) from notice where notice_title like ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchNotice+"%");
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			endPage = rs.getInt("count(*)");
			if(endPage%rowPage == 0)			
				endPage = (int)(endPage/rowPage);
			else
				endPage = (int)(endPage/rowPage) + 1;
			
		}	
		
		conn.close();
		return endPage;
	}
	
	
	// 공지사항 수정
	public void updateNotice(Notice notice) throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "update notice set notice_title=?, notice_content=? where notice_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getNoticeId());
		stmt.executeUpdate();
		
	}
	
	// 공지사항 작성
	public void insertNotice(Notice notice)throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "insert into notice(notice_title, notice_content, notice_date) values(?,?,now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.executeUpdate();
	}
	
	// 공지사항 삭제
	public void deleteNotice(int noticeId)throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "delete from notice where notice_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeId);
		stmt.executeUpdate();
	}
}
