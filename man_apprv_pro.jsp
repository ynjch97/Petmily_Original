<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ page import = "java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%> --%>

<%@ page import="petmily.manager.ManagerDBBean" %>
<%@ page import="petmily.petsitter.PetsitterDBBean" %>

<jsp:useBean id="petsitter" class="petmily.petsitter.PetsitterDataBean">
     <jsp:setProperty name="petsitter" property="*"/>
</jsp:useBean>

<%
	request.setCharacterEncoding("utf-8"); 
	String title = "펫밀리:회원가입 승인 완료";
%>

<%
	/* 배열 안에 chk_pet인 사람들의 Value(아이디)가져오기 */
	String[] chkid = request.getParameterValues("chk_pet");

	ManagerDBBean man = ManagerDBBean.getInstance();
	man.apprvPetsitter(chkid);
	

%>

<script>
    alert("회원가입 승인되었습니다.");
	location.href="man_apprv.jsp";
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false" />
