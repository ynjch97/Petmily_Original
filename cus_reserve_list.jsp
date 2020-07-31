<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String title = "new_pet_main";
%>

<!-- <link rel="stylesheet" type="text/css" href="styles/cus_reserve_list.css"> -->

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
	height: 200px; 
	margin-bottom: 20px;
}

#cardtagroup
{
	margin-top:2%;
	margin-left:1%;
}
#cardtitle
{
	font-size:20px;
	font-weight:bold;
	margin-bottom:8px;
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
#btntag
{
	width:80px;
	margin-right:15px;
	border:1px solid #aaa;
	font-size:14px;
}
#hs_circle2{
	margin-top: 10px;
   width: 130px;
   height: 130px;
}
#dogname1
{
	margin-left:2%;
	margin-top:1.8px;
}
#cardstar1
{
	margin-top:3px;
	margin-left:20px;
}
.review-date{
	margin-left:155px;
}
</style>

<!-- Header -->
<jsp:include page="layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<!-- Blog -->

<div class="blog">
	<div class="container">
		<div class="col-12 col-md-10 col-lg-8">
			<div class="card-body row no-gutters align-items-center">
				<div class="col-auto">
					<i class="fa fa-search fa-2x" style="margin-right: 10px;"></i>
				</div>
				<!--end of col-->
				<div class="col">
					<input class="form-control form-control-lg form-control-borderless"
						type="search" placeholder="펫시터ID, 이름 검색">
				</div>
				<!--end of col-->
				<div class="col-auto">
					<button class="btn btn-lg btn-success" type="submit"
						style="margin-left: 30px;">Search</button>
				</div>
				<!--end of col-->
			</div>
		</div>

		<div class="card flex-md-row mb-4">
			<div id="carouselExampleControls" class="carousel slide "
				data-ride="carousel" style="width: 25%">
				<div id="ec_carousel-inner" class="carousel-inner">
					<div class="carousel-item active">
						<img class="d-block w-100" src="images/room1.jpg">
					</div>
					<div class="carousel-item">
						<img class="d-block w-100" src="images/room2.jpg">
					</div>
					<div class="carousel-item">
						<img class="d-block w-100" src="images/room1.jpg">
					</div>
				</div>
				<a class="carousel-control-prev" href="#carouselExampleControls"
					role="button" data-slide="prev"> <span
					class="carousel-control-prev-icon" aria-hidden="true"></span> <span
					class="sr-only"></span></a> <a class="carousel-control-next"
					href="#carouselExampleControls" role="button" data-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="sr-only"></span>
				</a>
			</div>
			<div class="card-body">
				<h4 style="margin-bottom: 10px;">
					2018-09-18&nbsp;<small>17:02:33</small>
				</h4>
				<h3 class="card-title" style="font-weight: bold">깨끗한 집, 푸른
					센트럴파크가 바로 앞 맘편히 맡기세요:)</h3>
				<p class="card-text">홍길동</p>
				<div class="form-group row" id="cardtagroup">
					<button type="button" class="btn btn-outline-dark" id="btntag">투약가능</button>
					<button type="button" class="btn btn-outline-dark" id="btntag">픽업가능</button>
					<button type="button" class="btn btn-outline-dark" id="btntag">수제간식</button>
					<button type="button" class="btn btn-outline-dark" id="btntag">응급처치</button>
					<button type="button" class="btn btn-info" id="register"
						data-toggle="modal" data-target=".bd-example-modal-lg">일지</button>
					<button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal"
						id="register2">리뷰</button>
				</div>
				<!-- line modal 일지모달 -->
				<div class="modal fade bd-example-modal-lg" tabindex="-1"
					role="dialog" aria-labelledby="myLargeModalLabel"
					aria-hidden="true">
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
								<img src="images/dog4.jpg"
									style="width: 200px; height: 130px; margin-left: 60px;">
								<img src="images/dog5.jpg"
									style="width: 200px; height: 130px; margin-left: 10px;">
								<img src="images/dog6.jpg"
									style="width: 200px; height: 130px; margin-left: 10px;"">
								<p style="margin: 5%">배은지 저희 부부는 애견호텔에 맡기는 것 자체를 못미더워 정말
									싫어하는데, 이번 여행에 어쩔 수 없이 맡기게 되어 펫시터라는 걸 알게되었어요~ 반신반의한 마음으로 맡겨봤는데,
									정말 친절한 펫시터님께서 하루에 동영상, 사진 계속해서 보내주시고, 매일매일 산책도 해주시고~ 하루에 대한 자세한
									설명도 꾸준히 보내주셨어요! 진짜 우리 강아지들 맡기는게 이렇게 맘이 놓인 적은 없어요 ㅜㅜ 한편으론 저희보다 더
									잘 케어해주시는구나 ~ 하는 생각이 들 정도 였습니다 ㅎㅎ정말 너무 감사하고 다음에 이 분에게만 맡길거에요!
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



<!-- Footer -->

<jsp:include page="layout/footer.inc.jsp" flush="false" />