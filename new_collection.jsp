<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="petmily.manager.ManagerDBBean"%>
<%@ page import="petmily.customer.ReserveDBBean"%>
<%@ page import="petmily.customer.ReserveDataBean"%>
<%@ page import="petmily.customer.DogDataBean"%>
<%@ page import="petmily.customer.DogDBBean"%>
<%@ page import="petmily.petsitter.PetLogDataBean"%>
<%@ page import="petmily.petsitter.PetLogDBBean"%>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
   
<style>
body{
background-color:#ff0000;
}
.blog {
   width: 100%;
   background: #FFFFFF;
   padding-top: 20px;
   padding-bottom: 20px;
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

body {
   font-family: Nanum Gothic;
   font-size: 14px;
   font-weight: 400;
   /*    backgound: #FFFFFF; */
   color: #a5a5a5;
}

.card-img-top {
   height: 150px;
}

.card-header {
   font-size: 18px;
   font-weight: bold;
}

.card-title {
   font-weight: bold;
}

.fa-venus {
   color: #FFB2D9;
}

.fa-mars {
   color: #6EE3F7;
}

h4 {
   color: #a5a5a5;
}

#hs_circle {
   margin-top: 20px;
   margin-left: 90px;
   width: 150px;
   height: 150px;
}

#hs_circle1 {
   margin-top: 20px;
   margin-bottom: 2%;
   margin-left: 60px;
   width: 180px;
   height: 180px;
}

#hs_card {
   margin-bottom: 20px;
}

.hs_1 {
   margin-left: 60px;
   margin-top: 20px;
}

.hs_2 {
   margin-left: 90px;
   margin-top: 20px;
}

a.d:hover {
   text-decoration: underline;
   //
   언더라인
   (아래줄)
}

.d {
   margin-left: 900px;
   margin-right: 15px;
   color: #aaa;
}

a.f:hover {
   text-decoration: underline;
}

.f {
   margin-left: 15px;
   color: #aaa;
}

#hs_list {
   margin-left: 100px;
}

.hs_form {
   margin-left: 80px;
}

/* #hs_bt {
   margin-left: 950px;
} */
#hs_img {
   width: 80px;
   height: 80px;
}

.hs_form2 {
   margin-left: 150px;
}

#review-title {
   margin-left: 10px;
}

#review-text {
   margin-top: 16px;
}

#dogname {
   margin-left: 2%;
   margin-top: 1.8px;
}

.fa-star {
   color: #ffcc00;
}

#reviewimg {
   border-radius: 50%;
   width: 160px;
   height: 160px;
}

#weekimg {
   border-radius: 50%;
   width: 130px;
   height: 130px;
}

a.comment:hover {
   text-decoration: underline;
   //
   언더라인
   (아래줄)
}

#cardstar {
   margin-top: 3px;
   margin-left: 20px;
}

.comment {
   margin-left: 70%;
   margin-right: 15px;
   color: #aaa;
}

a.score:hover {
   text-decoration: underline;
}

.score {
   margin-left: 15px;
   color: #aaa;
}

.single-person {padding:15px; width:254px; margin-left:10px;/* box-shadow:1px 1px 15px rgba(204,204,204,1); float:left;  */
margin-right:20px; border:1px solid #a3a3a3; border-radius:5px;}
#tt{
height:160px;
background-image: url("images/tt.png");
background-size:165px;
   background-repeat: no-repeat;
   background-position: 25px 0px;}
.single-person:hover{background-color: #e9e9e9;}
.single-person hr {margin:10px 0px 10px 0px;}
.single-person h4 {text-align:center; font-weight:bold; text-transform:uppercase; font-size:15px;}
.single-person h5 {text-align:center;}
.single-person hr {margin:10px 0px 10px 0px;}
.ss {padding:15px; width:182px; float:left; margin-right:20px; border:1px solid #a3a3a3; border-radius:5px;}
.ss:hover{background-color: #e9e9e9;}
.ss h4 {text-align:center; font-weight:bold; text-transform:uppercase; font-size:15px;}
.ss h5 {text-align:center;}
.ss hr {margin:10px 0px 10px 0px;}
.price {font-size:25px; font-weight:bold;}
.full-price {margin-top:-6px;}
.title {font-weight:bold;}
.job-success {border-bottom:4px solid #14bff4; width:100%; border-top:none;}
.view-profile {padding:10px 30px 10px 30px; background:#14bff4; color:#fff; border-radius:3px;}
.view-profile:hover {background:#124c56; color:#fff;}
#reserveweek{
   width:14.28%;
   padding:0px;
   padding-bottom:10px;
   
}
#reserveweek:hover
{
   background-color: #e9e9e9;
}
#date{

padding:0px;
padding-top:5px; margin-top:5px;
}
#btntag
{
   margin-right:10px;
   border-color: #ff8a8a;
color: #ff8a8a;
background-color:#ffffff;
}
#row{
   padding-bottom:5px;
}
</style>

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

<%
	request.setCharacterEncoding("utf-8");
	String pet_id = session.getAttribute("pet_id").toString();
	String title = "펫밀리:"+pet_id+"님의 블로그";
	
	// 1. 예약 내역 띄우기
	ReserveDataBean resLists[] = null;
	ReserveDBBean res = ReserveDBBean.getInstance();
	int count = res.getResdCustomerCount(pet_id);		// count에 나에게 예약해준 고객의 수 저장
	resLists = res.getResdCustomer(count, pet_id);		// 나에게 예약해준 모든 고객 불러옴 (최근순으로)

	ManagerDBBean manager = ManagerDBBean.getInstance();
	
	DogDBBean dog = DogDBBean.getInstance();
	String dog_id = null; 								// 개 정보 가져오려고
	
	// 2. 날짜 설정을 위한 함수 
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	// 3. 일지 작성하기 
	ReserveDataBean todayRes = null;
	String today = sf.format(new Date());
	today = today.substring(0,10);
	todayRes = res.getTodayReserve(pet_id, today);
	
	// 4. 작성한 일지가 있나 확인 (오늘 날짜의 일지 출력하기)
	PetLogDBBean log = PetLogDBBean.getInstance();
	PetLogDataBean todayLog = null; 
	todayLog = log.getTodayLog(pet_id, today, today);
%>

<!-- Header -->
<jsp:include page="layout/header.inc.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>" />
</jsp:include>

<!-- Blog -->

<div class="blog">
	<div class="container">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link active" href="new_collection.jsp" style="color: #000000; font-size: 15px;"> <b>전체</b> </a></li>
			<li class="nav-item"><a class="nav-link" href="cal.jsp" style="color: #000000; font-size: 15px;"> 예약 내역 </a></li>
			<li class="nav-item"><a class="nav-link" href="new_diary.jsp" style="color: #000000; font-size: 15px;"> 일지 </a></li>
			<li class="nav-item"><a class="nav-link" href="new_review.jsp" style="color: #000000; font-size: 15px;"> 후기 </a></li>
		</ul>
		<div class="card">
			<div class="card-body">
				<div id="week" style="margin-top: 10px; margin-bottom: 30px;">
					최근 예약내역 (총 <%=count %>건)
				</div>
				<div class="row" align="center" style="align: center; margin: auto; padding: 0px;">

<!-- 예약 여부 체크 -->
<%
		String dog_kind = null;
		String dog_gender = null; 
		String gen_imo = null;
		String dog_pic = null;
		
		if (resLists == null) {	// 첫 번째 강아지 뜨게 할건지 
%>
					<div>아직 나에게 예약한 고객이 없어요.</div>
<%
		} else {

			for(int j=0; j<resLists.length; j++){
				if (resLists[j] == null) {
					continue;
				}
		
				// 예약일 몇일 전인지 & 예약일 가져옴 
				Date reg = resLists[j].getRes_reg_date();
				String when = manager.formatTimeString(reg);
				String regdate = sf.format(reg);
				regdate = regdate.substring(0,10);
				
				// 개 정보 가져오기
				dog_id = resLists[j].getDog_id();
				DogDataBean dogInfo = dog.getDog(dog_id);
				dog_kind = dogInfo.getDog_kind();
				dog_gender = dogInfo.getDog_gender();
				dog_pic = dogInfo.getDog_pic();
				
				if (dog_gender.equals("0")) {	// 0은 암컷
					gen_imo = "fa fa-venus";
				}
				else {						// 아님 수컷
					gen_imo = "fa fa-mars";
				}
				
				if (j==0) {			
%>
					<!-- 가장 최근 -->
					<div class="single-person" data-toggle="modal"
						data-target=".bd-example-modal-lg">
						<div style="height: 15px; vertical-align: center;">
							<h4><%=resLists[0].getRes_date() %></h4>
						</div>
						<hr>
						<div id="tt" align="center">
							<img class="img-responsive img-circle" id="weekimg" src="imageFile/<%=dog_pic %>" style="margin-top: 15px;" />
						</div>
						<hr>
						<h4>
							<%=resLists[0].getDog_name() %>&nbsp;<i class="<%=gen_imo %>"></i>&nbsp;(<%=dog_kind %>)
						</h4>
						<span class="title"><%=resLists[0].getCus_name() %> 고객님</span>
					</div>
<%
				}
				else {
%>

					<!-- 그 후 -->
					<div class="ss">
						<div style="height: 15px; vertical-align: center;">
							<h4><%=resLists[j].getRes_date() %></h4>
						</div>
						<hr>
						<div align="center" style="height: 160px;">
							<img class="img-responsive img-circle" id="weekimg" src="imageFile/<%=dog_pic %>" style="margin-top: 15px;" />
						</div>
						<hr>
						<h4>
							<%=resLists[j].getDog_name() %>&nbsp;<i class="<%=gen_imo %>"></i>&nbsp;(<%=dog_kind %>)
						</h4>
						<span class="title"><%=resLists[j].getCus_name()%> 고객님</span>
					</div>

<%
				}
			}
%>

<%
		}
%>
				</div>
			</div>


<%
		if (todayRes == null) { // 오늘 날짜의 예약 내역이 없다면 + 오늘 날짜의 일지가 없다면
%>
			<!-- 일지 쓸게 없을 때 -->
			<div class="blog">
				<div class="container">
					<div id="week">오늘의 일지</div>
					<div class="card" >
						<div class="card-body">
							<div class="row">
								오늘은 일지를 적을 필요가 없네요...
							</div>
						</div>
					</div>
					<br>
				</div>
			</div>

<%
		}
		else {
			
			//개 정보 가져오기
			dog_id = todayRes.getDog_id();
			DogDataBean dogInfo = dog.getDog(dog_id);
			dog_kind = dogInfo.getDog_kind();
			dog_gender = dogInfo.getDog_gender();
			dog_pic = dogInfo.getDog_pic();
			
			if (dog_gender.equals("0")) {	// 0은 암컷
				gen_imo = "fa fa-venus";
			}
			else {						// 아님 수컷
				gen_imo = "fa fa-mars";
			}
			
			if (todayLog != null) { // 오늘 날짜의 예약 내역이 있다면 + 오늘 이미 작성한 일지가 있다면
%>
			<!-- 일지 쓸게 없을 때 -->
			<div class="blog">
				<div class="container">
					<div id="week">오늘의 일지</div>
					<div class="card" >
						<div class="card-body">
							<div class="row">
								<div class="col-md-3">
									<div align="center" style="margin-top: 20px; margin-left: 60px;">
										<h6><%=todayLog.getRes_date() %></h6>
									</div>
									<img id="hs_circle1" class="rounded-circle" src="imageFile/<%=dog_pic %>">
									<div class="hs_1" align="center">
										<h4><%=todayLog.getDog_name() %>&nbsp;<i class="<%=gen_imo %>"></i>&nbsp;(<%=dog_kind %>)</h4>
										<h6><%=todayLog.getCus_name() %> 고객님</h6>
									</div>
								</div>
								<div class="col-md-9">
									<div class="form-group">
										<label for="log_title">제목</label>
										<input type="text" class="form-control" id="log_title" name="log_title" readonly value="<%=todayLog.getLog_title() %>">
									</div>
									<div class="form-group">
										<label for="log_content">일지 내용</label>
										<textarea class="form-control" id="log_content" name="log_content" rows="5" cols="85" readonly placeholder="<%=todayLog.getLog_content() %>"></textarea>
									</div>
									<div class="form-group row">
										<img src="imageFile/<%=todayLog.getLog_pic1() %>" style='width:15%;height:15%;margin-left:2%;'>
										<img src="imageFile/<%=todayLog.getLog_pic2() %>" style='width:15%;height:15%;'>
										<img src="imageFile/<%=todayLog.getLog_pic3() %>" style='width:15%;height:15%;'>
										<button type="submit" id="colorch" class="btn" style='margin-left:40%;'>수정하기</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<br>
				</div>
			</div>

<%	
			}	
			else if (todayLog == null) { // 오늘 날짜로 예약이 있다면 + 오늘 작성한 일지가 없다면
%>
			<!-- 일지 쓸게 있을 때 : 오늘 날짜에 예약된 내역이 있을 때 -->
			<div class="blog">
				<div class="container">
					<div id="week">오늘의 일지</div>
					<div class="card" id="hs_card">
						<div class="card-body">
							
							<form class="form" method="post" action="petLog_pro.jsp?pet_id=<%=pet_id %>" enctype="multipart/form-data">
									
								<div class="row">
									<div class="col-md-3">
										<div align="center" style="margin-top: 20px; margin-left: 60px;">
											<h6><%=todayRes.getRes_date() %></h6>
										</div>
										<img id="hs_circle1" class="rounded-circle" src="imageFile/<%=dog_pic %>">
										<div class="hs_1" align="center">
											<h4><%=todayRes.getDog_name() %>&nbsp;<i class="<%=gen_imo %>"></i>&nbsp;(<%=dog_kind %>)</h4>
											<h6><%=todayRes.getCus_name() %> 고객님</h6>
										</div>
									</div>
									<div class="col-md-9">
										<div class="form-group">
											<label for="log_title">제목</label>
											<input type="text" class="form-control" id="log_title" name="log_title">
										</div>
										<div class="form-group">
											<label for="log_content">일지 내용</label>
											<textarea class="form-control" id="log_content" name="log_content" rows="5" cols="85"></textarea>
										</div>
										<div class="form-group">
											<label for="exampleFormControlFile1">이미지 첨부</label> 
											<input type="file" id="log_pic1" name="log_pic1" class="image-upload" accept="image/*" required="required"/>
											<input type="file" id="log_pic2" name="log_pic2" class="image-upload" accept="image/*" required="required"/>
											<input type="file" id="log_pic3" name="log_pic3" class="image-upload" accept="image/*" required="required"/>
											<div class="form-group" align="right">
												<button type="submit" class="btn" id="colorch">작성완료</button>
											</div>
										</div>
									</div>
								</div>
								
								<input type="text" class="form-control" id="pet_id" name="pet_id" value="<%=todayRes.getPet_id() %>" hidden="hidden">
								<input type="text" class="form-control" id="cus_id" name="cus_id" value="<%=todayRes.getCus_id() %>" hidden="hidden">
								<input type="text" class="form-control" id="dog_id" name="dog_id" value="<%=todayRes.getDog_id() %>" hidden="hidden">
								<input type="text" class="form-control" id="pet_name" name="pet_name" value="<%=todayRes.getPet_name() %>" hidden="hidden">
								<input type="text" class="form-control" id="cus_name" name="cus_name" value="<%=todayRes.getCus_name() %>" hidden="hidden">
								<input type="text" class="form-control" id="dog_name" name="dog_name" value="<%=todayRes.getDog_name() %>" hidden="hidden">
								<input type="text" class="form-control" id="dog_pic" name="dog_pic" value="<%=dog_pic %>" hidden="hidden">
								<input type="text" class="form-control" id="res_date" name="res_date" value="<%=todayRes.getRes_date() %>" hidden="hidden">
									
							</form>
							
						</div>
					</div>
					<br>
				</div>
			</div>
<%
			}
			else {
%>
			<div>오류</div>
<%
			}
		}
%>
			


			<div class="blog">
				<div class="container">
					<div id="week">최근 등록된 후기</div>
					<div class="card" id="card1">
						<div class="card-body">
							<div id="reviewimgpad">
								<div class="row">
									<div class="col-sm-3">
										<img id="reviewimg" src="images/dog2.jpg">
									</div>
									<div class="col-sm-9">
										<div class="row">
											<h4 id="review-title">이름/아이디</h4>
											<div id="dogname">포포</div>
											<div class="form-group row" id="cardstar">
												<i class="fas fa-star fa-lg"></i> <i
													class="fas fa-star fa-lg"></i> <i class="fas fa-star fa-lg"></i>
												<i class="fas fa-star fa-lg"></i> <i
													class="far fa-star fa-lg"></i>
											</div>
										</div>
										<div id="review-text">저희 부부는 애견호텔에 맡기는 것 자체를 못미더워 정말
											싫어하는데, 이번 여행에 어쩔 수 없이 맡기게 되어 펫시터라는 걸 알게되었어요~ 반신반의한 마음으로
											맡겨봤는데, 정말 친절한 펫시터님께서 하루에 동영상, 사진 계속해서 보내주시고, 매일매일 산책도 해주시고~
											하루에 대한 자세한 설명도 꾸준히 보내주셨어요! 진짜 우리 강아지들 맡기는게 이렇게 맘이 놓인 적은 없어요
											ㅜㅜ 한편으론 저희보다 더 잘 케어해주시는구나 ~ 하는 생각이 들 정도 였습니다 ㅎㅎ정말 너무 감사하고 다음에
											이 분에게만 맡길거에요! 감사합니다!</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="card" id="card1">
						<div class="card-body">
							<div id="reviewimgpad">
								<div class="row">
									<div class="col-sm-3">
										<img id="reviewimg" src="images/dog2.jpg">
									</div>
									<div class="col-sm-9">
										<div class="row">
											<h4 id="review-title">이름/아이디</h4>
											<div id="dogname">포포</div>
											<div class="form-group row" id="cardstar">
												<i class="fas fa-star fa-lg"></i> <i
													class="fas fa-star fa-lg"></i> <i class="fas fa-star fa-lg"></i>
												<i class="fas fa-star fa-lg"></i> <i
													class="far fa-star fa-lg"></i>
											</div>
										</div>
										<div id="review-text">저희 부부는 애견호텔에 맡기는 것 자체를 못미더워 정말
											싫어하는데, 이번 여행에 어쩔 수 없이 맡기게 되어 펫시터라는 걸 알게되었어요~ 반신반의한 마음으로
											맡겨봤는데, 정말 친절한 펫시터님께서 하루에 동영상, 사진 계속해서 보내주시고, 매일매일 산책도 해주시고~
											하루에 대한 자세한 설명도 꾸준히 보내주셨어요! 진짜 우리 강아지들 맡기는게 이렇게 맘이 놓인 적은 없어요
											ㅜㅜ 한편으론 저희보다 더 잘 케어해주시는구나 ~ 하는 생각이 들 정도 였습니다 ㅎㅎ정말 너무 감사하고 다음에
											이 분에게만 맡길거에요! 감사합니다!</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="card" id="card1">
						<div class="card-body">
							<div id="reviewimgpad">
								<div class="row">
									<div class="col-sm-3">
										<img id="reviewimg" src="images/dog2.jpg">
									</div>
									<div class="col-sm-9">
										<div class="row">
											<h4 id="review-title">이름/아이디</h4>
											<div id="dogname">포포</div>
											<div class="form-group row" id="cardstar">
												<i class="fas fa-star fa-lg"></i> <i
													class="fas fa-star fa-lg"></i> <i class="fas fa-star fa-lg"></i>
												<i class="fas fa-star fa-lg"></i> <i
													class="far fa-star fa-lg"></i>
											</div>
										</div>
										<div id="review-text">저희 부부는 애견호텔에 맡기는 것 자체를 못미더워 정말
											싫어하는데, 이번 여행에 어쩔 수 없이 맡기게 되어 펫시터라는 걸 알게되었어요~ 반신반의한 마음으로
											맡겨봤는데, 정말 친절한 펫시터님께서 하루에 동영상, 사진 계속해서 보내주시고, 매일매일 산책도 해주시고~
											하루에 대한 자세한 설명도 꾸준히 보내주셨어요! 진짜 우리 강아지들 맡기는게 이렇게 맘이 놓인 적은 없어요
											ㅜㅜ 한편으론 저희보다 더 잘 케어해주시는구나 ~ 하는 생각이 들 정도 였습니다 ㅎㅎ정말 너무 감사하고 다음에
											이 분에게만 맡길거에요! 감사합니다!</div>
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

<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog"
	aria-labelledby="myLargeModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">

				<button type="button" class="close" data-dismiss="modal">&times;</button>

			</div>
			<div class="modal-body" style="font-size: 15px;">
				<div
					style="font-size: 20px; font-weight: bold; padding-bottom: 10px; color:#696969;">고객정보</div>
				<div>
					<div id="row" class="row">
						<div class="col-md-3" style="font-weight: bold;">아이디</div>
						<div class="col-md-7">hyoju65</div>
					</div>
					<div id="row" class="row">
						<div class="col-md-3" style="font-weight: bold;">이름</div>
						<div class="col-md-7">이효주</div>
					</div>
					<div id="row" class="row">
						<div class="col-md-3" style="font-weight: bold;">성별</div>
						<div class="col-md-7">여</div>
					</div>
					<div id="row" class="row">
						<div class="col-md-3" style="font-weight: bold;">전화번호</div>
						<div class="col-md-7">01024931237</div>
					</div>
					<div id="row" class="row">
						<div class="col-md-3" style="font-weight: bold;">주소</div>
						<div class="col-md-7">서울시 노원구 상계8동</div>
					</div>
					<div id="row" class="row">
						<div class="col-md-3" style="font-weight: bold;">매칭문항</div>
						<div class="col-md-7">
							<button type='button' class='btn btn-outline-dark' id='btntag'
								disabled>주택</button>
							<button type='button' class='btn btn-outline-dark' id='btntag'
								disabled>수제간식</button>
							<button type='button' class='btn btn-outline-dark' id='btntag'
								disabled>동물병원</button>
							<button type='button' class='btn btn-outline-dark' id='btntag'
								disabled>훈련가능</button>
						</div>
					</div>
					<hr>
					<div
						style="font-size: 20px; font-weight: bold; padding-bottom: 10px; color:#696969;">반려견정보</div>
					<div id="row" class="row">
						<div class="col-md-3" align="center">
							<img class="img-responsive img-circle" id="weekimg"
								src="images/komi.png" />
						</div>
						<div class="col-md-7">
							<div class="row">
								<div class="col-md-5" style="font-weight: bold;">이름</div>
								<div class="col-md-7">
									꼬미 <i class="fa fa-mars"></i>
								</div>
							</div>
							<div class="row">
								<div class="col-md-5" style="font-weight: bold;">품종</div>
								<div class="col-md-7">닥스훈트</div>
							</div>
							<div class="row">
								<div class="col-md-5" style="font-weight: bold;">몸무게</div>
								<div class="col-md-7">5kg</div>
							</div>
							<div class="row">
								<div class="col-md-5" style="font-weight: bold;">생년월일</div>
								<div class="col-md-7">2014/11/12</div>
							</div>
							<div class="row">
								<div class="col-md-5" style="font-weight: bold;">관리지침 및
									요청사항</div>
								<div class="col-md-7">다이어트중이니까 간식주지마세용</div>
							</div>
						</div>
					</div>
					<div class="row" style="padding-top: 10px;">
						<div class="col-md-6" style="font-weight: bold;">Q.반려동물 등록을
							하였습니까?</div>
						<div class="col-md-6">내장형 무선 식별장치 개체삽입</div>
					</div>
					<div class="row">
						<div class="col-md-6" style="font-weight: bold;">Q.중성화 수술을
							하였습니까?</div>
						<div class="col-md-6">네</div>
					</div>
					<div class="row">
						<div class="col-md-6" style="font-weight: bold;">Q.다른 개와
							친화적입니까?</div>
						<div class="col-md-6">네</div>
					</div>
					<div class="row">
						<div class="col-md-6" style="font-weight: bold;">Q.잘 짖습니까?</div>
						<div class="col-md-6">네</div>
						<div class="col-md-6" style="font-weight: bold;"></div>
						<div class="col-md-6">초인종을 눌렀을때</div>
					</div>
					<div class="row">
						<div class="col-md-6" style="font-weight: bold;">Q.앓고 있는
							지병이나 이전에 다쳤던 적이 있나요?</div>
						<div class="col-md-6">네</div>
						<div class="col-md-6" style="font-weight: bold;"></div>
						<div class="col-md-6">곰팡이 피부염</div>
					</div>
					<div class="row">
						<div class="col-md-6" style="font-weight: bold;">Q.당신의 반려견은
							대소변을 잘 가리는 편입니까?</div>
						<div class="col-md-6">네</div>
						<div class="col-md-6" style="font-weight: bold;"></div>
						<div class="col-md-6">배변패드</div>
					</div>
					<hr>
					<div
						style="font-size: 20px; font-weight: bold; padding-bottom: 10px; color:#696969;" >병원정보</div>
					<div id="row" class="row">
						<div class="col-md-5" style="font-weight: bold;">병원명</div>
						<div class="col-md-7">스마트동물병원</div>
					</div>
					<div id="row" class="row">
						<div class="col-md-5" style="font-weight: bold;">전화번호</div>
						<div class="col-md-7">029527582</div>
					</div>
					<div id="row" class="row">
						<div class="col-md-5" style="font-weight: bold;">주소</div>
						<div class="col-md-7">서울시 노원구 노원로 470</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
<%
	}
%>
</script>

<!-- Footer -->
<jsp:include page="layout/footer.inc.jsp" flush="false" />
