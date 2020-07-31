<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:아이디/비밀번호 찾기";
%>
<link rel="stylesheet" type="text/css" href="styles/id.css">

<script type="text/javascript">
<%  
	if(session.getAttribute("cus_id")!=null || session.getAttribute("pet_id")!=null )
	{
%>
       alert("회원은 이용할 수 없습니다.\n메인페이지로 이동합니다.");
       self.close();
       parent.location.replace("index.jsp"); // 추가
<% 
	} else {
%>
</script>

<jsp:include page="layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>
<style>
table {
	text-align ="center";
	margin-left: auto;
	margin-right: auto;
	border: 1px solid #DEE2E6;
}
.blog {
	width: 100%;
	background: #FFFFFF;
	padding-top: 20px;
}
.blog_info {
	width: 100%;
	background: #ffffff;
	padding-top: 30px;
}
.nav-tabs .nav-link .active {
	font-weight: bold;
	background-color: transparent;
	border-bottom: 3px solid #ff9999;
	border-right: none;
	border-left: none;
	border-top: none;
}
</style>

<div id="j-container">
	<article class="container">
		<div id="j-content">
			<div class="card">
				<div class="card-body">
				
<div class="blog">
	<div class="container">
		<section class=" ">
			<div class="row">
				<div class="col-md-12 text-center ">
					<nav class="nav-justified ">
						<div class="nav nav-tabs " id="nav-tab" role="tablist">
							<a class="nav-item nav-link active" id="pop1-tab" data-toggle="tab" href="#pop1" role="tab" 
								aria-controls="pop1" aria-selected="true">아이디 찾기</a> 
							<a class="nav-item nav-link" id="pop2-tab" data-toggle="tab" href="#pop2" role="tab"
								aria-controls="pop2" aria-selected="false">비밀번호 찾기</a>
						</div>
					</nav>
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade show active" id="pop1" role="tabpanel" aria-labelledby="pop1-tab">
							<div class="pt-3">
								<form method="post" action="searchIdForm_pro.jsp">
									<table class="table" style="margin-top:30px; margin-bottom:50px; width: 50%; background-color: #fbfbfb; text-align: center;">
										<tr>
											<td colspan="5" style="padding:20px;">
												<h3 style="font-weight: bold; margin-bottom: 10px;">아이디 찾기</h3>
												<font style="font-size: 14px;">
													내정보에 등록한 정보로 아이디를 찾을 수 있습니다.
												</font>
											</td>
										<tr>
											<td colspan="2"style="font-weight: bold; vertical-align: middle;">이름</td>
											<td colspan="3">
												<input type="text" class="form-control" name="name" id="name" size="18" required="required" style="width:250px;">
											</td>
										</tr>
										<tr>
											<td colspan="2" style="font-weight: bold; vertical-align: middle;">휴대폰번호</td>
											<td colspan="3">
												<input type="text" class="form-control" name="phone" id="phone" placeholder="-없이 입력해 주세요" required="required" style="width:250px;">
											</td>
										</tr>
										<tr>
											<td colspan="5" style="padding:20px;">
												<input type="submit" class="btn" id="colorch" value="찾기" style="width: 150px; height: 47px;">
											</td>										
										</tr>
									</table>
								</form>
							</div>
						</div>
						<div class="tab-pane fade" id="pop2" role="tabpanel" aria-labelledby="pop2-tab">
							<div class="pt-3">
								<form method="post" action="searchIdForm_pro2.jsp">
									<table class="table" style="margin-top:30px; margin-bottom:50px; width: 50%; background-color: #fbfbfb; text-align: center;">
										<tr>
											<td colspan="5" style="padding: 20px;">
												<h3 style="font-weight: bold; margin-bottom: 10px;">비밀번호 찾기</h3> 
											</td>
										<tr>
											<td colspan="2" style="font-weight: bold; vertical-align: middle;">아이디</td>
											<td colspan="3"> 
												<input type="text" class="form-control" name="id" id="id" size="18" required="required" style="width:250px;">
											</td>
										</tr>
										<tr>
											<td colspan="2" style="font-weight: bold; vertical-align: middle;">이름</td>
											<td colspan="3">
												<input type="text" class="form-control" name="name" id="name" required="required" style="width:250px;">
											</td>
										</tr>
										<tr>
											<td colspan="5" style="padding:20px;">
												<input type="submit" class="btn" id="colorch" value="찾기" style="width: 150px; height: 47px;">
											</td>
										</tr>
									</table>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
</div>

				</div>
			</div>
		</div>
	</article>
</div>

<script>
<%
	}
%>
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false" />