<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:차트보기";
%>
<%@ page import="petmily.manager.ManagerDBBean" %>

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
   <jsp:param name="title" value="<%=title %>"/>
</jsp:include>

<!-- Home -->

<div id="j-container">
	<article class="container">
		
		<div id="j-content">
		<div class="card" >
 <div class="card-body">
			<div class="page-header"><b><big>매출 관리</big></b></div><br>
		<div
		class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">

		<!-- 메뉴 버튼 -->

		<div class="btn-group btn-group-sm mr-2" role="group">
			<ul class="nav">
				<li class="nav-item">
					<a class="nav-link active" href="#chart_all" data-toggle="tab">
						총 매출 분석 보고서
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link dropdown-toggle nav-link" href="#chart_while" data-toggle="tab"> 
						<span data-feather="calendar"></span> 기간별 차트
					</a>
				</li>
			</ul>
		</div>
			
	</div>

	<div class="album py-2">

		<div class="tab-content">
			<ul id="chart_all" class="list-group list-group-flush tab-pane active">
				<jsp:include page="man_chart_all.jsp" flush="false" />
			</ul>
			<ul id="chart_while" class="list-group list-group-flush tab-pane">
				<jsp:include page="man_chart_while.jsp" flush="false" />
			</ul>
		</div>

	</div>
				</form></div></div></div>
	</article>
</div>

<script>
<%
	}
%>
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false"/>