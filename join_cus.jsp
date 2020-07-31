<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>

<%
	request.setCharacterEncoding("UTF-8");
	String title ="펫밀리:회원가입 1/3";
%>

<style>
.btn span.fa {
	opacity: 0;
}

.btn.active span.fa {
	opacity: 1;
}
label{
	font-weight:bold;
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

<script type="text/javascript">
	// 아이디 중복체크 
	function register() {
		var cus_id = $('#cus_id').val();
		$.ajax({
			type: 'POST',
			url: './UserRegisterCheckServlet',
			data: {cus_id: cus_id},
			success: function(result) {
				if(result==1) {
					$('#checkMessage').html('사용할 수 있는 아이디입니다.');
					$('#checkType').attr('class', 'modal-content panel-success');
				} else {
					$('#checkMessage').html('사용할 수 없는 아이디입니다.');
					$('#checkType').attr('class', 'modal-content panel-warning');
				}
				$('#checkModal').modal("show");
			}
		});
	}
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
                
                <div class="col-xs-3 bs-wizard-step active">
                  <div class="text-center bs-wizard-stepnum" style="font-weight:bold;">개인정보 입력</div>
                  <div class="progress"><div class="progress-bar"></div></div>
                  <a href="#" class="bs-wizard-dot"></a>
                  
                </div>
                
                <div class="col-xs-3 bs-wizard-step disabled">
                  <div class="text-center bs-wizard-stepnum">반려견 정보 입력</div>
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
		
						<!-- <form role="form" method="post" action="join_cus_pro.jsp"> -->
						<!-- <form method="post" action="join_cus_pro.jsp"> -->
						<form class="form" method="post" name="join_cus_form" action="join_cus_pro.jsp" enctype="multipart/form-data">
							<div class="form-group col-md-3 col-md-offset-3" style="padding-top:30px;">
								<label for="cus_id">아이디</label>
								<div class="input-group">
									<input type="text" class="form-control" name="cus_id" id="cus_id" placeholder="아이디" required="required"> 
									<span class="input-group-btn">
										<button class="btn btn-outline-secondary" onclick="registerCheck();">중복확인</button>
									</span>
								</div>
							</div>
							<div class="form-group col-md-4 col-md-offset-3">
								<label for="cus_passwd">비밀번호</label> 
								<input type="password" class="form-control" name="cus_passwd" id="cus_passwd" placeholder="비밀번호" required="required">
							</div>
							
							<div class="form-group col-md-4 col-md-offset-3">
		                        <label for="cus_passwd2">비밀번호 확인</label>
		                        <input type="password" class="form-control" name="cus_passwd2" id="cus_passwd2" placeholder="비밀번호 확인">
		                        <p class="help-block" name="pwdcheck">비밀번호 확인을 위해 다시한번 입력해주세요</p>
		                    </div> 
							
							<div class="form-group col-md-3 col-md-offset-3">
								<label for="cus_name">이름</label> 
								<input type="text" class="form-control" name="cus_name" id="cus_name" placeholder="이름을 입력해 주세요" required="required">
							</div>
							<div class="form-group col-md-3 col-md-offset-3">
								<label for="cus_gender">성별</label>
								<!-- <div class="input-group">
									<input type="radio" name="cus_gender" id="cus_gender" value="1" required="required" />남
									<div class="col-sm-10">
									<input type="radio" name="cus_gender" id="cus_gender" value="0" />여
									</div>
								</div> -->
								<div class="input-group">
										<label class="genderrb">남
										<input type="radio" name="cus_gender" id="cus_gender" value="1" required="required" /><span class="rb"></span></label>    
										<div class="col-sm-10">
										<label class="genderrb">여
										<input type="radio" name="cus_gender" id="cus_gender" value="0" required="required"/><span class="rb"></span></label>
										</div>
								</div>
							</div>
							<div class="form-group col-md-5 col-md-offset-3">
								<label for="cus_birth">생년월일</label>
								<div class="input-group">
									<!-- <input type="text" class="form-control" name="cus_birth" id="cus_birth" placeholder="년도" required="required"> -->
									<select class="form-control" name="cus_birth_year">
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
										
									<select class="form-control" name="cus_birth_month">
										<option selected value=0>월</option>
										<%
											for (int i = 1; i < 13; i++) {
										%>
										<option value=<%=i%>><%=i%></option>
										<%
											}
										%>
									</select> 월
									
									<select class="form-control" name="cus_birth_day">
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
								<label for="cus_phone">휴대폰번호</label> 
								<input type="text" class="form-control" name="cus_phone" id="cus_phone" placeholder="휴대폰번호를 -없이 입력해 주세요" required="required">
							</div>

							<div class="form-group col-md-9 col-md-offset-3">
								<label>주소</label>
								<div class="input-group">
									<input type="text" class="form-control" name="cus_post" id="cus_post" readonly="readonly" placeholder="우편번호 버튼을 클릭하여 입력" required="required"> 
									<span class="input-group-btn input-group-append">
										<button class="btn btn-outline-secondary" id="postcodeBtn" type="button">우편번호</button>
									</span>
								</div>
								<br> 
								<input type="text" name="cus_addr" class="form-control" placeholder="상세주소를 입력해주세요">
							</div>

							<br>
							<!-- <div class="form-group col-md-12 col-md-offset-3">
								<label>약관 동의</label>
								<textarea name="law" class="form-control" rows="4" style="color: #76777a; text-align: left;">
									제 1 장 총칙&#13;&#10;제 1 조 (목적)&#13;&#10;
									이 약관은 펫밀리(이하 ‘회사’라 합니다.)가 제공하는 펫시터 중개 서비스 및 펫밀리 관련 제반 서비스(이하 ‘서비스'라고 하며, 접속 가능한 유∙무선 단말기의 종류와는 상관없이 이용 가능한 ‘회사'가 제공하는 모든 ‘서비스'를 의미합니다. 이하 같습니다)를 이용자(이하 ‘회원’)가 이용함에 있어 회사와 회원간의 권리와 의무, 책임사항 및 회사의 서비스 이용절차에 관한 필요사항을 규정함을 목적으로 합니다.
								</textarea>
								<br>
								<div data-toggle="buttons">
									<label class="btn btn-primary active"> 
										<span class="fa fa-check"></span> <input id="agree" type="checkbox" autocomplete="off" checked>
									</label> 이용약관에 동의합니다.
								</div>
							</div> -->
							<br> <br>
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
	$('#cus_post').click(function(){
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

            $('#cus_post').val(data.zonecode);
            $('input[name="cus_addr"]').val(fullRoadAddr);
        }
    }).open();
}

//비밀번호 확인
$(document).ready(function(){
    if($('#cus_passwd').val()=='' && $('#cus_passwd2').val()==''){         
        $('p[name=pwdcheck]').html("비밀번호 확인을 위해 다시 한번 입력해 주세요.");
        $('p[name=pwdcheck]').css('color','black');
    }
    $('#cus_passwd2').keyup(function(){
        if($('#cus_passwd').val()!=$('#cus_passwd2').val()){           
            $('p[name=pwdcheck]').html("비밀번호 불일치");
            $('p[name=pwdcheck]').css('color','red');
        }else{
            $('p[name=pwdcheck]').html("비밀번호 일치");
            $('p[name=pwdcheck]').css('color','blue');
        }
    }); 
});

</script>

<!-- 아이디 중복체크 -->
<%
	String messageContent = null; 
	if (session.getAttribute("messageContent") != null) {
		messageContent = (String) session.getAttribute("messageContent");
	}
	String messageType = null; 
	if (session.getAttribute("messageType") != null) {
		messageType = (String) session.getAttribute("messageType");
	}
	if (messageContent != null) {
%>
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div class="modal-content <% if(messageType.equals("오류 메세지")) out.println("panel-warning"); else out.println("panel-success"); %>">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							<%= messageType %>
						</h4>
					</div>
					<div class="modal-body"> <%=messageContent %> </div>
					<div class="modal-footer"> 
						<button type="button" class="btn-primary btn" data-dismiss="modal">확인</button> 
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$('#messageModal').modal("show");
	</script>
<%		
	// 오류가 반환되면 두 개를 파기
	session.removeAttribute("messageContent");
	session.removeAttribute("messageType");
	}
%>
	<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div id="checkType" class="modal-content panel-info">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							확인 메세지
						</h4>
					</div>
					<div id="checkMessage" class="modal-body"></div>
					<div class="modal-footer"> 
						<button type="button" class="btn-primary btn" data-dismiss="modal">확인</button> 
					</div>
				</div>
			</div>
		</div>
	</div>
<!--  -->

<script>
<%
	}
%>
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false" />