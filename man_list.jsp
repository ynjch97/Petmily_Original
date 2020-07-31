<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:회원 목록";
%>
<%-- <%@page import="java.util.Date"%>
<%@ page import="java.util.List"%> --%>

<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="petmily.customer.ReserveDBBean"%>
<%@ page import="petmily.customer.ReserveDataBean"%>
<%@ page import="petmily.manager.ManagerDBBean"%>
<%@ page import="petmily.petsitter.PetsitterDataBean"%>
<%@ page import="petmily.customer.CustomerDataBean"%>

<!-- 배열 방법 -->
<%
	PetsitterDataBean petLists[] = null;
	CustomerDataBean cusLists[] = null;
	ReserveDataBean resLists[] = null;
	
	int p_count = 0;	
	int p_number= 0;
	int c_count = 0;	
	int c_number= 0;
	int r_count = 0;
	
	ManagerDBBean manager = ManagerDBBean.getInstance();
	ReserveDBBean reser = ReserveDBBean.getInstance();
	
	p_count = manager.getPetsitterCount();				// 펫시터 회원 수 저장
	c_count = manager.getCustomerCount();				// 고객 회원 수 저장
	r_count = reser.getResCount();						// 예약 수 저장 

	petLists = manager.getAllPetsitter(p_count);		// petLists : 배열에 모든 펫시터 저장
	cusLists = manager.getAllCustomer(c_count);			// cusLists : 배열에 모든 고객 저장
	resLists = reser.getReserve(r_count);				// resLists : 배열에 모든 예약 저장
%>

<style>
@charset "utf-8";

.blog {
	width: 100%;
	background: #FFFFFF;
	padding-top: 20px;
}

.blog_info {
	width: 100%;
	background: #ffffff;
	padding-top: 30px;
}

.nav-tabs .nav-link .active {
	font-weight: bold;
	background-color: transparent;
	border-bottom: 3px solid #ff9999;
	border-right: none;
	border-left: none;
	border-top: none;
}

#cg {
	margin-left: 14px;
	margin-right: 2px;
	width: 100px;
}

#searchinput {
	width: 200px;
	margin-right: 2px;
}

#search {
	margin-bottom: 30px;
	margin-left: 68%;
}

#chkbutton {
	float: left;
	margin-bottom: 10px;
}

.table-header-rotated {
	margin-top: 20px;
}
</style>
<script>
	$("#myModal").draggable({
		handle : ".modal-header"
	});
</script>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script type="text/javascript">
<%  
	if(session.getAttribute("man_id")==null)
	{
%>
       alert("관리자용 페이지입니다.\n메인페이지로 이동합니다.");
       self.close();
       parent.location.replace("index.jsp"); // 추가
<% 
	} else {
%>
</script>

<!-- Header -->
<jsp:include page="layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<!-- Home -->
<div id="j-container">
	<article class="container">
		<div id="j-content">
			<div class="card">
				<div class="card-body">
					<div class="page-header">
						<b><big>회원 목록</big></b>
					</div>
					<br>
					<div>
						<div class="album py-2">


		<div class="blog">
			<div class="container">
				<div class="row" id="search" style='width:100%;'>
					<select id="cg">
						<option value="고객">고객</option>
						<option value="펫시터">펫시터</option>
					</select> 
					<input type="text" id="searchinput" class="searchjoin2" placeholder="검색">
					<button type="submit" class="btn btn-primary searchjoin2">
						<i class="fas fa-search"></i>
					</button>
				</div>
				<!--row end-->
				<!-- <section class=" "> -->
					<div class="row">
						<div class="col-md-12 text-center ">
							<nav class="nav-justified ">
								<div class="nav nav-tabs " id="nav-tab" role="tablist">
									<a class="nav-item nav-link active" id="pop1-tab" data-toggle="tab" href="#pop1" role="tab" aria-controls="pop1" aria-selected="true">고객 (<%=c_count %>명)</a> 
									<a class="nav-item nav-link" id="pop2-tab" data-toggle="tab" href="#pop2" role="tab" aria-controls="pop2" aria-selected="false">펫시터 (<%=p_count %>명)</a> 
									<a class="nav-item nav-link" id="pop3-tab" data-toggle="tab" href="#pop3" role="tab" aria-controls="pop3" aria-selected="false">예약 내역 (<%=r_count %>명)</a>
								</div>
							</nav>
							<div class="tab-content" id="nav-tabContent">
								<div class="tab-pane fade show active" id="pop1" role="tabpanel" aria-labelledby="pop1-tab">
									<div class="pt-3">
										
										<table class="table table-header-rotated">
											<thead>
												<tr>
													<th class="rotate">
														<div> <input type="checkbox" id="chckHead" /> </div>
													</th>
													<th class="rotate">
														<div> <span>가입날짜</span> </div>
													</th>
													<th class="rotate">
														<div> <span>아이디</span> </div>
													</th>
													<th class="rotate">
														<div> <span>이름</span> </div>
													</th>
													<th class="rotate">
														<div> <span>성별</span> </div>
													</th>
													<th class="rotate">
														<div> <span>생년월일</span> </div>
													</th>
													<th class="rotate">
														<div> <span>핸드폰 번호</span> </div>
													</th>
													<th class="rotate">
														<div> <span>주소</span> </div>
													</th>
													<th class="rotate">
														<div> <span>탈퇴</span> </div>
													</th>
												</tr>
											</thead>
											<tbody>

<%
	String genString = "";
	String address = "";
	int addrLen = 0;
	String addrString = "";
	
	for(int j=0;j<petLists.length;j++){
		if (petLists[j] == null) {
			continue;
		}
		
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date reg = cusLists[j].getCus_reg_date();
		
		// 몇일 전인지, 가입일 언제인지 가져옴 
		String when = manager.formatTimeString(reg);
		String regdate = sf.format(reg);
		regdate = regdate.substring(0,10);
		
		// 성별
		String gen = cusLists[j].getCus_gender();
		if (gen.equals("1")) {
			genString = "남성";
		}
		else if (gen.equals("0")) {
			genString = "여성";
		}
		else {
			genString = "오류";
		}
		
		// 주소
		address = cusLists[j].getCus_post() + " " + cusLists[j].getCus_addr();
		addrLen = address.indexOf("구");
		addrString = address.substring(0, addrLen+1);
%>
												<tr>
													<td><input type="checkbox" class="chcktbl" /></td>
													<td><%=regdate %></td>
													<td><%=cusLists[j].getCus_id() %></td>
													<td><%=cusLists[j].getCus_name() %></td>
													<td><%=genString %></td>
													<td><%=cusLists[j].getCus_birth() %></td>
													<td><%=cusLists[j].getCus_phone() %></td>
													<td><%=addrString %></td>
													<td>
														<button class="btn btn-sm">탈퇴</button>
													</td>
												</tr>
<%
	}
%>
											</tbody>
										</table>
										<button type="button" class="btn btn-outline-secondary" id="chkbutton">탈퇴</button>
									</div>
								</div>
								
								<div class="tab-pane fade" id="pop2" role="tabpanel" aria-labelledby="pop2-tab">
									<div class="pt-3">
										
										<table class="table table-header-rotated">
											<thead>
												<tr>
													<!-- First column header is not rotated -->
													<!-- Following headers are rotated -->

													<td><input type="checkbox" class="chcktbl" /></td>
													<th class="rotate">
														<div> <span>가입날짜</span> </div>
													</th>
													<th class="rotate">
														<div> <span>아이디</span> </div>
													</th>
													<th class="rotate">
														<div> <span>이름</span> </div>
													</th>
													<th class="rotate">
														<div> <span>성별</span> </div>
													</th>
													<th class="rotate">
														<div> <span>생년월일</span> </div>
													</th>
													<th class="rotate">
														<div> <span>핸드폰 번호</span> </div>
													</th>
													<th class="rotate">
														<div> <span>주소</span> </div>
													</th>
													<th class="rotate">
														<div> <span>탈퇴</span> </div>
													</th>
												</tr>
											</thead>
											<tbody>

<%
	for(int j=0;j<petLists.length;j++){
		if (petLists[j] == null) {
			continue;
		}
		
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date reg = petLists[j].getPet_reg_date();
		
		// 몇일 전인지, 가입일 언제인지 가져옴 
		String when = manager.formatTimeString(reg);
		String regdate = sf.format(reg);
		regdate = regdate.substring(0,10);
		
		// 성별
		String gen = petLists[j].getPet_gender();
		if (gen.equals("1")) {
			genString = "남성";
		}
		else if (gen.equals("0")) {
			genString = "여성";
		}
		else {
			genString = "오류";
		}
		
		// 주소
		address = petLists[j].getPet_post() + " " + petLists[j].getPet_addr();
		addrLen = address.indexOf("구");
		addrString = address.substring(0, addrLen+1);
%>
												<tr>
													<td><input type="checkbox" class="chcktbl" /></td>
													<td><%=regdate %></td>
													<td><%=petLists[j].getPet_id() %></td>
													<td><%=petLists[j].getPet_name() %></td>
													<td><%=genString %></td>
													<td><%=petLists[j].getPet_birth() %></td>
													<td><%=petLists[j].getPet_phone() %></td>
													<td><%=addrString %></td>
													<td>
														<button class="btn btn-sm">탈퇴</button>
													</td>
												</tr>
<%
	}
%>
											</tbody>
										</table>
										<button type="button" class="btn btn-outline-secondary" id="chkbutton">탈퇴</button>
									</div>
								</div>
								
								<div class="tab-pane fade" id="pop3" role="tabpanel" aria-labelledby="pop3-tab">
									<div class="pt-3">
										
										<table class="table table-header-rotated">
											<thead>
												<tr>
													<!-- First column header is not rotated -->
													<!-- Following headers are rotated -->

													<td><input type="checkbox" class="chcktbl" /></td>
													<th class="rotate">
														<div> <span>예약번호</span> </div>
													</th>
													<th class="rotate">
														<div> <span>예약신청일</span> </div>
													</th>
													<th class="rotate">
														<div> <span>고객</span> </div>
													</th>
													<th class="rotate">
														<div> <span>반려견</span> </div>
													</th>
													<th class="rotate">
														<div> <span>펫시터</span> </div>
													</th>
													<th class="rotate">
														<div> <span>코멘트</span> </div>
													</th>
													<th class="rotate">
														<div> <span>비용</span> </div>
													</th>
													<th class="rotate">
														<div> <span>예약일</span> </div>
													</th>
												</tr>
											</thead>
											<tbody>

<%
	for(int j=0;j<resLists.length;j++){
		if (resLists[j] == null) {
			continue;
		}
		
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date reg = resLists[j].getRes_reg_date();
		
		// 몇일 전인지, 가입일 언제인지 가져옴 
		String when = manager.formatTimeString(reg);
		String regdate = sf.format(reg);
		regdate = regdate.substring(0,10);
		
		// 예약번호
		int resNum = resLists[j].getRes_num();
%>
												<tr>
													<td><input type="checkbox" class="chcktbl" /></td>
													<td><%=resNum %></td>
													<td><%=resLists[j].getRes_date() %></td>
													<td><%=resLists[j].getCus_name() %>(<%=resLists[j].getCus_id() %>)</td>
													<td><%=resLists[j].getDog_name() %></td>
													<td onclick="window.location.href='blog2.jsp?pet_id=<%=resLists[j].getPet_id() %>'" style='cursor:pointer;'><%=resLists[j].getPet_name() %>(<%=resLists[j].getPet_id() %>)</td>
													<td><%=resLists[j].getRes_comment() %></td>
													<td><%=resLists[j].getPet_cash() %></td>
													<td><%=regdate %></td>
												</tr>
<%
	}
%>
											</tbody>
										</table>
									</div> 
								</div>
								
							</div>
						</div>
					</div>
				<!-- </section> -->
			</div>
		</div>


						</div>
					</div>

				</div>
			</div>
		</div>
	</article>
</div>

<script type="text/javascript">
	$('#chckHead').click(function() {

		if (this.checked == false) {

			$('.chcktbl:checked').attr('checked', false);
		} else {
			$('.chcktbl:not(:checked)').attr('checked', true);

		}
	});
</script>

<script>
<%
	}
%>
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false" />