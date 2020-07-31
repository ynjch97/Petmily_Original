<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="petmily.petsitter.PetsitterDataBean"%>
<%@ page import="petmily.petsitter.PetsitterDBBean"%>
<%
	request.setCharacterEncoding("UTF-8");
	String pet_id = (String) session.getAttribute("pet_id"); //id
	String pet_passwd = (String) session.getAttribute("pet_passwd"); //pw
	String title = "펫밀리:"+pet_id+"님의 탈퇴";
%>

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

<%
	PetsitterDBBean pets = PetsitterDBBean.getInstance();
	PetsitterDataBean pet = null;
	pet = pets.getPetsitter(pet_id);	
%>

<jsp:include page="layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<!-- Home -->
<div id="j-container">
	<article class="container">
		<div id="j-content">
			<ul class="nav nav-tabs">
				<li class="nav-item">
					<a class="nav-link" href="pet_my_money.jsp" style="color: #000000; font-size: 15px;"> 
						매출관리 
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="pet_my_info.jsp" style="color: #000000; font-size: 15px;">
						개인정보 수정
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="pet_matching.jsp" style="color: #000000; font-size: 15px;">
						매칭 정보 수정
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active" href="pet_my_delete.jsp" style="color: #000000; font-size: 15px;">
						<b>회원 탈퇴</b>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="pet_my_mileage.jsp" style="color: #000000; font-size: 15px;">
						마일리지 환급
					</a>
				</li>
			</ul>
			<div class="card">
				<div class="card-body">
					<div class="page-header">
						<big><b>회원 탈퇴</b></big>
					</div>
					<br>
					<div style=margin-top:2%;margin-bottom:2%;>
					
						<form class="form" method="post" action="pet_my_delete_pro.jsp">
							
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
										    	<%=pet.getPet_id() %>님, 정말 탈퇴하시겠어요? <br>
										    	탈퇴하시면 회원님의 반려견 정보와 펫시터의 일지, 본인이 작성한 리뷰가 모두 사라져요.
										    </b></div>
										    <br><br>
										    <div class="form-group col-md-5 col-md-offset-7 row">
										    	<input type="text" class="form-control" name="pet_id" id="pet_id" value="<%=pet.getPet_id() %>" readonly hidden="hidden">
										    	<label for="cus_passwd">본인 확인을 위해 비밀번호를 입력해주세요.</label> 
												<input type="password" class="form-control" name="pet_passwd" id="pet_passwd" placeholder="비밀번호를 입력해주세요." required="required">
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

<jsp:include page="layout/footer.inc.jsp" flush="false" />
