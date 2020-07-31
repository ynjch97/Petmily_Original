<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="petmily.customer.CustomerMaDataBean"%>
<%@ page import="petmily.customer.CustomerMaDBBean"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:개인정보 수정 성공";
%>
<jsp:include page="layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<jsp:useBean id="cus_ma" class="petmily.customer.CustomerMaDataBean">
	<jsp:setProperty name="cus_ma" property="*" />
</jsp:useBean>

<%
	String cus_id = (String) session.getAttribute("cus_id");
	cus_ma.setCus_Id(cus_id); 
 
	CustomerMaDBBean ma = CustomerMaDBBean.getInstance();
	ma.updateMa(cus_ma); 
%>


<script>
	alert("매칭정보 수정이 완료되었습니다.");
	location.href = "index.jsp";
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false" />
