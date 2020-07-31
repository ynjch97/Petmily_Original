<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="petmily.customer.CustomerMaDataBean"%>
<%@ page import="petmily.customer.CustomerMaDBBean"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:매칭정보 수정";
%>
<link href="https://fonts.googleapis.com/css?family=Fira+Sans" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="styles/matching.css">
<%
	String cus_id = (String) session.getAttribute("cus_id"); //id

	CustomerMaDBBean ma = CustomerMaDBBean.getInstance();
	CustomerMaDataBean m = ma.getMa(cus_id);
	String m_que = m.getM_que();
	String m_ans = m.getM_ans();
%>

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
   <jsp:param name="title" value="<%=title %>"/>
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
					<a class="nav-link active" href="cus_my_matching.jsp" style="color: #090909; font-size: 14px;">
						<b>매칭 정보 수정</b>
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
			<div class="card" >
 				<div class="card-body">
	 				<div class="page-header">
	 					<big><b>매칭 정보 수정</b></big>
	 				</div>
	 				<br>
					<div>
						<form role="form" method="post" action="cus_my_matching_pro.jsp">
							<div class="form-group col-md-offset-3">											
								<label for="qna">1. 본인의 반려견을 맡기고 싶은 주거 형태를 알려주세요.</label>
								<div style="margin-top:10px;">
									<label><input type="radio" name="mq1" value="0" <%if (m_que.equals("mq1") && m_ans.equals("0")){ %>checked <% } %> />
									<span id="tag">아파트 및 빌라</span></label>
									<label><input type="radio" name="mq1" value="1" <%if (m_que.equals("mq1") && m_ans.equals("1")){ %>checked <% } %> />
									<span id="tag">마당이 있는 주택</span></label>
								</div>
							</div><br>
							<div class="form-group col-md-offset-3">											
								<label for="qna">2. 본인의 반려견에게 수제간식을 제공해도 되나요?</label>
								<div style="margin-top:10px;">
									<label><input type="radio" name="mq2" value="0" <%if (m_que.equals("mq2") && m_ans.equals("0")){ %>checked <% } %> />
									<span id="tag">수제간식 가능</span></label>
									<label><input type="radio" name="mq2" value="1" <%if (m_que.equals("mq2") && m_ans.equals("1")){ %>checked <% } %> />
									<span id="tag">수제간식 불가능</span></label>
								</div>
							</div><br>
							<div class="form-group col-md-offset-3">
							<div class="input-group">
								<label for="qna">3. 본인의 반려견에게 필요한 케어의 유형을 선택해주세요.</label>
								<label class="genderrb" style="margin-left:20px;">전체선택 <b>(중복 선택 가능)</b><input type="checkbox" id='checkall' name="all1"/><span class="rb"></span></label>
								</div></div>
								<div style="margin-top:10px;">
									<label><input type="checkbox" class="ck1" name="ck1" id="ck1" value="0" /><span id="tag">노령견 케어</span></label>
									<label><input type="checkbox" class="ck1" name="ck1" id="ck1" value="1" /><span id="tag">질병견 케어</span></label>
									<label><input type="checkbox" class="ck1" name="ck1" id="ck1" value="2" /><span id="tag">장애견 케어</span></label>
									<label><input type="checkbox" class="ck1" name="ck1" id="ck1" value="3" /><span id="tag">발정견 케어</span></label>
									<label><input type="checkbox" class="ck1" name="ck1" id="ck1" value="4" /><span id="tag">임신견 케어</span></label>
								</div>
							<br>
							<div class="form-group col-md-offset-3">
								<label for="qna">4. 본인의 반려견이 돌봄 기간 중 아플 경우, 어떻게 하면 좋을까요?</label>
								<div style="margin-top:10px;">
									<label><input type="radio" name="mq3" value="0" /><span id="tag">응급처치</span></label>
									<label><input type="radio" name="mq3" value="1" /><span id="tag">가정 내 상비약</span></label>
									<label><input type="radio" name="mq3" value="2" /><span id="tag">동물병원 진료</span></label>
									
								</div>
							</div><br>
							
							<div class="form-group col-md-offset-3">
								<div class="input-group">
								<label for="qna">5. 펫시터가 반려견을 데리고 가줬으면 하는 곳이 있나요?</label>
								<label class="genderrb" style="margin-left:20px;">전체선택 <b>(중복 선택 가능)</b><input type="checkbox" id='checkall2' name="all2"/><span class="rb"></span></label>
								</div><div style="margin-top:10px;">
									<label><input type="checkbox" class='ck2' name='ck2' id="ck2" value="0"/><span id="tag">야외(공원 등)</span></label>
									<label><input type="checkbox" class='ck2' name='ck2' id="ck2" value="1"/><span id="tag">애견카페</span></label>
									<label><input type="checkbox" class='ck2' name='ck2' id="ck2" value="2"/><span id="tag">미용샵</span></label>
									<label><input type="checkbox" class='ck2' name='ck2' id="ck2" value="3"/><span id="tag">병원</span></label>
								</div>
							</div><br>
							<div class="form-group col-md-offset-3">
								<label for="qna">6. 펫시터가 본인의 반려견을 목욕시켜도 되나요?</label>
								<div style="margin-top:10px;">
									<label><input type="radio" name="mq4" value="0" /><span id="tag">목욕 가능</span></label>
									<label><input type="radio" name="mq4" value="1" /><span id="tag">목욕 불가능</span></label>
									
								</div>
							</div><br>
							<div class="form-group col-md-offset-3">
								<label for="qna">7. 펫시터가 본인의 반려견을 훈련시켜도 되나요?</label>
								<div style="margin-top:10px;">
									<label><input type="radio" name="mq5" value="0" /><span id="tag">훈련 가능</span></label>
									<label><input type="radio" name="mq5" value="1" /><span id="tag">훈련 불가능</span></label>
									
								</div>
							</div><br>		
							<div class="form-group col-md-offset-3">
								<label for="qna">8. 펫시터가 어디서 반려견을 케어해주면 좋겠나요?</label>
								<div style="margin-top:10px;">
									<label><input type="radio" name="mq6" value="0" /><span id="tag">야외 케어</span></label>
									<label><input type="radio" name="mq6" value="1" /><span id="tag">실내 케어</span></label>
									
								</div>
							</div><br>	
							<div class="form-group col-md-offset-3">
								<label for="qna">9. 선호하시는 펫시터의 반려견 여부를 알려주세요.</label>
								<div style="margin-top:10px;">
									<label><input type="radio" name="mq7" value="0" id="dogyes"/><span id="tag">반려견 있음</span></label>
									<label><input type="radio" name="mq7" value="1" id="dogno"/><span id="tag">반려견 없음</span></label>
								</div>
							</div><br>
							<div id="medog" style="display:none;">
							<div class="form-group col-md-offset-3">
								<label for="qna">10. 펫시터의 반려견은 크기는 어느정도까지 괜찮으신가요?</label>
								<div style="margin-top:10px;">
									<label><input type="radio" name="mq8" value="0" /><span id="tag">소형견</span></label>
									<label><input type="radio" name="mq8" value="1" /><span id="tag">중형견</span></label>
									<label><input type="radio" name="mq8" value="2" /><span id="tag">대형견</span></label>
								</div>
							</div></div><br>
							<br><br>
							<div class="form-group text-right">
								<input type="button" value="이전" class="btn btn-light" onclick="window.location.href='join_cus_pet.jsp'">
								<button type="submit" id="colorch" class="btn btn-light" onclick="button1_click(); window.location.href='index.jsp';">완료</button>
							</div>
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