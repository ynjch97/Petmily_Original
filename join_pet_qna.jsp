<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:회원가입 2/3";
%>

<%
	String pet_id = "";
	pet_id = request.getParameter("pet_id");
%>

<style>
.col-md-10{
font-weight:bold;
}
</style>

<link rel="stylesheet" href="styles/pic3.css">

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

<!-- Home -->

<div id="j-container">
	<article class="container">
		<div id="j-content">
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link" href="join_cus.jsp"
					style="color: #000000; font-size: 15px;"> 고객 회원가입 </a></li>
				<li class="nav-item"><a class="nav-link active"
					href="join_pet.jsp" style="color: #000000; font-size: 15px;"><b>펫시터 회원가입</b>
				</a></li>
			</ul>
			<div class="card">
				<div class="card-body">
				
					<div class="row bs-wizard" style="border-bottom:0;">
                
                <div class="col-xs-3 bs-wizard-step complete">
                  <div class="text-center bs-wizard-stepnum">약관 동의</div>
                  <div class="progress"><div class="progress-bar"></div></div>
                  <a href="#" class="bs-wizard-dot"></a>
                 
                </div>
                
                <div class="col-xs-3 bs-wizard-step complete">
                  <div class="text-center bs-wizard-stepnum">개인정보 입력</div>
                  <div class="progress"><div class="progress-bar"></div></div>
                  <a href="#" class="bs-wizard-dot"></a>
                  
                </div>
                
                <div class="col-xs-3 bs-wizard-step active">
                  <div class="text-center bs-wizard-stepnum" style="font-weight:bold;">소개 정보 입력</div>
                  <div class="progress"><div class="progress-bar"></div></div>
                  <a href="#" class="bs-wizard-dot"></a>
                  
                </div>
                
                <div class="col-xs-3 bs-wizard-step disabled">
                  <div class="text-center bs-wizard-stepnum">매칭정보 입력</div>
                  <div class="progress"><div class="progress-bar"></div></div>
                  <a href="#" class="bs-wizard-dot"></a>
                  
                </div>
            </div>
					<div>
					<form class="form" method="post" name="join_pet_qna_form" action="join_pet_qna_pro.jsp?pet_id=<%= pet_id%>" enctype="multipart/form-data">
						<div class="page-header" style="padding-top:30px;">
							<b><big>고객에게 보여질 자신의 소개글을 입력해주세요.</big><br>
							고객이 펫시터를 선택할 때, 본인을 어필할 수 있는 내용으로 입력해주세요.</b>
						</div>
						<br>
						<div style="margin-bottom: 50px;">
							<input type="text" class="form-control" name="pet_intro"
								id="pet_intro" placeholder="50자 이내" required="required"
								maxlength="50" style="width: 890px;">
						</div>
						<div class="page-header">
							<b><big>고객에게 받으실 돌봄비용을 입력해주세요.</big><br>
							돌봄 비용은 1일 기준입니다.</b>
						</div>
						<br>
						<div style="margin-bottom: 50px;">
							<div class="row" style="padding-left:15px;">
							<input type="text" class="form-control" name="pet_cash" id="pet_cash" required="required" maxlength="15" style="width: 250px;">원
								</div>
						</div>
						<div class="page-header" style="margin-top: 50px;">
							<b><big>고객에게 보여질 본인의 거주환경 사진을 업로드 해주세요.</big><br>
							반려견이 주로 지내게 될 공간 위주로, 최소 2장 이상 올려주세요.</b>
						</div>
						<br>
						<div style="margin-bottom: 50px;">
							<div class="wrapper">
								<div class="box profile-pic">
									<div class="js--image-preview"></div>
									<div class="upload-options">
										<label> 
											<input type="file" id="pet_intro1" name="pet_intro1" class="image-upload" accept="image/*" required="required"/>
										</label>
									</div>
								</div>
								<div class="box">
									<div class="js--image-preview"></div>
									<div class="upload-options">
										<label> 
											<input type="file" id="pet_intro2" name="pet_intro2" class="image-upload" accept="image/*"/>
										</label>
									</div>
								</div>
								<div class="box">
									<div class="js--image-preview"></div>
									<div class="upload-options">
										<label> 
											<input type="file" id="pet_intro3" name="pet_intro3" class="image-upload" accept="image/*" />
										</label>
									</div>
								</div>
							</div>
						</div>
						
						<div style="padding-left:10px;">
							<div class="row" style="padding-top: 30px; padding-bottom: 10px;">
								<div class="col-md-10">
										펫시터 활동에 대해 가족 동거인의 동의를 받으셔야합니다.<br> 
										돌봄 중 가족 미동의로 인한 돌봄 포기및 예약 취소는 환불되지 않습니다.
								</div>
								<div class="col-md-2">
									<label class="genderrb">네 <input type="radio" name="q1" id="q1" value="" required="required" />
										<span class="rb"></span>
									</label>
								</div>
							</div>
							<hr>
							<div class="row" style="padding-top: 10px; padding-bottom: 10px;">
								<div class="col-md-10">
										펫밀리는 펫시터와 고객 간 1:1 케어로, 중복 돌봄이 불가합니다.
								</div>
								<div class="col-md-2">
									<label class="genderrb">네 <input type="radio" name="q2" id="q2" value="" required="required" />
										<span class="rb"></span>
									</label>
								</div>
							</div>
							<hr>
							<div style="padding-top: 10px; padding-bottom: 10px;">
								<div style="padding-bottom:15px; font-weight:bold;">
										펫시터의 의무와 책임에 대한 내용을 확인해주세요.<br> 
										펫밀리 펫시터로 활동하기 위해서는 필수적으로 진행해주셔야 하는 내용입니다. (아래내용 모두 체크)
								</div>
								<div>
									<label class="genderrb">거주환경 사진 제공 (반려견이 주로 지내게 될 공간 위주로, 3장) 
											<input type="checkbox" name="q3" id="q3_1" value="" required="required"/> 
											<span class="rb"></span>
										</label> 
										<label class="genderrb">하루 1번 이상 돌봄일지 작성 
											<input type="checkbox" name="q3" id="q3_2" value="" required="required"/> 
											<span class="rb"></span>
										</label>
										<label class="genderrb">관리자와 1:1 채팅 
											<input type="checkbox" name="q3" id="q3_3" value="" required="required"/> 
											<span class="rb"></span>
										</label>
								</div>
							</div>
							<hr>
							<div class="row" style="padding-top: 10px; padding-bottom: 10px;">
								<div class="col-md-10">
										돌봄기간 내에는 자리 비움 없이 돌봄을 진행해주셔야 합니다.
								</div>
								<div class="col-md-2">
									<label class="genderrb">네 
											<input type="radio" name="q4" id="q4" value="" required="required"/> 
											<span class="rb"></span>
										</label>
								</div>
							</div>
							<hr>
							<div class="row" style="padding-top: 10px; padding-bottom: 10px;">
								<div class="col-md-10">
									내 강아지를 키우는 경험과는 전혀 다른 새로운 경험일 것입니다.<br> 
									더 조심스럽고 더 신경써야 할 부분이 많습니다. 그저 귀엽다고만 생각했던 강아지를<br> 
									펫시터 활동을 하면서 더 이해하고 하나의 생명체로서 존중할 수 있기를 진심으로 바랍니다.
								</div>
								<div class="col-md-2">
									<label class="genderrb">네 
											<input type="radio" name="q7" id="q7" value="" required="required"/> 
											<span class="rb"></span>
										</label>
								</div>
							</div>
						</div>
						<div class="form-group text-right" style="margin-top: 50px;">
							<input type="button" style="width:80px;" value="이전" class="btn btn-light" onclick="history.go(-1);">
							<input type="submit" id="colorch" value="다음" class="btn btn-light" style="width:80px;"onclick="javascript:next();">
						</div>					
					</form>
					
					</div>
					
				
											
				</div>
			</div>
		</div>
	</article>
</div>

<script src="js/pic3.js"></script>

<script>
	function next(){
		for(var i =1; i<=5 ;i++){
			if($("#q"+i).is(':checked')!=true){
				alert("모든 문항에 동의하여 주세요");
				return;
			}
		}
		
		$("#qna_form").submit();
		
	};
</script>

<script>
	function next(){
		for(var i =1; i<=5 ;i++){
			if($("#q"+i).is(':checked')!=true){
				alert("모든 문항에 동의하여 주세요");
				return;
			}
		}
	};
</script>

<script>
<%
	}
%>
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false" />