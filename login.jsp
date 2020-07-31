<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="petmily.customer.CustomerDBBean"%>
<%@ page import="petmily.petsitter.PetsitterDBBean"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cus_id = (String) session.getAttribute("cus_id");
	String pet_id = (String) session.getAttribute("pet_id");
	String pageTitle = request.getParameter("title");
	// title 이라는 변수를 받아와서 pageTitle에 넣는다 
	
	String title = "펫밀리:내블로그";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
<link href="plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
<link href="plugins/colorbox/colorbox.css" rel="stylesheet" type="text/css">
<link href="plugins/video-js/video-js.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<link href="https://cdnjs.cloudflare.com/ajax/libs/air-datepicker/2.2.3/css/datepicker.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/air-datepicker/2.2.3/js/datepicker.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/air-datepicker/2.2.3/js/i18n/datepicker.en.js"></script>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="styles/bootstrap4/popper.js"></script>
<script src="styles/bootstrap4/bootstrap.min.js"></script>
<script src="plugins/greensock/TweenMax.min.js"></script>
<script src="plugins/greensock/TimelineMax.min.js"></script>
<script src="plugins/scrollmagic/ScrollMagic.min.js"></script>
<script src="plugins/greensock/animation.gsap.min.js"></script>
<script src="plugins/greensock/ScrollToPlugin.min.js"></script>
<script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="plugins/easing/easing.js"></script>
<script src="plugins/parallax-js-master/parallax.min.js"></script>
<script src="js/custom.js"></script>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
	<script src="js/jquery-3.2.1.min.js"></script>
	<script src="styles/bootstrap4/popper.js"></script>
	<script src="styles/bootstrap4/bootstrap.min.js"></script>
	<script src="plugins/greensock/TweenMax.min.js"></script>
	<script src="plugins/greensock/TimelineMax.min.js"></script>
	<script src="plugins/scrollmagic/ScrollMagic.min.js"></script>
	<script src="plugins/greensock/animation.gsap.min.js"></script>
	<script src="plugins/greensock/ScrollToPlugin.min.js"></script>
	<script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
	<script src="plugins/easing/easing.js"></script>
	<script src="plugins/parallax-js-master/parallax.min.js"></script>
	<script src="plugins/colorbox/jquery.colorbox-min.js"></script>
	<script src="js/about.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="styles/main_styles.css">
<title>Insert title here</title>
<style>
.panel-login {
	border-color: #ccc;
	-webkit-box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
	-moz-box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
	box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
}
.panel-login>.panel-heading {
	color: #a5a5a5;
	background-color: #fff;
	border-color: #fff;
	text-align:center;
}
.panel-login>.panel-heading a{
	text-decoration: none;
	color: #a5a5a5;
	font-weight: bold;
	font-size: 15px;
	-webkit-transition: all 0.1s linear;
	-moz-transition: all 0.1s linear;
	transition: all 0.1s linear;
}
.panel-login>.panel-heading a.active{
	font-weight: bold;
	font-size: 18px;
}
.panel-login>.panel-heading hr{
	margin-top: 10px;
	margin-bottom: 0px;
	clear: both;
	border: 0;
	height: 1px;
	background-image: -webkit-linear-gradient(left,rgba(0, 0, 0, 0),rgba(0, 0, 0, 0.15),rgba(0, 0, 0, 0));
	background-image: -moz-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
	background-image: -ms-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
	background-image: -o-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
}
.panel-login input[type="text"],.panel-login input[type="email"],.panel-login input[type="password"] {
	height: 45px;
	border: 1px solid #ddd;
	font-size: 16px;
	-webkit-transition: all 0.1s linear;
	-moz-transition: all 0.1s linear;
	transition: all 0.1s linear;
}
.panel-login input:hover,
.panel-login input:focus {
	outline:none;
	-webkit-box-shadow: none;
	-moz-box-shadow: none;
	box-shadow: none;
	border-color: #ccc;
}
.btn-login {
	background-color: #FFB9B9;
	outline: none;
	color: #fff;
	font-size: 14px;
	height: auto;
	font-weight: normal;
	padding: 14px 0;
	text-transform: uppercase;
	border-color: #FFB9B9;
}
.btn-login:hover,
.btn-login:focus {
	color: #fff;
	background-color: #FFA2A2;
	border-color: #FFA2A2;
}
.forgot-password {
	text-decoration: underline;
	color: #888;
}
.forgot-password:hover,
.forgot-password:focus {
	text-decoration: underline;
	color: #666;
}

.btn-register {
	background-color: #FFB9B9;
	outline: none;
	color: #fff;
	font-size: 14px;
	height: auto;
	font-weight: normal;
	padding: 14px 0;
	text-transform: uppercase;
	border-color: #FFB9B9;
}
.btn-register:hover,
.btn-register:focus {
	color: #fff;
	background-color: #FFA2A2;
	border-color: #FFA2A2;
}
</style>
<script>
$(function() {
    $('#login-form-link').click(function(e) {
		$("#login-form").delay(100).fadeIn(100);
 		$("#register-form").fadeOut(100);
	 	$(this).addClass('active'); 
		e.preventDefault();
	});
});
</script>
</head>
<body>
	<div class="super_container">

		<header class="header">
			<!-- 최상단바 : 문의, 전화번호, 이메일 -->
			<div class="top_bar">
				<div class="top_bar_container">
					<div class="container">
						<div class="row">
							<div class="col">
								<div
									class="top_bar_content d-flex flex-row align-items-center justify-content-start">
									<ul class="top_bar_contact_list">
										<li><div class="question"
												style="font-family: Nanum Gothic">문의</div></li>
										<li><i class="fa fa-phone" aria-hidden="true"></i>
											<div style="font-family: Nanum Gothic">010-7553-9714</div></li>
										<li><i class="fa fa-envelope" aria-hidden="true"></i>
											<div style="font-family: Nanum Gothic">yj9714@naver.com</div>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- 메뉴바 : 로고, 메뉴 -->
			<div class="header_container">
				<div class="container">
					<div class="row">
						<div class="col">
							<div
								class="header_content d-flex flex-row align-items-center justify-content-start">
								<div class="logo_container">
									<a href="index.jsp">
										<div class="logo_text">
											Pet<span id="logo">mily</span> <i class="fa fa-paw"></i>
										</div> <!-- <img src="images/logo.png"> -->
									</a>
								</div>
								<nav class="main_nav_contaner ml-auto">
									<ul class="main_nav">
										
										<li><a href="login.jsp">로그인</a></li>
										<li><a href="join.jsp">회원가입</a>
										</li>
										
									</ul>
								</nav>
							</div>
						</div>
					</div>
				</div>
			</div>

		</header><br><br><br><br><br><br><br><br><br><br><br>
	</div>
<div class="container">
    	<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-login">
					<div class="panel-heading">
						<div class="row">
							<div class="col">
								<a class="active" id="login-form-link">로그인</a>
							</div>
						</div>
						<hr>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12" style="text-align:center;">
								<form id="login-form" class="active" method="post" action="#" role="form" style="display: block;">
									
										<div class="input-group mb-3" style="width: 50%; margin: auto;">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1"> <i
										class="fa fa-user" style="padding-right: 10px;"></i>
									</span>
								</div>
								<input type="text" class="form-control" id="id" name="id"
									placeholder="Username" aria-label="Username"
									aria-describedby="basic-addon1">
							</div>
							<div class="form-group mb-3" style="width: 50%; margin: auto;">
								
									<span class="input-group-text" id="basic-addon1"> <i
										class="fa fa-lock" style="padding-right: 10px;"></i>
									</span>
								
								<input type="password" class="form-control" id="passwd"
									name="passwd" placeholder="Password" aria-label="Password"
									>
							</div>
									
									<div class="form-group"">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3" style="margin-top:20px; margin-bottom:10px;">
												<input type="button" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="로그인" onclick="window.location.href='loginPro.jsp'">
											</div>
										</div>
									</div>
									<div class="modal-footer">
						비밀번호를 잊으셨나요? &nbsp; <a href="#"> 비밀번호 찾기 </a>
					</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div><br><br>
	</body>
	</html>
	
<jsp:include page="layout/footer.inc.jsp" flush="false"/>