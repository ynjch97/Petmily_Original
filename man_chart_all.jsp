<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="petmily.manager.ManMonDBBean"%>
<%@ page import="petmily.manager.ManMonDataBean"%>

<%
	request.setCharacterEncoding("UTF-8"); 
	String title = "펫밀리:총 매출 분석 보고서";
	
	ManMonDataBean MonList[] = null;
	
	int m_count = 0;	
	
	ManMonDBBean manMon = ManMonDBBean.getInstance();
	/* m_count = manMon.getMileCount();				
	MonList = manMon.getMileage(m_count);	
 */
	DecimalFormat df = new DecimalFormat("###,###");

	// 가장 최근의 누적금액 (즉, 총 누적금액)
	int totMile = manMon.getTotMileage();
	String totMileComma = df.format(totMile);
%>

<!-- 총 매출 분석 보고서 -->


<table class="table table-hover table-bordered">
	<colgroup>
		<col width="15%">
		<col width="25%">
		<col width="30%">
		<col width="30%">
	</colgroup>
	<thead>
		<tr>
			<th></th>
			<th>거래 발생 건수</th>
			<th>월 이익</th>
			<th>누적 이익</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th><a href="man_chart_while.jsp">1월</a></th>
			<td>10</td>
			<td>10,000</td>
			<td>10,000</td>
		</tr>
		<tr>
			
			<th><a href="man_chart_while.jsp">2월</a></th>
			<td>10</td>
			<td>10,000</td>
			<td>20,000</td>
			
		</tr>
		<tr>
			<th><a href="man_chart_while.jsp">3월</a></th>
			<td>10</td>
			<td>10,000</td>
			<td>30,000</td>
		</tr>
		<tr>
			<th>연간 총 이익</th>
			<th colspan=3><%=totMileComma %></th>
		</tr>
	</tbody>
</table>