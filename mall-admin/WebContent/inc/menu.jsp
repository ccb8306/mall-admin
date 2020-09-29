<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<table class="table table-bordered"  style="background-color:#F15F5F">
	<tr>
		<td>
			<nav class="navbar navbar-expand-sm navbar-dark">
				<ul class="navbar-nav">
					<li class="nav-item active">
						<a class="nav-link" data-toggle="tab" href="<%=request.getContextPath() %>/index.jsp">|Home|</a>
					</li>
					<li class="nav-item active">
						<a class="nav-link" data-toggle="tab" href="<%=request.getContextPath() %>/category/categoryList.jsp">|카테고리 관리|</a>
					</li>
					<li class="nav-item active">
						<a class="nav-link" data-toggle="tab" href="<%=request.getContextPath() %>/product/productList.jsp">|상품 관리|</a>
					</li>
					<li class="nav-item active">
						<a class="nav-link" data-toggle="tab" href="<%=request.getContextPath() %>/orders/ordersList.jsp">|주문내역 관리|</a>
					</li>
					<li class="nav-item active">
						<a class="nav-link" data-toggle="tab" href="<%=request.getContextPath() %>/notice/noticeList.jsp">|공지사항 관리|</a>
					</li>
					<li class="nav-item active">
						<a class="nav-link" data-toggle="tab" href="<%=request.getContextPath() %>/member/memberList.jsp">|회원 관리|</a>
					</li>
				</ul>
			</nav>
		</td>
		<td>
			<nav class="navbar navbar-expand-sm navbar-dark">
				<ul class="navbar-nav">
					<li class="nav-item active">
						<a class="nav-link"><%=session.getAttribute("loginAdminId") %>님 반갑습니다.</a>
					</li>
					<li class="nav-item active">
						<a class="nav-link" data-toggle="tab" href="/mall-admin/logoutAction.jsp">[Log out]</a>
					</li>
				</ul>
			</nav>
		</td>
	</tr>
</table>