<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="petmily.customer.DogDBBean" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%
	request.setCharacterEncoding("utf-8"); 
	String title = "회원가입 2/3 성공";
%>

<jsp:useBean id="dog" class="petmily.customer.DogDataBean">
     <jsp:setProperty name="dog" property="*"/>
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
	String cus_id = "";
	cus_id = request.getParameter("cus_id");
	String dog_name = imageUp.getParameter("dog_name");
	String dog_gender = imageUp.getParameter("dog_gender");
	String dog_kind = imageUp.getParameter("dog_kind");
	String dog_wei = imageUp.getParameter("dog_wei");
	
	String year = imageUp.getParameter("dog_birth_year");
	String month = 
			  (imageUp.getParameter("dog_birth_month").length()==1)?
			  "0"+ imageUp.getParameter("dog_birth_month"):
			  imageUp.getParameter("dog_birth_month");
	String day =  (imageUp.getParameter("dog_birth_day").length()==1)?
			  "0"+ imageUp.getParameter("dog_birth_day"):
				  imageUp.getParameter("dog_birth_day");
			  
	String dog_rqrd = imageUp.getParameter("dog_rqrd");
	String dog_reg = imageUp.getParameter("dog_reg");
	String dog_surg = imageUp.getParameter("dog_surg");
	String dog_fri = imageUp.getParameter("dog_fri");
	String dog_bow = imageUp.getParameter("dog_bow");
	String dog_bow_spec = imageUp.getParameter("dog_bow_spec");
	String dog_sick = imageUp.getParameter("dog_sick");
	String dog_sick_spec = imageUp.getParameter("dog_sick_spec");
	String dog_poo = imageUp.getParameter("dog_poo");
	String dog_poo_spec = imageUp.getParameter("dog_poo_spec");
	String dog_hspt = imageUp.getParameter("dog_hspt");
	String dog_hspt_tel = imageUp.getParameter("dog_hspt_tel");
	String dog_hspt_post = imageUp.getParameter("dog_hspt_post");
	String dog_hspt_addr = imageUp.getParameter("dog_hspt_addr");

	/* 값 넣기 */	
	dog.setDog_id(cus_id+"_1");
	dog.setCus_id(cus_id);
	dog.setDog_pic(filename);
	dog.setDog_name(dog_name);
	dog.setDog_gender(dog_gender);
	dog.setDog_kind(dog_kind);
	dog.setDog_wei(dog_wei);
	
	dog.setDog_birth(year+"-"+month+"-"+day);
	
	dog.setDog_rqrd(dog_rqrd);
	dog.setDog_reg(dog_reg);
	dog.setDog_surg(dog_surg);
	dog.setDog_fri(dog_fri);
	dog.setDog_bow(dog_bow);
	dog.setDog_bow_spec(dog_bow_spec);
	dog.setDog_sick(dog_sick);
	dog.setDog_sick_spec(dog_sick_spec);
	dog.setDog_poo(dog_poo);
	dog.setDog_poo_spec(dog_poo_spec);
	dog.setDog_hspt(dog_hspt);
	dog.setDog_hspt_tel(dog_hspt_tel);
	dog.setDog_hspt_post(dog_hspt_post);
	dog.setDog_hspt_addr(dog_hspt_addr);
	
	dog.setReg_date(new Timestamp(System.currentTimeMillis()) );
	
	DogDBBean logon = DogDBBean.getInstance();
	logon.insertDog(dog, cus_id); 
	
	response.sendRedirect("join_cus_matching.jsp?cus_id="+cus_id);
	//request.getRequestDispatcher("join_cus_pet.jsp").forward(request, response);
%>

<jsp:include page="layout/footer.inc.jsp" flush="false" />
