<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8"); 
String title = "펫밀리:일대일 매칭";
%>

<style>

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

#totalprice {
   font-weight: bold;
   font-size: 20px;
   color: #ffcc00;
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
<link rel="stylesheet" type="text/css" href="styles/matching.css">
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
     <jsp:param name="title" value="<%=title %>"/>
</jsp:include>

<!-- Blog -->

<div class="blog">
   <div class="container">
      <div id="matchingtitle">
         <div class="row">
            <div>
               <img src="images/medal.png" style="width: 70px;">
            </div>
            <div style="padding-left: 10px;">
               <div id="title1"> 객관적이고 정확하게 매칭된 맞춤형 펫시터를 <br>더 많이 만나보세요. </div>
            </div>
         </div>
      </div>

      <div id="pet_div">
         <!-- ajax 값 들어오는 곳 -->
      </div>
         
   </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>

var slideIndex = 0;

$( document ).ready(function() {
   $.ajax({
      url : 'cus_matching_all_pro.jsp',
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

<jsp:include page="layout/footer.inc.jsp" flush="false"/>