<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="petmily.manager.ManagerDBBean"%>
<%@ page import="petmily.customer.ReserveDBBean"%>
<%@ page import="petmily.customer.ReserveDataBean"%>
<%@page import="java.util.Date" %>
<%@ page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat" %>

<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:예약내역 관리";
	
	String cus_id = session.getAttribute("cus_id").toString();
	
	ReserveDataBean resLists[] = null;
	int count = 0;	
	int number= 0;

	ReserveDBBean res = ReserveDBBean.getInstance();
	count = res.getResPetsitterCount(cus_id);			// count에 승인되지 않은 펫시터 회원 수 저장
	resLists = res.getResPetsitter(count, cus_id);		// 내가 예약한 모든 펫시터를 불러옴 (최근순으로)
	
	ManagerDBBean manager = ManagerDBBean.getInstance();
%>

<style>
.card
{
	margin-bottom:20px;
}
#btitle {
   margin-top: 2%;
   margin-left: 2%;
   font-weight: bold;
   font-size: 16px;
   color: #A5A5A5;
}

#passedtitle {
   margin-top: 5%;
   margin-left: 2%;
   font-weight: bold;
   font-size: 16px;
   color: #A5A5A5;
}
#cardtitle
{
   margin-bottom:2%;
   margin-right:2%;
   font-weight:bold;
   
}
#cardtitle2
{
   margin-bottom:2%;
   margin-right:2%;
   margin-left:4%;
   font-weight:bold;
   
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

<jsp:include page="layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<div id="j-container">
	<article class="container">
		<div id="j-content">
		
		<ul class="nav nav-tabs">
			<li class="nav-item">
				<a class="nav-link active" href="cus_my_reserve.jsp" style="color: #000000; font-size: 14px;">
					<b>예약내역 관리</b>
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="cus_my_info.jsp" style="color: #000000; font-size: 14px;">
					개인정보 수정
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="cus_my_pet.jsp" style="color: #090909; font-size: 14px;">
					반려견 정보 수정
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="cus_my_matching.jsp" style="color: #090909; font-size: 14px;">
					매칭 정보 수정
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="cus_my_delete.jsp" style="color: #090909; font-size: 14px;">
					회원 탈퇴
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="cus_my_mileage.jsp" style="color: #090909; font-size: 14px;">
					마일리지 충전
				</a>
			</li>
		</ul>
							
					
		<div class="card">
			<div class="card-body">
				<div class="page-header">
					<big><b style="color:#696969;">예약 내역</b></big>
				</div>
				<br>
				<div>
					
<!--  -->
		<!-- <p id="btitle">예정된 예약</p>
		
		<div class="tab-pane fade show active" id="pop1" role="tabpanel" aria-labelledby="pop1-tab">
            <div class="pt-3">
               <table class="table table-header-rotated">
               <colgroup>
               	<col width="12%">
               	<col width="10%">
               	<col width="20%">
               	<col width="9%">
               	<col width="9%">
               	<col width="9%">
               	<col width="*">
               	<col width="9%">
               </colgroup>
                  <thead class="text-center">
                     <tr>
                        <th class="rotate"> <div> <span>예약날짜</span> </div> </th>
                        <th class="rotate"> <div> <span>반려견이름</span> </div> </th>
                        <th class="rotate"> <div> <span>펫시터정보</span> </div> </th>
                        <th class="rotate"> <div> <span>나의별점</span> </div> </th>
                        <th class="rotate"> <div> <span>평균별점</span> </div> </th>
                        <th class="rotate"> <div> <span>금액</span> </div> </th>
                        <th class="rotate"> <div> <span>요청사항</span> </div> </th>
                        <th class="rotate"> <div> <span>예약취소</span> </div> </th>
                     </tr>
                  </thead>
                  <tbody>
                     <tr class="text-center">
                        <td>2018-11-20</td>
                        <td>초코</td>
                        <td>
                        	이름(아이디)
                        	<button class="btn btn-sm" data-toggle="modal" data-target="#modal1">상세보기</button>
                        </td>
                        <td>4.5</td>
                        <td>3.5</td>
                        <td>30000</td>
                        <td class="text-left">잘 놀아주세요</td>
                        <td>
                           <button class="btn btn-sm">취소</button>
                        </td>
                     </tr>
                  </tbody>
               </table>
            </div>
         </div> -->

         <%-- <p id="passedtitle">지난 예약 내역 (총 <%=count %>건)</p> --%>
         <p id="btitle" style="color:#808080;">지난 예약 내역 (총 <%=count %>건)</p>
         
         <div class="tab-pane fade show active" id="pop1" role="tabpanel" aria-labelledby="pop1-tab">
            <div class="pt-3">
               <table class="table table-header-rotated">
               <colgroup>
               	<col width="12%">
               	<col width="10%">
               	<col width="20%">
               	<col width="9%">
               	<col width="9%">
               	<col width="9%">
               	<col width="*">
               	<col width="9%">
               </colgroup>
                  <thead class="text-center">
                     <tr>
                        <th class="rotate"> <div> <span>예약날짜</span> </div> </th>
                        <th class="rotate"> <div> <span>반려견이름</span> </div> </th>
                        <th class="rotate"> <div> <span>펫시터정보</span> </div> </th>
                        <th class="rotate"> <div> <span>나의별점</span> </div> </th>
                        <th class="rotate"> <div> <span>평균별점</span> </div> </th>
                        <th class="rotate"> <div> <span>금액</span> </div> </th>
                        <th class="rotate"> <div> <span>요청사항</span> </div> </th>
                        <th class="rotate"> <div> <span>일지/후기</span> </div> </th>
                     </tr>
                  </thead>
                  <tbody>

<!-- 예약 여부 체크 -->
<%
	if (resLists == null) {	// 첫 번째 강아지 뜨게 할건지 
%>
		<tr class="text-center"><td colspan="8"><br>예약 내역이 없어요.<td></tr>
<%
	} else {
%>

<%
		int j = 0;
	
		while(j<resLists.length && resLists[j]!=null){
		//for(int j=0;j<resLists.length;j++){
			if (resLists[j] == null) {
				break;
			}
			
			// 예약일 몇일 전인지 & 예약일 가져옴  
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date reg = resLists[j].getRes_reg_date();		//예약한 날짜
			Date tod = new Date();							//오늘 날짜
			String when = manager.formatTimeString(reg);	//그게 몇분전인가?
			String regdate = sf.format(reg);				//예약한 날짜를 String으로
			String toddate = sf.format(reg);				//오늘 날짜를 String으로
			regdate = regdate.substring(0,10);
			
			System.out.println(when);						// test
%>
						
                     <tr class="text-center">			
                        <td><%=resLists[j].getRes_date() %></td>
                        <td><%=resLists[j].getDog_name() %></td>
                        <td>
                        	<a href="blog2.jsp?pet_id=<%=resLists[j].getPet_id() %>">
                        		<%=resLists[j].getPet_name() %>(<%=resLists[j].getPet_id() %>)
                        	</a>
              
                        </td>
                        <td>4.5</td>
                        <td>3.5</td>
                        <td><%=resLists[j].getPet_cash() %></td>
                        <td class="text-left"><%=resLists[j].getRes_comment() %></td>
                        <td><button type="button" id="colorch" class="btn btn-sm" data-toggle="modal" data-target="#modal2" >일지/후기</button></td>
                     </tr>

<%
			j++;
		}
%>

<%
	}
%>

                  </tbody>
               </table>
               
               <!--매칭정보 Modal -->
               
               
               <!-- 일지/후기 Modal -->
               <div class="modal fade" id="modal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                  <div class="modal-dialog modal-dialog-centered" role="document">
                     <div class="modal-content">
                        <div class="modal-header">
                           <h5 class="modal-title" id="exampleModalCenterTitle">일지/후기</h5>
                           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                           </button>
                        </div>
                        <div class="modal-body">
                              <div id="cardtitle" style="color:#696969;">펫시터가 쓴 일지</div>
                           <div class="card">
                                 <div class="card-body" style="color:#808080;">
				                                    *산책<br>시민공원으로50분 산책 진행했습니다.<br>
				                                     하루가 줄을 당기는 버릇이 있어서 몇번 뛰게 했습니다. 산책이 끝나고
				                                    물티슈로 발 닦아주었습니다.<br>
				                                    <br> * 식사 및 간식<br> 준비해 두신 저녁을 산책 끝나고 돌아와서 내줬는데 물그릇 씻으러
				                                    갔다 온 사이에 다 먹었어요.<br> 간식은 돌아다니던 양말에 트릿 넣어 놓았고 개껌 주니까 열심히
				                                    먹었습니다.
                                 </div>
                           </div>
                           <div class="row">
                              <div id="cardtitle2" style="color:#696969;">내가 작성한 후기</div>
                              <label style="color:#d09d6c ;">4.5</label>
                           </div>
                           <div class="card">
                                 <div class="card-body" style="color:#808080;">
				                                    저희 부부는 애견호텔에 맡기는 것 자체를 못미더워 정말 싫어하는데, 이번
				                                    여행에 어쩔 수 없이 맡기게 되어 펫시터라는 걸 알게되었어요~ 반신반의한 마음으로 맡겨봤는데, 정말 친절한 펫시터님께서
				                                    하루에 동영상, 사진 계속해서 보내주시고, 매일매일 산책도 해주시고~ 하루에 대한 자세한 설명도 꾸준히 보내주셨어요! 진짜
				                                    우리 강아지들 맡기는게 이렇게 맘이 놓인 적은 없어요 ㅜㅜ 한편으론 저희보다 더 잘 케어해주시는구나 ~ 하는 생각이 들
				                                    정도 였습니다 ㅎㅎ정말 너무 감사하고 다음에 이 분에게만 맡길거에요! 감사합니다!
                                 </div>
                           </div>
                           <div class="text-right">
	                           <button type="button" class="btn" id="colorch" >후기 쓰러가기</button>
	                       </div>
                        </div>
                     </div>
                  </div>
               </div>
               
            </div>
         </div>
         
<!--  -->
						
				</div>
			</div>
		</div>
		
		<div class="card" style="height:75px;">
			<div class="card-body"></div>
		</div>
		
		<div class="card" style="height:75px;">
			<div class="card-body"></div>
		</div>
		
		</div>
	</article>
</div>

<script>
<% 
	} 
%>
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false"/>
