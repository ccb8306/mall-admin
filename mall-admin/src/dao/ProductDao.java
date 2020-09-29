package dao;
import java.util.*;

import commons.DBUtil;

import java.sql.*;
import vo.*;

public class ProductDao {

	// 상품 목록 출력 (페이징 x, JOIN x) 
	public ArrayList<Product> selectProductList() throws Exception {
		ArrayList<Product> list = new ArrayList<Product>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select product_id, category_id, product_name, product_price, product_soldout from product";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Product p = new Product();
			p.setProductId(rs.getInt("product_id"));
			p.setCategoryId(rs.getInt("category_id"));
			p.setProductName(rs.getString("product_name"));
			p.setProductPrice(rs.getInt("product_price"));
			p.setProductSoldout(rs.getString("product_soldout"));
			list.add(p);
		}

		conn.close();
		return list;
		
	}
	
	// 상품 목록 출력 (페이징 o, JOIN o)
	public ArrayList<ProductAndCategory> selectProductList(int currentPage, int rowPage) throws Exception {
		ArrayList<ProductAndCategory> list = new ArrayList<ProductAndCategory>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select p.product_id, p.category_id, p.product_name, p.product_price, p.product_soldout, c.category_name from product p inner join category c on c.category_id = p.category_id limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, (currentPage-1)*rowPage);
		stmt.setInt(2, rowPage);
		ResultSet rs = stmt.executeQuery();

		while(rs.next()) {
			Product p = new Product();
			Category c = new Category();
			ProductAndCategory pc = new ProductAndCategory();
			p.setProductId(rs.getInt("product_id"));
			p.setCategoryId(rs.getInt("category_id"));
			p.setProductName(rs.getString("product_name"));
			p.setProductPrice(rs.getInt("product_price"));
			p.setProductSoldout(rs.getString("product_soldout"));
			c.setCategoryName(rs.getString("category_name"));
			
			pc.setCategory(c);
			pc.setProduct(p);
			list.add(pc);
		}

		conn.close();
		return list;
		
	}
	
	// 카테고리 id로 상품 목록 출력 (페이징 o)
	public ArrayList<ProductAndCategory> selectProductListByCategoryId(int categoryId, int currentPage, int rowPage) throws Exception {
		ArrayList<ProductAndCategory> list = new ArrayList<ProductAndCategory>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select p.product_id, p.category_id, p.product_name, p.product_price, p.product_soldout, c.category_name from product p inner join category c on c.category_id = p.category_id where p.category_id=? limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryId);
		stmt.setInt(2, (currentPage-1)*rowPage);
		stmt.setInt(3, rowPage);

		ResultSet rs = stmt.executeQuery();

		while(rs.next()) {
			Product p = new Product();
			Category c = new Category();
			ProductAndCategory pc = new ProductAndCategory();
			p.setProductId(rs.getInt("product_id"));
			p.setCategoryId(rs.getInt("category_id"));
			p.setProductName(rs.getString("product_name"));
			p.setProductPrice(rs.getInt("product_price"));
			p.setProductSoldout(rs.getString("product_soldout"));
			c.setCategoryName(rs.getString("category_name"));
			
			pc.setCategory(c);
			pc.setProduct(p);
			list.add(pc);
		}

		conn.close();
		return list;
		
	}
	
	// 상품 검색 --> 상품 이름에 검색 단어가 포함되는 상품 출력
	public ArrayList<ProductAndCategory> selectProductListByProductName(String productName, int currentPage, int rowPage) throws Exception {
		ArrayList<ProductAndCategory> list = new ArrayList<ProductAndCategory>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select p.product_id, p.category_id, p.product_name, p.product_price, p.product_soldout, c.category_name from product p inner join category c on c.category_id = p.category_id where p.product_name like ? limit ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + productName + "%");
		stmt.setInt(2, (currentPage-1)*rowPage);
		stmt.setInt(3, rowPage);

		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Product p = new Product();
			Category c = new Category();
			ProductAndCategory pc = new ProductAndCategory();
			p.setProductId(rs.getInt("product_id"));
			p.setCategoryId(rs.getInt("category_id"));
			p.setProductName(rs.getString("product_name"));
			p.setProductPrice(rs.getInt("product_price"));
			p.setProductSoldout(rs.getString("product_soldout"));
			c.setCategoryName(rs.getString("category_name"));
			
			pc.setCategory(c);
			pc.setProduct(p);
			list.add(pc);
		}

		conn.close();
		return list;
		
	}
	
	// 상품 상세보기 --> 상품 id로 해당 상품 정보 가져오기
	public Product selectProductOne(int productId) throws Exception {
		Product p = new Product();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select product_id, category_id, product_name, product_price, product_content, product_soldout, product_pic from product where product_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productId);

		ResultSet rs = stmt.executeQuery();

		if(rs.next()) {
			p.setProductId(rs.getInt("product_id"));
			p.setCategoryId(rs.getInt("category_id"));
			p.setProductName(rs.getString("product_name"));
			p.setProductPrice(rs.getInt("product_price"));
			p.setProductSoldout(rs.getString("product_soldout"));
			p.setProductContent(rs.getString("product_content"));
			p.setProductPic(rs.getString("product_pic"));
		}

		conn.close();
		return p;		
	}
	
	// 상품 추가
	public void insertProduct(Product p) throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "insert into product(category_Id, product_name, product_price, product_content, product_soldout) values(?,?,?,?,?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getProductId());
		stmt.setString(2, p.getProductName());
		stmt.setInt(3, p.getProductPrice());
		stmt.setString(4, p.getProductContent());
		stmt.setString(5, p.getProductSoldout());
		
		stmt.executeUpdate();

		conn.close();
	}
	
	// 상품 삭제 
	public void deleteProduct(int productId) throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "delete from product where product_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productId);
		stmt.executeUpdate();

		conn.close();
	}
	
	
	// 상품 수정
	public void updateProduct(Product p) throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "update product set category_id=? , product_name=? , product_price=?, product_content=? , product_soldout=? where product_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getCategoryId());
		stmt.setString(2, p.getProductName());
		stmt.setInt(3, p.getProductPrice());
		stmt.setString(4, p.getProductContent());
		stmt.setString(5, p.getProductSoldout());
		stmt.setInt(6, p.getProductId());
		stmt.executeUpdate();
		conn.close();
	}
	
	// 전체 카테고리 최대 페이지 구하기
	public int getProductEndPage(int rowPage) throws Exception {
		int endPage = 1;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select count(*) from product";
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
	
	// 선택된 카테고리 최대 페이지 구하기
	public int getProductEndPagebyCategoryId(int categoryId, int rowPage) throws Exception {
		int endPage = 1;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select count(*) from product where category_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryId);
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
	
	// 상품 이름으로 최대 페이지 구하기 --> 상품 검색시 사용
	public int getProductEndPagebyProductName(String productName, int rowPage) throws Exception {
		int endPage = 1;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select count(*) from product where product_name like ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + productName + "%");
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
	
	// 재고 현황 변경 [toggle --> '품절','판매중']
	public void updateProductSoldout(int productId, String productSoldout) throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "update product set product_soldout=? where product_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		if(productSoldout.equals("Y")) {
			stmt.setString(1, "N");	
		}else {
			stmt.setString(1, "Y");
		}
		stmt.setInt(2, productId);
		
		int row = stmt.executeUpdate();
		
		System.out.println(row + "행 수정");
	}
	
	// 상품 이미지 수정
	public void updateProductPic(Product product)throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "update product set product_pic=? where product_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, product.getProductPic());
		stmt.setInt(2, product.getProductId());
		stmt.executeUpdate();
		
		conn.close();
	}
}
