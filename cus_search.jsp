<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@ page import = "java.util.List" %> 
<%@ page import="java.lang.String.*" %>
<%@ page import="petmily.manager.ManagerDBBean"%>
<%@ page import="petmily.petsitter.PetsitterDataBean"%>
<!-- 날짜 정보를 위해 가져옴 -->
<%@ page import="java.util.Date"%>
    
<%
request.setCharacterEncoding("utf-8"); 
String title = "펫밀리:펫시터 검색";
%>

<%
   String id = request.getParameter("id");
   String passwd = request.getParameter("passwd");
   
   PetsitterDataBean petLists[] = null;
   int count = 0;      
   
   ManagerDBBean manager = ManagerDBBean.getInstance();
   count = manager.getPetsitterHaveTagCount();          // count에 태그가 들어간 펫시터의 수를 나타내는 메소드
   
   // petLists = manager.getApprvPetsitter(count);      // petLists : 승인되지 않은 0인 사람들을 (승인되지 않은 펫시터 회원 수만큼) 배열에 저장
%> 

<link href="https://fonts.googleapis.com/css?family=Fira+Sans" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="styles/matching.css">

<script type="text/javascript">
<%  
   if(session.getAttribute("cus_id")==null && session.getAttribute("pet_id")==null && session.getAttribute("man_id")==null)
   {
%>
       alert("로그인 후 이용가능한 서비스입니다.\n메인페이지로 이동합니다.");
       self.close();
       parent.location.replace("index.jsp"); // 추가
<% 
   } else {
%>
</script>

<style>
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

<!-- Header -->
<jsp:include page="layout/header.inc.jsp" flush="false">
     <jsp:param name="title" value="<%=title %>"/>
</jsp:include>
    

   <!-- Blog -->

   <div class="blog">
      <div class="container">

      <form class="form" id="tagform" method="post"  action="cus_search_pro.jsp" style="padding-top:30px;">
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">이름</label>   
                <input type="text" class="form-control" name="search_text" id="search_text" placeholder="펫시터 이름으로 검색해보세요" style="width:800px;">
            </div>
            <div class="form-group row">
                      <label class="col-sm-2 col-form-label">지역</label>   
                      <input type="text" class="form-control" name="search_addr" id="search_addr" placeholder="지역을 입력하세요" style="width:800px;">
                   
               </div>
               <!-- 
               <div class="form-group row">
                <label class="col-sm-2 col-form-label">날짜</label>
                  <form action="/action_page.php">
                       <input type="date" name="bday" id="calen">
                  </form>
               </div> -->   
               <div class="form-group row" style="padding-top:10px;">
                   <label class="col-sm-2 col-form-label" id="tag1">태그</label>
                   <label><input type="checkbox" class="tag" name="tag" value="mq1_1" /><span id="tag">마당이 있는 주택</span></label> 
                   <label><input type="checkbox" class="tag" name="tag" value="mq2_0" /><span id="tag">수제간식 가능</span></label> 
                   <label><input type="checkbox" class="tag" name="tag" value="ck1_0" /><span id="tag">노령견 케어</span></label>
                   <label><input type="checkbox" class="tag" name="tag" value="ck1_1" /><span id="tag">질병견 케어</span></label> 
                   <label><input type="checkbox" class="tag" name="tag" value="ck1_2" /><span id="tag">장애견 케어</span></label>
                   <label><input type="checkbox" class="tag" name="tag" value="ck1_3" /><span id="tag">발정견 케어</span></label>
               </div>
               <div class="form-group row">
                   <label class="col-sm-2 col-form-label" id="tag1"></label>
                   <label><input type="checkbox" class="tag" name="tag" value="ck1_4" /><span id="tag">임신견 케어</span></label>
                   <label><input type="checkbox" class="tag" name="tag" value="mq3_0" /><span id="tag">응급처치</span></label> 
                   <label><input type="checkbox" class="tag" name="tag" value="mq4_0" /><span id="tag">목욕 가능</span></label>
                   <label><input type="checkbox" class="tag" name="tag" value="mq5_0" /><span id="tag">훈련 가능</span></label> 
                   <label><input type="checkbox" class="tag" name="tag" value="mq6_0" /><span id="tag">야외 케어</span></label>
                   <label style="padding-right:133px;"><input type="checkbox" class="tag" name="tag" value="mq7_1" /><span id="tag">반려견 없음</span></label>             
                   <button type="button" class="btn btn-info" id="colorch" onclick="javascript:search();" style="width:120px;">검색하기</button>
                  
               </div>
      </form>
         <hr>
         <div class="form-group row" style="padding-left:13px;">
         
         <a onClick="window.location.reload()" class="comment" style="color:#a5a5a5;">전체보기</a>
            
               <a href="#" class="comment" style="padding-left:880px; color:#a5a5a5;">후기 많은 순</a>
               <p>|</p>
               <a href="#" class="score" style="color:#a5a5a5;">별점 높은 순</a>               
            
         </div>
         
         <div id="pet_div" style="padding-top:30px;">
        


         </div>

         
      </div>
   </div>

   
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script>
$( document ).ready(function() {
    $.ajax({
       url : 'cus_load.jsp',
       dataType : "html",
       success : 
       function(data) {
          $("#pet_div").html();
          $("#pet_div").html(data);
          
          showSlides();
       }
    });
 }); 
function search(){
   var params = $('#tagform').serialize(); //검색창에서 입력한 부분을 직렬화로 받음
   console.log(params); //console에 params를 출력
   $.ajax({ //ajax를 이용하여 서버와 페이지가 새로고침없이 데이터를 주고받게함
   url : 'cus_search_pro.jsp', //호출할 url
   dataType : "html", //html로 결과를 받음
   data : params, //보낼 데이터
   success : //정상응답시 실행됨
      function(data) {
         console.log(data);
         $("#pet_div").html(); 
         $("#pet_div").html(data); //pet_div에 데이터 출력
               
      }
   });
}

</script>

<script>
<% 
   }
%>
</script>

   <!-- Footer -->
<jsp:include page="layout/footer.inc.jsp" flush="false"/>