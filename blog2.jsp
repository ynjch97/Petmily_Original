<%@page import="com.mysql.fabric.xmlrpc.base.Array"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="petmily.manager.ManagerDBBean"%>
<%@ page import="petmily.petsitter.PetsitterDataBean"%>
<%@ page import="petmily.petsitter.PetLogDataBean"%>
<%@ page import="petmily.petsitter.PetLogDBBean"%>
<%@ page import="petmily.customer.ReserveDBBean"%>
<%@ page import="petmily.customer.ReserveDataBean"%>
<%@ page import="petmily.customer.CusReviewDBBean"%>
<%@ page import="petmily.customer.CusReviewDataBean"%>
<%@ page import="petmily.customer.DogDataBean"%>
<%@ page import="petmily.customer.DogDBBean"%>
<!-- 날짜 정보를 위해 가져옴 -->
<%@ page import="java.util.Date"%>

<!-- 일주일 내 예약한 건만 리뷰 작성할 수 있도록 계산하기 위해 import -->
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>

<%
   request.setCharacterEncoding("utf-8");

   // 이 펫시터의 정보를 보여준다
   String pet_id = "";
   pet_id = request.getParameter("pet_id");
   PetsitterDataBean petSitter = null;
   ManagerDBBean manager = ManagerDBBean.getInstance();
   petSitter = manager.getPetsitter(pet_id);
   
   // 펫시터의 금액 
   int pet_cash = petSitter.getPet_cash();
   int pet_cash_real = (int) (pet_cash * 0.9);
   int pet_cash_fee = (int) (pet_cash * 0.1);

   String title = "펫밀리:" + pet_id + "님의 페이지";

   // 날짜 계산해서 값을 비교해보기로 한다 (7일 이내의 예약건에 대해서만 리뷰를 작성할 수 있도록)
   int addDate = 0; // 가감하려는 날짜의 수    
   String strYear = null;
   String strMonth = null;
   String strDay = null;
   String strDate = null;
   
   // 고객이 리뷰를 작성하기 위해 예약 정보를 불러온다
   String cus_id = session.getAttribute("cus_id").toString();
   ReserveDBBean reserving = ReserveDBBean.getInstance();
   ReserveDataBean reservation = null;
   int resDateCheck = 0;    // 해당 날짜에 예약 내역이 있는지부터 확인하는 체크 변수
   int resCheck = 0;      // 예약 내역이 있을 때만 후기를 쓸 수 있도록 함
   
   // 리뷰를 불러온다
   CusReviewDataBean reviewList[] = null;
   CusReviewDBBean review = CusReviewDBBean.getInstance();
   int revCount = review.getCusReviewCount(pet_id);
   reviewList = review.getCusReview(revCount, pet_id);
   
   // 펫시터 리뷰 별점 평균
   float revStarAvgOri = review.getCusRevStar(pet_id);
   String format = "#.#";
   java.text.DecimalFormat ddff = new java.text.DecimalFormat(format);
   String revStarAvg = ddff.format(revStarAvgOri);
   revStarAvgOri = Float.parseFloat(revStarAvg);
   
   // 반려견 값을 가져오기 위함
   DogDBBean dog = DogDBBean.getInstance();
   
   // 일지 번호 초기화 후 pro 에서 함
   int revNum = 0;
   
   //System.out.println(revStarAvgOri + "평균 별점");
%>

<link rel="stylesheet" type="text/css" href="styles/blog2.css">
<link rel="stylesheet" type="text/css" href="styles/cal2.css">
<link rel="stylesheet"
   href="http://fonts.googleapis.com/css?family=Lato:300,400,700">
<link rel="stylesheet"
   href="http://weloveiconfonts.com/api/?family=fontawesome">

<script src="http://code.jquery.com/jquery-latest.min.js"
   type="text/javascript"></script>
<script src="assets/js/simplecalendar.js" type="text/javascript"></script>

<script type="text/javascript">
<%if (session.getAttribute("cus_id") == null && session.getAttribute("pet_id") == null
               && session.getAttribute("man_id") == null) {%>
       alert("로그인 후 이용가능한 서비스입니다.\n메인페이지로 이동합니다.");
       self.close();
       parent.location.replace("index.jsp"); // 추가
<%} else {%>
</script>

<style>
/* input[type="date"]::-webkit-calendar-picker-indicator, */
input[type="date"]::-webkit-inner-spin-button {
   display: none;
   appearance: none;
}
/* input[type="date"]::-webkit-calendar-picker-indicator {
   color: rgba(0, 0, 0, 0); //숨긴다
   opacity: 1;
   display: block;
   background: url(https://mywildalberta.ca/images/GFX-MWA-Parks-Reservations.png) no-repeat; // 대체할 아이콘
   width: 20px;
   height: 20px;
   border-width: thin;
} */
#hrhr {
   margin-right: 5%;
}

#gold {
   background-image: url("images/medal1.png");
   background-size: 100px;
   background-repeat: no-repeat;
   background-position: 80px 0px;
}

#silver {
   background-image: url("images/medal2.png");
   background-size: 100px;
   background-repeat: no-repeat;
   background-position: 80px 0px;
}

#bronze {
   background-image: url("images/medalb.png");
   background-size: 100px;
   background-repeat: no-repeat;
   background-position: 80px 0px;
}

.card {
   margin-bottom: 2%;
}
</style>

<!-- Header -->
<jsp:include page="layout/header.inc.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>" />
</jsp:include>

<!-- Blog -->
<div class="blog">
   <div class="container">
      <div class="card">

         <!-- 이미지 세 장 Carousel -->

         <div class="row">
            <div class="col-md-4" style="width: 30%">
               <div id="carouselExampleFade" class="carousel slide carousel-fade"
                  data-ride="carousel">
                  <div class="carousel-inner">
                     <div class="carousel-item active">
                        <img class="d-block w-100"
                           src="imageFile/<%=petSitter.getPet_intro1()%>"
                           alt="<%=petSitter.getPet_id()%> 회원님 사진 1">
                     </div>
                     <div class="carousel-item">
                        <img class="d-block w-100"
                           src="imageFile/<%=petSitter.getPet_intro2()%>"
                           alt="<%=petSitter.getPet_id()%> 회원님 사진 2">
                     </div>
                     <div class="carousel-item">
                        <img class="d-block w-100"
                           src="imageFile/<%=petSitter.getPet_intro3()%>"
                           alt="<%=petSitter.getPet_id()%> 회원님 사진 3">
                     </div>
                  </div>
                  <a class="carousel-control-prev" href="#carouselExampleFade"
                     role="button" data-slide="prev"> <span
                     class="carousel-control-prev-icon" aria-hidden="true"></span> <span
                     class="sr-only">Previous</span>
                  </a> <a class="carousel-control-next" href="#carouselExampleFade"
                     role="button" data-slide="next"> <span
                     class="carousel-control-next-icon" aria-hidden="true"></span> <span
                     class="sr-only">Next</span>
                  </a>
               </div>
            </div>
            <div class="col-sm-8">
               <div class="row">
                  <div class="col-md-9">
                     <p id="cardtitle" style="padding-top:10px; padding-bottom: 15px;"><%=petSitter.getPet_intro()%></p>
                     <b><label><%=petSitter.getPet_name()%></label></b><br> <label><i
                        class="fas fa-map-marker-alt"></i> <%=petSitter.getPet_addr()%></label>
                  </div>
                  
<%
   if (revStarAvgOri < 2) {
%>         
            <div class="col-md-3" id="bronze">
               <label style="font-weight: bold; font-size: 20px; color: #384158; padding-left: 100px; padding-top: 28px;">
                  <%=revStarAvgOri %>
               </label>
            </div>   
<%
   } else if (revStarAvgOri >= 2 && revStarAvgOri<4) {
%>      
            <div class="col-md-3" id="silver">
               <label style="font-weight: bold; font-size: 20px; color: #384158; padding-left: 100px; padding-top: 28px;">
                  <%=revStarAvgOri %>
               </label>
            </div>   
<%
   } else {
%>
            <div class="col-md-3" id="gold">
               <label style="font-weight: bold; font-size: 20px; color: #384158; padding-left: 100px; padding-top: 28px;">
                  <%=revStarAvgOri %>
               </label>
            </div>   
<%
   }
%>
               </div>

<%
   /* 태그용 */
   String tags = "";
   String petID = "";
   int tagCount = 0;
   //String tagArray[] = new String[7];
   //var tagArray = new Array();;
   
  
      tags = manager.getPetsittersTag(petSitter.getPet_id());
      
      // 태그 개수 세서 그만큼 for문 안에서 잘라넣기
      tagCount = manager.getPetsitterTagCount(petID);
      
      String[] tagArray = tags.split("\\_\\_");
%>              
               <div class="form-group row" id="cardtagroup">
              <%
	for (int k=0; k<tagArray.length; k++) {
	
%>
                                       <button type="button" class="btn btn-outline-dark"  id="btntag" disabled><%=tagArray[k]%></button>
<%
	}
%>     
               </div>
               <div class="row">
                  <div class="col-md-9" style="padding-top: 10px;">
                     <i class="far fa-comment-dots fa-lg"></i> <label id="cardcomment">고객후기
                        <%=revCount %>개</label>
                  </div>
                  <div class="col-md-3" align="right">
                     <label id="cardprice"
                        style="font-weight: bold; font-size: 20px; padding-right: 22px;"><%=pet_cash%>원</label>
                  </div>
               </div>
            </div>
         </div>


      </div>
      <!-- 지도, 예약, 캘린더, 후기, 일지 -->
      <div class="row">
         <div class="col-md-4" style="padding-right: 0px;">
            <div class="card">
               <div id="map" style="width: 100%; height: 305px;"></div>

               <script type="text/javascript"
                  src="//dapi.kakao.com/v2/maps/sdk.js?appkey=40f1714f2f89ccbee2e525f95d172f52&libraries=services"></script>
               <script>
   var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
       mapOption = {
           center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
           level: 3 // 지도의 확대 레벨
       };  
   
   // 지도를 생성합니다    
   var map = new daum.maps.Map(mapContainer, mapOption); 
   
   // 주소-좌표 변환 객체를 생성합니다
   var geocoder = new daum.maps.services.Geocoder();
  
      
      // 주소로 좌표를 검색합니다
      geocoder.addressSearch('<%=petSitter.getPet_addr()%>', function(result, status) {
      
          // 정상적으로 검색이 완료됐으면 
           if (status === daum.maps.services.Status.OK) {
              var coords = new daum.maps.LatLng(result[0].y, result[0].x);
              // 결과값으로 받은 위치를 마커로 표시합니다
              var marker = new daum.maps.Marker({
                  map: map,
                  position: coords
              });
              // 인포윈도우로 장소에 대한 설명을 표시합니다
              var infowindow = new daum.maps.InfoWindow({
                  content: '<div style="width:150px;text-align:center;padding:6px 0;">'+'<%=petSitter.getPet_name()%>'+' 님의 집</div>'
              });
              infowindow.open(map, marker);
              // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
              map.setCenter(coords);
          } 
      });    
   

</script>

            </div>
         </div>
         <div class="col-md-8">
            <!-- calendar -->
            <div class="card">
               <div class="row">
                  <div class="col-md-6">
                     <div class="calendar hidden-print" style="margin-left: 10px;">
                        <a><i class="fas fa-circle fa-xs" id="reserved"></i>예약불가</a>
                        <header>
                           <h4 class="month" style="text-align: center;"></h4>
                           <a class="btn-prev" href="#"><i
                              class="fa fa-chevron-left fa-xs"></i></a> <a class="btn-next"
                              href="#"><i class="fa fa-chevron-right fa-xs"></i></a>
                        </header>
                        <table>
                           <thead class="event-days">
                              <tr></tr>
                           </thead>
                           <tbody class="event-calendar">
                              <tr class="1"></tr>
                              <tr class="2"></tr>
                              <tr class="3"></tr>
                              <tr class="4"></tr>
                              <tr class="5"></tr>
                           </tbody>
                        </table>
                     </div>
                  </div>
                  <div class="col-md-6">
                     <div class="modal-body" style="margin-right: 25px;">

                        <!-- css는 내 즐겨찾기 참고 -->
                        <form class="form" method="post" id="man_apprv_form"
                           name="man_apprv_form"
                           action="cus_search_reserve.jsp?pet_id=<%=petSitter.getPet_id()%>">

                           <div align="center">
                              <label style="padding-top: 10px;">원하시는 날짜를 선택해주세요.</label>
                           </div>
                           <!-- <form action="/action_page.php">
                              <div align="center">
                                 <input type="date" name="bday" class="far fa-calendar-alt"
                                    id="datepic">
                              </div>
                           </form> -->
                           <div align="center">
                              <input type="date" name="res_date" id="res_date"
                                 class="far fa-calendar-alt" id="datepic">
                           </div>
                           <hr>
                           <div class="row" style="padding: 10px;">
                              <div class="col-md-6" align="left">돌봄비용</div>
                              <div class="col-md-6" align="right"><%=pet_cash_real%>원
                              </div>
                           </div>
                           <div class="row" style="padding: 10px;">
                              <div class="col-md-6" align="left">부가세</div>
                              <div class="col-md-6" align="right"><%=pet_cash_fee%>원
                              </div>
                           </div>
                           <div class="row"
                              style="padding: 10px; font-size: 16px; font-weight: bold;">
                              <div class="col-md-6" align="left" style="padding-top: 3px;">총합계</div>
                              <div class="col-md-6" align="right">
                                 <label id="totalprice"><%=pet_cash%>원</label>
                              </div>
                           </div>
                           <div align="center">

                              <button type="submit" class="btn btn-info" id="colorch"
                                 style="width: 42%;">예약하기</button>
                           </div>

                        </form>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>

      <!-- 일지 -->
      <div class="card" id="card2">
         <div class="form-group row" id="cardi" style="padding-top:20px; padding-left:20px;">
            <p id="option">일지</p>
            <p id="review3">일지 3개</p>
         </div>
         <div class="hs_form2">
            <img src="images/dog1.jpg" class="rounded" alt="..." id="hs_img"
               data-toggle="modal" data-target="#squarespaceModal2"> <img
               src="images/dog2.jpg" class="rounded" alt="..." id="hs_img"
               data-toggle="modal" data-target="#squarespaceModal2"> <img
               src="images/dog4.jpg" class="rounded" alt="..." id="hs_img"
               data-toggle="modal" data-target="#squarespaceModal2">
         </div>
      </div>
      
      <!-- 후기 -->
      <div class="card" id="card2">
         <div class="form-group row" style="padding-top:20px; padding-left:20px;">
            <p id="option">고객후기</p>
            <p id="review3">
               	총 <%=revCount %>개
            </p>
         </div>
         <%
   // 사람 이름 비밀스럽게 가져오기
   String cusName = null;
   String cusNameSec = null;
   
   // 반려견 정보 가져오기
   String dog_id = null;
   String dog_kind = null;
   String dog_gender = null; 
   String gen_imo = null;
   String dog_pic = null;
   
   if (reviewList == null) {
%>
         <div class="text-center" style="padding-bottom: 2%;">
            ***<br>아직 작성된 후기가 없어요.<br>***
         </div>
         <%
   } else {
      
      String strRevStar = null;
      String logYN = null;
      String logYNAns = null; 
      String revDate = null;
      
      for (int k=0; k<reviewList.length; k++) {
         if (reviewList[k] == null) {
            continue;
         }
         
         // 반려견값
         dog_id = reviewList[k].getDog_id();
         System.out.println(dog_id);
         DogDataBean dogInfo = dog.getDog(dog_id); 
         dog_kind = dogInfo.getDog_kind();
         dog_gender = dogInfo.getDog_gender();
         dog_pic = dogInfo.getDog_pic();
         
         // 이름값
         cusName = reviewList[k].getCus_name();
         cusNameSec = cusName.substring(0,1);
         cusNameSec += "*";
         cusNameSec += cusName.substring(2);
         
         // 별점값
         int revStar = reviewList[k].getRev_star();
         if (revStar == 1) strRevStar = "<i class='fas fa-star fa-lg'></i><i class='far fa-star fa-lg'></i><i class='far fa-star fa-lg'></i><i class='far fa-star fa-lg'></i><i class='far fa-star fa-lg'></i>";
         if (revStar == 2) strRevStar = "<i class='fas fa-star fa-lg'></i><i class='fas fa-star fa-lg'></i><i class='far fa-star fa-lg'></i><i class='far fa-star fa-lg'></i><i class='far fa-star fa-lg'></i>";
         if (revStar == 3) strRevStar = "<i class='fas fa-star fa-lg'></i><i class='fas fa-star fa-lg'></i><i class='fas fa-star fa-lg'></i><i class='far fa-star fa-lg'></i><i class='far fa-star fa-lg'></i>";
         if (revStar == 4) strRevStar = "<i class='fas fa-star fa-lg'></i><i class='fas fa-star fa-lg'></i><i class='fas fa-star fa-lg'></i><i class='fas fa-star fa-lg'></i><i class='far fa-star fa-lg'></i>";
         if (revStar == 5) strRevStar = "<i class='fas fa-star fa-lg'></i><i class='fas fa-star fa-lg'></i><i class='fas fa-star fa-lg'></i><i class='fas fa-star fa-lg'></i><i class='fas fa-star fa-lg'></i>";

         // 일지 작성여부
         logYN = reviewList[k].getRev_num().substring(0,1);
         if (logYN.equals("0")) {
            logYNAns = "작성안함";
         } else {
            logYNAns = "작성";
         }

         System.out.println(logYN + "이건 일지 작성여부");
         
         // 리뷰 작성일
         revDate = reviewList[k].getRev_date().toString();
         revDate = revDate.substring(0, 10);
%>
         <div class="card" id="hugi">
            <div class="form-group row">
               <img src="imageFile/<%=dog_pic %>" id="imiji">
               <div style="padding-top: 1%; font-size: 15px;"><%=cusNameSec %>(<%=reviewList[k].getCus_id() %>)
               </div>
               <div style="padding-top: 1.4%;" id="star" class="row">
                  <%=strRevStar %>
               </div>
            </div>
            <div>
               <%=reviewList[k].getRev_content() %>
            </div>
            <div style="padding-top: 10px; padding-bottom: 20px;">
                  예약일
               <%=reviewList[k].getRes_date() %>
               | 일지
               <%=logYNAns %>
               | 리뷰작성일
               <%=revDate %>
            </div>
         </div>
         <%
      }      
   }
%>
        
<%
   // 7일 이내의 예약 내역이 있을 경우에만 후기 작성 폼이 출력되며 그렇지 않으면 안내 문구만 나온다.
   String[] strDates = new String[8];

   int ii = 0;
   for (addDate=0; addDate>=-7; addDate--) {
      DecimalFormat df = new DecimalFormat("00");
      Calendar currentCalendar = Calendar.getInstance();
      currentCalendar.add(currentCalendar.DATE, addDate);
      
      strYear = Integer.toString(currentCalendar.get(Calendar.YEAR));
      strMonth = df.format(currentCalendar.get(Calendar.MONTH)+1);
      strDay = df.format(currentCalendar.get(Calendar.DATE));
      strDates[ii] = strYear + "-" + strMonth + "-" + strDay;
      
      //System.out.println(strDates[ii] + "개" );
      ii++;
   }
   
   resCheck = reserving.getResPetsitterForRevYN(cus_id, pet_id, strDates[0], strDates[1], strDates[2], strDates[3], 
                        strDates[4], strDates[5], strDates[6], strDates[7]);
   //System.out.println(resCheck + "개" );
   
   if(resCheck != 0) {
      reservation = reserving.getResCustomer(cus_id, pet_id);
      
      // 반려견값
      dog_id = reservation.getDog_id();
      DogDataBean dogInfo = dog.getDog(dog_id); 
      dog_kind = dogInfo.getDog_kind();
      dog_gender = dogInfo.getDog_gender();
      dog_pic = dogInfo.getDog_pic();
               
      cusName = reservation.getCus_name();
      cusNameSec = cusName.substring(0,1);
      cusNameSec += "*";
      cusNameSec += cusName.substring(2);
%>
         <form class="form" method="post"
            action="cusReview_pro.jsp?pet_id=<%=pet_id %>"
            enctype="multipart/form-data">

            <div class="card" id="hugi">
               <div class="form-group row">
                  <div class="col-md-9">
                  <div class="row">
                     <img src="imageFile/<%=dog_pic %>" id="imiji">
                     <div style="padding-top: 1%; font-size: 15px;"><%=cusNameSec %>(<%=cus_id %>)
                     </div>
                  </div>
                  </div>
                  <div class="col-md-3">
                  <div class="row">
                     <div>
                        <div class="row">
                           <select id="gorgi" name="rev_star" style="padding-top: 5px;">
                              <option value="">별점</option>
                              <option value="1">1</option>
                              <option value="2">2</option>
                              <option value="3">3</option>
                              <option value="4">4</option>
                              <option value="5">5</option>
                           </select>
                           <div style="padding-left: 10px; padding-right: 20px;">
                              <select id="gorgi" name="res_date">
                                 <option value="">예약 날짜</option>
<%
      for (addDate=0; addDate>=-7; addDate--) {
         DecimalFormat df = new DecimalFormat("00");
         Calendar currentCalendar = Calendar.getInstance();
         currentCalendar.add(currentCalendar.DATE, addDate);
         
         strYear = Integer.toString(currentCalendar.get(Calendar.YEAR));
         strMonth = df.format(currentCalendar.get(Calendar.MONTH)+1);
         strDay = df.format(currentCalendar.get(Calendar.DATE));
         strDate = strYear + "-" + strMonth + "-" + strDay;
   
         resDateCheck = reserving.getResPetsitterForRevYN(cus_id, pet_id, strDate);
         if (resDateCheck == 1) { // 값이 들어있나 검사하는 함수부터 실행하고 있다고 할 떄만(1일 때) 아래 함수 사용  
            reservation = reserving.getResPetsitterForRev(cus_id, pet_id, strDate);
            String res_date = reservation.getRes_date();            
%>
                                 <option value="<%=strDate%>"><%=strDate%></option>
                                 <%
         }   
      }
%>
                              </select>
                           </div>
                        </div>
                     </div>
                     <div style="padding-left: 10px;">
                        <button type="submit" class="btn btn-sm" id="beoteun">작성완료</button>
                     </div>
                  </div>
                  </div>
               </div>
               <textarea class="form-control" id="rev_content" name="rev_content"
                  rows="5" cols="85"></textarea>
            </div>


            <input type="text" class="form-control" id="rev_num" name="rev_num"
               value="<%=revNum %>" hidden="hidden"> <input type="text"
               class="form-control" id="cus_id" name="cus_id" value="<%=cus_id %>"
               hidden="hidden"> <input type="text" class="form-control"
               id="dog_id" name="dog_id" value="<%=reservation.getDog_id() %>"
               hidden="hidden"> <input type="text" class="form-control"
               id="pet_name" name="pet_name"
               value="<%=reservation.getPet_name() %>" hidden="hidden"> <input
               type="text" class="form-control" id="cus_name" name="cus_name"
               value="<%=reservation.getCus_name() %>" hidden="hidden"> <input
               type="text" class="form-control" id="dog_name" name="dog_name"
               value="<%=reservation.getDog_name() %>" hidden="hidden"> <input
               type="text" class="form-control" id="dog_pic" name="dog_pic"
               value="<%=dog_pic %>" hidden="hidden">

         </form>
         <%
   } else {
%>
         <div class="text-center" style="padding-bottom: 2%;">
            ***<br>펫시터에게 돌봄을 맡긴지 7일 이내에만 후기를 작성할 수 있어요.<br>***
         </div>
         <%
   }
%>

      </div>
      <!-- line modal 일지모달 -->
      <div class="modal fade" id="squarespaceModal2" tabindex="-1"
         role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
         <div class="modal-dialog modal-lg">
            <div class="modal-content">
               <div class="modal-header">
                  <h3 class="modal-title" id="lineModalLabel">일지</h3>
                  <button type="button" class="close" data-dismiss="modal">
                     <span aria-hidden="true"><i class="fas fa-times fa-lg"></i></span>
                     <span class="sr-only">Close</span>
                  </button>
               </div>
               <div class="modal-body">
                  <!-- content goes here -->
                  <form>
                     <div>
                        <p>2018-09-10 13:35 작성</p>
                        <hr>
                     </div>
                     <div class="form-group">
                        <label for="exampleInputEmail1" id="modalpetname">하루</label> 
                        <label for="exampleInputEmail1" style="color:#808080;">포메라니안</label>
                     </div>
                     <hr>
                     <div class="card" id="modalcard1">
                        <div class="form-group">
                           <label for="exampleInputPassword1" style="color:#808080;">*산책<br>시민공원으로
                              50분 산책 진행했습니다.<br> 하루가 줄을 당기는 버릇이 있어서 몇번 뛰게 했습니다. 산책이 끝나고
                              물티슈로 발 닦아주었습니다.<br> <br> * 식사 및 간식<br> 준비해 두신
                              저녁을 산책 끝나고 돌아와서 내줬는데 물그릇 씻으러 갔다 온 사이에 다 먹었어요.<br> 간식은
                              돌아다니던 양말에 트릿 넣어 놓았고 개껌 주니까 열심히 먹었습니다.
                           </label>
                        </div>
                     </div>
                  </form>
               </div>
            </div>
         </div>
      </div>
   </div>
   </div>
   <script>
   var picker = new Pikaday({ 
    field: document.getElementById('res_date'),
    format: 'yyyy-MM-dd',
    toString(date, format){
      let day = ("0" + date.getDate()).slice(-2);
      let month = ("0" + (date.getMonth() + 1)).slice(-2);
      let year = date.getFullYear();
      return `${year}-${month}-${day}`;
    }
   });
</script>

   <script>
<% }
%>
</script>

   <!-- Footer -->
   <jsp:include page="layout/footer.inc.jsp" flush="false" />