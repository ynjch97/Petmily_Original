<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="petmily.customer.DogDataBean"%>
<%@ page import="petmily.customer.DogDBBean"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:반려견 정보 수정";
%>
	
<%
String cus_id = (String) session.getAttribute("cus_id"); //id

DogDBBean dog = DogDBBean.getInstance();
DogDataBean d = dog.getDogs(cus_id);
String gender = d.getDog_gender();
String reg = d.getDog_reg();
String surg = d.getDog_surg();
String fri = d.getDog_fri();
String bow = d.getDog_bow();
String bow_spec = d.getDog_bow_spec();
String sick = d.getDog_sick();
String sick_spec = d.getDog_sick_spec();
String poo = d.getDog_poo();
String poo_spec = d.getDog_poo_spec();
%>

<link rel="stylesheet" href="styles/style.css">
<style>
.circle {
	cursor:pointer;
}
.p-image {
	cursor:pointer;
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

<jsp:include page="layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<!-- Home -->

<div id="j-container">
	<article class="container">
		<div id="j-content">
			<ul class="nav nav-tabs">
			<li class="nav-item">
				<a class="nav-link" href="cus_my_reserve.jsp" style="color: #000000; font-size: 15px;">
					예약내역 관리
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="cus_my_info.jsp" style="color: #000000; font-size: 15px;">
					개인정보 수정
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link active" href="cus_my_pet.jsp" style="color: #000000; font-size: 15px;">
					<b>반려견 정보 수정</b>
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="cus_my_matching.jsp" style="color: #000000; font-size: 15px;">
					매칭 정보 수정
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="cus_my_delete.jsp" style="color: #000000; font-size: 15px;">
					회원 탈퇴
				</a>
			</li>
		</ul>
			<div class="card">
				<div class="card-body">
					<div class="page-header">
						<big><b>반려견 정보 수정</b></big>
					</div><br>
					<div>
						<form role="form" method="post" action="cus_my_pet_pro.jsp">
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
												<img class="profile-pic" src="imageFile/<%=d.getDog_pic()%>">
<%-- <img class="profile-pic" src="C:/_server/Petmily/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/petmily/imageFile/<%=d.getDog_pic()%>"> --%>
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
								<input type="text" class="form-control" name="dog_name" id="dog_name" value="<%=d.getDog_name()%>" readonly>
							</div>
							<div class="form-group col-md-3 col-md-offset-3">
								<label for="dog_gender" style="font-weight:bold;">성별</label>						
								<div class="input-group">
									<label class="genderrb">남 
										<input type="radio" id="dog_gender" name="dog_gender" value="1"
										<%if (gender != null && gender.equals("1")) {%> checked <%}%> /> 
										<span class="rb"></span></label>
									<div class="col-sm-10">
										<label class="genderrb">여 
											<input type="radio" id="dog_gender" name="dog_gender" value="0"
											<%if (gender != null && gender.equals("0")) {%> checked <%}%> /> 
											<span class="rb"></span></label>
									</div>
								</div>
							</div>
							<div class="form-group col-md-4 col-md-offset-3">
								<label for="kind">품종</label> 
								<input type="kind" class="form-control" id="kind" value="<%=d.getDog_kind()%>" readonly>
							</div>
							<div class="form-group col-md-3 col-md-offset-3">
								<label for="dog_wei">무게</label>
								<div class="input-group">
									<input type="weight" class="form-control" name="dog_wei" id="dog_wei" value="<%=d.getDog_wei()%>">kg
								</div> 
							</div>
							<div class="form-group col-md-5 col-md-offset-3">
								<label for="username">생년월일</label>
								<input type="text" class="form-control" name="dog_birth" id="dog_birth" value="<%=d.getDog_birth()%>" readonly>
							</div><br>
							<div class="form-group col-md-9 col-md-offset-3">
								<textarea name="dog_rqrd" class="form-control" rows="5" id="dog_rqrd" name="dog_rqrd"><%=d.getDog_rqrd()%></textarea>
							</div><br><hr><br>
							<div class="form-group col-md-9 col-md-offset-3"> 
								<label for="qna">반려동물 등록을 하였습니까?</label>
								<div>
									<label class="genderrb">내장형 무선식별장치 개체삽입
										<input type="radio" id="dog_reg" name="dog_reg" value="1"
										<%if (reg != null && reg.equals("1")) {%> checked <%}%> /> 
										<span class="rb"></span></label>
									<label class="genderrb">외장형 무선식별장치 부착
										<input type="radio" id="dog_reg" name="dog_reg" value="2"
										<%if (reg != null && reg.equals("2")) {%> checked <%}%> />
										<span class="rb"></span></label>
									<label class="genderrb">등록인식표 부착
										<input type="radio" id="dog_reg" name="dog_reg" value="3"
										<%if (reg != null && reg.equals("3")) {%> checked <%}%> />
										<span class="rb"></span></label>
									<label class="genderrb">하지 않음
										<input type="radio" id="dog_reg" name="dog_reg" value="4"
										<%if (reg != null && reg.equals("4")) {%> checked <%}%> />
										<span class="rb"></span></label>
								</div>
							</div><br> 
							<div class="form-group col-md-9 col-md-offset-3"> 
								<label for="qna">중성화 수술을 하였습니까?</label>
								<div class="input-group">
									<label class="genderrb">네
										<input type="radio" id="dog_surg" name="dog_surg" value="1"
										<%if (surg != null && surg.equals("1")) {%> checked <%}%> /> 
										<span class="rb"></span></label>
									<div class="col-sm-10">
										<label class="genderrb">아니오
											<input type="radio" id="dog_surg" name="dog_surg"  value="2"
											<%if (surg != null && surg.equals("2")) {%> checked <%}%> /> 
											<span class="rb"></span></label>
									</div>
								</div>
							</div><br>
							<div class="form-group col-md-9 col-md-offset-3">
								<label for="qna">다른 개와 친화적입니까?</label>
								<div class="input-group">
									<label class="genderrb">네
										<input type="radio" id="dog_fri" name="dog_fri"  value="1"
										<%if (fri != null && fri.equals("1")) {%> checked <%}%> /> 
										<span class="rb"></span></label>
									<div class="col-sm-10">
										<label class="genderrb">아니오
											<input type="radio" id="dog_fri" name="dog_fri" value="2"
											<%if (fri != null && fri.equals("2")) {%> checked <%}%> />
											<span class="rb"></span></label>
									</div>
								</div>
							</div><br>
							<div class="form-group col-md-9 col-md-offset-3">
								<label for="dog_bow" style="font-weight:bold;">잘 짖습니까?</label><br> 
								<div class="input-group">
									<label class="genderrb" id="yes1">네
										<input type="radio" id="dog_bow" name="dog_bow" value="1" 
										<%if (bow != null && bow.equals("1")) {%> checked <%}%> />
										<span class="rb"></span></label>
									<div class="col-sm-10">
										<label class="genderrb" id="no1">아니오
											<input type="radio" id="dog_bow" name="dog_bow" value="2" 
											<%if (bow != null && bow.equals("2")) {%> checked <%}%> />
											<span class="rb"></span></label>
									</div> 
								</div>
								<textarea name="dog_bow_spec" id="dog_bow_spec" class="form-control" rows="4"
									placeholder="짖는다면 어떤 상황에서 짖나요?&#13;&#10;짖을 경우에 따로 주의를 주는행동이 있나요?"><%=d.getDog_bow_spec()%></textarea> 
							</div><br>
							<div class="form-group col-md-9 col-md-offset-3">
								<label for="dog_sick" style="font-weight:bold;">앓고 있는 지병이나 이전에 다쳤던 적이 있나요?</label><br> 
								<div class="input-group">
									<label class="genderrb" id="yes2">네
										<input type="radio" id="dog_sick" name="dog_sick" value="1" 
										<%if (sick != null && sick.equals("1")) {%> checked <%}%> />
										<span class="rb"></span></label>
									<div class="col-sm-10">
										<label class="genderrb" id="no2">아니오
											<input type="radio" id="dog_sick" name="dog_sick" value="2" 
											<%if (sick != null && sick.equals("2")) {%> checked <%}%> />
											<span class="rb"></span></label>
									</div>
								</div>
								<textarea name="dog_sick_spec" id="dog_sick_spec" class="form-control" rows="4"
									placeholder="아프거나 아팠던 적이 있다면 자세히 적어주세요.&#13;&#10;또한 관리해서 주의해야 할 행동도 알려주세요."><%=d.getDog_sick_spec()%></textarea>
							</div><br>
							<div class="form-group col-md-9 col-md-offset-3">
								<label for="dog_poo" style="font-weight:bold;">당신의 반려견은 대소변을 잘 가리는 편입니까?</label><br> 
								<div class="input-group">
									<label class="genderrb" id="yes3">네
										<input type="radio" id="dog_poo" name="dog_poo" value="1" 
										<%if (poo != null && poo.equals("1")) {%> checked <%}%> />
										<span class="rb"></span></label>
									<div class="col-sm-10">
										<label class="genderrb" id="no3">아니오
											<input type="radio" id="dog_poo" name="dog_poo" value="2"
											<%if (poo != null && poo.equals("2")) {%> checked <%}%> />
											<span class="rb"></span></label>
									</div>
								</div>
								<textarea name="dog_poo_spec" id="dog_poo_spec" class="form-control" rows="4"
									placeholder="주로 어느 곳에 대소변을 보는지 알려주세요."><%=d.getDog_poo_spec()%></textarea>
							</div><br><hr><br>
							<div class="form-group col-md-9 col-md-offset-3">
								<b>반려동물이 자주 다니는 동물병원을 입력해주세요.<br>위급시 사용될 수 있는 중요한 정보입니다.</b>
							</div><br>
							<div class="form-group col-md-3 col-md-offset-3">
								<label for="username">병원명</label> 
								<input type="text" class="form-control" id="dog_hspt" name="dog_hspt" value="<%=d.getDog_hspt()%>">
							</div>
							<div class="form-group col-md-4 col-md-offset-3">
								<label for="InputPhone">전화번호</label> 
								<input type="text" class="form-control" id="dog_hspt_tel" name="dog_hspt_tel" value="<%=d.getDog_hspt_tel()%>">
							</div>
						<div class="form-group col-md-9 col-md-offset-3">
								<label style="font-weight:bold;">주소</label>
								<div class="input-group">
									<input type="text" class="form-control" name="dog_hspt_post" id="dog_hspt_post" readonly="readonly" value="<%=d.getDog_hspt_post()%>" required="required"> 
									<span class="input-group-btn input-group-append">
										<button class="btn btn-outline-secondary" id="postcodeBtn" type="button">우편번호</button>
									</span>
								</div>
								<br> 
								<input type="text" name="dog_hspt_addr" class="form-control" value="<%=d.getDog_hspt_addr()%>">
							</div>
							<div class="form-group text-right">
								<button type="submit" id="colorch" class="btn btn-light" onclick="button1_click();">완료</button>
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
	