<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String title = "펫밀리:일대일 채팅";
%>
<%@ page import="petmily.manager.ManagerDBBean"%>

<script type="text/javascript">
<%  
	if(session.getAttribute("man_id")==null)
	{
%>
       alert("관리자용 페이지입니다.\n메인페이지로 이동합니다.");
       self.close();
       parent.location.replace("index.jsp"); // 추가
<% 
	} else {
%>
</script>

<jsp:include page="layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>


<!-- Home -->
<div id="j-container">
	<article class="container">

		<div id="j-content">
			<div class="card">
				<div class="card-body">
					<div class="page-header">
						<b><big>실시간 1:1 상담</big></b>
					</div>
					<br>
					<div class="album py-2">
						<%-- <div>

							<div class="card widget tabbed w-70%">
								<div class="card-header tabs-wrapper">
									<ul class="nav nav-tabs card-header-tabs">
										<li class="nav-item"><a class="nav-link active"
											href="#pet_messages" data-toggle="tab"><i
												class="fa fa-comments tab-comment"></i> 펫시터</a></li>
										<li class="nav-item"><a class="nav-link"
											href="#cus_messages" data-toggle="tab"><i
												class="fa fa-comments tab-comment"></i> 고객</a></li>
										<button class="btn btn-sm btn-link"
											onClick="window.location.reload()">
											<i class="fas fa-redo-alt"></i>
										</button>
									</ul>
								</div>
								<div class="card-body">
									<div class="tab-content">
										<ul id="pet_messages"
											class="list-group list-group-flush tab-pane active">

											<%
												for (int i = 0; i < 5; i++) {
											%>

											<a class="list-group-item list-group-item-action list-group-item-light" href="#myModal" data-toggle="modal" data-target="#conModal">
												<div class="content d-flex justify-content-between">
													<br> <img width="60" height="60"
														src="image_petmily/dog_8.png" /> &nbsp; <b>차윤지</b> &nbsp;
													<h6>상담 페이지 상담 페이지 상담 페이지 상담 페이지 상담 페이지 상담 페이지 상담 페이지 </h6>
													&nbsp; <small class="text-muted"><i> 31분 전 </i></small>
													&nbsp; <span class="badge badge-primary badge-pill">4</span>
												</div>
											</a>


											<%
												}
											%>
										</ul>
										<ul id="cus_messages"
											class="list-group list-group-flush tab-pane">

											<%
												for (int j = 0; j < 5; j++) {
											%>

											<a
												class="list-group-item list-group-item-action list-group-item-light"
												href="#myModal" data-toggle="modal" data-target="#conModal">
												<div class="content d-flex justify-content-between">
													<br> <img width="60" height="60"
														src="image_petmily/dog_8.png" /> &nbsp; <b>차윤지</b> &nbsp;
													<h6>안녕</h6>
													&nbsp; <small class="text-muted"><i> 31분 전 </i></small>
													&nbsp; <span class="badge badge-primary badge-pill">14</span>
												</div>
											</a>

											<%
												}
											%>
										</ul>


									</div>
								</div>
							</div>

						</div>


						</form> --%>
						
    <fieldset>
        <textarea id="messageWindow" rows="10" cols="50" readonly="true"></textarea>
        <br/>
        <input id="inputMessage" type="text"/>
        <input type="submit" value="send" onclick="send()" />
    </fieldset>
    <script type="text/javascript">
        var textarea = document.getElementById("messageWindow");
        var webSocket = new WebSocket('ws://localhost:8091/petmily/broadcasting');
        var inputMessage = document.getElementById('inputMessage');
    webSocket.onerror = function(event) {
      onError(event)
    };
    webSocket.onopen = function(event) {
      onOpen(event)
    };
    webSocket.onmessage = function(event) {
      onMessage(event)
    };
    function onMessage(event) {
        textarea.value += "상대 : " + event.data + "\n";
    }
    function onOpen(event) {
        textarea.value += "연결 성공\n";
    }
    function onError(event) {
      alert(event.data);
    }
    function send() {
        textarea.value += "나 : " + inputMessage.value + "\n";
        webSocket.send(inputMessage.value);
        inputMessage.value = "";
    }
  </script>
					</div>
				</div>
			</div>
		</div>
	</article>
</div>

<script>
<%
	}
%>
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false" />