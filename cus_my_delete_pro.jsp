<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="petmily.customer.CustomerDBBean" %>
<%@ page import="petmily.customer.CustomerDataBean" %>

<%-- <%@ page import = "java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%> --%>

<jsp:useBean id="customer" class="petmily.customer.CustomerDataBean">
     <jsp:setProperty name="customer" property="*"/>
</jsp:useBean>

<%
	request.setCharacterEncoding("utf-8"); 
	String title = "탈퇴완료";	
	
	String id = request.getParameter("cus_id");
	String passwd = request.getParameter("cus_passwd");
	customer.setCus_id(id);
	customer.setCus_passwd(passwd);
	
	CustomerDBBean logon = CustomerDBBean.getInstance();
	int check= logon.CustomerCheck(id,passwd);
	
	if(check==1){
		session.setAttribute("id",id);
		//이거 지워도 되는데 혹시 몰라서 
		CustomerDBBean cust = CustomerDBBean.getInstance();
		cust.deleteCustomer(id, passwd);
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

