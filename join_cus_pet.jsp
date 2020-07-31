<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>

<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:회원가입 2/3";
%>

<%
	String cus_id = "";
	cus_id = request.getParameter("cus_id");
%>

<link rel="stylesheet" href="styles/style.css">

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

<style>
.circle {
	cursor:pointer;
}
.p-image {
	cursor:pointer;
}
</style>

<jsp:include page="layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<!-- Home -->

<div id="j-container">
	<article class="container">
		<div id="j-content">
			<ul class="nav nav-tabs">
				<li class="nav-item">
					<a class="nav-link active" href="join_cus.jsp" style="color: #000000; font-size: 15px;">
						<b>고객 회원가입</b>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="join_pet.jsp" style="color: #000000; font-size: 15px;">
						펫시터 회원가입
					</a>
				</li>
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
                  <div class="text-center bs-wizard-stepnum" style="font-weight:bold;">반려견 정보 입력</div>
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
						<form class="form" method="post" name="join_cus_pet_form" action="join_cus_pet_pro.jsp?cus_id=<%= cus_id%>" enctype="multipart/form-data">
							<div class="form-group col-md-9 col-md-offset-3" style="padding-top:30px;">	
								<label for="dog_pic" style="font-weight:bold;">반려견 사진 등록</label>
								<!-- <div class="input-group">
									<input type="file" name="dog_pic" id="dog_pic" placeholder="반려견 사진을 등록해주세요">
								</div> -->
								<div class="input-group" style="padding-bottom:200px;">
									<div class="row">
										<div class="small-12 medium-2 large-2 columns">
											<div class="circle">
												<!-- User Profile Image -->
												<img class="profile-pic" src="images/img.png">

												<!-- Default Image -->
												<!-- <i class="fa fa-user fa-5x"></i> -->
											</div>
											<div class="p-image">
												<i class="fa fa-pencil-alt upload-button" style="font-size:30px;"></i>
												<input class="file-upload" type="file" name="dog_pic" id="dog_pic" accept="image/*"/>
											</div>
										</div>
									</div>
								<!-- <input type="file" name="dog_pic" id="dog_pic" placeholder="반려견 사진을 등록해주세요"> -->
								</div>
							</div>
							<div class="form-group col-md-3 col-md-offset-3">
								<label for="dog_name" style="font-weight:bold;">이름</label> 
								<input type="text" class="form-control" name="dog_name" id="dog_name" placeholder="이름을 입력해 주세요" required="required">
							</div>
							<div class="form-group col-md-3 col-md-offset-3">
								<label for="dog_gender" style="font-weight:bold;">성별</label>						
								<div class="input-group">
									<label class="genderrb">남
									<input type="radio" name="dog_gender" id="dog_gender" value="1" required="required"/><span class="rb"></span></label>    
									<div class="col-sm-10">
									<label class="genderrb">여
									<input type="radio" name="dog_gender" id="dog_gender" value="0" required="required"/><span class="rb"></span></label>
									</div>
								</div>
							</div>
							<div class="form-group col-md-4 col-md-offset-3">
								<label for="dog_kind" style="font-weight:bold;">품종</label> 
								<input type="text" class="form-control" name="dog_kind" id="dog_kind" placeholder="품종을 입력해 주세요" required="required">
							</div>
							<div class="form-group col-md-3 col-md-offset-3">
								<label for="dog_wei" style="font-weight:bold;">무게</label>
								<div class="input-group">
									<input type="text" class="form-control" name="dog_wei" id="dog_wei" placeholder="무게를 입력해 주세요" required="required"> kg
								</div>
							</div>
							<div class="form-group col-md-5 col-md-offset-3">
							<label for="dog_birth" style="font-weight:bold;">생년월일</label>
								<div class="input-group">
									<!-- <input type="text" class="form-control" name="cus_birth" id="cus_birth" placeholder="년도" > -->
									<select class="form-control" name="dog_birth_year">
										<option selected value=0>년도</option>
										<%
											Timestamp nowTime  = new Timestamp(System.currentTimeMillis());
									        int lastYear = Integer.parseInt(nowTime.toString().substring(0,4));
									        	for(int i=lastYear;i>=1990;i--){
										%>
										<option value=<%=i%>><%=i%></option>
										<%
											}
										%>
									</select> 년
										
									<select class="form-control" name="dog_birth_month">
										<option selected value=0>월</option>
										<%
											for (int i = 1; i < 13; i++) {
										%>
										<option value=<%=i%>><%=i%></option>
										<%
											}
										%>
									</select> 월
									
									<select class="form-control" name="dog_birth_day">
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
							<br>
							<div class="form-group col-md-9 col-md-offset-3">
								<label for="dog_rqrd" style="font-weight:bold;">관리지침 및 요청사항</label>
								<textarea name="dog_rqrd" id="dog_rqrd" class="form-control" rows="5" placeholder="관리지침 및 요청사항이 있다면 적어주세요"></textarea>
							</div>
						
							<br><hr><br>
							
							<div class="form-group col-md-9 col-md-offset-3">
								<label for="dog_reg" style="font-weight:bold;">반려동물 등록을 하였습니까?</label>
								<div>
									<label class="genderrb">내장형 무선식별장치 개체삽입
										<input type="radio" name="dog_reg" id="dog_reg" value="1" required="required"/><span class="rb"></span></label>
									<label class="genderrb">외장형 무선식별장치 부착
										<input type="radio" name="dog_reg" id="dog_reg" value="2" /><span class="rb"></span></label>
									<label class="genderrb">등록인식표 부착
										<input type="radio" name="dog_reg" id="dog_reg" value="3" /><span class="rb"></span></label>
									<label class="genderrb">하지 않음
										<input type="radio" name="dog_reg" id="dog_reg" value="4" /><span class="rb"></span></label>
								</div>
							</div><br>
							<div class="form-group col-md-9 col-md-offset-3">
								<label for="dog_surg" style="font-weight:bold;">중성화 수술을 하였습니까?</label>
								<div class="input-group">
									<label class="genderrb">네
									<input type="radio" name="dog_surg" id="dog_surg" value="1" required="required"/><span class="rb"></span></label>
									<div class="col-sm-10">
									<label class="genderrb">아니오
									<input type="radio" name="dog_surg" id="dog_surg" value="2" /><span class="rb"></span></label>
									</div>
								</div>
							</div><br>
							<div class="form-group col-md-9 col-md-offset-3">
								<label for="dog_fri" style="font-weight:bold;">다른 개와 친화적입니까?</label>
								<div class="input-group">
									<label class="genderrb">네
									<input type="radio" name="dog_fri" id="dog_fri" value="1" required="required"/><span class="rb"></span></label>
									<div class="col-sm-10">
									<label class="genderrb">아니오
									<input type="radio" name="dog_fri" id="dog_fri" value="2" /><span class="rb"></span></label>
									</div>
								</div>
							</div><br>
							<div class="form-group col-md-9 col-md-offset-3">
								<label for="dog_bow" style="font-weight:bold;">잘 짖습니까?</label><br> 
								<div class="input-group">
									<label class="genderrb" id="yes1">네
									<input type="radio" name="dog_bow" id="dog_bow" value="1" required="required"/><span class="rb"></span></label>
									<div class="col-sm-10">
									<label class="genderrb" id="no1">아니오
									<input type="radio" name="dog_bow" id="dog_bow" value="2" /><span class="rb"></span></label>
									</div>
								</div>
								<textarea name="dog_bow_spec" id="dog_bow_spec" class="form-control" rows="4" style="display:none;"
									placeholder="짖는다면 어떤 상황에서 짖나요?&#13;&#10;짖을 경우에 따로 주의를 주는행동이 있나요?"></textarea> 
							</div><br>
							<div class="form-group col-md-9 col-md-offset-3">
								<label for="dog_sick" style="font-weight:bold;">앓고 있는 지병이나 이전에 다쳤던 적이 있나요?</label><br> 
								<div class="input-group">
									<label class="genderrb" id="yes2">네
									<input type="radio" name="dog_sick" id="dog_sick" value="1" required="required"/><span class="rb"></span></label>
									<div class="col-sm-10">
									<label class="genderrb" id="no2">아니오
									<input type="radio" name="dog_sick" id="dog_sick" value="2" /><span class="rb"></span></label>
									</div>
								</div>
								<textarea name="dog_sick_spec" id="dog_sick_spec" class="form-control" rows="4" style="display:none;"
									placeholder="아프거나 아팠던 적이 있다면 자세히 적어주세요.&#13;&#10;또한 관리해서 주의해야 할 행동도 알려주세요."></textarea>
							</div><br>
							<div class="form-group col-md-9 col-md-offset-3">
								<label for="dog_poo" style="font-weight:bold;">당신의 반려견은 대소변을 잘 가리는 편입니까?</label><br> 
								<div class="input-group">
									<label class="genderrb" id="yes3">네
									<input type="radio" name="dog_poo" id="dog_poo" value="1" required="required"/><span class="rb"></span></label>
									<div class="col-sm-10">
									<label class="genderrb" id="no3">아니오
									<input type="radio" name="dog_poo" id="dog_poo" value="2" /><span class="rb"></span></label>
									</div>
								</div>
								<textarea name="dog_poo_spec" id="dog_poo_spec" class="form-control" rows="4" style="display:none;" 
									placeholder="주로 어느 곳에 대소변을 보는지 알려주세요."></textarea>
							</div><br><hr><br>
							<div class="form-group col-md-9 col-md-offset-3">
								<b>반려동물이 자주 다니는 동물병원을 입력해주세요.<br>위급시 사용될 수 있는 중요한 정보입니다.</b>
							</div><br>
							<div class="form-group col-md-3 col-md-offset-3">
								<label for="dog_hspt" style="font-weight:bold;">병원명</label> 
								<input type="text" class="form-control" name="dog_hspt" id="dog_hspt" placeholder="병원명 입력해 주세요" required="required">
							</div>
							<div class="form-group col-md-4 col-md-offset-3">
								<label for="dog_hspt_tel" style="font-weight:bold;">전화번호</label> 
								<input type="text" class="form-control" name="dog_hspt_tel" id="dog_hspt_tel" placeholder="전화번호를 -없이 입력해 주세요" required="required">
							</div>
							<div class="form-group col-md-9 col-md-offset-3">
								<label style="font-weight:bold;">주소</label>
								<div class="input-group">
									<input type="text" class="form-control" name="dog_hspt_post" id="dog_hspt_post" readonly="readonly" placeholder="우편번호 버튼을 클릭하여 입력" required="required"> 
									<span class="input-group-btn input-group-append">
										<button class="btn btn-outline-secondary" id="postcodeBtn" type="button">우편번호</button>
									</span>
								</div>
								<br> 
								<input type="text" name="dog_hspt_addr" class="form-control" placeholder="상세주소를 입력해주세요">
							</div>		
							<br><br>
							<div class="form-group text-right">
							<input type="button" style="width:80px;" value="이전" class="btn btn-light" onclick="history.go(-1);">
								<button type="submit" id="colorch" style="width:80px;" class="btn btn-light">다음</button>
								
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
	$('#dog_hspt_post').click(function(){
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

            $('#dog_hspt_post').val(data.zonecode);
            $('input[name="dog_hspt_addr"]').val(fullRoadAddr);
        }
    }).open();
}
</script>

<script src='https://code.jquery.com/jquery-2.2.4.min.js'></script>
<script  src="js/index.js"></script>
	
<script>
<%
	}
%>
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false"/>
	