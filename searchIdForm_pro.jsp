<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:아이디/비밀번호 찾기";
%>

<%@ page import="petmily.customer.CustomerDataBean"%>
<%@ page import="petmily.customer.CustomerDBBean"%>
<%@ page import="petmily.petsitter.PetsitterDataBean"%>
<%@ page import="petmily.petsitter.PetsitterDBBean"%>

<jsp:include page="layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<%
	String name = request.getParameter("name");
	String phone = request.getParameter("phone");    	

	CustomerDBBean cus = CustomerDBBean.getInstance();
	PetsitterDBBean pet = PetsitterDBBean.getInstance();
	CustomerDataBean c = cus.searchId(name, phone); 
	PetsitterDataBean p = pet.searchId(name, phone);	
	
	try {
%>

<div id="j-container">
	<article class="container">
		<div id="j-content">
			<div class="card">
				<div class="card-body">
				
		<form method="post" action="index.jsp">
<%
	    if(c != null)
	    {
%>
			<div class="text-center">
				고객 <%=name %>님의 아이디는 <b><%= c.getCus_id() %></b> 입니다.<br><br>
				<button class="btn btn-light" id="colorch" type="submit">메인으로</button>
			</div>
<%
		} else if(p != null)
	    {
%>
			<div class="text-center">
				펫시터 <%=name %>님의 아이디는 <b><%= p.getPet_id() %></b> 입니다.<br><br>
				<button class="btn btn-light" id="colorch" type="submit">메인으로</button>
			</div>
<%
		} else
		{
%>
			<div class="text-center">
				이름 또는 전화번호가 틀렸습니다.<br><br>
				<button class="btn btn-light" id="colorch" onclick="javascript:window.location='searchIdForm.jsp'">다시 입력</button>
			</div>
<%
     	}	
%>
		</form>
		
				</div>
			</div>
		</div>
	</article>
</div>

<%
	}catch(Exception e) {}
%>

<jsp:include page="layout/footer.inc.jsp" flush="false" />