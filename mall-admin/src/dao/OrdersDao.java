package dao;
import java.util.*;

import commons.DBUtil;
import vo.*;
import java.sql.*;

public class OrdersDao {
	// �ֹ� �߰�
	public void insertOrders(Orders orders)throws Exception{
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		String sql = "insert into orders(product_id, orders_amount, orders_price, member_email, orders_addr, orders_state, orders_date) values(?,?,?,?,?,?,now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orders.getProductId());
		stmt.setInt(2, orders.getOrdersAmount());
		stmt.setInt(3, orders.getOrdersPrice());
		stmt.setString(4, orders.getMemberEmail());
		stmt.setString(5, orders.getOrdersAddr());
		stmt.setString(6, orders.getOrdersState());
		
		stmt.executeUpdate();
		
		conn.close();
	}
	
	// �ֹ� ���� --> �ش� �ֹ��� ���¸� ���� ����
	public void updateOrdersState(Orders orders)throws Exception {
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		String sql = "update orders set orders_state=? where orders_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, orders.getOrdersState());
		stmt.setInt(2, orders.getOrdersId());
		stmt.executeUpdate();
		
		conn.close();
	}
	
	// �ֹ� �󼼺��� --> �ֹ� ������ ������ ���� ������
	// �ֹ� id�� �ֹ� ���¸� ���
	public Orders selectOrdersOne(int ordersId)throws Exception {
		Orders o = new Orders();

		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select orders_id, orders_state from orders where orders_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersId);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			o.setOrdersId(rs.getInt("orders_id"));
			o.setOrdersState(rs.getString("orders_state"));
		}
		
		conn.close();
		return o;
	}
	
	
	// �ֹ� ���� ����Ʈ --> �ֹ� �������� ���µ��� ���
	// �ߺ����� ������ ���·� �޾ƿ�
	public ArrayList<String> selectOrdersStateList() throws Exception{
		ArrayList<String> list = new ArrayList<String>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select distinct orders_state from orders";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			list.add(rs.getString("orders_state"));
		}

		conn.close();
		return list;
	}
	
	// �ֹ� ����Ʈ ���� --> �ֹ� ������� ��ǰ�� �̸��� JOIN�Ͽ� ���
	public ArrayList<OrdersAndProduct> selectOrdersList(int currentPage, int rowPage) throws Exception {
		ArrayList<OrdersAndProduct> list = new ArrayList<OrdersAndProduct>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select o.orders_id, o.product_id, o.orders_amount, o.orders_price, o.member_email, o.orders_addr, o.orders_state, o.orders_date, p.product_name from orders o inner join product p on o.product_id = p.product_id order by o.orders_date desc limit ?,?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, (currentPage-1)*10);
		stmt.setInt(2, 10);
		ResultSet rs = stmt.executeQuery();

		while(rs.next()) {
			Orders o = new Orders();
			Product p = new Product();
			OrdersAndProduct op = new OrdersAndProduct();
			o.setOrdersId(rs.getInt("orders_id"));
			o.setProductId(rs.getInt("product_id"));
			o.setOrdersAmount(rs.getInt("orders_amount"));
			o.setOrdersPrice(rs.getInt("orders_price"));
			o.setMemberEmail(rs.getString("member_email"));
			o.setOrdersAddr(rs.getString("orders_addr"));
			o.setOrdersState(rs.getString("orders_state"));
			o.setOrdersDate(rs.getString("orders_date"));
			p.setProductName(rs.getString("product_name"));
			
			op.setOrders(o);
			op.setProduct(p);
			list.add(op);
		}
		
		conn.close();
		
		return list;
	}
	
	// ����(state)�� �ֹ� ����Ʈ ����   --> �ֹ� ������� ��ǰ�� �̸��� JOIN�Ͽ� ���
	public ArrayList<OrdersAndProduct> selectOrdersListbyState(String ordersState, int currentPage, int rowPage) throws Exception {
		ArrayList<OrdersAndProduct> list = new ArrayList<OrdersAndProduct>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select o.orders_id, o.product_id, o.orders_amount, o.orders_price, o.member_email, o.orders_addr, o.orders_state, o.orders_date, p.product_name from orders o inner join product p on o.product_id = p.product_id where o.orders_state=? order by o.orders_date desc limit ?,?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, ordersState);
		stmt.setInt(2, (currentPage-1)*10);
		stmt.setInt(3, 10);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Orders o = new Orders();
			Product p = new Product();
			OrdersAndProduct op = new OrdersAndProduct();
			o.setOrdersId(rs.getInt("orders_id"));
			o.setProductId(rs.getInt("product_id"));
			o.setOrdersAmount(rs.getInt("orders_amount"));
			o.setOrdersPrice(rs.getInt("orders_price"));
			o.setMemberEmail(rs.getString("member_email"));
			o.setOrdersAddr(rs.getString("orders_addr"));
			o.setOrdersState(rs.getString("orders_state"));
			o.setOrdersDate(rs.getString("orders_date"));
			p.setProductName(rs.getString("product_name"));
			
			op.setOrders(o);
			op.setProduct(p);
			list.add(op);
		}
		
		conn.close();
		
		return list;
	}
	
	// �ֹ� ����Ʈ ��ü ��½� --> �ִ� ������ ���ϱ�
	public int getProductEndPage(int rowPage) throws Exception {
		int endPage = 1;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select count(*) from orders";
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
	
	// ������ �ֹ������� �ֹ� ����Ʈ ��½� --> �ִ� ������ ���ϱ�
	public int getProductEndPageByState(String State, int rowPage) throws Exception {
		int endPage = 1;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();	
		
		String sql = "select count(*) from orders where orders_state=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, State);
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
	
}
