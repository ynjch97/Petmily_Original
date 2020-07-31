<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="petmily.petsitter.PetsitterDataBean"%>
<%@ page import="petmily.petsitter.PetsitterDBBean"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:개인정보 수정 성공";
%>
<jsp:include page="layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>

<jsp:useBean id="petsitter" class="petmily.petsitter.PetsitterDataBean">
	<jsp:setProperty name="petsitter" property="*" />
</jsp:useBean>

<%
	String pet_id = (String) session.getAttribute("pet_id");
	petsitter.setPet_id(pet_id);

	PetsitterDBBean pet = PetsitterDBBean.getInstance();
	pet.updatePetsitter(petsitter);
%>


<script>
	alert("개인정보 수정이 완료되었습니다.");
	location.href = "index.jsp";
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false" />
