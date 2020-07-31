<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.util.Date" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="petmily.petsitter.PetLogDBBean"%>

<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<jsp:useBean id="petlog" class="petmily.petsitter.PetLogDataBean">
     <jsp:setProperty name="petlog" property="*"/>
</jsp:useBean>

<%
	String realFolder = "";//웹 어플리케이션상의 절대 경로
	String filename[] = new String[4];
	MultipartRequest imageUp = null; 

	String saveFolder = "/imageFile";
	//위: 파일이 업로드되는 폴더를 지정한다.
	String encType = "utf-8"; //엔코딩타입
	int maxSize = 2*1024*1024;  //최대 업로될 파일크기 5Mb
	//현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
	ServletContext context = getServletContext();
	realFolder = context.getRealPath(saveFolder);  
	
	try{
		int i=0;
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
		  filename[i] = imageUp.getFilesystemName(name);
		  System.out.println(filename[i]);
		  i++;
	   }
	}catch(Exception e){
	   e.printStackTrace();
	}
%>
<%
   request.setCharacterEncoding("utf-8"); 

   /* 값 가져오기 */
   String pet_id = request.getParameter("pet_id");
   String cus_id = imageUp.getParameter("cus_id");
   String dog_id = imageUp.getParameter("dog_id");
   String pet_name = imageUp.getParameter("pet_name");
   String cus_name = imageUp.getParameter("cus_name");
   String dog_name = imageUp.getParameter("dog_name");
   String dog_pic = imageUp.getParameter("dog_pic");
   String res_date = imageUp.getParameter("res_date");
   String log_title = imageUp.getParameter("log_title");
   String log_content = imageUp.getParameter("log_content");
	  
   /* 값 넣기 */
   petlog.setPet_id(pet_id);
   petlog.setPet_id(pet_id);
   petlog.setCus_id(cus_id);
   petlog.setDog_id(dog_id);
   petlog.setPet_name(pet_name);
   petlog.setCus_name(cus_name);
   petlog.setDog_name(dog_name);
   petlog.setDog_pic(filename[0]);
   petlog.setLog_title(log_title);
   petlog.setLog_content(log_content);
   petlog.setLog_pic1(filename[1]);
   petlog.setLog_pic2(filename[2]);
   petlog.setLog_pic3(filename[3]);
   petlog.setLog_ip(request.getRemoteAddr());
   petlog.setRes_date(res_date);
   petlog.setLog_date(new Timestamp(System.currentTimeMillis()) );

   PetLogDBBean pet = PetLogDBBean.getInstance();
   pet.insertPetLog(petlog); 
%>

<script>
  alert("일지 작성 완료!");
  // history.go(-1);
  // window.location.reload();
  // location.href="new_collection.jsp";
  self.close();
  parent.location.replace("new_collection.jsp");
</script> 