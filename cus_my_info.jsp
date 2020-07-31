<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="petmily.customer.CustomerDataBean"%>
<%@ page import="petmily.customer.CustomerDBBean"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:개인정보 수정";
%>
<%
	String cus_id = (String) session.getAttribute("cus_id"); //id

	CustomerDBBean cus = CustomerDBBean.getInstance();
	CustomerDataBean c = cus.getCustomer(cus_id);
	String gender = "";
	gender = c.getCus_gender();
%>

<script type="text/javascript">
	
<%if (session.getAttribute("cus_id") == null) {%>
	alert("<고객> 로그인 후 이용가능한 서비스입니다.\n메인페이지로 이동합니다.");
	self.close();
	parent.location.replace("index.jsp"); // 추가
<%} else {%>
	
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
					<a class="nav-link active" href="cus_my_info.jsp" style="color: #000000; font-size: 14px;">
						<b>개인정보 수정</b>
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
					<a class="nav-link" href="cus_my_mileage.jsp" style="color: #090909; font-size: 14px;">
						마일리지 충전
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
						<form role="form" method="post" action="cus_my_info_pro.jsp">
							<div class="form-group col-md-3 col-md-offset-3">
								<label for="InputID">아이디</label>
								<div class="input-group">
									<input type="id" class="form-control" id="Inputid"
										value="<%=c.getCus_id()%>" readonly>
								</div>
							</div>
							<div class="form-group col-md-4 col-md-offset-3">
								<label for="cus_passwd">비밀번호</label> <input type="password"
									class="form-control" name="cus_passwd" id="cus_passwd"
									placeholder="비밀번호" required="required">
							</div>

							<div class="form-group col-md-4 col-md-offset-3">
								<label for="cus_passwd2">비밀번호 확인</label> <input type="password"
									class="form-control" name="cus_passwd2" id="cus_passwd2"
									placeholder="비밀번호 확인">
								<p class="help-block" name="pwdcheck">비밀번호 확인을 위해 다시한번
									입력해주세요</p>
							</div>
							<div class="form-group col-md-3 col-md-offset-3">
								<label for="username">이름</label> <input type="text"
									class="form-control" id="username" value="<%=c.getCus_name()%>"
									readonly>
							</div>
							<div class="form-group col-md-3 col-md-offset-3">
								<label for="username">성별</label>
								<div class="input-group">
									<label class="genderrb">남 
										<input type="radio" id="cus_gender" name="cus_gender" value="1" 
										<%if (gender != null && gender.equals("1")){ %>checked <% } %> />
										<span class="rb"></span></label>
									<div class="col-sm-10">
										<label class="genderrb">여 
											<input type="radio" id="cus_gender" name="cus_gender" value="0"
											<%if (gender != null && gender.equals("0")){ %>checked <% } %> />
											<span class="rb"></span></label>
									</div>
								</div>
							</div>
							<div class="form-group col-md-4 col-md-offset-3">
								<label for="username">생년월일</label>
								<div class="input-group">
									<input type="text" class="form-control" name="year" value="<%=c.getCus_birth()%>" readonly>
								</div>
							</div>
							<div class="form-group col-md-4 col-md-offset-3">
								<label for="cus_phone">휴대폰번호</label> <input type="text"
									class="form-control" id="cus_phone" name="cus_phone"
									value="<%=c.getCus_phone()%>">
							</div>
							<div class="form-group col-md-9 col-md-offset-3">
								<label>주소</label>
								<div class="input-group">
									<input type="text" class="form-control" name="cus_post"
										id="cus_post"
										value="<%=c.getCus_post()%>" required="required"> <span
										class="input-group-btn input-group-append">
										<button class="btn btn-outline-secondary" id="postcodeBtn"
											type="button">우편번호</button>
									</span>
								</div>
								<br> <input type="text" name="cus_addr" id="cus_addr"
									class="form-control" value="<%=c.getCus_addr()%>">
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
		$('#cus_post').click(function() {
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

				$('#cus_post').val(data.zonecode);
				$('input[name="cus_addr"]').val(fullRoadAddr);
			}
		}).open();
	}

	//비밀번호 확인
	$(document).ready(function() {
		if ($('#cus_passwd').val() == '' && $('#cus_passwd2').val() == '') {
			$('p[name=pwdcheck]').html("비밀번호 확인을 위해 다시 한번 입력해 주세요.");
			$('p[name=pwdcheck]').css('color', 'black');
		}
		$('#cus_passwd2').keyup(function() {
			if ($('#cus_passwd').val() != $('#cus_passwd2').val()) {
				$('p[name=pwdcheck]').html("비밀번호 불일치");
				$('p[name=pwdcheck]').css('color', 'red');
			} else {
				$('p[name=pwdcheck]').html("비밀번호 일치");
				$('p[name=pwdcheck]').css('color', 'blue');
			}
		});
	});
</script>
<script>
	
<%}%>
	
</script>
<jsp:include page="layout/footer.inc.jsp" flush="false" />
