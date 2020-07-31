<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
   String title = "펫밀리:회원가입 승인";
%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="petmily.manager.ManagerDBBean"%>
<%@ page import="petmily.petsitter.PetsitterDataBean"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<!-- 날짜 정보를 위해 가져옴 -->
<%@ page import="java.util.Date"%>
<%-- <%@ page import="java.util.Calendar"%>
<%@ page import="java.text.DecimalFormat"%> --%>

<!-- 리스트 방법 -->
<%-- <%
   String id = request.getParameter("id");
   String passwd = request.getParameter("passwd");
   String pet_apprv = "0";
   
   List<PetsitterDataBean> petLists = null;
   PetsitterDataBean petList = null;
   
   ManagerDBBean manager = ManagerDBBean.getInstance();
   petLists = manager.getApprvPetsitter();
%> --%>

<!-- 배열 방법 -->
<%
   String id = request.getParameter("id");
   String passwd = request.getParameter("passwd");

   PetsitterDataBean petLists[] = null;
   int count = 0;

   ManagerDBBean manager = ManagerDBBean.getInstance();
   count = manager.getPetsitterYetCount(); // count에 승인되지 않은 펫시터 회원 수 저장

   petLists = manager.getApprvPetsitter(count, "0"); // petLists : 승인되지 않은 0인 사람들을 (승인되지 않은 펫시터 회원 수만큼) 배열에 저장
   
   int number = 0;
%>

<!-- <script>
   $("#myModal").draggable({
      handle : ".modal-header"
   });
</script>
 -->

<script type="text/javascript">
   
<%if (session.getAttribute("man_id") == null) {%>
   alert("관리자용 페이지입니다.\n메인페이지로 이동합니다.");
   self.close();
   parent.location.replace("index.jsp"); // 추가
<%} else {%>
   
</script>

<!-- ♥♥♥모달♥♥♥ -->
<script>
	/* var myModal = new Example.Modal({
	    id: "appModal" // 모달창 아이디 지정
	});
	  
	$("#apprv_modal").click(function() {
	    myModal.show(); // 모달창 보여주기
	}); */

	function click_detail('number') { //모달 열기
		handle: ".modal-header"
	}
	function click_accept(number) { //모달에서 승인하기
		$("#chk_pet").checked = false;
		$("#chk_" + number).checked = true;
		document.getElementById('man_apprv_form').submit();
	}
</script>

<jsp:include page="layout/header.inc.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>" />
</jsp:include>

<!-- Home -->
<div id="j-container">
   <article class="container">
      
      <!-- ♥♥♥모달♥♥♥ -->
      <div class="modal" id="appModal">
         <div class="modal-dialog">
            <div class="modal-content">
               <!--  Modal Header -->
               <div class="modal-header">
                  <input type="hidden" value="loginAction" name="cmd"> <big><b>펫시터 회원가입 승인</b></big>
                  <button type="button" class="close" data-dismiss="modal">&times;</button>
               </div>
               <div class="container-fluid">
                  <br>
                  <table class="table table-bordered table-sm table-hover">
                     <tr>
                        <th scope="col">이름</th>
                        <td scope="col"><%=petLists[number].getPet_name()%></td>
                     </tr>
                     <tr>
                        <th scope="row">아이디</th>
                        <td><%=petLists[number].getPet_id()%></td>
                     </tr>
                     <tr>
                        <th scope="row">생년월일</th>
                        <td><%=petLists[number].getPet_birth()%></td>
                     </tr>
                     <tr>
                        <th scope="row">자격증</th>
                        <td><img src="imageFile/<%=petLists[number].getPet_lic()%>"
                           width=180 height=180></td>
                     </tr>
                  </table>
                  <div class="text-center">
                     <button type="button" class="btn btn-outline-info" onclick="javascript:click_accept('<%=number%>');" style="width: 30%">
                     	승인
                     </button>
                     <button type="button" class="btn btn-outline-danger" style="width: 30%">거절</button>
                  </div>
                  <br>
               </div>
            </div>
         </div>
      </div>
      
      <div id="j-content">
         <div class="card">
            <div class="card-body">
               <div class="page-header">
                  <b><big>펫시터 회원가입 승인</big></b>
               </div>
               <br>
               <div class="container">
                  <form class="form" method="post" id="man_apprv_form" name="man_apprv_form" action="man_apprv_pro.jsp">
                     <div class="row">

<!-- 리스트 방법  -->
<%-- <%
   for (int i=0; i<=petLists.size(); i++) { // 3000번부터 count만큼의 회원들 중 승인여부가 0인(승인되지 않은) 회원들만 추출
      petList = (PetsitterDataBean)petLists.get(i);
      for(int j=0;j<petLists.length;j++){
           if (petLists[j] == null) {
              continue;
           }
%>  --%>

<!-- 배열 방법 -->
<%
   for (int j = 0; j < petLists.length; j++) {
      if (petLists[j] == null) {
      continue;
   }
   SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   Date reg = petLists[j].getPet_reg_date();

   // 몇일 전인지, 가입일 언제인지 가져옴 
   String when = manager.formatTimeString(reg);
   String regdate = sf.format(reg);
   regdate = regdate.substring(0, 10);
%>
                        <div class="col-md-3">
                           <input class="form-check-input" type="checkbox" value="<%=petLists[j].getPet_id()%>" 
                              id="chk_<%=j%>" name="chk_pet" value="<%=petLists[j].getPet_id()%>"> 
                           <a href="click_detail('<%=j%>');" id="apprv_modal" data-toggle="modal" data-target="#appModal">
                           
                              <div class="card mb-3 shadow-sm">
                                 <div class="form-check"></div>
                                 <img class="card-img-top" src="imageFile/<%=petLists[j].getPet_lic()%>"
                                    alt="<%=petLists[j].getPet_id()%> 회원님" style="width: 100%; height: 35%;">
                                 <div class="card-body">
                                    <p class="card-text">
										아이디 : <%=petLists[j].getPet_id()%>
										<br> 이름 : <%=petLists[j].getPet_name()%>
										<br> 생년월일 : <%=petLists[j].getPet_birth()%>
										<br> 가입일 : <%=regdate%>
										<br>
                                    </p>
                                    <div class="d-flex justify-content-between align-items-center">
                                       <div class="form-check"></div>
                                       <small class="text-muted"> <%=when%> </small>
                                    </div>
                                 </div>
                              </div>
                           </a>
                        </div>
<%
            }
%>
                        <br>
                     </div>
                     <!-- 체크박스 선택 후 승인, 거절 -->
                     <div class="text-center">
                        <button type="submit" class="btn btn-outline-info" style="width: 20%">승인</button> &nbsp;
                        <button type="button" class="btn btn-outline-danger" style="width: 20%">거절</button>
                     </div>
                  </form>
               </div>
            </div>
         </div>
      </div>
   </article>
</div>

<script>
<%
   }
%>
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false" />