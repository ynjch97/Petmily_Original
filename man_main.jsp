<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:관리자 메인페이지";
%>
<%@ page import="petmily.manager.ManagerDBBean"%>
<%@ page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
	ManagerDBBean manager = ManagerDBBean.getInstance();

	int c_count = 0;	
	c_count = manager.getCustomerCount();				// 고객 회원 수 저장
	
	int count = manager.getPetsitterCount();			// 펫시터 회원 수 저장
	int yetcount = manager.getPetsitterYetCount();
	
	Date date = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String today = sf.format(date);
	today = today.substring(5,7);
	
	int conCount = 0;
%>

<style>
.btn:hover{
font-color:#ffffff;
}
</style>

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

<jsp:include page="layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>
	
<div id="m-container">
	<article class="container">
		<div id="m-content">
			 <div class="container">
			 
	<div class="card-deck mb-3 text-center">
	
		<div class="card mb-3 shadow-sm">
			<button type="button" class="btn btn-light btn-lg btn-block" id="colorch" onclick="location.href='man_apprv.jsp'">
			<br><br><br>
          		<div class="card-body" align="center">
		            <h3 class="card-title pricing-card-title"><b>회원가입 승인</b><br></h3>
		            <h5><small class="text-muted"><%=yetcount %>/<%=count %>건의 승인 요청이 있습니다.</small></h5>
          		</div>  
          	<br><br><br>	        
 			</button>
        </div>
       
		<div class="card mb-3 shadow-sm">
			<button type="button" class="btn btn-light btn-lg btn-block" id="colorch" onclick="location.href='man_list.jsp'">
			<br><br><br>
          		<div class="card-body">
		            <h3 class="card-title pricing-card-title"><b>회원 목록</b><br></h3>
		            <h5><small class="text-muted">고객 <%=c_count %>명 / 펫시터 <%=count %>명</small></h5>
          		</div>  
          	<br><br><br>	        
 			</button>
        </div>
        
      	<div class="card mb-3 shadow-sm">
			<button type="button" class="btn btn-light btn-lg btn-block" id="colorch" onclick="location.href='man_chart.jsp'">
			<br><br><br>
          		<div class="card-body">
		            <h3 class="card-title pricing-card-title"><b>매출 관리</b><br></h3>
		            <h5><small class="text-muted"><%=today %>월의 매출을 확인해보세요.</small></h5>
          		</div>  
          	<br><br><br>	        
 			</button>
        </div>
        
        <div class="card mb-3 shadow-sm">
			<button type="button" class="btn btn-light btn-lg btn-block" id="colorch" onclick="location.href='man_consult.jsp'">
			<br><br><br>
          		<div class="card-body">
		            <h3 class="card-title pricing-card-title"><b>실시간 1:1 상담</b><br></h3>
		            <h5><small class="text-muted"><%=conCount %>건의 상담 요청이 있습니다.</small></h5>
          		</div>  
          	<br><br><br>	        
 			</button>
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

<jsp:include page="layout/footer.inc.jsp" flush="false"/>