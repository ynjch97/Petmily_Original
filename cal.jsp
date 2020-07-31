<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@ page import = "java.util.List" %>
<%@ page import="petmily.manager.ManagerDBBean"%>
<%@ page import="petmily.petsitter.PetsitterDataBean"%>
<!-- 날짜 정보를 위해 가져옴 -->
<%@ page import="java.util.Date"%>
<%
   request.setCharacterEncoding("utf-8"); 
   String title = "PetMily";
%>

<%
   String pet_id = "";
   pet_id = request.getParameter("pet_id");
   PetsitterDataBean petSitter = null;
   ManagerDBBean manager = ManagerDBBean.getInstance();
   petSitter = manager.getPetsitter(pet_id);
%>
  <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Lato:300,400,700">
  <link rel="stylesheet" href="http://weloveiconfonts.com/api/?family=fontawesome">
<link rel="stylesheet" type="text/css" href="styles/cal.css">

  <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
  <script src="assets/js/simplecalendar.js" type="text/javascript"></script>
  <style>

@charset "utf-8";

.blog {
	width: 100%;
	background: #FFFFFF;
	padding-top: 20px;
}

.blog_info {
	width: 100%;
	background: #ffffff;
	padding-top: 30px;
}

#week {
	color: #76777A;
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 12px;
}
  
.card {
	
	margin-bottom: 20px;
}
#ec_circle1{
	margin-bottom: 2%;
   margin-left: 100px;
   margin-top: 20px;
    width: 100px;
    height: 100px; 
}
.ec_1{
	margin-left:90px;
	margin-top: 20px;
}
#cardtagroup
{
	margin-top:2%;
	margin-left:1%;
}
#btntag
{
	width:80px;
	margin-right:15px;
	border:1px solid #aaa;
	font-size:14px;
}
#register
{
	width:120px;
	margin-left:100px;
}
#register2
{
	width:120px;
	margin-left:20px;
}
#hs_circle2{
	margin-top: 10px; 
   width: 130px;
   height: 130px;
}
</style>

<jsp:include page="layout/header.inc.jsp" flush="false">
      <jsp:param name="title" value="<%=title %>"/>
</jsp:include>
  <div class="container" >
  
		<ul class="nav nav-tabs" style="padding-top:20px;">
			<li class="nav-item"><a class="nav-link"
				href="new_collection.jsp" style="color: #090909; font-size: 14px;">
					전체
			</a></li>
			<li class="nav-item"><a class="nav-link active"
				href="cal.jsp" style="color: #090909; font-size: 14px;">
					<b>예약 내역</b> </a></li>
			<li class="nav-item"><a class="nav-link" href="new_diary.jsp"
				style="color: #090909; font-size: 14px;"> 일지 </a></li>
			<li class="nav-item"><a class="nav-link" href="new_review.jsp"
				style="color: #090909; font-size: 14px;"> 후기 </a></li>
		</ul>
<div class="card">
				<div class="card-body">
    <div class="row">
      <div class="col-md-5">
        <div class="calendar hidden-print" >
          <header style="width:100%; padding-top:20px;">
            <h4 class="month"></h4>
            <a class="btn-prev href="#"><i class="fa fa-chevron-left fa-xs" style="padding-top:7px;"></i></a>
            <a class="btn-next href="#"><i class="fa fa-chevron-right fa-xs" style="padding-top:7px;"></i></a>
          </header>
          <table style="width:100%; margin-left:12px;">
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
          </div></div>
          <div class="col-md-7">
          <div class="list" style="width:100%;">
            <div class="day-event" date-day="2" date-month="11" date-year="2018"  data-number="1">
              <a id="cala" href="#" class="close"><i class="fas fa-times"></i></a>
              <h2 class="title">Lorem ipsum 1</h2>
              <p>Lorem Ipsum är en utfyllnadstext från tryck- och förlagsindustrin. Lorem ipsum har varit standard ända sedan 1500-talet, när en okänd boksättare tog att antal bokstäver och blandade dem för att göra ett provexemplar av en bok.</p>
              <label class="check-btn">
              <input type="checkbox" class="save" id="save" name="" value=""/>
              
              </label>
            </div>
            <div class="day-event" date-day="5" date-month="11" date-year="2018"  data-number="1">
              <a id="cala" href="#" class="close"><i class="fas fa-times"></i></a>
              <h2 class="title">Lorem ipsum 1</h2>
              <p>Lorem Ipsum är en utfyllnadstext från tryck- och förlagsindustrin. Lorem ipsum har varit standard ända sedan 1500-talet, när en okänd boksättare tog att antal bokstäver och blandade dem för att göra ett provexemplar av en bok.</p>
              <label class="check-btn">
              <input type="checkbox" class="save" id="save" name="" value=""/>
              
              </label>
            </div>
          </div>
        </div>
      </div>
      <div class="blog">
	<div class="container">
		<div id="week">전체 내역</div>
		<div class="card flex-md-row mb-4">
			<div>
				<img id="ec_circle1" class="rounded-circle" src="images/Bichon.jpg">
				<h3 class="ec_1">복실이(비숑)</h3>
			</div>
			<div class="card-body" style="margin-left: 30px;">
			 <h4 style="margin-bottom: 10px;">2018-09-18&nbsp;<small>17:02:33</small></h4>
				<h3 class="card-title" style="font-weight: bold">Lee님</h3>
				<p class="card-text">이효주 고객님</p> 
				<div class="form-group row" id="cardtagroup">
					<button type="button" class="btn btn-outline-dark" id="btntag">투약가능</button>
					<button type="button" class="btn btn-outline-dark" id="btntag">픽업가능</button>
					<button type="button" class="btn btn-outline-dark" id="btntag">수제간식</button>
					<button type="button" class="btn btn-outline-dark" id="btntag">응급처치</button>
												 <button type="button" class="btn btn-info" id="register" data-toggle="modal"
							data-target=".bd-example-modal-lg">일지</button>
							 <button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal"
						id="register2">리뷰</button>
				 		</div>    
				 			<!-- line modal 일지모달 -->
						<div class="modal fade bd-example-modal-lg" tabindex="-1"
			role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true"> 
			<div class="modal-dialog modal-lg">
				<div class="modal-content"> 
					<div class="modal-header">
						<h2 class="modal-title">꼬미</h2>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div> 
					<div class="modal-body">
						<img src="images/dog4.jpg" style="width: 200px; height: 130px; margin-left: 60px;">
						<img src="images/dog5.jpg" style="width: 200px; height: 130px; margin-left: 10px;">
						<img src="images/dog6.jpg" style="width: 200px; height: 130px; margin-left: 10px;"">
						<p style="margin: 5%">배은지 저희 부부는 애견호텔에 맡기는 것 자체를 못미더워 정말
							싫어하는데, 이번 여행에 어쩔 수 없이 맡기게 되어 펫시터라는 걸 알게되었어요~ 반신반의한 마음으로 맡겨봤는데, 정말
							친절한 펫시터님께서 하루에 동영상, 사진 계속해서 보내주시고, 매일매일 산책도 해주시고~ 하루에 대한 자세한 설명도
							꾸준히 보내주셨어요! 진짜 우리 강아지들 맡기는게 이렇게 맘이 놓인 적은 없어요 ㅜㅜ 한편으론 저희보다 더 잘
							케어해주시는구나 ~ 하는 생각이 들 정도 였습니다 ㅎㅎ정말 너무 감사하고 다음에 이 분에게만 맡길거에요!
							감사합니다!.</p>
					</div>
				</div>
			</div>
		</div>
		<!-- line modal 리뷰모달 -->
			 <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">후기 보기</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body --> 
        <div class="modal-body text-left">
         <div style="float: left; width: 20%; padding: 5px">
						<img src="images/Bichon.jpg" alt="..." class="rounded-circle" id="hs_circle2">
		</div>
		<div class="cus-review"><br>
									<div class="row">
										<div>
											<h4 id="review-title">이름/아이디</h4>
										</div>
										<div id="dogname1">포포</div>
										<div id="cardstar1">
											<h4>
												<span class="badge badge-info">5점</span>
											</h4>
										</div>
									</div>
									<div id="review-text">저희 부부는 애견호텔에 맡기는 것 자체를 못미더워 정말 싫어하는데, 이번 여행에 어쩔 수 없이 맡기게 되어 펫시터라는 걸 알게되었어요~ 반신반의한 마음으로 맡겨봤는데, 정말 친절한 펫시터님께서 하루에 동영상, 사진 계속해서 보내주시고, 매일매일 산책도 해주시고~ 하루에 대한 자세한 설명도 꾸준히 보내주셨어요! 진짜 우리 강아지들 맡기는게 이렇게 맘이 놓인 적은 없어요 ㅜㅜ 한편으론 저희보다 더 잘 케어해주시는구나 ~ 하는 생각이 들 정도 였습니다 ㅎㅎ정말 너무 감사하고 다음에 이 분에게만 맡길거에요! 감사합니다!
								</div>
		<div class="review-date">2018. 09. 07.</div>
		</div>
		
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
        
      </div>
    </div>
  </div>                    
				</div>
			</div>
		</div>
	</div>
      </div>
      
    </div>
  </div>
<jsp:include page="layout/footer.inc.jsp" flush="false" />
