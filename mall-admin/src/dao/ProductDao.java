package dao;
import java.util.*;

import commons.DBUtil;

import java.sql.*;
import vo.*;

public class ProductDao {

	// ��ǰ ��� ��� (����¡ x, JOIN x) 
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
	
	// ��ǰ ��� ��� (����¡ o, JOIN o)
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
	
	// ī�װ� id�� ��ǰ ��� ��� (����¡ o)
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
	
	// ��ǰ �˻� --> ��ǰ �̸��� �˻� �ܾ ���ԵǴ� ��ǰ ���
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
	
	// ��ǰ �󼼺��� --> ��ǰ id�� �ش� ��ǰ ���� ��������
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
	
	// ��ǰ �߰�
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
	
	// ��ǰ ���� 
	public void deleteProduct(int productId) throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "delete from product where product_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productId);
		stmt.executeUpdate();

		conn.close();
	}
	
	
	// ��ǰ ����
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
	
	// ��ü ī�װ� �ִ� ������ ���ϱ�
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
	
	// ���õ� ī�װ� �ִ� ������ ���ϱ�
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
	
	// ��ǰ �̸����� �ִ� ������ ���ϱ� --> ��ǰ �˻��� ���
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
	
	// ��� ��Ȳ ���� [toggle --> 'ǰ��','�Ǹ���']
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
		
		System.out.println(row + "�� ����");
	}
	
	// ��ǰ �̹��� ����
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
