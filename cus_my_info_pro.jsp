<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="petmily.customer.CustomerDataBean"%>
<%@ page import="petmily.customer.CustomerDBBean"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:개인정보 수정 성공";
%>
<jsp:include page="layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<jsp:useBean id="customer" class="petmily.customer.CustomerDataBean">
	<jsp:setProperty name="customer" property="*" />
</jsp:useBean>

<%
	String cus_id = (String) session.getAttribute("cus_id");
	customer.setCus_id(cus_id); 
 
	CustomerDBBean cus = CustomerDBBean.getInstance();
	cus.updateCustomer(customer);
%>


<script>
	alert("개인정보 수정이 완료되었습니다.");
	location.href = "index.jsp";
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false" />
