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
   
   String search_text = request.getParameter("search_text");
   String search_addr = request.getParameter("search_addr");
   String tag[] = request.getParameterValues("tag");

   Context initCtx = new InitialContext();
   Context envCtx = (Context) initCtx.lookup("java:comp/env");
   DataSource ds = (DataSource) envCtx.lookup("jdbc/petmily");

   Connection conn = ds.getConnection();
   PreparedStatement pstmt = null;
   PreparedStatement pstmt2 = null;

   String divstr = "";

   String realFolder = "";//웹 어플리케이션상의 절대 경로
   String saveFolder = "";//파일이 업로드되는 폴더를 지정한다.
   ServletContext context = getServletContext();
   realFolder = context.getRealPath(saveFolder);

   try {
      String sql = "";
      sql += "select * from ( ";
      sql += " select p.pet_id ,p.pet_name, p.pet_intro, p.pet_cash, p.pet_intro1, p.pet_intro2, p.pet_intro3, p.pet_addr, count(*) cnt  ";
      sql += " from petsitter p         ";
      sql += " inner join pet_ma pm     ";
      sql += " on p.pet_id = pm.pet_id ";
      sql += " where  ";
      sql += " pet_apprv =  1 ";
      sql += " and (p.pet_name like '%" + search_text + "%' ";
      sql += " or p.pet_intro like '%" + search_text + "%' )";
      sql += " and p.pet_addr like '%" + search_addr + "%' ";
      
      if (tag != null) {
    	  
         sql += " and ( ";
         for (int i = 0; i < tag.length; i++) {
            if (i != 0) {
               sql += " or ";
            }
            sql += " ( pm.m_que = '" + tag[i].split("\\_")[0] + "' ";
            sql += " and pm.m_ans = '" + tag[i].split("\\_")[1] + "' )";
         }

         sql += " )  ";
      }
      sql += " group by p.pet_id ";
      sql += ") a ";
      if (tag != null) {
      sql += " where a.cnt = " + tag.length;
      }

      System.out.println(sql);
      pstmt = conn.prepareStatement(sql);

      ResultSet rs = pstmt.executeQuery();

      String pet_id = null;
      String pet_name = null;
      String pet_addr = null;
      String pet_intro = null;
      int pet_cash = 0;
      int pet_cash_fee = 0;
      String pet_intro1 = null;
      String pet_intro2 = null;
      String pet_intro3 = null;
      int cnt = 0;
      while (rs.next()) {
         pet_id = rs.getString("pet_id").toString();
         
      		// 펫시터 리뷰 별점 평균 	     		
	   		CusReviewDBBean review = CusReviewDBBean.getInstance();
			float revStarAvgOri = review.getCusRevStar(pet_id);
		   String format = "#.#";
		   java.text.DecimalFormat ddff = new java.text.DecimalFormat(format);
		   String revStarAvg = ddff.format(revStarAvgOri);
		   revStarAvgOri = Float.parseFloat(revStarAvg);
		   int revCount = review.getCusReviewCount(pet_id);
		   
         pet_name = rs.getString("pet_name").toString();
         pet_addr= rs.getString("pet_addr").toString();
         pet_intro = rs.getString("pet_intro").toString();
         pet_cash = rs.getInt("pet_cash");
	     pet_cash_fee = (int)(pet_cash * 0.1);
         pet_intro1 = rs.getString("pet_intro1").toString();
         pet_intro2 = rs.getString("pet_intro2").toString();
         pet_intro3 = rs.getString("pet_intro3").toString();

         String sql2 = "";
         sql2 += " select m.remark remark";
         sql2 += " from pet_ma pm        ";
         sql2 += " inner join matching m ";
         sql2 += " on pm.m_que = m.m_que ";
         sql2 += " and pm.m_ans = m.tag  ";
         sql2 += " where pm.pet_id = '" + pet_id + "'  ";

         System.out.println(sql2);
         pstmt2 = conn.prepareStatement(sql2);
         ResultSet rs2 = pstmt2.executeQuery();

         divstr += "<div class='table' id='box' style='border: 1px solid #e4e4e4;'> ";
         divstr += "    <div class='row'>          ";
         divstr += "      <div class='col-md-4' style='width:30%'> ";
         divstr += "         <div id='carouselExampleFade" + cnt
               + "' class='carousel slide carousel-fade' data-ride='carousel'>";
         divstr += "            <div class='carousel-inner'>";
         divstr += "               <div class='carousel-item active'>                                     ";
         divstr += "                 <img class='d-block w-100' src='imageFile/"
               + rs.getString("pet_intro1").toString() + "'>";
         divstr += "               </div>  ";
         divstr += "               <div class='carousel-item'>                                     ";
         divstr += "                <img class='d-block w-100' src='imageFile/"
               + rs.getString("pet_intro2").toString() + "'>";
         divstr += "               </div>  ";
         divstr += "               <div class='carousel-item'>                                     ";
         divstr += "                  <img class='d-block w-100' src='imageFile/"
               + rs.getString("pet_intro3").toString() + "'>";
         divstr += "               </div>  ";
         divstr += "            </div>";
         divstr += "            <a class='carousel-control-prev' href='#carouselExampleFade" + cnt
               + "' role='button' data-slide='prev'>";
         divstr += "               <span class='carousel-control-prev-icon' aria-hidden='true'></span>";
         divstr += "               <span class='sr-only'>Previous</span>";
         divstr += "            </a>";
         divstr += "            <a class='carousel-control-next' href='#carouselExampleFade" + cnt
               + "' role='button' data-slide='next'>";
         divstr += "             <span class='carousel-control-next-icon' aria-hidden='true'></span>";
         divstr += "               <span class='sr-only'>Next</span>";
         divstr += "            </a>";
         divstr += "         </div>";
         divstr += "       </div>";
         divstr += "       <div class='col-md-8' style='width:70%' onclick='javascript:location.href=\"/petmily/blog2.jsp?pet_id=" + pet_id + "\"'> ";
         divstr += "         <div class='row'>";
         divstr += "       <div class='col-md-9'>";
         divstr += "            <p id='cardtitle' style='padding-bottom:15px;'>" + pet_intro + "</p> ";
         divstr += "            <label>" + pet_name + "</label><br> ";
         divstr += "               <label><i class='fas fa-map-marker-alt'></i>&nbsp;&nbsp;" + rs.getString("pet_addr").toString() + "</label> ";
         divstr += "         </div>";

			if (revStarAvgOri < 2) {
				
				divstr += "				<div class='col-md-3' id='bronze'>";
						divstr += "					<label style='font-weight: bold; font-size: 20px; color: #384158; padding-left: 100px; padding-top: 28px;'>";
						divstr += 				revStarAvgOri;
			divstr += "					</label>";
			divstr += "				</div>	";

			} else if (revStarAvgOri >= 2 && revStarAvgOri<4) {
	
				divstr += "			<div class='col-md-3' id='silver'>";
				divstr += "				<label style='font-weight: bold; font-size: 20px; color: #384158; padding-left: 100px; padding-top: 28px;'>";
				divstr += 			   revStarAvgOri ;
				divstr += "				</label>";
				divstr += "			</div>	";

			} else {

				divstr += "			<div class='col-md-3' id='gold'>";
				divstr += "				<label style='font-weight: bold; font-size: 20px; color: #384158; padding-left: 100px; padding-top: 28px;'>";
					divstr += 	  revStarAvgOri ;
				divstr += "				</label>";
				divstr += "			</div>	";

			}
         
/*          divstr += "         <div class='col-md-3' id='gold'>";
          divstr += "       <label style='font-weight: bold; font-size:20px; color:#384158; padding-left:100px; padding-top:28px;'>4.5</label>         ";
         divstr += "         </div>"; 
*/
         divstr += "         </div>";
         divstr += "         <div class='form-group row' id='cardtagroup'> ";
         //펫시터마다 태그 읽어와서 뿌려 줌
         while (rs2.next()) {
            divstr += "       <button type='button' class='btn btn-outline-dark' id='btntag' disabled>"
                  + rs2.getString("remark").toString() + "</button>   ";
         }
         divstr += "         </div>                                        ";
         divstr += " <div class='row'>";
         divstr += " <div class='col-md-9' style='padding-top:10px;'>";
         divstr += "         <i class='far fa-comment-dots fa-lg'>";
         divstr += "         </i>";
         divstr += "         <label id='cardcomment'>고객후기 " + revCount + "개</label>      ";
         divstr += "       </div>";
         divstr += " <div class='col-md-3' align='right'>";
         divstr += "         <label id='cardprice' style='font-weight: bold; font-size:20px; padding-right:22px;'>"+ pet_cash +"원</label>         ";
         divstr += "       </div>";
         divstr += "       </div>";
         divstr += "       </div>";
         divstr += "    </div>";
         divstr += "</div>";
         cnt++;
      }
      if (cnt == 0) {

         divstr += "<div style='padding-top:50px; padding-bottom:150px; text-align:center;'>";
         divstr += "<img class='img-responsive' src='images/no.png' style='width:150px;'>";
         divstr += "<h3 style='color:#fed476; padding-top:30px; padding-bottom:10px;'>죄송합니다. 검색 조건에 맞는 펫시터가 없습니다.</h3>";
         divstr += "<b>강아지와 함께 하세요!</b><br>";
         divstr += "강아지와 함께 사는 사람들은 삶의 행복지수가 높다고 합니다.<br>";
         divstr += "스트레스를 받다가도 강아지를 보면 긍정적인 힘이 솟는다고 하네요!";
         divstr += "</div>";
      }
   } catch (Exception ex) {
      ex.printStackTrace();
   } finally {
      if (pstmt != null)
         try {
            pstmt.close();
         } catch (SQLException ex) {
         }
      if (conn != null)
         try {
            conn.close();
         } catch (SQLException ex) {
         }
   }
%>
<div>
<%=divstr %>

</div>