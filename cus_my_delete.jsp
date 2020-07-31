<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="petmily.customer.CustomerDBBean"%>
<%@ page import="petmily.customer.CustomerDataBean"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cus_id = (String) session.getAttribute("cus_id");
	String cus_passwd = request.getParameter("cus_passwd");
	String title = "펫밀리:"+cus_id+"님의 탈퇴";
%>

<style>
#font_del
{
	font-family: Nanum Gothic;
	font-size: 14px;
	font-weight: 400;
	color: #a5a5a5;
}
#font_del_main
{
	font-family: Nanum Gothic;
	font-size: 18px;
	font-weight: 400;
	color: #a1a1a1;
}
</style>							
	
<script type="text/javascript">
<%  
	if(session.getAttribute("cus_id")==null)
	{
%>
       alert("<고객> 로그인 후 이용가능한 서비스입니다.\n메인페이지로 이동합니다.");
       self.close();
       parent.location.replace("index.jsp"); // 추가
<% 
	} else {
%>
</script>

<%
	CustomerDataBean cus = null;
	CustomerDBBean cust = CustomerDBBean.getInstance();
	cus = cust.getCustomer(cus_id);
%>

<jsp:include page="layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<div id="j-container">
	<article class="container">
		<div id="j-content">
			<ul class="nav nav-tabs">
				<li class="nav-item">
					<a class="nav-link" href="cus_my_reserve.jsp" style="color: #000000; font-size: 14px;">
						예약내역 관리
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="cus_my_info.jsp" style="color: #000000; font-size: 14px;">
						개인정보 수정
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="cus_my_pet.jsp" style="color: #090909; font-size: 14px;">
						반려견 정보 수정
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="cus_my_matching.jsp" style="color: #090909; font-size: 14px;">
						매칭 정보 수정
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active" href="cus_my_delete.jsp" style="color: #090909; font-size: 14px;">
						<b>회원 탈퇴</b>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="cus_my_mileage.jsp" style="color: #090909; font-size: 14px;">
						마일리지 충전
					</a>
				</li>
			</ul>
			<div class="card">
				<div class="card-body">
					<div class="page-header">
						<b><big>회원 탈퇴</big></b>
					</div><br>
					<div style=margin-top:2%;margin-bottom:2%;>
					
						<form class="form" method="post" action="cus_my_delete_pro.jsp">
							
							<table style=margin-left:5%;margin-right:5%;>
								<colgroup>
									<col width="20%">
									<col width="80%">
								</colgroup>
								<tr>
								    <td> <img class="img-responsive" src="images/rtrv.png" style=width:80%;height=80%;> </td>
								    <td> 
								    	<div id="font_del">
									    	<div id="font_del_main"><b>
										    	<%=cus.getCus_id() %>님, 정말 탈퇴하시겠어요? <br>
										    	탈퇴하시면 회원님의 반려견 정보와 펫시터의 일지, 본인이 작성한 리뷰가 모두 사라져요.
										    </b></div>
										    <br><br>
										    <div class="form-group col-md-5 col-md-offset-7 row">
										    	<input type="text" class="form-control" name="cus_id" id="cus_id" value="<%=cus.getCus_id() %>" readonly hidden="hidden">
										    	<label for="cus_passwd">본인 확인을 위해 비밀번호를 입력해주세요.</label> 
												<input type="password" class="form-control" name="cus_passwd" id="cus_passwd" placeholder="비밀번호를 입력해주세요." required="required">
											</div>
										</div>
										<button type="submit" id="colorch" class="btn btn-light">완료</button>
								    </td>
								</tr>
							</table>
							
						</form>
						
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

<jsp:include page="layout/footer.inc.jsp" flush="false"/>
