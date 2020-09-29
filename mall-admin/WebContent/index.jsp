<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect("/mall-admin/login.jsp");	
		return;
	}
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>index</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>	
<div class="jumbotron text-center" style="margin-bottom:0">
  <h1><a style="color:black" href="/mall/index.jsp">Goodee Shop</a></h1>
  <h1>Admin Main Page</h1><br><br>
  <p>- 본 페이지는 쇼핑몰 사이트 관리를 위한 관리자 전용 페이지 입니다. -</p>
</div>
<jsp:include page="/inc/menu.jsp"></jsp:include>
<br><br>
<div class="container">
	<div class="row">
	    <div class="col-sm-4">
	      <h3>
			[목적]<br><br></h3>
	      <p>
			이 사이트는 Goodee Academy에서 공부를 위해 개발하였으며<br>
			추후 개발 예정인 쇼핑몰 웹 사이트를 관리하기 위한 용도입니다.<br>
			앞으로도 발전을 위해 지속적인 개발이 진행 될 예정입니다.</p>
	    </div>
	    <div class="col-sm-4">
	      <h3>[개발 환경]<br><br></h3>
	      <p>
			운영체제 : Window 10 - 64bit<br>
			사용 프로그램 : Eclipse, mariaDB<br>
			사용 언어 : Html, Java, SQL<br>
			개발 기간 : 2020-09-16 ~ 진행중<br></p>
	    </div>
	    <div class="col-sm-4">
	      <h3>[from]<br><br></h3>
	      <p>
			제작자 - Jo Sung Hyun<br><br><br>
			Copyright by Jo Sung Hyun</p>
	    </div>
		
	</div>
</div>
</body>
</html>