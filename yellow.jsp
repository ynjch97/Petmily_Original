<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8"); 
	String title = "펫밀리에 오신걸 환영합니다";
%>
	<jsp:include page="layout/header.inc.jsp" flush="false">
	   <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>
<div class="graymenu">
		<div class="breadcrumbs_container">
			<div class="container">
				<div class="row">
					<div class="col">
						<div class="breadcrumbs">
							
							<ul>
								<li><a href="index.jsp">Home</a></li>
								<li><a>내 블로그</a></li>
								<li><a>예약 내역</a></li>
							</ul>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="app"></div>
    <script src="./dist/build.js"></script>
</body>
</html>