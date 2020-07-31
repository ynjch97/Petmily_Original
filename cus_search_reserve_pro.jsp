<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.util.Date" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="petmily.customer.ReserveDBBean"%>
<%@ page import="petmily.customer.CustomerDBBean" %>
<%@ page import="petmily.petsitter.PetsitterDBBean" %>

<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<jsp:useBean id="reserve" class="petmily.customer.ReserveDataBean">
     <jsp:setProperty name="reserve" property="*"/>
</jsp:useBean>

<jsp:useBean id="customer" class="petmily.customer.CustomerDataBean">
     <jsp:setProperty name="customer" property="*"/>
</jsp:useBean>

<jsp:useBean id="petsitter" class="petmily.petsitter.PetsitterDataBean">
     <jsp:setProperty name="petsitter" property="*"/>
</jsp:useBean>

<%
   String realFolder = "";//웹 어플리케이션상의 절대 경로
   String filename ="";
   MultipartRequest imageUp = null; 
   
   String saveFolder = "/imageFile";//파일이 업로드되는 폴더를 지정한다.
   String encType = "utf-8"; //엔코딩타입
   int maxSize = 2*1024*1024;  //최대 업로될 파일크기 5Mb
   //현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
   ServletContext context = getServletContext();
   realFolder = context.getRealPath(saveFolder);  
   
   try{
      //전송을 담당할 콤포넌트를 생성하고 파일을 전송한다.
      //전송할 파일명을 가지고 있는 객체, 서버상의 절대경로,최대 업로드될 파일크기, 문자코드, 기본 보안 적용
      imageUp = new MultipartRequest(
          request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
   }catch(Exception e){
      e.printStackTrace();
   }
%>

<%
   request.setCharacterEncoding("utf-8"); 

   /* 값 가져오기 */
   String res_date = imageUp.getParameter("res_date");
   String cus_id = imageUp.getParameter("cus_id");
   String dog_id = imageUp.getParameter("dog_id");
   String pet_id = imageUp.getParameter("pet_id");
   String cus_name = imageUp.getParameter("cus_name");
   String dog_name = imageUp.getParameter("dog_name");
   String pet_name = imageUp.getParameter("pet_name");
   int pet_cash = Integer.parseInt(imageUp.getParameter("pet_cash"));
   int petmily_pet = (int)(pet_cash * 0.9);	// 예약 금액의 90%
   int petmily_fee = (int)(pet_cash * 0.1);
   String res_comment = imageUp.getParameter("res_comment");
   
   /* 값 넣기 */
   reserve.setRes_date(res_date);
   reserve.setCus_id(cus_id);
   reserve.setCus_name(cus_name);
   reserve.setDog_id(dog_id);
   reserve.setDog_name(dog_name);
   reserve.setPet_id(pet_id);
   reserve.setPet_name(pet_name);
   reserve.setPet_cash(pet_cash);
   reserve.setPetmily_pet(petmily_pet);
   reserve.setPetmily_fee(petmily_fee);
   reserve.setRes_comment(res_comment);
   reserve.setRes_reg_date(new Timestamp(System.currentTimeMillis()) );
   
   String title = "펫밀리:"+pet_id+"님에게 예약 신청 PRO";
   
   CustomerDBBean charge = CustomerDBBean.getInstance();
   int cusMileBefore = charge.getCusMileage(cus_id); // 있던 금액
   if ((cusMileBefore - petmily_pet) < 0) {
%>
	
	<script>
	    alert("마일리지가 부족해서 예약을 할 수 없어요. \n마일리지를 충전해보세요.");
		location.href="cus_my_mileage.jsp";
	</script>
	
<%	   
   } else {
	   ReserveDBBean logon = ReserveDBBean.getInstance();
	   logon.insertReserve(reserve); 
	   
	   // 고객 마일리지 감소
	   int cusMileAfter = cusMileBefore - pet_cash;
	   charge.updateMileage(cusMileAfter, cus_id);
	   
	   // 펫시터 마일리지 증가
	   PetsitterDBBean petCharge = PetsitterDBBean.getInstance();
	   int petMileAfter = petCharge.getPetMileage(pet_id);
	   petMileAfter += petmily_pet;
	   petCharge.updateMileage(petMileAfter, pet_id);
	   
	   System.out.println(petMileAfter);
%>

<style>
@charset "utf-8";

.blog
{
   width: 100%;
   background: #FFFFFF;
   padding-top: 60px;
   margin-bottom:4%;
   
}
#reservetitle
{
   padding-top:10px;
   padding-bottom:50px;
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
   font-size:16px;
   color:#000000;
   
}
#reservefont2
{
   font-size:16px;
   color:#000000;
   margin-left:2.8%;
   
}
#sumreservefont
{
   font-size:20px;
   color:#000000;
   font-weight:bold;
   margin-left:2.8%;
   
}
#dateselect /**예약날짜*/
{
   margin-right:72%;
}
#date
{
   margin-top:12px;
}
#care /**박길동*/
{
   margin-left:88%;
   margin-top:-20px;
}

#sum /**최종 금액*/
{
   color: #ffcc00;
}
#sumprice /**30000원*/
{
   margin-left:100px;
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
   <div class="container" align="center">
   <img src="images/guarantee.png" width="90px;" style="padding-bottom:10px;">
      <div id="reservetitle">
         <div id="title1">
            펫시터 <span id="petsittername"><%=pet_name%>님</span>께 고객님의 반려견 <span
               id="petsittername"><%=dog_name%></span>의 돌봄 예약을 완료하였습니다.
         </div>
         <div id="title2">아래 내역을 확인해 주세요.</div>
      </div>

      <div style="font-size:17px; width:600px;">
      <div class="row">
      <div class="col-md-3" align="left">예약일</div>
      <div class="col-md-9" align="left" style="font-weight:bold;"><%=res_date%></div>   
      
      </div>
      <hr>
      <div class="row">
      <div class="col-md-3" align="left">금액</div>
      <div class="col-md-9" align="left" style="font-weight:bold;"><%=pet_cash%> 원</div>   
      
      </div>
      <hr>
      <div class="row">
      <div class="col-md-3" align="left">요청사항</div>
      <div class="col-md-9" align="left" style="font-weight:bold;"><%=res_comment%></div>   
      </div>
      <hr>
      <div style=" font-size:15px; padding-top:40px;padding-bottom:10px;">
      확인을 누르시면 마이페이지로 이동합니다
      </div>
      
      </div>
<%--       예약이 완료되었습니다. (여기다 예약완료 페이지를 만듦)
      <p> 고객 : <%=cus_id %> <%=cus_name%> </p>
      <p> 펫시터 : <%=pet_id %> <%=pet_name %> </p>
      <p> 개 : <%=dog_id %> <%=dog_name %> </p>
      <p> 예약일 : <%=res_date%> </p>
      <p> 금액 : <%=pet_cash%> </p>
      <p> 요청사항 : <%=res_comment%> </p> --%>
      <button type="button" class="btn" id="colorch" onclick="window.location.href='cus_my_reserve.jsp'" style="width:15%">확인</button>
       
   </div>
</div>

<script>
<% 
   } 
%>
</script>
  
<!-- Footer -->
<jsp:include page="layout/footer.inc.jsp" flush="false"/>

<%
   }
%>