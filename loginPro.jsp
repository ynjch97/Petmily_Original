<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="petmily.customer.CustomerDBBean"%>
<%@ page import="petmily.petsitter.PetsitterDBBean" %>
<%@ page import="petmily.manager.ManagerDBBean" %>

<% request.setCharacterEncoding("utf-8");%>

<!-- 펫시터, 고객별 로그인 -->
<%
    String id = request.getParameter("id");
	String passwd  = request.getParameter("passwd");
	
	CustomerDBBean customer = CustomerDBBean.getInstance();
	PetsitterDBBean petsitter = PetsitterDBBean.getInstance();
	ManagerDBBean manager = ManagerDBBean.getInstance();

	int cus_check= customer.CustomerCheck(id, passwd);
	int pet_check= petsitter.PetsitterCheck(id, passwd);
	int man_check= manager.ManagerCheck(id, passwd);

    if(cus_check==1){
		session.setAttribute("cus_id", id);
		response.sendRedirect("index.jsp");
	}
    else if(pet_check==1){
		session.setAttribute("pet_id", id);
		response.sendRedirect("new_collection.jsp");
	}
    else if(man_check==1){
		session.setAttribute("man_id", id);
		response.sendRedirect("man_main.jsp");
	}
    else if(cus_check==0 || pet_check==0 || man_check==0){
%>
    <script> 
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
<%
	}else{ 
%>
	<script>
		alert("아이디가 맞지 않습니다..");
		history.go(-1);
	</script>
<%
	}
%>