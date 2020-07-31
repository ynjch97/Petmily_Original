<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="petmily.petsitter.PetsitterDataBean"%>
<%@ page import="petmily.petsitter.PetsitterDBBean"%>

<jsp:useBean id="petsitter" class="petmily.petsitter.PetsitterDataBean">
     <jsp:setProperty name="petsitter" property="*"/>
</jsp:useBean>

<%
	request.setCharacterEncoding("utf-8"); 
	String title = "탈퇴완료";	
	
	String id = request.getParameter("pet_id");
	String passwd = request.getParameter("pet_passwd");
	petsitter.setPet_id(id);
	petsitter.setPet_passwd(passwd);
	
	PetsitterDBBean logon = PetsitterDBBean.getInstance();
	int check= logon.PetsitterCheck(id,passwd);
	
	if(check==1){
		session.setAttribute("id",id);
		//이거 지워도 되는데 혹시 몰라서 
		PetsitterDBBean pets = PetsitterDBBean.getInstance();
		pets.deletePetsitter(id, passwd);
		//cust.deleteCustomer(id); 
%>

<% session.invalidate(); %>
<script>
    alert("탈퇴가 성공적으로 완료되었습니다. \n다음에 다시 만나요!");
	location.href="index.jsp";
</script> 

<%
	}else if(check==0){
%>
    <script> 
	  alert("아이디가 맞지 않습니다.");
      history.go(-1);
	</script>
<%
	}else{
%>
	<script>
	  alert("비밀번호가 맞지 않습니다..");
	  history.go(-1);
	</script>
<%
	}
%>

