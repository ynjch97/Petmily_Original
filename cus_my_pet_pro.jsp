<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="petmily.customer.DogDBBean"%>
<%@ page import="petmily.customer.DogDataBean"%>
<%@ page import="java.sql.*"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:반려견 수정 성공";
%>
<jsp:include page="layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<jsp:useBean id="dog" class="petmily.customer.DogDataBean">
     <jsp:setProperty name="dog" property="*"/>
</jsp:useBean>

<%
	String cus_id = (String) session.getAttribute("cus_id");
	dog.setCus_id(cus_id); 
 
	DogDBBean d = DogDBBean.getInstance(); 
	d.updateDog(dog);
%> 


 

<script>
	alert("반려견정보 수정이 완료되었습니다.");
	location.href = "index.jsp";
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false" />
