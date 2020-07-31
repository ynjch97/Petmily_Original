<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.text.SimpleDateFormat" %>
<%@ page import = "java.util.List" %>
<%@ page import="petmily.manager.ManagerDBBean"%>
<%@ page import="petmily.petsitter.PetsitterDataBean"%>
<%@ page import="petmily.customer.CustomerDBBean"%>
<%@ page import="petmily.customer.CustomerDataBean"%>
<%@ page import="petmily.customer.DogDBBean"%>
<%@ page import="petmily.customer.DogDataBean"%>
<!-- 날짜 정보를 위해 가져옴 -->
<%@ page import="java.util.Date"%>

<%
   request.setCharacterEncoding("utf-8"); 
   
   String pet_id = request.getParameter("pet_id");
   PetsitterDataBean petSitter = null;
   ManagerDBBean manager = ManagerDBBean.getInstance();
   petSitter = manager.getPetsitter(pet_id);
   
   String cus_id = session.getAttribute("cus_id").toString();
   CustomerDBBean cusman = CustomerDBBean.getInstance();
   CustomerDataBean customer = null;
   customer = cusman.getCustomer(cus_id);
   
   DogDBBean dogman = DogDBBean.getInstance();
   String dogID = dogman.getDogId(cus_id);
   DogDataBean dog = null;
   dog = dogman.getDog(dogID);
   
   String res_date = request.getParameter("res_date");
   String res_year = res_date.substring(0,4);
   String res_mon = res_date.substring(5,7);
   String res_day = res_date.substring(8,10);

   String title = "펫밀리:"+pet_id+"님에게 예약 신청";
%>

<style>
@charset "utf-8";

.blog
{
   width: 100%;
   background: #FFFFFF;
   padding-top: 20px;
   margin-bottom:4%;
   
}
#reservetitle
{
   padding:20px;
   padding-left:40px;
}
#title1
{
   color:#404040;
   font-size:20px;
   font-weight:bold;
   font-size:25px;
}
#title2
{
   color:#404040;
   font-size:20px;
   font-weight:bold;
   font-size:25px;
}
#petsittername
{
   color:#d09d6c;
}

#card1
{
   margin-bottom:2%;
}

#reservefont1
{
   margin-left:20px;
   font-weight:bold;
   font-size:20px;
   color:#000000;
   
}
#reservefont2
{
   font-size:16px;
   color:#000000;
   margin-left:20px;
   margin-right:20px;
   
}
#sumreservefont
{
   font-size:20px;
   color:#000000;
   font-weight:bold;
   margin-left:20px;
   margin-right:20px;
}

#care /**박길동*/
{
  
   margin-top:-20px;
}

#sum /**최종 금액*/
{
   color: #ffcc00;
}
#sumprice /**30000원*/
{
   
}
#reservecheck
{
   font-size:16px;
   font-weight:bold;
   color:#000000;
   margin-left:3%;
}
#reservechecklist
{
   margin-left:4%;
   margin-bottom:2%;
}
#card2{
   margin-bottom:20px;
   height:200px;
}
#btnreserve
{
   height:9%;
}
</style>

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
   
      <form class="form" method="post" action="cus_search_reserve_pro.jsp?pet_id=<%=petSitter.getPet_id() %>" enctype="multipart/form-data">
   
          <div id="reservetitle">
               <div id="title1">펫시터<span id="petsittername"> <%=petSitter.getPet_name()%>님</span>께 예약을 요청합니다.</div>
               <div id="title2"> 아래 내역을 확인해 주세요.</div>      
          </div>
          <div class="card" id="card1">
               <div class="card-body">
                  <div class="form-group row" id="reservefont1" style="padding-top:10px;">
                     <!-- 추가 -->
                     <%=customer.getCus_name() %>님의 반려견(<%=dog.getDog_name() %>)을 <%=res_year %>년 <%=res_mon %>월 <%=res_day %>일에 예약하시겠습니까?
                     <!-- 추가 -->
               </div> 
                 <div class="form-group row" id="reservefont2" >
                    <div class="col-md-6" align="left">
                     <span>예약 날짜</span></div>  
                       <div class="col-md-6" align="right">
                      <span id="date"><%=res_date %> </span></div>
               </div>   
                  <div class="form-group row" id="reservefont2">
                     <div class="col-md-6" align="left">
                     <span id="carecost">예약자 성명</span></div>
                     <div class="col-md-6" align="right">
                      <span id="care"><%=customer.getCus_name() %></span></div>
                  </div>
                       
                  <div class="form-group row" id="sumreservefont">
                  <div class="col-md-6" align="left">
                     <span id="sum">최종 금액</span></div>
                     <div class="col-md-6" align="right">
                      <span id="sumprice"><%=petSitter.getPet_cash() %>원</span></div>
                  </div>
            </div>
         </div>
           <textarea class="form-control" rows="5" name="res_comment" id="res_comment" placeholder="펫시터 홍길동님께 예약요청을 위해 메시지를 남겨주세요."></textarea>
           <hr>
           <p id="reservecheck"> 예약 요청 전 꼭 확인해 주세요!</p>
           <div id="reservechecklist">
            <ul>
               <li>예약을 위해 강아지에 대한 내용을 돌보미에게 상세히 적어주세요.</li>
               <li>예약완료를 위해 예약완료 버튼을 누르면 마일리지가 차감됩니다.</li>
               <li>예약완료 이후에는 환불이 불가합니다.</li>
               <li>메시지 내용은 안전거래 등의 목적으로 회사가 열람, 수집할 수 있습니다.</li>
               <li>요청 시 잘못된 정보를 전달할 경우 이로인해 발생되는 문제에 대한 책임은 의뢰인 본인에게 있습니다.</li>
               <li>'예약 요청'을 클릭하면 서비스 총액을 지불하는 것과 서비스 약관, 환불정책에 동의하는 것입니다.</li>
            </ul>
         </div>
         
         <input type="text" class="form-control" name="res_date" id="res_date" value="<%=res_date %>" readonly hidden="hidden">
         <input type="text" class="form-control" name="cus_id" id="cus_id" value="<%=cus_id %>" readonly hidden="hidden">
         <input type="text" class="form-control" name="cus_name" id="cus_name" value="<%=customer.getCus_name() %>" readonly hidden="hidden">
         <input type="text" class="form-control" name="dog_id" id="dog_id" value="<%=dog.getDog_id() %>" readonly hidden="hidden">
         <input type="text" class="form-control" name="dog_name" id="dog_name" value="<%=dog.getDog_name() %>" readonly hidden="hidden">
         <input type="text" class="form-control" name="pet_id" id="pet_id" value="<%=pet_id %>" readonly hidden="hidden">
         <input type="text" class="form-control" name="pet_name" id="pet_name" value="<%=petSitter.getPet_name() %>" readonly hidden="hidden">
         <input type="text" class="form-control" name="pet_cash" id="pet_cash" value="<%=petSitter.getPet_cash() %>" readonly hidden="hidden">
         
           <div align="center">
              <button type="submit" class="btn btn-info" id="colorch" style="width:400px;">예약하기</button>
          </div>
       
       </form>
       
   </div>
</div>

<script>
<% 
   } 
%>
</script>
   
   
   <!-- Footer -->

<jsp:include page="layout/footer.inc.jsp" flush="false"/>