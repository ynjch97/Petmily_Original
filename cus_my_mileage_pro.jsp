<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="petmily.customer.CustomerDBBean" %>
<%@ page import="petmily.customer.CustomerDataBean" %>
<%@ page import="petmily.manager.ManMonDBBean" %>
<%@ page import="petmily.manager.ManMonDataBean" %>

<%-- <%@ page import = "java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%> --%>

<%
	request.setCharacterEncoding("utf-8"); 
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

<jsp:useBean id="customer" class="petmily.customer.CustomerDataBean">
     <jsp:setProperty name="customer" property="*"/>
</jsp:useBean>

<jsp:useBean id="manager" class="petmily.manager.ManMonDataBean">
     <jsp:setProperty name="manager" property="*"/>
</jsp:useBean>

<%
	String id = request.getParameter("cus_id");
	String name = request.getParameter("cus_name");
	int cusMile = Integer.parseInt(request.getParameter("cus_mile"));
	int cusMileNow = 0;

	String title = "펫밀리:"+id+"님의 마일리지 충전";	
	
	customer.setCus_id(id);
	customer.setCus_mile(cusMile);
	
	CustomerDBBean charge = CustomerDBBean.getInstance();
	int cusMileBefore = charge.getCusMileage(id); // 있던 금액

	if (cusMile != 0 || cusMile > 0) {
		cusMileNow = cusMile + cusMileBefore; // 이제 현재 값은 받아온 값 + 이전 값
		charge.updateMileage(cusMileNow, id);

		// 매니저 매출 관리 쪽으로 들어갈 것
		ManMonDBBean manMon = ManMonDBBean.getInstance();
		int monMile = manMon.getTotMileage();
		
		manager.setMon_id(id);
		manager.setMon_name(name);
		
		System.out.println(name + "는 이름");
		
		manager.setMon_kind("고객");
		manager.setMon_mile(cusMile);
		manager.setMon_miletot(cusMile+monMile);
		manager.setMon_date(new Timestamp(System.currentTimeMillis()) );
		
		manMon.insertMile(manager); 
%>

	<script>
	    alert("충전이 성공적으로 완료되었어요.");
		// location.href="cus_my_mileage.jsp";
	</script>

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
					<a class="nav-link" href="cus_my_delete.jsp" style="color: #090909; font-size: 14px;">
						회원 탈퇴
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active" href="cus_my_mileage.jsp" style="color: #090909; font-size: 14px;">
						<b>마일리지 충전</b>
					</a>
				</li>
			</ul>
			<div class="card">
				<div class="card-body">
					<div class="page-header">
						<b><big>마일리지 충전</big></b>
					</div><br>
					<div style=margin-top:2%;margin-bottom:2%;>
					
						<form class="form" method="post" action="cus_my_mileage_pro.jsp">
							
							<table style=margin-left:5%;margin-right:5%;>
								<colgroup>
									<col width="20%">
									<col width="80%">
								</colgroup>
								<tr>
								    <td> <img class="img-responsive" src="images/dog_7.png" style=width:80%;height=80%;> </td>
								    <td> 
								    	<div id="font_del">
									    	<div id="font_del_main"><b>
										    	<%=customer.getCus_id() %>님, 마일리지를 충전이 완료되었어요. <br><br>
										    </b></div>
										    <div class="form-group col-md-5 col-md-offset-7 row" style="font-size:15px;">
										    	<label>
											    	기존 마일리지 : <%=cusMileBefore %><br>
											    	충전 마일리지 : <%=cusMile %><br>
											    	현재 마일리지 : <%=cusMileNow %>
										    	</label> 
											</div>
											<div id="font_del_main" style="font-size:15px;"><b>
										    	이제 나에게 맞는 펫시터를 찾아보세요. <a href="cus_matching.jsp"><i class="far fa-hand-point-right"></i></a>
										    	<br><br>
										    </b></div>
										</div>
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

<jsp:include page="layout/footer.inc.jsp" flush="false"/>
	
<%		
	} else {		
%>

	<script>
	    alert("값이 잘못되었어요. 다시 입력해주세요.");
		location.href="cus_my_mileage.jsp";
	</script>
	
<%		
	} 
%>
	
<script>
<%
	}
%>
</script>




