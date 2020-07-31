<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="petmily.petsitter.PetsitterDBBean" %>
<%@ page import="petmily.petsitter.PetsitterDataBean" %>

<%@ page import="petmily.manager.ManMonDBBean" %>
<%@ page import="petmily.manager.ManMonDataBean" %>

<%@ page import = "java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

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
	if(session.getAttribute("pet_id")==null)
	{
%>
		alert("<펫시터> 로그인 후 이용가능한 서비스입니다.\n메인페이지로 이동합니다.");
		self.close();
		parent.location.replace("index.jsp"); // 추가
<% 
	} else {
%>
</script>

<jsp:useBean id="petsitter" class="petmily.petsitter.PetsitterDataBean">
     <jsp:setProperty name="petsitter" property="*"/>
</jsp:useBean>

<jsp:useBean id="manager" class="petmily.manager.ManMonDataBean">
     <jsp:setProperty name="manager" property="*"/>
</jsp:useBean>

<%
	request.setCharacterEncoding("utf-8"); 
	
	String id = request.getParameter("pet_id");
	int petMile = Integer.parseInt(request.getParameter("pet_mile")); // 환급하고 싶은 돈
	int petMileNow = 0; // 환급하고 난 잔액 초기화

	String title = "펫밀리:"+id+"님의 마일리지 환급";	
	
	petsitter.setPet_id(id);
	petsitter.setPet_mile(petMile);
	
	PetsitterDBBean charge = PetsitterDBBean.getInstance();
	int petMileBefore = charge.getPetMileage(id); // 기존 마일리지 출력

	if ((petMileBefore-petMile) < 0) {
%>
	<script>
	    alert("보유 마일리지 금액보다 큰 금액을 입력했어요. 다시 입력해주세요.");
		location.href="pet_my_mileage.jsp";
	</script>
<%		
	} else {
		
		// 펫시터 환급
		petMileNow = petMileBefore - petMile;
		charge.updateMileage(petMileNow, id);
		
		// 관리자 계좌에서 금액 감소
		ManMonDBBean manMon = ManMonDBBean.getInstance();
		int monMile = manMon.getTotMileage();

		String name = charge.getPetName(id);
		
		manager.setMon_id(id);
		manager.setMon_name(name);
		
		System.out.println(name + "는 펫시터 이름");
		
		manager.setMon_kind("펫시터");
		manager.setMon_mile(petMile);
		manager.setMon_miletot(monMile-petMile);
		manager.setMon_date(new Timestamp(System.currentTimeMillis()) );
		
		manMon.insertMile(manager); 
%>
	<script>
	    alert("환급이 성공적으로 완료되었어요.");
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
										    	<%=petsitter.getPet_id() %>님, 마일리지를 충전이 완료되었어요. <br><br>
										    </b></div>
										    <div class="form-group col-md-5 col-md-offset-7 row" style="font-size:15px;">
										    	<label>
											    	기존 마일리지 : <%=petMileBefore %><br>
											    	환급 마일리지 : <%=petMile %><br>
											    	현재 마일리지 : <%=petMileNow %>
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

<script>
<%
	}
%>
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false"/>
	
<%		
	} 
%>

