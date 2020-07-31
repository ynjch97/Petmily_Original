<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="petmily.manager.ManagerDBBean"%>
<%@ page import="petmily.petsitter.PetsitterDataBean"%>
<!-- 날짜 정보를 위해 가져옴 -->
<%@ page import="java.util.Date"%>

<!-- 일주일 내 예약한 건만 리뷰 작성할 수 있도록 계산하기 위해 import -->
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>


<%
	request.setCharacterEncoding("utf-8");

	String pet_id = "";
	pet_id = request.getParameter("pet_id");
	PetsitterDataBean petSitter = null;
	ManagerDBBean manager = ManagerDBBean.getInstance();
	petSitter = manager.getPetsitter(pet_id);

	int pet_cash = petSitter.getPet_cash();
	int pet_cash_real = (int) (pet_cash * 0.9);
	int pet_cash_fee = (int) (pet_cash * 0.1);

	String title = "펫밀리:" + pet_id + "님의 페이지";

	// 날짜 계산해서 값을 비교해보기로 한다 (7일 이내의 예약건에 대해서만 리뷰를 작성할 수 있도록)
	int addDate = 0; // 가감하려는 날짜의 수    
	String strYear = null;
	String strMonth = null;
	String strDay = null;
	String strDate = null;
%>

<link rel="stylesheet" type="text/css" href="styles/blog2.css">
<link rel="stylesheet" type="text/css" href="styles/cal2.css">
<link rel="stylesheet"
	href="http://fonts.googleapis.com/css?family=Lato:300,400,700">
<link rel="stylesheet"
	href="http://weloveiconfonts.com/api/?family=fontawesome">

<script src="http://code.jquery.com/jquery-latest.min.js"
	type="text/javascript"></script>
<script src="assets/js/simplecalendar.js" type="text/javascript"></script>
<script type="text/javascript">
<%if (session.getAttribute("cus_id") == null && session.getAttribute("pet_id") == null
					&& session.getAttribute("man_id") == null) {%>
       alert("로그인 후 이용가능한 서비스입니다.\n메인페이지로 이동합니다.");
       self.close();
       parent.location.replace("index.jsp"); // 추가
<%} else {%>
</script>
<style>
/* input[type="date"]::-webkit-calendar-picker-indicator, */
input[type="date"]::-webkit-inner-spin-button {
	display: none;
	appearance: none;
}
/* input[type="date"]::-webkit-calendar-picker-indicator {
   color: rgba(0, 0, 0, 0); //숨긴다
   opacity: 1;
   display: block;
   background: url(https://mywildalberta.ca/images/GFX-MWA-Parks-Reservations.png) no-repeat; // 대체할 아이콘
   width: 20px;
   height: 20px;
   border-width: thin;
} */
#hrhr {
	margin-right: 5%;
}

#gold {
	background-image: url("images/medal1.png");
	background-size: 100px;
	background-repeat: no-repeat;
	background-position: 80px 0px;
}

#silver {
	background-image: url("images/medal2.png");
	background-size: 100px;
	background-repeat: no-repeat;
	background-position: 80px 0px;
}

#bronze {
	background-image: url("images/medalb.png");
	background-size: 100px;
	background-repeat: no-repeat;
	background-position: 80px 0px;
}

.card {
	margin-bottom: 2%;
}
</style>

<!-- Header -->
<jsp:include page="layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<!-- Blog -->
<div class="blog">
	<div class="container">
		<div class="card">

			<!-- 이미지 세 장 Carousel -->

			<div class="row">
				<div class="col-md-4" style="width: 30%">
					<div id="carouselExampleFade" class="carousel slide carousel-fade"
						data-ride="carousel">
						<div class="carousel-inner">
							<div class="carousel-item active">
								<img class="d-block w-100"
									src="imageFile/<%=petSitter.getPet_intro1()%>"
									alt="<%=petSitter.getPet_id()%> 회원님 사진 1">
							</div>
							<div class="carousel-item">
								<img class="d-block w-100"
									src="imageFile/<%=petSitter.getPet_intro2()%>"
									alt="<%=petSitter.getPet_id()%> 회원님 사진 2">
							</div>
							<div class="carousel-item">
								<img class="d-block w-100"
									src="imageFile/<%=petSitter.getPet_intro3()%>"
									alt="<%=petSitter.getPet_id()%> 회원님 사진 3">
							</div>
						</div>
						<a class="carousel-control-prev" href="#carouselExampleFade"
							role="button" data-slide="prev"> <span
							class="carousel-control-prev-icon" aria-hidden="true"></span> <span
							class="sr-only">Previous</span>
						</a> <a class="carousel-control-next" href="#carouselExampleFade"
							role="button" data-slide="next"> <span
							class="carousel-control-next-icon" aria-hidden="true"></span> <span
							class="sr-only">Next</span>
						</a>
					</div>
				</div>
				<div class="col-sm-8">
					<div class="row">
						<div class="col-md-9">
							<p id="cardtitle" style="padding-bottom: 15px;"><%=petSitter.getPet_intro()%></p>
							<b><label><%=petSitter.getPet_name()%></label></b><br> <label><i
								class="fas fa-map-marker-alt"></i> <%=petSitter.getPet_addr()%></label>
						</div>
						<div class="col-md-3" id="silver">
							<label
								style="font-weight: bold; font-size: 20px; color: #384158; padding-left: 100px; padding-top: 28px;">4.5</label>
						</div>
					</div>
					<div class="form-group row" id="cardtagroup">
						<button type="button" class="btn" id="btntag">투약가능</button>
						<button type="button" class="btn" id="btntag">픽업가능</button>
						<button type="button" class="btn" id="btntag">수제간식</button>
						<button type="button" class="btn" id="btntag">응급처치</button>
					</div>
					<div class="row">
						<div class="col-md-9" style="padding-top: 10px;">
							<i class="far fa-comment-dots fa-lg"></i> <label id="cardcomment">고객후기
								12개</label>
						</div>
						<div class="col-md-3" align="right">
							<label id="cardprice"
								style="font-weight: bold; font-size: 20px; padding-right: 22px;"><%=pet_cash%>원</label>
						</div>
					</div>
				</div>
			</div>


		</div>
		<!-- 지도, 예약, 캘린더, 후기, 일지 -->
		<div class="row">
			<div class="col-md-4" style="padding-right: 0px;">
				<div class="card">
					<div id="map" style="width: 100%; height: 305px;"></div>

					<script type="text/javascript"
						src="//dapi.kakao.com/v2/maps/sdk.js?appkey=40f1714f2f89ccbee2e525f95d172f52&libraries=services"></script>
					<script>
   var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
       mapOption = {
           center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
           level: 3 // 지도의 확대 레벨
       };  
   
   // 지도를 생성합니다    
   var map = new daum.maps.Map(mapContainer, mapOption); 
   
   // 주소-좌표 변환 객체를 생성합니다
   var geocoder = new daum.maps.services.Geocoder();
  
      
      // 주소로 좌표를 검색합니다
      geocoder.addressSearch('<%=petSitter.getPet_addr()%>', function(result, status) {
      
          // 정상적으로 검색이 완료됐으면 
           if (status === daum.maps.services.Status.OK) {
              var coords = new daum.maps.LatLng(result[0].y, result[0].x);
              // 결과값으로 받은 위치를 마커로 표시합니다
              var marker = new daum.maps.Marker({
                  map: map,
                  position: coords
              });
              // 인포윈도우로 장소에 대한 설명을 표시합니다
              var infowindow = new daum.maps.InfoWindow({
                  content: '<div style="width:150px;text-align:center;padding:6px 0;">'+'<%=petSitter.getPet_name()%>'+' 님의 집</div>'
              });
              infowindow.open(map, marker);
              // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
              map.setCenter(coords);
          } 
      });    
   

</script>

				</div>
			</div>
			<div class="col-md-8">
				<!-- calendar -->
				<div class="card">
					<div class="row">
						<div class="col-md-6">
							<div class="calendar hidden-print" style="margin-left: 10px;">
								<a><i class="fas fa-circle fa-xs" id="reserved"></i>예약불가</a>
								<header>
									<h4 class="month" style="text-align: center;"></h4>
									<a class="btn-prev" href="#"><i
										class="fa fa-chevron-left fa-xs"></i></a> <a class="btn-next"
										href="#"><i class="fa fa-chevron-right fa-xs"></i></a>
								</header>
								<table>
									<thead class="event-days">
										<tr></tr>
									</thead>
									<tbody class="event-calendar">
										<tr class="1"></tr>
										<tr class="2"></tr>
										<tr class="3"></tr>
										<tr class="4"></tr>
										<tr class="5"></tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="col-md-6">
							<div class="modal-body" style="margin-right: 25px;">

								<!-- css는 내 즐겨찾기 참고 -->
								<form class="form" method="post" id="man_apprv_form"
									name="man_apprv_form"
									action="cus_search_reserve.jsp?pet_id=<%=petSitter.getPet_id()%>">

									<div align="center">
										<label style="padding-top: 10px;"><%=petSitter.getPet_name()%>님의 예약 정보에요.</label>
									</div>
									<!-- <form action="/action_page.php">
                              <div align="center">
                                 <input type="date" name="bday" class="far fa-calendar-alt"
                                    id="datepic">
                              </div>
                           </form> -->
									<hr>
									<div class="row" style="padding: 10px;">
										<div class="col-md-6" align="left">돌봄비용</div>
										<div class="col-md-6" align="right"><%=pet_cash_real%>원
										</div>
									</div>
									<div class="row" style="padding: 10px;">
										<div class="col-md-6" align="left">부가세</div>
										<div class="col-md-6" align="right"><%=pet_cash_fee%>원
										</div>
									</div>
									<div class="row"
										style="padding: 10px; font-size: 16px; font-weight: bold;">
										<div class="col-md-6" align="left" style="padding-top: 3px;">총합계</div>
										<div class="col-md-6" align="right">
											<label id="totalprice"><%=pet_cash%>원</label>
										</div>
									</div>
									<div align="center">
										펫시터는 예약 서비스를 이용할 수 없어요.
									</div>

								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 일지 -->
		<div class="card" id="card2">
			<div class="form-group row" id="cardi">
				<p id="option">일지</p>
				<p id="review3">일지 3개</p>
			</div>
			<div class="hs_form2">
				<img src="images/dog1.jpg" class="rounded" alt="..." id="hs_img"
					data-toggle="modal" data-target="#squarespaceModal2"> <img
					src="images/dog2.jpg" class="rounded" alt="..." id="hs_img"
					data-toggle="modal" data-target="#squarespaceModal2"> <img
					src="images/dog4.jpg" class="rounded" alt="..." id="hs_img"
					data-toggle="modal" data-target="#squarespaceModal2">
			</div>
		</div>

		<!-- 후기 -->
		<div class="card" id="card2">
			<div class="form-group row" id="cardi">
				<p id="option">고객후기</p>
				<p id="review3">후기 2개</p>
			</div>

			<div class="card" id="hugi">
				<div class="form-group row">
					<img src="images/dog1.jpg" id="imiji">
					<div style="padding-top:1%;font-size:15px;">choi 왜안돼</div>
					<div style="padding-top:1.4%;" id="star" class="row">
						<i class="fas fa-star fa-lg"></i> <i class="fas fa-star fa-lg"></i>
						<i class="fas fa-star fa-lg"></i> <i class="fas fa-star fa-lg"></i> <i class="far fa-star fa-lg"></i>
					</div>
					<div>
						저희 부부는 애견호텔에 맡기는 것 자체를 못미더워 정말 싫어하는데, 이번
						여행에 어쩔 수 없이 맡기게 되어 펫시터라는 걸 알게되었어요~ 반신반의한 마음으로 맡겨봤는데, 정말 친절한 펫시터님께서
						하루에 동영상, 사진 계속해서 보내주시고, 매일매일 산책도 해주시고~ 하루에 대한 자세한 설명도 꾸준히 보내주셨어요! 진짜
						우리 강아지들 맡기는게 이렇게 맘이 놓인 적은 없어요 ㅜㅜ 한편으론 저희보다 더 잘 케어해주시는구나 ~ 하는 생각이 들
						정도 였습니다 ㅎㅎ정말 너무 감사하고 다음에 이 분에게만 맡길거에요! 감사합니다!
					</div>
				</div>
			</div>
				
		</div>
		
		
		

	<!-- line modal 일지모달 -->
	<div class="modal fade" id="squarespaceModal2" tabindex="-1"
		role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h3 class="modal-title" id="lineModalLabel">일지</h3>
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true"><i class="fas fa-times fa-lg"></i></span>
						<span class="sr-only">Close</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- content goes here -->
					<form>
						<div>
							<p>2018-09-10 13:35 작성</p>
							<hr>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1" id="modalpetname">하루</label> <label
								for="exampleInputEmail1">포메라니안</label>
						</div>
						<hr>
						<div class="card" id="modalcard1">
							<div class="form-group">
								<label for="exampleInputPassword1">*산책<br>시민공원으로
									50분 산책 진행했습니다.<br> 하루가 줄을 당기는 버릇이 있어서 몇번 뛰게 했습니다. 산책이 끝나고
									물티슈로 발 닦아주었습니다.<br> <br> * 식사 및 간식<br> 준비해 두신
									저녁을 산책 끝나고 돌아와서 내줬는데 물그릇 씻으러 갔다 온 사이에 다 먹었어요.<br> 간식은
									돌아다니던 양말에 트릿 넣어 놓았고 개껌 주니까 열심히 먹었습니다.
								</label>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
   var picker = new Pikaday({ 
    field: document.getElementById('res_date'),
    format: 'yyyy-MM-dd',
    toString(date, format) {
      let day = ("0" + date.getDate()).slice(-2);
      let month = ("0" + (date.getMonth() + 1)).slice(-2);
      let year = date.getFullYear();
      return `${year}-${month}-${day}`;
    }
   });
</script>

<script>
<%}%>
</script>

<!-- Footer -->
<jsp:include page="layout/footer.inc.jsp" flush="false" />