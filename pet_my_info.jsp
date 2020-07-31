<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="petmily.petsitter.PetsitterDataBean"%>
<%@ page import="petmily.petsitter.PetsitterDBBean"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리에 오신걸 환영합니다";
%>

<%
	String pet_id = (String) session.getAttribute("pet_id"); //id

	PetsitterDBBean pet = PetsitterDBBean.getInstance();
	PetsitterDataBean p = pet.getPetsitter(pet_id);
%>


<script type="text/javascript">
	
<%if (session.getAttribute("pet_id") == null) {%>
	alert("<펫시터> 로그인 후 이용가능한 서비스입니다.\n메인페이지로 이동합니다.");
	self.close();
	parent.location.replace("index.jsp"); // 추가
<%} else {%>
	
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
					<a class="nav-link" href="pet_my_money.jsp" style="color: #000000; font-size: 15px;"> 
						매출관리 
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active" href="pet_my_info.jsp" style="color: #000000; font-size: 15px;">
						<b>개인정보 수정</b>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="pet_matching.jsp" style="color: #000000; font-size: 15px;">
						매칭 정보 수정
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="pet_my_delete.jsp" style="color: #000000; font-size: 15px;">
						회원 탈퇴
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
						<big><b>개인정보 수정</b></big>
					</div>
					<br>
					<div>
						<form role="form" action="pet_my_info_pro.jsp">
							<div class="form-group col-md-3 col-md-offset-3">
								<label for="InputID">아이디</label>
								<div class="input-group">
									<input type="id" class="form-control" id="Inputid"
										value="<%=p.getPet_id()%>" readonly>
								</div>
							</div>
							<div class="form-group col-md-4 col-md-offset-3">
								<label for="pet_passwd">비밀번호</label> <input type="password"
									class="form-control" name="pet_passwd" id="pet_passwd"
									placeholder="비밀번호" required="required">
							</div>

							<div class="form-group col-md-4 col-md-offset-3">
								<label for="pet_passwd2">비밀번호 확인</label> <input type="password"
									class="form-control" name="pet_passwd2" id="pet_passwd2"
									placeholder="비밀번호 확인">
								<p class="help-block" name="pwdcheck">비밀번호 확인을 위해 다시한번
									입력해주세요</p>
							</div>
							<div class="form-group col-md-3 col-md-offset-3">
								<label for="username">이름</label> <input type="text"
									class="form-control" id="username" value="<%=p.getPet_name()%>"
									readonly>
							</div>
							<div class="form-group col-md-3 col-md-offset-3">
								<label for="username">성별</label>
								<div class="input-group">
									<label class="genderrb">남 <input type="radio"
										name="gender" value="male" /><span class="rb"></span></label>
									<div class="col-sm-10">
										<label class="genderrb">여 <input type="radio"
											name="gender" value="female" /><span class="rb"></span></label>
									</div>
								</div>
							</div>
							<div class="form-group col-md-4 col-md-offset-3">
								<label for="username">생년월일</label>
								<div class="input-group">
									<input type="text" class="form-control" name="year" value="<%=p.getPet_birth()%>" readonly>
								</div>
							</div>
							<div class="form-group col-md-4 col-md-offset-3">
								<label for="pet_phone">휴대폰번호</label> <input type="text"
									class="form-control" id="pet_phone" name="pet_phone"
									placeholder="휴대폰번호를 -없이 입력해 주세요">
							</div>	
							<div class="form-group col-md-9 col-md-offset-3">
								<label>주소</label>
								<div class="input-group">
									<input type="text" class="form-control" name="pet_post"
										id="pet_post" readonly="readonly"
										placeholder="우편번호 버튼을 클릭하여 입력" required="required"> <span
										class="input-group-btn input-group-append">
										<button class="btn btn-outline-secondary" id="postcodeBtn"
											type="button">우편번호</button>
									</span>
								</div>
								<br> <input type="text" name="pet_addr" id="pet_addr"
									class="form-control" placeholder="상세주소를 입력해주세요">
							</div>
							<br> <br> <br>
							<div class="form-group text-right">

								<button type="submit" id="colorch" class="btn btn-light"
									onclick="button1_click();">완료</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</article>
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	$(document).ready(function() {
		$('#pet_post').click(function() {
			//fetchDaumPostcode();
			$('#postcodeBtn').trigger('click');
		});
		$('#postcodeBtn').click(function() {
			fetchDaumPostcode();
		});
	});

	function fetchDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 도로명 조합형 주소 변수

				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
				// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}
				// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
				if (fullRoadAddr !== '') {
					fullRoadAddr += extraRoadAddr;
				}

				$('#pet_post').val(data.zonecode);
				$('input[name="pet_addr"]').val(fullRoadAddr);
			}
		}).open();
	}

	//비밀번호 확인
	$(document).ready(function() {
		if ($('#pet_passwd').val() == '' && $('#pet_passwd2').val() == '') {
			$('p[name=pwdcheck]').html("비밀번호 확인을 위해 다시 한번 입력해 주세요.");
			$('p[name=pwdcheck]').css('color', 'black');
		}
		$('#pet_passwd2').keyup(function() {
			if ($('#pet_passwd').val() != $('#pet_passwd2').val()) {
				$('p[name=pwdcheck]').html("비밀번호 불일치");
				$('p[name=pwdcheck]').css('color', 'red');
			} else {
				$('p[name=pwdcheck]').html("비밀번호 일치");
				$('p[name=pwdcheck]').css('color', 'blue');
			}
		});
	});
<%}%>
	
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false" />
