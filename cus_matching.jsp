<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8"); 
String title = "펫밀리:일대일 매칭";
%>

<link href="https://fonts.googleapis.com/css?family=Fira+Sans" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="styles/matching.css">
<style>
#ma{
   background-image: url("images/medal2.png");
   background-size:100px;
   background-repeat: no-repeat;
   background-position: 80px 0px;
}
#matchingtitle {
   padding-bottom: 40px;
   padding-left: 20px;
}

#title1 {
   color: #404040;
   font-size: 20px;
   font-weight: bold;
   font-size: 25px;
}

#title2 {
   color: #404040;
   font-size: 20px;
   font-weight: bold;
   font-size: 25px;
}

#datepic {
   width: 230px;
   border: 1px solid #aaa;
   border-radius: 4px;
   outline: none;
   padding: 5px;
   box-sizing: border-box;
   transition: .3s;
}

#totalprice {
   font-weight: bold;
   font-size: 20px;
   color: #ffcc00;
}
#star
{
   color:#ffd633;
}
#hrhr {
   margin-right : 5%;   
}
#gold{
   background-image: url("images/medal1.png");
   background-size:100px;
   background-repeat: no-repeat;
   background-position: 80px 0px;
}
#silver{
   background-image: url("images/medal2.png");
   background-size:100px;
   background-repeat: no-repeat;
   background-position: 80px 0px;
}
#bronze{
   background-image: url("images/medalb.png");
   background-size:100px;
   background-repeat: no-repeat;
   background-position: 80px 0px;
}
</style>

<link rel="stylesheet" type="text/css" href="styles/blog2.css">
<link rel="stylesheet" type="text/css" href="styles/cal2.css">
<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Lato:300,400,700">
<link rel="stylesheet" href="http://weloveiconfonts.com/api/?family=fontawesome">
<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
<script src="assets/js/simplecalendar.js" type="text/javascript"></script>
<script type="text/javascript">
<%  
   if(session.getAttribute("cus_id")==null)
   {
%>
       alert("<고객> 로그인 후 이용가능한 서비스입니다.\n메인페이지로 이동합니다.");
       self.close();
       parent.location.replace("index.jsp"); // 추가
<% 
   } else {
%>
</script>

<!-- Header -->
<jsp:include page="layout/header.inc.jsp" flush="false">
   <jsp:param name="title" value="<%=title %>" />
</jsp:include>

<!-- Blog -->
<div class="blog">
   <div class="container">
      <div id="matchingtitle" style="padding-top:20px; margin-bottom:10px;">
         <div class="row">
            <div class="col-md-1 text-left">
               <img src="images/medal.png" style="width: 70px;">
            </div>
            <div class="col-md-9 text-left" style="padding-left: 10px;">
               <div id="title1" style="padding-bottom:10px;">
                  펫밀리가 추천하는 1:1 맞춤형 펫시터를 경험해보세요.
                   </div>
                  <h5>회원가입 시 입력하신 매칭문항을 토대로 나와 딱 맞는 펫시터를 추천드립니다.</h5>
               
            </div>
            <div class="col-md-2">
               
            </div>
         </div>
      </div>
      <div id="pet_div" style="margin-bottom: 30px;">
         <!-- ajax 값 들어오는 곳 -->
      </div>
      <!--  -->
      <!-- 지도, 예약, 캘린더, 후기, 일지 -->
      
     
      
      
   </div>
  <!--  <div style="background:url(images/mm.png) no-repeat center center; background-size: cover;">
  <div class="title">
    <h3 style="color:white;">내 반려동물 전문가 No.1수의사의 펫시팅</h3>
    <p>수의사가 운영하고 수의대생이 돌보는 펫시팅<br>
      내 아이 믿고 맡길 수 있는 펫트너를 찾아보세요!</p>
  </div>
  <a href="/petners" class="btn btn_new">
    <i class="fa fa-search"></i>
    <span>펫트너 찾기</span>
  </a>
</div>
<div class="btn_fixed m_only">
  <a href="/petners" class="btn btn_new">
    <span class="icn icn_new"></span>
    <span>펫트너 찾기</span>
  </a>
</div> -->
<div align="center" style="margin-top:80px; margin-bottom:100px;">
<h4>더 많은 매칭된 펫시터를 원하시나요?</h4><br>
<img src="images/mm.png" style="padding-bottom:10px;"><br>
<button type="button" class="btn" id="colorch" onclick="window.location.href='cus_matching_all.jsp'">
               더 많은 매칭 결과보기</button>
</div>
</div>


<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>

$( document ).ready(function() {
   $.ajax({
      url : 'cus_matching_pro.jsp',
      dataType : "html",
      //data : params,
      success : 
      function(data) {
         $("#pet_div").html();
         $("#pet_div").html(data);
      }
   });
});

</script>

<script>   
<%}%>
</script>

<!-- Footer -->

<jsp:include page="layout/footer.inc.jsp" flush="false" />