<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp" %>

<%
   request.setCharacterEncoding("UTF-8");
   String title ="펫밀리:회원가입 1/3";
%>
<script>
<%  
if(session.getAttribute("cus_id")!=null || session.getAttribute("pet_id")!=null )
{
%>
   alert("회원은 이용할 수 없습니다.\n메인페이지로 이동합니다.");
   self.close();
   parent.location.replace("index.jsp"); // 추가
<% 
} else {
%>
</script>
<style>
.btn span.fa {
   opacity: 0;
}

.btn.active span.fa {
   opacity: 1;
}
</style>

<jsp:include page="layout/header.inc.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>" />
</jsp:include>

<!-- Home -->
<div id="j-container">
   <article class="container">
      <div id="j-content">
      <ul class="nav nav-tabs">
         <li class="nav-item">
            <a class="nav-link active" href="join_cus.jsp" style="color: #000000; font-size: 15px;">
               <b>고객 회원가입</b>
            </a>
         </li>
         <li class="nav-item">
            <a class="nav-link" href="join_pet.jsp" style="color: #000000; font-size: 15px;">
               펫시터 회원가입
            </a>
         </li>
      </ul>
         <div class="card">
            <div class="card-body">
                        <div class="row bs-wizard" style="border-bottom:0;">
                
                <div class="col-xs-3 bs-wizard-step active">
                  <div class="text-center bs-wizard-stepnum" style="font-weight:bold;">약관 동의</div>
                  <div class="progress"><div class="progress-bar"></div></div>
                  <a href="#" class="bs-wizard-dot"></a>
                 
                </div>
                
                <div class="col-xs-3 bs-wizard-step disabled">
                  <div class="text-center bs-wizard-stepnum">개인정보 입력</div>
                  <div class="progress"><div class="progress-bar"></div></div>
                  <a href="#" class="bs-wizard-dot"></a>
                  
                </div>
                
                <div class="col-xs-3 bs-wizard-step disabled">
                  <div class="text-center bs-wizard-stepnum">반려견 정보 입력</div>
                  <div class="progress"><div class="progress-bar"></div></div>
                  <a href="#" class="bs-wizard-dot"></a>
                  
                </div>
                
                <div class="col-xs-3 bs-wizard-step disabled">
                  <div class="text-center bs-wizard-stepnum">매칭정보 입력</div>
                  <div class="progress"><div class="progress-bar"></div></div>
                  <a href="#" class="bs-wizard-dot"></a>
                  
                </div>
            </div>              
                  <form class="form" method="post" name="join_cus_form" enctype="multipart/form-data"">
                     <div class="form-group col col-md-offset-3">
                     <div class="input-group" style="padding-top:30px;">
                     <div class="form-group col-11 col-md-offset-3">
                        <h4 style="font-weight:bold;">서비스 이용약관 (필수) / 개인정보취급방침 (필수) 전체 동의합니다.</h4>      
                     </div>      
                     <div class="form-group col-1 col-md-offset-3" align="right";>
                        <label style="padding-top:7px;"><input type="checkbox" name="a1" id="a1" value="1" /></label>
                     </div>
                     </div>
                     </div>
                     <hr>
                     
                     <div class="form-group col col-md-offset-3">
                     <div class="input-group" style="padding-top:20px;">
                     <div class="form-group col-11 col-md-offset-3">
                        <h6 style="font-weight:bold;">서비스 이용약관 </h6>
                        </div>
                        <div class="form-group col-1 col-md-offset-3" align="right";>
                        <label style="padding-top:7px;"><input type="checkbox" class="a" name="a" id="a2" value="1" required="required" /></label>
                        </div></div>&#13;&#10;
                        <textarea name="law" class="form-control" rows="12" style="color: #76777a; text-align: left; font-size: 14px;">
제 1 장 총칙
제 1 조 (목적)
이 약관은 주식회사 펫밀리(이하 ‘회사’라 합니다.)가 제공하는 펫밀리 펫시터 중개 서비스 및 펫밀리 관련 제반 서비스(이하 ‘서비스'라고 하며, 접속 가능한 유∙무선 단말기의 종류와는 상관없이 이용 가능한 ‘회사'가 제공하는 모든 ‘서비스'를 의미합니다. 이하 같습니다)를 이용자(이하 ‘회원’)가 이용함에 있어 회사와 회원간의 권리와 의무, 책임사항 및 회사의 서비스 이용절차에 관한 필요사항을 규정함을 목적으로 합니다.

제 2조 (용어의 정의)
1. 이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
1) 서비스 : 구현되는 단말기(PC,TV, 휴대형단말기 등의 각종 유무선 장치를 포함)와 상관없이 회원이 이용할 수 있는 펫밀리 및 펫밀리 관련 제반 서비스를 의미합니다.
2) 회원 : 이 약관을 승인하고 회사와 서비스 이용 계약을 체결한 자를 말합니다.
3) 이용계약 : 서비스 이용과 관련하여 회사와 회원 간에 체결하는 계약을 말합니다.
4) 아이디(ID) : 펫밀리 아이디(ID)는 서비스를 사용하기 위하여 필요한 이메일 주소나 핸드폰 번호를 의미합니다. 약관에 동의하고 여러분의 이메일 주소나 핸드폰 번호를 입력하고 비밀번호를 등록한 후 필요한 경우 펫밀리가 이메일 주소와 핸드폰 번호를 인증한 후 승낙하는 절차로 생성됩니다.
5) 비밀번호 : 회원정보의 보호를 위하여 회원이 설정하고 회사가 승인한 문자 또는 문자와 숫자의 조합을 말합니다.
6) 해지 : 회사 또는 회원이 이용계약을 해약하는 것을 말합니다.
7) 반려동물 펫시터 : 반려동물 돌봄 관련 서비스를 판매할 의사로 가입하고 회사가 별도로 승인하여 반려동물 펫시터(이하 ‘펫시터’라 합니다.) 목록에 등록된 회원을 말합니다.
8) 반려동물 돌봄 서비스 : '회사'에서 운영하는 두 가지 형태의 펫시터 서비스(펫시터 집에 맡기기, 펫시터 부르기)를 말합니다.
- 펫시터 집에 맡기기 서비스 : '회원'이 '회사'의 사이트 혹은 앱을 이용하여 결제 후 예약한 '펫시터'의 집에 약속된 기간동안 '회원'의 반려동물의 돌봄을 위탁하여 맡길 수 있는 서비스를 말합니다.
- 펫시터 부르기 서비스 : '회원'이 '회사'의 사이트 혹은 앱을 이용하여 결제 후 예약한 '펫시터'가 '회원'의 집에 약속된 시간에 방문하여 '회원'의 반려동물을 정해진 시간동안 대신 돌봄서비스(산책,배식,배변처리)를 제공하는 서비스를 말합니다.
9) 의뢰인 : '펫시터 집에 맡기기 서비스' 나 '펫시터 부르기 서비스'를 결제하여 예약한 회원을 말합니다.
10) 직거래 : 회사가 제공하는 서비스를 이용하지 않고 이메일, 연락처, 메신져 아이디 등 교환을 통한 개인간 거래를 말합니다.
11) 사전만남 : 펫시터와 의뢰인이 의뢰계약을 진행하기 전 사전에 만나 펫시터와 서로의 반려동물에 대한 성향을 파악하는 것을 말합니다. (상호간 첫 의뢰계약을 하는 경우 필수로 진행해야 합니다.)
12) 의뢰계약 : 의뢰인이 서비스를 이용하기 위해 펫시터 혹은 회사와 상호간의 체결하는 계약을 말합니다.
2. 위 1항에서 정의되지 않은 이 약관상의 용어의 의미는 일반적인 거래관행에 의합니다.

제 3 조 (약관의 명시, 효력 및 변경)
1. 이 약관은 주식회사 펫밀리가 운영하는 사이트와 앱에서 온라인으로 공시함으로써 효력이 발생됩니다.
2. 회사는 사정상 중요한 사유가 발생될 경우 변경 전 최소 7일간 (약관 변경이 소비자에게 불리한 경우에는 변경전 30일 이상) 변경 전 내용과 변경 후 내용을 비교하여 제 1항과 같은 방법으로 공지 또는 통지합니다. 고지기간 경과 후 약관의 효력이 발생 됩니다.
3. 이 약관에 동의하는 것은 정기적으로 회사가 운영하는 인터넷 사이트와 앱을 방문하여 약관의 변경사항을 확인하는 것에 동의함을 의미합니다. 변경된 약관에 대한 정보를 알지 못하여 발생하는 회원 또는 이용자의 피해에 대하여 회사는 책임을 부담하지 않습니다.
4. 회원은 변경된 약관에 동의하지 않을 경우 회원 해지(탈퇴)를 요청할 수 있으며, 변경된 약관의 효력 발생일 이후에도 서비스를 계속 사용할 경우 약관의 변경 사항에 동의한 것으로 간주됩니다.
5. 회사는 필요한 경우 특정 서비스에 관하여 적용될 사항(이하 "특별약관"이라고 합니다)을 정하여 미리 공지할 수 있습니다. 특별약관에 동의한 후 특정 서비스를 이용하는 경우 특별약관이 우선적으로 적용됩니다. 특별약관을 변경하고자 하는 경우 2항에 따라 공지합니다.
                        </textarea>
                        <br>
                        
                     </div>
                     <div class="form-group col col-md-offset-10">
                     
                     <div class="input-group" style="padding-top:20px;">
                     <div class="form-group col-11 col-md-offset-3">
                        <h6 style="font-weight:bold;">개인정보취급방침</h6>
                        </div>
                        <div class="form-group col-1 col-md-offset-3" align="right";>
                        <label style="padding-top:7px;"><input type="checkbox" class="a" name="a" id="a2" value="1" required="required" /></label>
                        </div></div>&#13;&#10;
                        <textarea name="law" class="form-control" rows="12" style="color: #76777a; text-align: left; font-size: 14px;">
주식회사 펫밀리(이하 “회사”라 한다.)는 회원님들의 개인정보를 안전하게 보호하기 위하여 최선의 노력을 다하고 있으며, 개인정보보호관련 법규 및 정부기관의 가이드라인을 준수하고 있습니다.
회사는 개인정보 취급방침을 통하여 회원님의 개인정보가 어떻게 이용되고 있고, 이용 시 어떠한 보호조치가 취해지고 있는지 알려드립니다.
개인정보 취급방침은 법령의 변경이나, 보다 나은 서비스의 제공을 위하여 내용이 변경될 수 있습니다. 이 경우 회사는 이메일을 통해서 공지하고 있습니다. 개인정보 취급방침은 홈페이지 첫 화면의 맨 아래에 굵은 글씨로 표시되어 있습니다.
개인정보 취급방침과 이용 약관의 개인정보 관련한 내용의 경우 이용약관이 우선 순위를 갖습니다.

1. 개인정보 수집에 대한 동의
회사는 서비스 이용을 위한 회원가입 시 이용약관의 내용에 대하여 동의하는 의사표시를 ‘서비스 이용약관’,‘개인정보취급방침’, ‘안전보상제도 약관’에 ‘동의하기' 버튼을 누른 후 ‘가입하기’ 버튼을 누르는 절차를 마련하고 있으며 같은 화면에서 개인정보취급방침 또한 확인하실 수 있습니다.
동의의 의사표시가 있는 경우 개인정보의 수집에 동의한 것으로 봅니다. 또한 회사는 개인정보취급방침을 홈페이지 첫 화면에 공개함으로써 귀하께서 언제나 용이하게 보실 수 있도록 조치하고 있습니다.

2. 개인정보 수집 및 이용 목적
1) 회사가 개인정보를 수집하는 목적은 회원의 신분과 서비스 이용의사를 확인하여 최적화되고 맞춤화된 서비스를 제공하기 위함입니다. 회사는 회원께서 서비스 상품을 주문, 결제하고 기타 회원님들을 위한 각종 서비스를 제공하기 위해 필요한 최소한의 정보를 수집하고 있습니다.
2) 회사는 개인정보의 기본 수집 목적 이외에 다른 용도로 이를 이용하거나 회원의 동의 없이 제3자에게 이를 제공하지 않습니다.
3) 회사는 회원의 인권을 침해할 우려가 있는 민감한 정보(인종, 사상 및 신조, 정치적 성향이나 범죄기록, 의료정보 등)는 어떠한 경우에도 수집하지 않으며, 만약 불가피하게 수집하는 경우에는 반드시 회원에게 사전 동의를 구합니다.
4) 회사는 회원의 개인정보를 다음과 같이 수집합니다.
가) 회원 가입 시
이메일, 비밀번호, 이름, 주소, 성별, CI, DI, 생년월일, 가입인증 휴대폰번호, 이통사 정보
나) 서비스 구매 시
반려동물 정보, 신분인증 사진(신분증, 우편물), 결제를 위한 신용카드 정보, 은행계좌 정보, 주거관련 정보, 결제기록 등의 정보
다) 펫시터 등록 시
신분인증 사진, 펫시터로 활동하기 위한 주거형태 및 가족구성원, 반려동물 키운 경험에 관한 정보, 관련 이미지
라) 펫시터 수익금 출금 신청 시
수익금 출금과 수익금에 관해 세금 신고를 위한 실명확인 정보(이름 및 주민등록번호)
마) 기타
서비스 이용과정에서 자동 수집 정보 : IP Address, 쿠키, 방문 일시, 서비스 이용 기록, 불량 이용 기록, 기기 정보
5) 수집한 개인정보는 다음과 같은 목적으로 사용됩니다.
가) 개인 식별 : 이메일, 휴대폰번호, CI, 이름, 비밀번호, 주소
나) 본인 인증 : 이름, 휴대폰 번호, 이통사 정보, 생년월일, 성별
다) 서비스 구매 및 요금 결제, 환불, 관련 법령에 의한 기록 보존 : 신용카드 정보, 은행계좌 정보, 결제기록 등의 정보, 이름 주소 이메일 등 거래주체 식별 정보
라) 서비스 제공을 위한 연락 및 안내, 민원 처리 : 이름, 이메일, 휴대폰 번호, 주소, 생년월일, 성별 등
마) 세금 신고 : 이름, 주민등록번호
바) 이벤트 및 신규 서비스 안내, 마케팅 및 광고 : 이름, 이메일, 휴대폰번호
6) 회사는 회원가입, 요금결제, 서비스 문의 게시판, 고객 상담 등을 통하여 개인정보를 수집합니다.

3. 개인정보의 보유 및 이용기간
회사는 원칙적으로 개인정보 이용목적 달성 후에는 해당 개인정보를 지체 없이 파기합니다. 단, 내부방침 및 관계법령의 규정에 의하여 보존할 필요가 있는 경우 아래와 같이 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다.
1) 내부 방침(부정이용 방지)
가) 보존이유 : 기존 구매 서비스에 대한 본인 인증 필요성(부정이용의 배제 등 회사 방침에 의한 보존)
나) 보존항목 : 이름, 휴대폰 번호, 이메일, 주소
다) 보존기간 : 계약기간 내내, 계약해지 후 2 년
2) 상법 등 법령에 따라 보존할 필요성이 있는 경우
가) 계약 또는 청약철회 등에 관한 기록
a) 보존근거 : 전자상거래 등에서의 소비자보호에 관한 법률
b) 보존기간 : 5년
나) 대금결제 및 서비스 등의 공급에 관한 기록
a) 보존근거 : 전자상거래 등에서의 소비자보호에 관한 법률
b) 보존기간 : 5년
다) 소비자의 불만 또는 분쟁처리에 관한 기록
a) 보존근거 : 전자상거래 등에서의 소비자보호에 관한 법률
b) 보존기간 : 3년
라) 웹사이트 방문기록
a) 보존근거 : 통신비밀보호법
b) 보존기간 : 3개월
                        </textarea>
                        <br>
                        
                     </div>
                     
                     <div class="form-group text-right">
                        <button type="button" id="colorch" class="btn btn-light" style="width:80px;" onclick="window.location.href='join_cus.jsp'">다음</button>
                        
                     </div>
                  </form>
                  
               </div>
            </div>
         </div>
      
   </article>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="/aban/assets/bootstrap-4.1.0/js/bootstrap.min.js"></script>  
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
<%
   }
%>
</script>

<jsp:include page="layout/footer.inc.jsp" flush="false" />