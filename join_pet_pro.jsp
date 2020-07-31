<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="petmily.petsitter.PetsitterDBBean" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%
	request.setCharacterEncoding("utf-8"); 
	String title = "회원가입 1/3 성공";	
%>

<jsp:useBean id="petsitter" class="petmily.petsitter.PetsitterDataBean">
     <jsp:setProperty name="petsitter" property="*"/>
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
	 
	   //전송한 파일 정보를 가져와 출력한다 
	   Enumeration<?> files = imageUp.getFileNames();
	 
	   //파일 정보가 있다면
	   while(files.hasMoreElements()){
	     //input 태그의 속성이 file인 태그의 name 속성값 :파라미터이름
	     String name = (String)files.nextElement();
	 
	     //서버에 저장된 파일 이름
	     filename = imageUp.getFilesystemName(name);
	   }
	}catch(Exception e){
	   e.printStackTrace();
	}
%>
 
<%
	/* 가져오기 */
	String pet_id = imageUp.getParameter("pet_id");
	String pet_passwd = imageUp.getParameter("pet_passwd");
	String pet_name = imageUp.getParameter("pet_name");
	String pet_gender = imageUp.getParameter("pet_gender");
	String pet_phone = imageUp.getParameter("pet_phone");
	String pet_post = imageUp.getParameter("pet_post");
	String pet_addr = imageUp.getParameter("pet_addr");
	
	String year = imageUp.getParameter("pet_birth_year");
	String month = 
			  (imageUp.getParameter("pet_birth_month").length()==1)?
			  "0"+ imageUp.getParameter("pet_birth_month"):
			  imageUp.getParameter("pet_birth_month");
	String day =  (imageUp.getParameter("pet_birth_day").length()==1)?
			  "0"+ imageUp.getParameter("pet_birth_day"):
				  imageUp.getParameter("pet_birth_day");
	
	/* 값 넣기 */	
	petsitter.setPet_id(pet_id);
	petsitter.setPet_passwd(pet_passwd);
	petsitter.setPet_name(pet_name);
	petsitter.setPet_gender(pet_gender);
	petsitter.setPet_phone(pet_phone);
	petsitter.setPet_post(pet_post);
	petsitter.setPet_addr(pet_addr);
	petsitter.setPet_lic(filename);
	
	petsitter.setPet_birth(year+"-"+month+"-"+day);
	petsitter.setPet_reg_date(new Timestamp(System.currentTimeMillis()) );

	PetsitterDBBean logon = PetsitterDBBean.getInstance();
	logon.insertPetsitter(petsitter); 
	
	response.sendRedirect("join_pet_qna.jsp?pet_id="+pet_id);
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

