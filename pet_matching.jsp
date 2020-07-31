<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리에 오신걸 환영합니다";
%>
<link href="https://fonts.googleapis.com/css?family=Fira+Sans" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="styles/matching.css">
<script>
function button1_click() {
	alert("매칭 정보 수정이 완료되었습니다.");
	/* location.href="index.jsp"; */
}
</script>

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
				<a class="nav-link active" href="pet_matching.jsp" style="color: #000000; font-size: 15px;">
					<b>매칭 정보 수정</b>
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
						<big><b>매칭 정보 수정</b></big>
					</div><br>
				<div>
			<form role="form">
				<div class="form-group col-md-offset-3">											
											<label for="qna">1. 본인의 주거 형태를 알려주세요.</label>
											<div style="margin-top:10px;">
												<label><input type="radio" name="mq1" value="" /><span id="tag">아파트 및 빌라</span></label>
												<label><input type="radio" name="mq1" value="" /><span id="tag">마당이 있는 주택</span></label>
											</div>
										</div><br>
										<div class="form-group col-md-offset-3">											
											<label for="qna">2. 반려견에게 수제간식을 제공해주실 수 있나요?</label>
											<div style="margin-top:10px;">
												<label><input type="radio" name="mq2" value="" /><span id="tag">수제간식 가능</span></label>
												<label><input type="radio" name="mq2" value="" /><span id="tag">수제간식 불가능</span></label>
											</div>
										</div><br>
										<div class="form-group col-md-offset-3">
										<div class="input-group">
											<label for="qna">3. 어떤 반려견까지 케어 가능하신가요?</label>
											<label class="genderrb" style="margin-left:20px;">전체선택 <b>(중복 선택 가능)</b><input type="checkbox" id='checkall' name="all1"/><span class="rb"></span></label>
											</div></div>
											<div style="margin-top:10px;">
												<label><input type="checkbox" class="ck1" name="ck1" value="" /><span id="tag">노령견 케어</span></label>
												<label><input type="checkbox" class="ck1" name="ck1" value="" /><span id="tag">질병견 케어</span></label>
												<label><input type="checkbox" class="ck1" name="ck1" value="" /><span id="tag">장애견 케어</span></label>
												<label><input type="checkbox" class="ck1" name="ck1" value="" /><span id="tag">발정견 케어</span></label>
												<label><input type="checkbox" class="ck1" name="ck1" value="" /><span id="tag">임신견 케어</span></label>
											</div>
										</div><br>
										<div class="form-group col-md-offset-3">
											<label for="qna">4. 고객의 반려견이 돌봄 기간 중 아플 경우, 어떻게 해주실 수 있나요?</label>
											<div style="margin-top:10px;">
												<label><input type="radio" name="mq3" value="" /><span id="tag">응급처치</span></label>
												<label><input type="radio" name="mq3" value="" /><span id="tag">가정 내 상비약</span></label>
												<label><input type="radio" name="mq3" value="" /><span id="tag">동물병원 진료</span></label>
												
											</div>
										</div><br>
										
										<div class="form-group col-md-offset-3">
											<div class="input-group">
											<label for="qna">5. 고객의 반려견과 가고 싶은 곳이 있나요?</label>
											<label class="genderrb" style="margin-left:20px;">전체선택 <b>(중복 선택 가능)</b><input type="checkbox" id='checkall2' name="all2"/><span class="rb"></span></label>
											</div><div style="margin-top:10px;">
												<label><input type="checkbox" class='ck2' name='ck2' id="ck2"/><span id="tag">야외(공원 등)</span></label>
												<label><input type="checkbox" class='ck2' name='ck2' id="ck2"/><span id="tag">애견카페</span></label>
												<label><input type="checkbox" class='ck2' name='ck2' id="ck2"/><span id="tag">미용샵</span></label>
												<label><input type="checkbox" class='ck2' name='ck2' id="ck2"/><span id="tag">병원</span></label>
											</div>
										</div><br>
										<div class="form-group col-md-offset-3">
											<label for="qna">6. 고객의 반려견을 목욕시키실 수 있나요?</label>
											<div style="margin-top:10px;">
												<label><input type="radio" name="mq4" value="" /><span id="tag">목욕 가능</span></label>
												<label><input type="radio" name="mq4" value="" /><span id="tag">목욕 불가능</span></label>
												
											</div>
										</div><br>
										<div class="form-group col-md-offset-3">
											<label for="qna">7. 고객의 반려견을 훈련시키실 수 있나요?</label>
											<div style="margin-top:10px;">
												<label><input type="radio" name="mq5" value="" /><span id="tag">훈련 가능</span></label>
												<label><input type="radio" name="mq5" value="" /><span id="tag">훈련 불가능</span></label>
												
											</div>
										</div><br>		
										<div class="form-group col-md-offset-3">
											<label for="qna">8. 고객의 반려견과 반려견을 주로 어디서 케어하시나요?</label>
											<div style="margin-top:10px;">
												<label><input type="radio" name="mq6" value="" /><span id="tag">야외 케어</span></label>
												<label><input type="radio" name="mq6" value="" /><span id="tag">실내 케어</span></label>
												
											</div>
										</div><br>	
										<div class="form-group col-md-offset-3">
											<label for="qna">9. 본인은 반려견을 키우시나요?</label>
											<div style="margin-top:10px;">
												<label><input type="radio" name="mq7" value="" id="dogyes"/><span id="tag">반려견 있음</span></label>
												<label><input type="radio" name="mq7" value="" id="dogno"/><span id="tag">반려견 없음</span></label>
											</div>
										</div></div><br>
										<div id="medog" style="display:none;">
										<div class="form-group col-md-offset-3">
											<label for="qna">10. 본인 반려견의 크기를 알려주세요.</label>
											<div style="margin-top:10px;">
												<label><input type="radio" name="mq8" value="" /><span id="tag">소형견</span></label>
												<label><input type="radio" name="mq8" value="" /><span id="tag">중형견</span></label>
												<label><input type="radio" name="mq8" value="" /><span id="tag">대형견</span></label>
											</div>
										</div></div>
				<br><br>
				<div class="form-group text-right">
					<input type="button" value="이전" class="btn btn-light" onclick="window.location.href='join_pet_qna.jsp'">
					<input type="button" id="colorch" value="완료" class="btn btn-light" onclick="window.location.href='index.jsp'; button1_click();">
				</div>
			</form>
		
	
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