<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>

<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:회원가입 1/3";
%>

<style>
.btn span.fa {
	opacity: 0;
}

.btn.active span.fa {
	opacity: 1;
}
</style>

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
   <jsp:param name="title" value="<%=title %>"/>
</jsp:include>

<!-- Home -->

<div id="j-container">
	<article class="container">
		<div id="j-content">
		<ul class="nav nav-tabs">
			<li class="nav-item">
				<a class="nav-link" href="join_cus.jsp" style="color: #000000; font-size: 15px;">
					고객 회원가입
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link active" href="join_pet.jsp" style="color: #000000; font-size: 15px;">
					<b>펫시터 회원가입</b>
				</a>
			</li>
		</ul>
			<div class="card" >
 					<div class="card-body">
					<div class="row bs-wizard" style="border-bottom:0;">
                
                <div class="col-xs-3 bs-wizard-step complete">
                  <div class="text-center bs-wizard-stepnum">약관 동의</div>
                  <div class="progress"><div class="progress-bar"></div></div>
                  <a href="#" class="bs-wizard-dot"></a>
                 
                </div>
                
                <div class="col-xs-3 bs-wizard-step active">
                  <div class="text-center bs-wizard-stepnum" style="font-weight:bold;">개인정보 입력</div>
                  <div class="progress"><div class="progress-bar"></div></div>
                  <a href="#" class="bs-wizard-dot"></a>
                  
                </div>
                
                <div class="col-xs-3 bs-wizard-step disabled">
                  <div class="text-center bs-wizard-stepnum">소개 정보 입력</div>
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
								<form class="form" method="post" name="join_pet_form" action="join_pet_pro.jsp" enctype="multipart/form-data">
									<div class="form-group col-md-3 col-md-offset-3" style="padding-top:30px;">
										<label for="pet_id" style="font-weight:bold;">아이디</label>
										<div class="input-group">
											<input type="text" class="form-control" name="pet_id" id="pet_id" placeholder="아이디" required="required"> 
											<span class="input-group-btn">
												<button class="btn btn-outline-secondary">중복확인</button>
											</span>
										</div>
									</div>
									
									<div class="form-group col-md-4 col-md-offset-3">
				                        <label for="pet_passwd" style="font-weight:bold;">비밀번호</label> 
				                        <input type="password" class="form-control" name="pet_passwd" id="pet_passwd" placeholder="비밀번호" required="required">
				                    </div>
									
									<div class="form-group col-md-4 col-md-offset-3">
				                        <label for="pet_passwd2" style="font-weight:bold;">비밀번호 확인</label>
				                        <input type="password" class="form-control" name="pet_passwd2" id="pet_passwd2" placeholder="비밀번호 확인">
				                        <p class="help-block" name="pwdcheck">비밀번호 확인을 위해 다시한번 입력해주세요</p>
				                     </div> 
                    
									<div class="form-group col-md-3 col-md-offset-3">
										<label for="pet_name" style="font-weight:bold;">이름</label> 
										<input type="text" class="form-control" name="pet_name" id="pet_name" placeholder="이름을 입력해 주세요" required="required">
									</div>
									<div class="form-group col-md-3 col-md-offset-3">
										<label for="pet_gender" style="font-weight:bold;">성별</label>
										<!-- <div class="input-group">
											<input type="radio" name="pet_gender" id="pet_gender" value="1" required="required" />남
											<div class="col-sm-10">
											<input type="radio" name="pet_gender" id="pet_gender" value="0" />여
											</div>
										</div> -->
										<div class="input-group">
												<label class="genderrb">남
												<input type="radio" name="pet_gender" id="pet_gender" value="1" required="required" /><span class="rb"></span></label>    
												<div class="col-sm-10">
												<label class="genderrb">여
												<input type="radio" name="pet_gender" id="pet_gender" value="0" required="required"/><span class="rb"></span></label>
												</div>
										</div>
									</div>
									<div class="form-group col-md-5 col-md-offset-3">
										<label for="pet_birth" style="font-weight:bold;">생년월일</label>
										<div class="input-group">
											<!-- <input type="text" class="form-control" name="pet_birth" id="pet_birth" placeholder="년도" required="required"> -->
											<select class="form-control" name="pet_birth_year">
												<option selected value=0>년도</option>
												<%
													Timestamp nowTime  = new Timestamp(System.currentTimeMillis());
											        int lastYear = Integer.parseInt(nowTime.toString().substring(0,4));
											        	for(int i=lastYear;i>=1910;i--){
												%>
												<option value=<%=i%>><%=i%></option>
												<%
													}
												%>
											</select> 년
												
											<select class="form-control" name="pet_birth_month">
												<option selected value=0>월</option>
												<%
													for (int i = 1; i < 13; i++) {
												%>
												<option value=<%=i%>><%=i%></option>
												<%
													}
												%>
											</select> 월
											
											<select class="form-control" name="pet_birth_day">
												<option selected value=0>일</option>
												<%
													for (int i = 1; i < 32; i++) {
												%>
												<option value=<%=i%>><%=i%></option>
												<%
													}
												%>
											</select> 일
										</div>
									</div>
									
									<div class="form-group col-md-4 col-md-offset-3">
										<label for="pet_phone" style="font-weight:bold;">휴대폰번호</label> 
										<input type="text" class="form-control" name="pet_phone" id="pet_phone" placeholder="휴대폰번호를 -없이 입력해 주세요" required="required">
									</div>
									
									<div class="form-group col-md-9 col-md-offset-3">
										<label style="font-weight:bold;">주소</label>
										<div class="input-group">
											<input type="text" class="form-control" name="pet_post" id="pet_post" readonly="readonly" placeholder="우편번호 버튼을 클릭하여 입력" required="required"> 
											<span class="input-group-btn input-group-append">
												<button class="btn btn-outline-secondary" id="postcodeBtn" type="button">우편번호</button>
											</span>
										</div>
										<br> 
										<input type="text" name="pet_addr" class="form-control" placeholder="상세주소를 입력해주세요">
									</div>
									
									<br><br>
									
									<div class="form-group col-md-12 col-md-offset-3">					
										<div> <b>펫시터 자격 확인을 위해, 반려동물관리사 자격증을 인증하여 주세요.</b><br>
											다음과 같이 자격종목, 자격번호, 성명, 생년월일, 취득날짜가 모두 나올 수 있도록 하여 촬영한 이미지를 첨부해 주세요.<br><br>
											<div class="card"  style="width:40%;">
													<div class="card-body">
													<!-- <label>예시 이미지) </label> -->
													<img src="images/reallicense.PNG" alt="" style="max-width:100%;">
												</div>
											</div>
										</div>
									</div>
									<div class="form-group col-md-9 col-md-offset-3">
										<label label for="pet_lic" style="font-weight:bold;">이미지 업로드</label>				
										<div class="input-group">
											<input type="file" name="pet_lic" id="pet_lic" placeholder="반려견 사진을 등록해주세요">
										</div>
									</div>
									
									<br><br>
									
									<!-- <div class="form-group col-md-12 col-md-offset-3">
										<label>약관 동의</label>
										<textarea name="law" class="form-control" rows="4" style="color:#76777a; text-align:left;">제 1 장 총칙&#13;&#10;제 1 조 (목적)&#13;&#10;이 약관은 펫밀리(이하 ‘회사’라 합니다.)가 제공하는 펫시터 중개 서비스 및 펫밀리 관련 제반 서비스(이하 ‘서비스'라고 하며, 접속 가능한 유∙무선 단말기의 종류와는 상관없이 이용 가능한 ‘회사'가 제공하는 모든 ‘서비스'를 의미합니다. 이하 같습니다)를 이용자(이하 ‘회원’)가 이용함에 있어 회사와 회원간의 권리와 의무, 책임사항 및 회사의 서비스 이용절차에 관한 필요사항을 규정함을 목적으로 합니다.
										</textarea><br>
										<div data-toggle="buttons">
											<label class="btn btn-primary active"> 
												<span class="fa fa-check"></span> 
												<input id="agree" type="checkbox" autocomplete="off" checked>
											</label>
													이용약관에 동의합니다.
										</div>
									</div> -->
									
									<br><br>
									
									<div class="form-group text-right">	
									<input type="button" style="width:80px;" value="이전" class="btn btn-light" onclick="history.go(-1);">
										<button type="submit" id="colorch" class="btn btn-light" style="width:80px;">다음</button>
									</div>
								</form>
							</div>
					</div>
				</div>
			</div>
	</article>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/aban/assets/bootstrap-4.1.0/js/bootstrap.min.js"></script>  
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>

$(document).ready(function(){
	$('#pet_post').click(function(){
    	//fetchDaumPostcode();
		$('#postcodeBtn').trigger('click');
	});
	$('#postcodeBtn').click(function(){
    	fetchDaumPostcode();
	});
});

function fetchDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 도로명 조합형 주소 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }
            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
            if(fullRoadAddr !== ''){
                fullRoadAddr += extraRoadAddr;
            }

            $('#pet_post').val(data.zonecode);
            $('input[name="pet_addr"]').val(fullRoadAddr);
        }
    }).open();
}

//비밀번호 확인
$(document).ready(function(){
    if($('#pet_passwd').val()=='' && $('#pet_passwd2').val()==''){         
        $('p[name=pwdcheck]').html("비밀번호 확인을 위해 다시 한번 입력해 주세요.");
        $('p[name=pwdcheck]').css('color','black');
    }
    $('#pet_passwd2').keyup(function(){
        if($('#pet_passwd').val()!=$('#pet_passwd2').val()){           
            $('p[name=pwdcheck]').html("비밀번호 불일치");
            $('p[name=pwdcheck]').css('color','red');
        }else{
            $('p[name=pwdcheck]').html("비밀번호 일치");
            $('p[name=pwdcheck]').css('color','blue');
        }
    }); 
});

</script>

<script>
<%
	}
%>
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false"/>