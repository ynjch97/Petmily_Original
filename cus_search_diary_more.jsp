<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8"); 
String title = "PetMily";
%>

<!-- <link rel="stylesheet" type="text/css" href="styles/cus_search_diary_more.css"> -->

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
	padding:20px;
	border: solid 1px;
	margin-bottom:30px;
}
#blogtitle
{
	/**color:#000000;*/
	font-weight:bold;
	font-size:20px;
}



#btntag
{
	width:80px;
	margin-right:15px;
	border:1px solid #aaa;
	font-size:14px;
}


#cardcontainer
{	padding:30px;
	height:300px;
	margin-bottom:20px;
}
#card1
{
	padding-left:10px;
	padding-right:10px;
	padding-bottom:10px;
	margin-right:20px;
	height:240px;
}
#card2
{
	padding-top:5px;
	padding:10px;
	margin-right:20px;
	height:240px;
}
#carddate
{
	font-size:15px;
}
#dogname
{
	font-weight:bold;
	margin-right:10px;
}
</style>

<jsp:include page="layout/header.inc.jsp" flush="false">
      <jsp:param name="title" value="<%=title %>"/>
</jsp:include>

	<!-- Blog -->

	<div class="blog">
		<div class="container" id="blogcontainer">
			<p id="blogtitle">일지</p>
			<div class="card" id="cardcontainer">
			<div class="form-group row">
			<div class="col-sm-4">
			<div class="card" id="card1">
 				 <div class="card-body">
      					<label id="carddate">2018-09-23</label>	
      					<hr>	
      					<div class="form-group row" id="cardtagroup">
							<label id="dogname">반려견</label>
							<label id="dogtype">견종</label>
				 		</div>
				 		<label>고객명</label>
				 		
 				 </div>
			</div>
			</div>
			<div class="col-sm-8">
			<div class="card" id="card2">
 				 <div class="card-body">
      				<p id="content">일지내용</p>
					<p id="content">일지 내용</p>
 				 </div>
			</div>
			</div>
			</div>
			</div>
			
			<div class="card" id="cardcontainer">
			<div class="form-group row">
			<div class="col-sm-4">
			<div class="card" id="card1">
 				 <div class="card-body">
      					<label id="carddate">2018-09-23</label>	
      					<hr>	
      					<div class="form-group row" id="cardtagroup">
							<label id="dogname">반려견</label>
							<label id="dogtype">견종</label>
				 		</div>
				 		<label>고객명</label>
				 		
 				 </div>
			</div>
			</div>
			<div class="col-sm-8">
			<div class="card" id="card2">
 				 <div class="card-body">
      				<p id="content">일지내용</p>
					<p id="content">일지 내용</p>
 				 </div>
			</div>
			</div>
			</div>
			</div>
		</div>
	</div>

	
	<!-- Footer -->
<jsp:include page="layout/footer.inc.jsp" flush="false"/>