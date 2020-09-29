<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<!-- 
	/*loginAction.jsp*/
	
	login.jsp���������� �α��� ��ư���� ���� �׼� ������
	
	�Է��� ���̵�� ��й�ȣ�� �����ͺ��̽��� ��ġ�ϸ� index.jsp��������,
	��ġ���� ������ login.jsp�������� �̵�
 -->
<%
	request.setCharacterEncoding("utf-8");

	// �Է��� id�� pw
	String adminId = request.getParameter("adminId");
	String adminPw = request.getParameter("adminPw");
	
	// Admin�� id�� pw����
	Admin paramAdmin = new Admin();
	paramAdmin.setAdminId(adminId);
	paramAdmin.setAdminPw(adminPw);
	
	// �����ϴ� �������� Ȯ��
	AdminDao adminDao = new AdminDao();
	Admin loginAdmin = adminDao.login(paramAdmin);
	
	// �α��� ����
	if(loginAdmin == null){
		System.out.println("�α��� ����");
		response.sendRedirect(request.getContextPath() + "/login.jsp");
	}
	// �α��� ����
	else{
		System.out.println("�α��� ����");
		// �α��� ������ �α��� ������ session�� ���� 
		session.setAttribute("loginAdminId", loginAdmin.getAdminId());
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
	
%>
