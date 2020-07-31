<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8"); 
String title = "new_pet_main";
%>

<style>
@charset "utf-8";

.blog
{
	width: 100%;
	background: #FFFFFF;
	padding-top: 20px;
	
}
.blog_info
{
	width:100%;
	background: #ffffff;
	padding-top:30px;

}
#week
{
	color:#76777A;
	font-size:18px;
	font-weight:bold;
	margin-bottom:12px;
}
.card
{
	height:200px;
	margin-bottom:20px;
	
}
#card1
{
	padding-left:5%;
	padding-right:5%;

}
#review-title
{
	margin-left:10px;
}
#review-text
{
	margin-top:16px;
}
#dogname
{
	margin-left:2%;
	margin-top:1.8px;
}
#cardstar
{
	margin-top:3px;
	margin-left:20px;
}
.fa-star
{
	color:#ffcc00;
}
#reviewimg
 {
    border-radius: 50%;
    width:160px;
}
a.comment:hover
{
   text-decoration: underline; // 언더라인(아래줄)
}
.comment
{
	margin-left:70%;
	margin-right:15px;
	color:#aaa;
}
a.score:hover 
{
   text-decoration: underline; 
}
.score
{
	margin-left:15px;
	color:#aaa;
}
#all
{
	margin-left:20px;
	color:#76777A;
	font-size:18px;
	font-weight:bold;
	margin-bottom:12px;
}
#total
{
	margin-left:10px;
}
</style>

<!-- <link rel="stylesheet" type="text/css" href="styles/new_review.css"> -->

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

<!-- Header -->
<jsp:include page="layout/header.inc.jsp" flush="false">
     <jsp:param name="title" value="<%=title %>"/>
</jsp:include>

	<!-- Blog -->

<div class="blog">
	<div class="container">
	<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link"
				href="new_collection.jsp" style="color: #090909; font-size: 14px;">
					전체
			</a></li>
			<li class="nav-item"><a class="nav-link"
				href="new_reserve_list.jsp" style="color: #090909; font-size: 14px;">
					예약내역 </a></li>
			<li class="nav-item"><a class="nav-link" href="new_diary.jsp"
				style="color: #090909; font-size: 14px;"> 일지 </a></li>
			<li class="nav-item"><a class="nav-link active" href="new_review.jsp"
				style="color: #090909; font-size: 14px;"><b>후기</b></a></li>
		</ul>
		<div id="week" style="margin-top: 30px; margin-bottom: 30px;">최근 등록된 후기</div>
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
				 						<i class="fas fa-star fa-lg"></i>
				 						<i class="fas fa-star fa-lg"></i>
				 						<i class="fas fa-star fa-lg"></i>
				 						<i class="fas fa-star fa-lg"></i>
				 						<i class="far fa-star fa-lg"></i>
				 					</div>
								</div>
								<div id="review-text">저희 부부는 애견호텔에 맡기는 것 자체를 못미더워 정말 싫어하는데, 이번 여행에 어쩔 수 없이 맡기게 되어 펫시터라는 걸 알게되었어요~ 반신반의한 마음으로 맡겨봤는데, 정말 친절한 펫시터님께서 하루에 동영상, 사진 계속해서 보내주시고, 매일매일 산책도 해주시고~ 하루에 대한 자세한 설명도 꾸준히 보내주셨어요! 진짜 우리 강아지들 맡기는게 이렇게 맘이 놓인 적은 없어요 ㅜㅜ 한편으론 저희보다 더 잘 케어해주시는구나 ~ 하는 생각이 들 정도 였습니다 ㅎㅎ정말 너무 감사하고 다음에 이 분에게만 맡길거에요! 감사합니다!
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class=alignclick>
				<div class="form-group row">
						<div id="all">전체 후기</div>
						<p id="total">총 8개</p>
						<a href="#" class="comment">날짜 순</a>
					<p>|</p>
					<a href="#" class="score">별점 높은 순</a>					
				</div>
			</div>
			<div class="card">
				<div class="card-body">
					<div>
						<img id="reviewimg" src="images/dog2.jpg">
					</div>
				</div>
			</div>
			<div class="card">
				<div class="card-body">
					<div>
						<img id="reviewimg" src="images/dog2.jpg">
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
<jsp:include page="layout/footer.inc.jsp" flush="false"/>