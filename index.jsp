<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8"); 
	String title = "펫밀리에 오신걸 환영합니다";
%>
<style>
p
{
	font-family: Nanum Gothic;
	font-size: 17px;
	line-height: 1.5;
	font-weight: 400;
	color: #76777a;
}
h3{
	padding-bottom: 10px;
}
 </style>
 
	<jsp:include page="layout/header.inc.jsp" flush="false">
	   <jsp:param name="title" value="<%=title %>"/>
	</jsp:include>

	<!-- Home -->
    
	<div class="home">
		<div class="home_slider_container">	
			<div class="owl-carousel owl-theme home_slider">		
				<div class="owl-item">
					<div class="home_slider_background" style="background-image:url(images/back11.jpg)"></div>
				</div>		
				<div class="owl-item">
					<div class="home_slider_background" style="background-image:url(images/back22.jpg)"></div>
				</div>		
			</div>
		</div>
	</div>
	 

	<!-- Features -->

	<div class="features">
		<div class="container">
			<div class="row">
				<div class="col">
					<div class="section_title_container text-center">
						<br><br><br><h2 class="section_title" style="font-family: Nanum Gothic">믿고 맡겨보세요</h2><br><br>
						<div class="section_subtitle"><p>펫시터의 집에 반려동물을 맡기는 위탁 펫시팅은 놀이와 산책,<br>
						사료 및 간식 급여와 배변 정리, 잠자리 돌봄 등의 서비스를 제공합니다.</p></div>
					</div>
				</div>
			</div>
			<div class="row features_row">
					<div class="text-center">
						<div><img src="images/intro_img.png" alt="" style="max-width:70%;"></div>
					</div>
			</div><br><br><br><br><br><br><br>
			<div class="row">
				<div class="col">
					<div class="section_title_container text-center">
						<h2 class="section_title" style="font-family: Nanum Gothic">프리미엄 펫시팅 서비스</h2>
					</div>
				</div>
			</div>
			<div class="row features_row">
				
				<!-- Features Item -->
				<div class="col-lg-3 feature_col">
					<div class="feature text-center trans_400">
						<div class="feature_icon"><img src="images/matching.png" alt=""></div>
						<h3 class="feature_title">1:1 매칭 서비스</h3>
						<div class="feature_text"><p>성격 및 성향 설문을 통해<br>맞춤형 펫시터를 소개합니다.</p></div>
					</div>
				</div>

				<!-- Features Item -->
				<div class="col-lg-3 feature_col">
					<div class="feature text-center trans_400">
						<div class="feature_icon"><img src="images/license.png" alt=""></div>
						<h3 class="feature_title">검증된 펫시터</h3>
						<div class="feature_text"><p>반려동물관리사 자격증을 <br>소지한 펫시터만 활동합니다</p></div>
					</div>
				</div>

				<!-- Features Item -->
				<div class="col-lg-3 feature_col">
					<div class="feature text-center trans_400">
						<div class="feature_icon"><img src="images/greenhouse.png" alt=""></div>
						<h3 class="feature_title">안전한 펫시팅 환경</h3>
						<div class="feature_text"><p>펫시터 집의 청결성 및 안정성을<br>주기적으로 검증합니다</p></div>
					</div>
				</div>
				<!-- Features Item -->
				<div class="col-lg-3 feature_col">
					<div class="feature text-center trans_400">
						<div class="feature_icon"><img src="images/chat.png" alt=""></div>
						<h3 class="feature_title">일지보기 및 채팅 기능</h3>
						<div class="feature_text"><p>일지보기 및 채팅하기를 통해<br>반려견 상태 실시간 확인 가능</p></div>
					</div>
				</div>
			</div><br><br><br>
		</div>
	</div>

<jsp:include page="layout/footer.inc.jsp" flush="false"/>