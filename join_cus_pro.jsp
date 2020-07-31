<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="petmily.customer.CustomerDBBean" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%
	request.setCharacterEncoding("utf-8"); 
	String title = "회원가입 1/3 성공";	
%>

<jsp:useBean id="customer" class="petmily.customer.CustomerDataBean">
     <jsp:setProperty name="customer" property="*"/>
</jsp:useBean>

<%
	String realFolder = "";//웹 어플리케이션상의 절대 경로
	String filename ="";
	MultipartRequest imageUp = null; 
	
	String saveFolder = "/imageFile";//파일이 업로드되는 폴더를 지정한다.
	String encType = "utf-8"; //엔코딩타입
	int maxSize = 2*1024*1024;  //최대 업로될 파일크기 5Mb
	//현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
	ServletContext context = getServletContext();
	realFolder = context.getRealPath(saveFolder);  
	
	try{
	   //전송을 담당할 콤포넌트를 생성하고 파일을 전송한다.
	   //전송할 파일명을 가지고 있는 객체, 서버상의 절대경로,최대 업로드될 파일크기, 문자코드, 기본 보안 적용
	   imageUp = new MultipartRequest(
			 request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
	}catch(Exception e){
	   e.printStackTrace();
	}
%>
 
<%
	/* 가져오기 */
	String cus_id = imageUp.getParameter("cus_id");
	String cus_passwd = imageUp.getParameter("cus_passwd");
	String cus_name = imageUp.getParameter("cus_name");
	String cus_gender = imageUp.getParameter("cus_gender");
	String cus_phone = imageUp.getParameter("cus_phone");
	String cus_post = imageUp.getParameter("cus_post");
	String cus_addr = imageUp.getParameter("cus_addr");
	
	String year = imageUp.getParameter("cus_birth_year");
	String month = 
			  (imageUp.getParameter("cus_birth_month").length()==1)?
			  "0"+ imageUp.getParameter("cus_birth_month"):
			  imageUp.getParameter("cus_birth_month");
	String day =  (imageUp.getParameter("cus_birth_day").length()==1)?
			  "0"+ imageUp.getParameter("cus_birth_day"):
				  imageUp.getParameter("cus_birth_day");
	
	/* 값 넣기 */	
	customer.setCus_id(cus_id);
	customer.setCus_passwd(cus_passwd);
	customer.setCus_name(cus_name);
	customer.setCus_gender(cus_gender);
	customer.setCus_phone(cus_phone);
	customer.setCus_post(cus_post);
	customer.setCus_addr(cus_addr);
	
	customer.setCus_birth(year+"-"+month+"-"+day);
	customer.setCus_reg_date(new Timestamp(System.currentTimeMillis()) );

	CustomerDBBean logon = CustomerDBBean.getInstance();
	logon.insertCustomer(customer); 
	
	response.sendRedirect("join_cus_pet.jsp?cus_id="+cus_id);
	//request.getRequestDispatcher("join_cus_pet.jsp").forward(request, response);
%>

<!-- <script>
    alert("회원가입 1/4단계 완료");
	/* location.href="join_cus_pet.jsp"; */
</script> -->

<%-- <div class="text-center"> <jsp:getProperty name="customer" property="cus_id" /> 님, 회원가입을 축하합니다. </div> --%>
 
<%-- <%
	response.sendRedirect("join_cus_pet.jsp");
%>  --%>

<%-- <%
	response.sendRedirect("join_cus_pet.jsp?cus_id="+cus_id);
%> --%>

