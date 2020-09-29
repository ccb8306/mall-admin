<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>productList</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include><br><br>
		</div>
		
		<!-- 자바 -->
		<%
			int currentPage = 1; // 현재 페이지
			int rowPage = 10; // 한 페이지당 출력 개수
			int endPage = 1; // 마지막 페이지
			String searchProductName = "";
			request.setCharacterEncoding("utf-8");
			
			// 카테고리 아이디 받기
			int categoryId = -1;
			if(request.getParameter("categoryId") != null)
				categoryId = Integer.parseInt(request.getParameter("categoryId"));
			
			// 페이지 값 받기
			if(request.getParameter("currentPage") != null)
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
				
			// 이름 검색 받기
			if(request.getParameter("searchProductName") != null)
				searchProductName = request.getParameter("searchProductName");
			
			ProductDao productDao = new ProductDao();
			ArrayList<ProductAndCategory> productList = null;
			
			CategoryDao categoryDao = new CategoryDao();
			ArrayList<Category> categoryList = categoryDao.selectCategoryList();
			
	
			
			// 전체 카테고리 상품 목록일시 && 검색 x
			if(categoryId == -1 && searchProductName == ""){
				endPage = productDao.getProductEndPage(rowPage);
				productList = productDao.selectProductList(currentPage, rowPage);
			// 선택 카테고리 상품 목록일시 && 검색 x
			}else if(categoryId != -1 && searchProductName == ""){
				endPage = productDao.getProductEndPagebyCategoryId(categoryId, rowPage);
				productList = productDao.selectProductListByCategoryId(categoryId, currentPage, rowPage);
			// 검색 상품 목록
			}else if(searchProductName != ""){
				endPage = productDao.getProductEndPagebyProductName(searchProductName, rowPage);
				productList = productDao.selectProductListByProductName(searchProductName, currentPage, rowPage);		
			}
		%>
		
		<!-- 카테고리 -->
		<table class="table">
			<thead class="thead-light">
				<tr>
					<th><h4>카테고리</h4></th>
				</tr>
			</thead>
		</table>
		<table class="table">
			<tr>
				<td><a href="<%=request.getContextPath() %>/product/productList.jsp">[-전체보기-]</a>	</td>
			</tr>
			<tr>
				<%
					int i = 0;
					for(Category c : categoryList){
						i++;
				%>
							<td><a href="<%=request.getContextPath() %>/product/productList.jsp?categoryId=<%=c.getCategoryId() %>">[<%=c.getCategoryName() %>]</a></td>
				<%	
						if(i%7 == 0){
				%>
							</tr><tr>
				<%
						}
					}
				%>
			</tr>
		</table>
		<!-- 상품 목록 -->
		<table class="table table-dark">
			<thead class="thead-light">
				<tr>
					<th><h3>상품 목록</h3></th>
				</tr>
				<tr>
					<th>
						<ul class="pagination" >	
							<li class="page-item">
								<a style="background-color:#white" class="page-link" href="<%=request.getContextPath() %>/product/addProduct.jsp">[상품 추가하기]</a>
							</li>
						</ul>
					</th>
				</tr>
			</thead>
		</table>
		<table class="table table-striped table-hover">
			<thead style="background-color:#F15F5F">
				<tr style="color:white">
					<th>product_id</th>
					<th>category_id</th>
					<th>category_name</th>
					<th>product_name</th>
					<th>product_price</th>
					<th>product_soldout</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(ProductAndCategory pc : productList){
						if(pc.getProduct().getProductSoldout().equals("Y")){
				%>
						<tr style="color:red">
							<td><a href="<%=request.getContextPath() %>/product/productOne.jsp?productId=<%=pc.getProduct().getProductId()%>"><del><%=pc.getProduct().getProductId() %></del></a></td>
							<td><del><%=pc.getProduct().getCategoryId() %></del></td>
							<td><del><%=pc.getCategory().getCategoryName() %></del></td>
							<td><del><%=pc.getProduct().getProductName() %></del></td>
							<td><del><%=pc.getProduct().getProductPrice() %></del></td>
							<td><del>품절</del></td>
						</tr>	
				<%
						}else{
				%>
						<tr>
							<td><a href="<%=request.getContextPath() %>/product/productOne.jsp?productId=<%=pc.getProduct().getProductId()%>"><%=pc.getProduct().getProductId() %></a></td>
							<td><%=pc.getProduct().getCategoryId() %></td>
							<td><%=pc.getCategory().getCategoryName() %></td>
							<td><%=pc.getProduct().getProductName() %></td>
							<td><%=pc.getProduct().getProductPrice() %></td>
							<td>판매중</td>
						</tr>
				<%
						}
					}
				%>
			</tbody>
		</table>
		
		<br>
		
		<!-- 상품 검색 -->
		<form method="post" action="<%=request.getContextPath() %>/product/productList.jsp">
			<div class="input-group mb-3">
				<input type="text" class="form-control" name="searchProductName" placeholder="Serach Product Name" value="<%=searchProductName%>">
				<div class="input-group-prepend">	
					<button class="btn btn-outline-primary" type="submit">상품 이름 검색</button>
				</div>
			</div>
		</form>
		<!-- 페이징 -->
		<ul class="pagination">
			<%
				// 현재 페이지가 1페이지 보다 클 시
				if(currentPage > 1){
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp?searchProductName=<%=searchProductName %>&categoryId=<%=categoryId%>&currentPage=1">처음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp?searchProductName=<%=searchProductName %>&categoryId=<%=categoryId%>&currentPage=<%=currentPage-1 %>">이전</a></li>
			<%
				// 현재 페이지가 1페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp?searchProductName=<%=searchProductName %>&categoryId=<%=categoryId%>&currentPage=1">처음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp?searchProductName=<%=searchProductName %>&categoryId=<%=categoryId%>&currentPage=<%=currentPage-1 %>">이전</a></li>
			<%
				}// 현재 페이지
			%>
					<li class="page-item"><a class="page-link"><%=currentPage %></a></li>
			<%
				// 현재 페이지가 마지막 페이지보다 작을 시
				if(currentPage < endPage){
			%>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp?searchProductName=<%=searchProductName %>&categoryId=<%=categoryId%>&currentPage=<%=currentPage+1 %>">다음</a></li>
					<li class="page-item"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp?searchProductName=<%=searchProductName %>&categoryId=<%=categoryId%>&currentPage=<%=endPage %>">맨끝</a></li>
			<%
				// 현재 페이지가 마지막 페이지 일 시
				}else{
			%>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp?searchProductName=<%=searchProductName %>&categoryId=<%=categoryId%>&currentPage=<%=currentPage+1 %>">다음</a></li>
					<li class="page-item disabled"><a class="page-link" href="<%=request.getContextPath() %>/product/productList.jsp?searchProductName=<%=searchProductName %>&categoryId=<%=categoryId%>&currentPage=<%=endPage %>">맨끝</a></li>
			<%
				}
			%>	
		</ul>
	</div>
</body>
</html>