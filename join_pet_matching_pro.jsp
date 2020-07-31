<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="petmily.petsitter.PetsitterDBBean" %>
<%@ page import="petmily.petsitter.PetsitterMaDBBean" %>

<%
	request.setCharacterEncoding("utf-8"); 
	String title = "회원가입 3/3 성공";	

	String pet_id = "";
	pet_id = request.getParameter("pet_id");
%>

<jsp:useBean id="petsitter" class="petmily.petsitter.PetsitterMaDataBean">
     <jsp:setProperty name="petsitter" property="*"/>
</jsp:useBean>

<%
  // 문항 하나당 컬럼 하나가 생성됨 (아이디, 문항이름, 응답)
  // submit 시, 체크된 문항 수만 계산하여  cus_ma로 들어감
  
  // 1. mq(라디오버튼)와 ck(체크박스)의 문항 수 담아두기
  int mq_cnt = 8;
  int ck_cnt = 2;
  
  // 3-1. for문으로 ck_result1(응답값) 가져와서 ck배열에 넣어줌
  /* ArrayList<String> ck = new ArrayList<String>(); */
  
  // 2. ck(체크박스)는 값이 여러 개라서 따로 배열값 저장하려고 따로 가져옴 - ck1를 값으로 받아오면 0&3
  /* String[] ck1 = request.getParameterValues("ck1");
  String[] ck2 = request.getParameterValues("ck2"); */
  
  // 2-1. ck_result1 안에 값이 여러 개인 ck1의 값을 &로 연결해서 출력
  String[] ck1 = request.getParameterValues("ck1");
  String ck_result1= "";
  for (int i = 0; i <= ck1.length-1; i++) {
    ck_result1+=ck1[i]+"|";
  }

  String[] ck2 = request.getParameterValues("ck2");
  String ck_result2= "";
  for (int i = 0; i <= ck2.length-1; i++) {
    ck_result2+=ck2[i]+"|";
  }
  
  // 3-1. for문으로 ck_result1(응답값) 가져와서 ck배열에 넣어줌
  ArrayList<String> ck = new ArrayList<String>();
  ck.add(0,ck_result1);
  ck.add(1,ck_result2);
  
  // 3-1-re. 배열 방법 (실패)
  /* String[] ckk = new String[ck_cnt];
  for(int i=1; i<=ck_cnt ; i++){
    ckk[i] = "ck_result" + String.valueOf(i);
  } */
    
  // 3-2. for문으로 mq(라디오버튼)의 문항이름 가져와서 mq배열에 넣어줌
  ArrayList<String> mq = new ArrayList<String>();
  for(int i=1; i<=mq_cnt ; i++){
    mq.add(request.getParameter("mq"+i));
  }
  
  // 3-2-re. 배열 방법 (실패)
  /* String[] mqq = new String[mq_cnt];
  for(int i=1; i<=mq_cnt ; i++){
    mqq[i] = request.getParameter("mq"+i);
  } */
  
  // 4. DB에 값 넣기 (실패)
  /* CustomerMaDBBean matching = CustomerMaDBBean.getInstance();
  matching.insertCustomerMa(cus_id, mqq, ckk); */
  
  // 실패
  /* for(int i=1; i<21; i++) {
    String m_que = "q"+i;
    logon.insertCustomerMa(customer, m_que, cus_id);
  } */
  
  // DB를 바로 PRO.JSP에서 작업하는 방법으로 한다.
  Context initCtx = new InitialContext();
    Context envCtx = (Context) initCtx.lookup("java:comp/env");
    DataSource ds = (DataSource)envCtx.lookup("jdbc/petmily");
    
  Connection conn = ds.getConnection();
    PreparedStatement pstmt = null;
    
    try {
        String sql = "insert into PET_MA(pet_id,m_que,m_ans) values (?,?,?)"; 

        for(int i=1; i<=mq_cnt ; i++){
              pstmt = conn.prepareStatement(sql); 
            
			pstmt.setString(1, pet_id);
        	pstmt.setString(2, "mq"+i);
			pstmt.setString(3, mq.get(i-1));
	        if(mq.get(i-1)!=null){
	          pstmt.executeUpdate();  
	        }
        }
        
        for(int i=1; i<=ck_cnt ; i++){
              pstmt = conn.prepareStatement(sql); 

			pstmt.setString(1, pet_id);
	        pstmt.setString(2, "ck"+i);
	        pstmt.setString(3, ck.get(i-1));
	        if(ck.get(i-1)!=null){
	          pstmt.executeUpdate();  
	        }
        }
        
        //pstmt.setString(1, customer.getPet_Id());
        //pstmt.executeUpdate();
        
    }catch(Exception ex) {
      ex.printStackTrace();
    } finally {
        if (pstmt != null) 
          try { pstmt.close(); } catch(SQLException ex) {}
        if (conn != null) 
          try { conn.close(); } catch(SQLException ex) {}
    }
%>

<script>
    alert("	 님의 회원가입이 완료되었습니다.\n승인이 될 때까지 펫시터 검색 목록에 정보가 뜨지 않습니다.");
	location.href="index.jsp";
</script>



