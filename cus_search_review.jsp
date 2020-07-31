<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8"); 
String title = "PetMily";
%>

<!-- <link rel="stylesheet" type="text/css" href="styles/cus_search_review.css"> -->

<style>
@charset "utf-8";

.blog
{
	width: 100%;
	background: #FFFFFF;
	padding-top: 20px;
	
}

#blogcontainer
{
	padding:30px;
	border: solid 1px;
	margin-bottom:30px;
}
#blogtitle
{
	/**color:#000000;*/
	font-weight:bold;
	font-size:20px;
	margin-left:20px;
	margin-right:20px;
}
#review
{
	margin-top:5px;
}
a.comment:hover
{
   text-decoration: underline; // 언더라인(아래줄)
}
.comment
{
	margin-left:700px;
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

#btntag
{
	width:80px;
	margin-right:15px;
	border:1px solid #aaa;
	font-size:14px;
}



#card1
{
	padding:10px;
	margin-bottom:20px;
	
}
#cusname
{
	margin-right:10px;
}
.fa-star
{
	color:#ffcc00;
}
</style>

<!-- Header -->
<jsp:include page="layout/header.inc.jsp" flush="false">
     <jsp:param name="title" value="<%=title %>"/>
</jsp:include>

	<!-- Blog -->

	<div class="blog">
		<div class="container" id="blogcontainer">
			<div class="form-group row">
				<p id="blogtitle">고객후기</p>
				<p id="review">고객후기 12개</p>
				<a href="#" class="comment">후기 많은 순</a>
					<p>|</p>
					<a href="#" class="score">별점 높은 순</a>		
			</div>
			<div class="card" id="card1">
 				 <div class="card-body">
				 		<label id="cusname">고객명</label>
				 		<i class="fas fa-star fa-lg"></i>
				 		<i class="fas fa-star fa-lg"></i>
				 		<i class="fas fa-star fa-lg"></i>
				 		<i class="fas fa-star fa-lg"></i>
				 		<i class="far fa-star fa-lg"></i>
				 		<p>후기내용</p>
 				 </div>
			</div>
			<div class="card" id="card1">
 				 <div class="card-body">
				 	<label id="cusname">고객명</label>
				 	<i class="fas fa-star fa-lg"></i>
				 	<i class="fas fa-star fa-lg"></i>
				 	<i class="fas fa-star fa-lg"></i>
				 	<i class="fas fa-star fa-lg"></i>
				 	<i class="far fa-star fa-lg"></i>
				 	<p>후기내용</p>
 				 </div>
			</div>
			<div class="card" id="card1">
 				 <div class="card-body">
				 	<label id="cusname">고객명</label>
				 	<i class="fas fa-star fa-lg"></i>
				 	<i class="fas fa-star fa-lg"></i>
				 	<i class="fas fa-star fa-lg"></i>
				 	<i class="fas fa-star fa-lg"></i>
				 	<i class="far fa-star fa-lg"></i>
				 	<p>후기내용</p>
 				 </div>
			</div>
		</div>
	</div>

	
	<!-- Footer -->
<jsp:include page="layout/footer.inc.jsp" flush="false"/>