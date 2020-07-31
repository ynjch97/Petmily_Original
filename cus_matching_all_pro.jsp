<%@page import="java.util.ArrayList"%>
<%@page import="petmily.petsitter.PetsitterMaDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="petmily.customer.CustomerDBBean"%>
<%@ page import="petmily.customer.CustomerMaDBBean"%>
<%@ page import="petmily.customer.CusReviewDBBean"%>
<%@ page import="petmily.customer.CusReviewDataBean"%>

<%
   String cus_id = (String) session.getAttribute("cus_id");
   
   Context initCtx = new InitialContext();
   Context envCtx = (Context) initCtx.lookup("java:comp/env");
   DataSource ds = (DataSource)envCtx.lookup("jdbc/petmily");
    
   Connection conn = ds.getConnection();
   PreparedStatement pstmt = null;
   PreparedStatement pstmt2 = null;
   
   String puppy = "";
    
   try {
      String sql = "";
      sql += "SELECT pm.pet_id,p.pet_name, p.pet_addr, p.pet_intro, p.pet_cash, ";
      sql += "p.pet_intro1, p.pet_intro2, p.pet_intro3, sum(m.m_wei) score ";
      sql += "FROM matching m, petsitter p, ";
      sql += "cus_ma cm inner join pet_ma pm ";
      sql += "on cm.m_que = pm.m_que and cm.m_ans =  pm.m_ans ";
      sql += "where cm.cus_id = '" + cus_id + "'";
      sql += "and pm.m_que = m.m_que ";
      sql += "and cm.m_que = m.m_que ";
      sql += "and p.pet_id = pm.pet_id ";
      sql += "group by pet_id ";
      sql += "order by score desc;";
        
        System.out.println(sql);
        pstmt = conn.prepareStatement(sql); 
        ResultSet rs = pstmt.executeQuery();
       
        String pet_id = null;
        String pet_name = null;
        String pet_intro = null;
        int pet_cash = 0;
        int pet_cash_fee = 0;
        String pet_addr = null;
        // int finishing = 0;         //쓰지 않으면 펫시터가 여러명이 나옴(반복되니까) 
        
      while (rs.next()) {
           pet_id = rs.getString("pet_id").toString();
           pet_name = rs.getString("pet_name").toString();
           pet_intro = rs.getString("pet_intro").toString();
           pet_cash= rs.getInt("pet_cash");
           pet_cash_fee = (int)(pet_cash * 0.1);
           pet_addr = rs.getString("pet_addr").toString();
           
        // 펫시터 리뷰 별점 평균               
            CusReviewDBBean review = CusReviewDBBean.getInstance();
         float revStarAvgOri = review.getCusRevStar(pet_id);
         String format = "#.#";
         java.text.DecimalFormat ddff = new java.text.DecimalFormat(format);
         String revStarAvg = ddff.format(revStarAvgOri);
         revStarAvgOri = Float.parseFloat(revStarAvg);

		   int revCountss = review.getCusReviewCount(pet_id);
         
         String sql2 = "";
         sql2 += " select distinct m.remark remark";
         sql2 += " from pet_ma pm, matching m ";
         sql2 += " where pm.m_que = m.m_que ";
         sql2 += " and pm.m_ans = m.tag  ";
         sql2 += " and pm.pet_id = '"+pet_id+"'  ";
         
         System.out.println(sql2);
         pstmt2 = conn.prepareStatement(sql2); 
         ResultSet rs2 = pstmt2.executeQuery();
         
          puppy += "<div class='table' id='box' style='border: 1px solid #e4e4e4;'> ";
            puppy += "<div class='row'> ";
            
            // 사진
            puppy += "<div class='col-md-4' style='width:30%'>";
            puppy += "      <div id='carouselExampleFade' class='carousel slide carousel-fade' data-ride='carousel'>";
            puppy += "         <div class='carousel-inner'>";
            puppy += "             <div class='carousel-item active'>                                     ";
            puppy += "                <img class='d-block w-100' src='imageFile/"+rs.getString("pet_intro1").toString()+"'>";
            puppy += "             </div>  ";
            puppy += "             <div class='carousel-item'>                                     ";
            puppy += "                <img class='d-block w-100' src='imageFile/"+rs.getString("pet_intro2").toString()+"'>";
            puppy += "             </div>  ";
            puppy += "             <div class='carousel-item'>                                     ";
            puppy += "                <img class='d-block w-100' src='imageFile/"+rs.getString("pet_intro3").toString()+"'>";
            puppy += "            </div>  ";    
            puppy += "         </div>";
            puppy += "         <a class='carousel-control-prev' href='#carouselExampleFade' role='button' data-slide='prev'>";
            puppy += "            <span class='carousel-control-prev-icon' aria-hidden='true'></span>";
            puppy += "             <span class='sr-only'>Previous</span>";
            puppy += "         </a>";
            puppy += "         <a class='carousel-control-next' href='#carouselExampleFade' role='button' data-slide='next'>";
            puppy += "             <span class='carousel-control-next-icon' aria-hidden='true'></span>";
            puppy += "            <span class='sr-only'>Next</span>";
            puppy += "         </a>";
            puppy += "      </div>";
            puppy += "</div>";
            
            puppy += "       <div class='col-md-8' style='width:70%'> ";
            puppy += "            <div class='row'>";
            puppy += "             <div class='col-md-9'>";
            puppy += "                  <p id='cardtitle' style='padding-bottom:15px; padding-top:7px;'>" + pet_intro + "</p> ";
            puppy += "                  <label>" + pet_name + "</label><br> ";
            puppy += "                  <label><i class='fas fa-map-marker-alt'></i>&nbsp;&nbsp;" + rs.getString("pet_addr").toString() + "</label> ";
            puppy += "               </div>";
if (revStarAvgOri < 2) {
            
            puppy += "            <div class='col-md-3' id='bronze'>";
                  puppy += "               <label style='font-weight: bold; font-size: 20px; color: #384158; padding-left: 100px; padding-top: 28px;'>";
                  puppy +=             revStarAvgOri;
         puppy += "               </label>";
         puppy += "            </div>   ";

         } else if (revStarAvgOri >= 2 && revStarAvgOri<4) {
   
            puppy += "         <div class='col-md-3' id='silver'>";
            puppy += "            <label style='font-weight: bold; font-size: 20px; color: #384158; padding-left: 100px; padding-top: 28px;'>";
            puppy +=             revStarAvgOri ;
            puppy += "            </label>";
            puppy += "         </div>   ";

         } else {

            puppy += "         <div class='col-md-3' id='gold'>";
            puppy += "            <label style='font-weight: bold; font-size: 20px; color: #384158; padding-left: 100px; padding-top: 28px;'>";
               puppy +=      revStarAvgOri ;
            puppy += "            </label>";
            puppy += "         </div>   ";

         }
         puppy += "            </div>";
            // 태그
            puppy += "           <div class='form-group row' id='cardtagroup'>     ";
            while(rs2.next()) {
               puppy += "      <button type='button' class='btn' id='btntag'>"+rs2.getString("remark").toString()+"</button>   ";
            }
            puppy +=  "         </div> ";
            puppy += "          <div class='row'>";
            puppy += "             <div class='col-md-9' style='padding-left:0px;'>";
            puppy += "<i class='far fa-comment-dots fa-lg'>";
            puppy += "</i>";
            puppy += "<label id='cardcomment'>고객후기 " + revCountss + "개</label>";
            puppy += "</div>";
            puppy += "             <div class='col-md-3' align='right'>";
            puppy += "                  <label id='cardprice' style='font-weight: bold; font-size:20px; padding-right:22px; padding-bottom:5px;'>"+ pet_cash +"원</label>         ";
            puppy += "             </div>";
            puppy += "          </div>";
            puppy += "      </div>";
            
            puppy += "</div>";
            puppy += "</div>";  

      }
      
   }catch(Exception ex) {
      ex.printStackTrace();
   } finally {
       if (pstmt != null) 
          try { pstmt.close(); } catch(SQLException ex) {}
       if (conn != null) 
          try { conn.close(); } catch(SQLException ex) {}
   }
    
%>

<div>

<%=puppy %>

</div>