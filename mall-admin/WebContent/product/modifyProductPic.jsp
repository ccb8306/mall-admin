<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
	/*modifyProductPic.jsp*/
	
	productOne.jsp에서 이미지 수정 버튼으로 올 수 있는
	이미지 수정 페이지
	이미지 한개를 선택할 수 있고
	수정 버튼 클릭시 modifyProductPicAction.jsp페이지로 이동
 -->
<%
	// 비정상적인 접근시
	if(session.getAttribute("loginAdminId") == null){
		response.sendRedirect(request.getContextPath() + "/login.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyProductPic</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container form-group">
		<!-- 메뉴 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include><br><br>
		</div>
		
		<!-- jsp -->
		<%
			int productId = Integer.parseInt(request.getParameter("productId"));		
		%>
		
		<!-- 이미지 수정 폼 -->
		<form action="<%=request.getContextPath() %>/product/modifyProductPicAction.jsp" method="post" enctype="multipart/form-data">	
			<input type="hidden" name="productId" value="<%=productId %>">
			<table class="table">
				<thead class="thead-light">
					<tr>
						<th colspan="2"><h3>상품 이미지 수정</h3></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width:15%">이미지 선택 : </td>
						<td><input class="form-control-file border" type="file" name="productPic"></td>
					</tr>
					<tr>
						<td colspan="2">
							<button class="btn btn-outline-primary" type="submit">수정완료</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>