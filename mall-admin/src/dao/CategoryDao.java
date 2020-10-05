package dao;
import java.util.ArrayList;
import commons.DBUtil;
import vo.Category;
import java.sql.*;

public class CategoryDao {
	// 카테고리 추가
	public void insertCategory(Category category) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "insert into category(category_name) values(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.executeQuery();	
		
		conn.close();
		
	}
	
	// 카테고리 상세보기
	public Category selectCategoryOne(int categoryId)throws Exception {
		Category c = new Category();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select category_id, category_name, category_pic, category_ck from category where category_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryId);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			c.setCategoryId(rs.getInt("category_id"));
			c.setCategoryName(rs.getString("category_name"));
			c.setCategoryPic(rs.getNString("category_pic"));
			c.setCategoryCk(rs.getString("category_ck"));
		}
		
		conn.close();		
		return c;
	}
	
	// 카테고리 이름 수정
	public void updateCategory(Category category) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "update category set category_name=?, category_ck=? where category_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryName());
		stmt.setString(2, category.getCategoryCk());
		stmt.setInt(3, category.getCategoryId());
		stmt.executeUpdate();	
		
		conn.close();
		
	}
	
	
	// 카테고리 삭제 
	public void deleteCategory(Category category) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "delete from category where category_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, category.getCategoryId());
		stmt.executeUpdate();	
		
		conn.close();
		
	}
	
	// 카테고리 목록 출력 (페이지 o)
	public ArrayList<Category> selectCategoryList(int currentPage) throws Exception {
		ArrayList<Category> list = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select category_id, category_name, category_pic, category_ck from category order by category_id desc limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, (currentPage-1)*10);
		stmt.setInt(2, 10);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryId(rs.getInt("category_id"));
			category.setCategoryName(rs.getString("category_name"));
			category.setCategoryPic(rs.getString("category_pic"));
			category.setCategoryCk(rs.getString("category_ck"));
			list.add(category);
		}

		conn.close();
		return list;
	}
	
	// 카테고리 목록 출력 (페이지 x)
	public ArrayList<Category> selectCategoryList() throws Exception {
		ArrayList<Category> list = new ArrayList<Category>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select category_id, category_name from category order by category_id desc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Category category = new Category();
			category.setCategoryId(rs.getInt("category_id"));
			category.setCategoryName(rs.getString("category_name"));
			list.add(category);
		}

		conn.close();
		return list;
	}
	
	// 카테고리 최대 페이지 구하기
	public int getCategoryEndPage() throws Exception {
		int endPage = 1;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select count(*) from category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			endPage = rs.getInt("count(*)");
			if(endPage%10 == 0)			
				endPage = (int)(endPage/10);
			else
				endPage = (int)(endPage/10) + 1;
			
		}	
		
		conn.close();
		return endPage;
	}
	
	// 카테고리 이미지 수정
	public void updateCategoryPic(Category category)throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "update category set category_pic=? where category_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryPic());
		stmt.setInt(2, category.getCategoryId());
		stmt.executeUpdate();
		
		conn.close();
	}
	
	
}
