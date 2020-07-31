<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8"); 
	String title = "new_pet_main";
%>

<!-- <link rel="stylesheet" type="text/css" href="styles/new_diary.css"> -->

<style>
@charset "utf-8";

.blog {
	width: 100%;
	background: #FFFFFF;
	padding-top: 20px;
	padding-bottom: 20px;
}
#week {
	color: #76777A;
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 12px;
}
.card
{
	height:330px;
	margin-bottom:20px;
}
#hs_circle{
	margin-top: 20px;
   margin-left: 90px;
   width: 150px;
   height: 150px;
}
#hs_circle1{
	margin-bottom: 2%;
   margin-left: 100px;
    width: 180px;
    height: 180px;
}
#hs_card
{
	height:400px;
	margin-bottom:20px;
}
.hs_1{
	margin-left:120px;
	margin-top: 30px;
}
.hs_2{
	margin-left:90px;
	margin-top: 20px;
	
}
a.d:hover
{
   text-decoration: underline; // 언더라인(아래줄)
}
.d
{
	margin-left:900px;
	margin-right:15px;
	color:#aaa;
}
a.f:hover 
{
   text-decoration: underline; 
}
.f
{
	margin-left:15px;
	color:#aaa;
}
#hs_list{
	margin-left:100px;
}
.hs_form{
	
	margin-left:150px;
}
#hs_bt{
	margin-left:1000px;
}
#hs_img{
	width: 80px;
	height: 80px;
}
.hs_form2{
	margin-left: 150px;
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
			<li class="nav-item"><a class="nav-link active" href="new_diary.jsp"
				style="color: #090909; font-size: 14px;"> <b>일지</b></a></li>
			<li class="nav-item"><a class="nav-link" href="new_review.jsp"
				style="color: #090909; font-size: 14px;"> 후기 </a></li>
		</ul>
		<div id="week" style="margin-top: 30px; margin-bottom: 30px;">일지를 작성해주세요.</div>
			<div class="card" id="hs_card">
				<div class="card-body">
				<div class="row">
				<div>
				<img id="hs_circle1" class="rounded-circle" src="images/bis_1.jpg">

					<div class="hs_1">
						<h6>2018-10-08</h6>
						<br>
						<h3>복실이(비숑)</h3>
						<h6>김혜수 고객님</h6>
					</div>
				</div>
				<div>
				<form class="hs_form">
					<div class="form-group">
						<label for="exampleFormControlInput1">제목</label>
						<input type="text" class="form-control" id="exampleFormControlInput1">
					</div>
					<div class="form-group">
						<label for="Textarea1">일지 내용</label>
							<textarea class="form-control" id="Textarea1" rows="5" cols="60"></textarea>
					</div>
					<div class="form-group">
						<label for="exampleFormControlFile1">이미지 첨부</label>
						<input type="file" class="form-control-file" id="exampleFormControlFile1">
					</div>
				</form>
				</div>
				<button type="button" class="btn btn-info" id="hs_bt">작성완료</button>
				
			
           
        
				</div>
			</div>
			</div><br>
		<div id="week">전체 일지</div>
		<div class="form-group row" id="hs_list">
		<a href="#" class="d">최신 순</a>
		<p>|</p>
		<a href="#" class="f">과거 순</a>
		</div>

		<div class="card">
				<div class="card-body">
				<div class="row">
				<div>
					<img id="hs_circle" class="rounded-circle" src="images/Bichon.jpg">
					<div class="hs_2">
						<h5>2018-09-18&nbsp;<small>17:02:33</small></h5>
						<br>
						<h4>뽀글이(비숑)</h4>
						<h7>박은채 고객님</h7>
					</div>
				</div>
				<div class="hs_form2">
				<label>제목:<b>뽀글이 5시간 돌봄일지</b></label><br>
				<label>내용:</label>
				<textarea class="form-control" id="Textarea1" rows="5" cols="60"></textarea><br>
				<img src="images/walk.jpg" class="rounded" alt="..." id="hs_img">
				<img src="images/walk.jpg" class="rounded" alt="..." id="hs_img">
				<img src="images/walk.jpg" class="rounded" alt="..." id="hs_img">
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
<jsp:include page="layout/footer.inc.jsp" flush="false"/>