<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.util.Date" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="petmily.customer.CusReviewDBBean"%>
<%@ page import="petmily.petsitter.PetLogDBBean"%>

<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<jsp:useBean id="cusreview" class="petmily.customer.CusReviewDataBean">
     <jsp:setProperty name="cusreview" property="*"/>
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
	
	// 일지 번호를 있으면 가져오게 하려고 
	PetLogDBBean logging = PetLogDBBean.getInstance();
%>
<%
   request.setCharacterEncoding("utf-8"); 

   /* 값 가져오기 */
   String rev_num = imageUp.getParameter("rev_num");
   String pet_id = request.getParameter("pet_id");
   String cus_id = imageUp.getParameter("cus_id");
   String dog_id = imageUp.getParameter("dog_id");
   String pet_name = imageUp.getParameter("pet_name");
   String cus_name = imageUp.getParameter("cus_name");
   String dog_name = imageUp.getParameter("dog_name");
   String dog_pic = imageUp.getParameter("dog_pic");
   String res_date = imageUp.getParameter("res_date");
   int rev_star = Integer.parseInt(imageUp.getParameter("rev_star"));
   String rev_content = imageUp.getParameter("rev_content");

 	//그 때의 일지 번호 가져오기 (rev_num(리뷰번호)은 일지번호+날짜+cus_id, 일지 없으면 0+날짜+cus_id 임)
  	int log_num = logging.getPetLogNum(pet_id, res_date);
  	rev_num = String.valueOf(log_num);
  	rev_num += res_date.substring(5,7) + res_date.substring(8,10) + cus_id + pet_id;
	System.out.println(rev_num+"은 리뷰번호");
	
   /* 값 넣기 */
   cusreview.setRev_num(rev_num);
   cusreview.setPet_id(pet_id);
   cusreview.setCus_id(cus_id);
   cusreview.setDog_id(dog_id);
   cusreview.setPet_name(pet_name);
   cusreview.setCus_name(cus_name);
   cusreview.setDog_name(dog_name);
   cusreview.setDog_pic(dog_pic);
   cusreview.setRev_content(rev_content);
   cusreview.setRev_star(rev_star);
   cusreview.setRev_ip(request.getRemoteAddr());
   cusreview.setRes_date(res_date);
   cusreview.setRev_date(new Timestamp(System.currentTimeMillis()) );

   CusReviewDBBean cusR = CusReviewDBBean.getInstance();
   cusR.insertReview(cusreview); 
%>

<script>
  alert("후기 작성 완료!");
  // history.go(-1);
  // window.location.reload();
  // location.href="new_collection.jsp";
  self.close();
  parent.location.replace("blog2.jsp?pet_id="+"<%=pet_id%>");
</script> 