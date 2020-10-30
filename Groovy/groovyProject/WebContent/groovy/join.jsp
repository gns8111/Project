<!-- 회원가입 페이지 -->
<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 메일주소 입력 관련-->
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- 메일주소 입력 관련  끝-->
<!-- 주소입력 관련 -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<!-- 주소입력 관련 끝-->
	<script type="text/javascript" src="script.js?ver=22"></script> 
<script type="text/javascript">
	window.onload = function() {
		function appendYear() { //생년월일 셀렉트 년월일 생성
			var date = new Date();
			var year = date.getFullYear();
			var selectValue = document.getElementById("year");
			var optionIndex = 0;
			for (var i = year - 100; i <= year; i++) {
				selectValue.add(new Option(i, i), optionIndex++);
			}
		}
		function appendMonth() {
			var selectValue = document.getElementById("month");
			var optionIndex = 0;
			for (var i = 1; i <= 12; i++) {
				if(i<10){
					selectValue.add(new Option("0"+i,"0"+ i), optionIndex++);	
				}else
				selectValue.add(new Option(i, i), optionIndex++);
			}
		}
		function appendDay() {
			var selectValue = document.getElementById("day");
			var optionIndex = 0;
			for (var i = 1; i <= 31; i++) {
				if(i<10){
					selectValue.add(new Option("0"+i,"0"+ i), optionIndex++);	
				}else 
				selectValue.add(new Option(i, i), optionIndex++);
			}
		}
		appendYear();
		appendMonth();
		appendDay();

		//이메일 셀렉트박스
		$('#selectEmail').change(function() {
			$("#selectEmail option:selected").each(function() {
				if ($(this).val() == '1') { //직접입력일 경우 
					$("#str_email02").val(''); //값 초기화 
					$("#str_email02").attr("readOnly", false); //활성화 
				} else { //직접입력이 아닐경우 
					$("#str_email02").val($(this).text()); //선택값 입력
					$("#str_email02").attr("readOnly", true); //비활성화
				}
			});
		});
}
</script>
<link href="member.css" rel="stylesheet" type="text/css">

<html>
<head>
<title>부산여행갑시다 그럽시다</title>
</head>	
<style type="text/css">
table {
	border-spacing: 5px 5px;
}
</style>
<body>
	<div align="center">
		<form name="regFrm" method="post" action="joinProc.jsp">
			<table id="tbl1"  style="width: 480px">
				<tr>
					<td id="title" align="center">회&nbsp;원&nbsp;가&nbsp;입</td>
				</tr>
			</table>
			<table>
				<tr></tr>
				<tr>
					<td>아이디</td>
				</tr>
				<tr>
					<td><input name="id" onkeyup="characterCheck()" onkeydown="characterCheck()" placeholder="&nbsp;&nbsp;영문, 숫자만 입력 가능" maxlength="20">
					 <input type="button" value="중복 확인" onclick="javascript:idCheck(this.form.id.value)">
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
				</tr>
				<tr>
					<td><input type="password" name="pwd"  maxlength="20"></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
				</tr>
				<tr>
					<td><input type="password" name="repwd"  maxlength="20"></td>
				</tr>
				<tr>
					<td>이름</td>
				</tr>
				<tr>
					<td><input name="name"  maxlength="20"></td>
				</tr>
				<tr>
					<td>생년월일</td>
				</tr>
				<tr>
					<td><select  name="year" id="year" style="width: 70px;"><option value="0" selected></option></select> 년&nbsp;&nbsp; 
					<select name="month" id="month" style="width: 50px;"><option value="0"></option>	</select> 월&nbsp;&nbsp; 
					<select name="day" id="day" style="width: 50px;"><option value="0"></option></select> 일</td>
				</tr>
				<tr>
					<td>성별</td>
				</tr>
				<tr>
					<td>
						<select name=gender>
							<option value="0" selected disabled>선택하세요.</option>
							<option value="남성">남성</option>
							<option value="여성">여성</option>
						</select></td>
				</tr>
				<tr>
					<td>이메일</td>
				</tr>
				<tr>
					<td>
						<input name="str_email01" id="str_email01"	 maxlength="20" style="width: 130px" onkeyup="characterCheck2()" onkeydown="characterCheck2()"> 
						@ <input	name="str_email02" id="str_email02" maxlength="19" style="width: 150px; color: black" readOnly value="naver.com">
						 <select	style="width: 150px; margin-right: 10px" name="selectEmail" id="selectEmail">
							<option value="1">직접입력</option>
							<option value="naver.com" selected>naver.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
							<option value="gmail.com">gmail.com</option>
					</select>
				</tr>
				<tr>
					<td>주소</td>
				<tr>
				<tr>
					<td><input name="zipcode" id="zipcode" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" placeholder="&nbsp;&nbsp;숫자만 입력 가능" maxlength="5" style="width: 310px;" > 
							<input type="button" onclick="javascript:daumPostcode()" value="  우편번호 검색  "></td>
				</tr>
				<tr>
					<td><input name="address1" id="address1" size="45" placeholder="&nbsp;&nbsp;주소"  maxlength="50" style="width: 460px;"></td>
				</tr>
				<tr>
					<td><input name="address2" id="address2" size="45" placeholder="&nbsp;&nbsp;상세주소" maxlength="50" style="width: 460px;"></td>
				</tr>
				<tr>
					<td align="center">개인정보 취급방침</td>
				</tr>
				<tr>
					<td><textarea name="privacy" style="width: 100%" rows="5"
							cols="40" disabled="disabled">
1. 개인정보의 처리 목적 <부산여행>(‘busan’이하 ‘부산여행’) 은(는) 다음의 목적을 위하여 개인정보를 처리하고 있으며, 다음의 목적 이외의 용도로는 이용하지 않습니다.
- 고객 가입의사 확인, 고객에 대한 서비스 제공에 따른 본인 식별.인증, 회원자격 유지.관리, 물품 또는 서비스 공급에 따른 금액 결제, 물품 또는 서비스의 공급.배송 등


2. 개인정보의 처리 및 보유 기간

① <부산여행>(‘busan’이하 ‘부산여행’) 은(는) 정보주체로부터 개인정보를 수집할 때 동의 받은 개인정보 보유․이용기간 또는 법령에 따른 개인정보 보유․이용기간 내에서 개인정보를 처리․보유합니다.

② 구체적인 개인정보 처리 및 보유 기간은 다음과 같습니다.
☞ 아래 예시를 참고하여 개인정보 처리업무와 개인정보 처리업무에 대한 보유기간 및 관련 법령, 근거 등을 기재합니다.
(예시)- 고객 가입 및 관리 : 서비스 이용계약 또는 회원가입 해지시까지, 다만 채권․채무관계 잔존시에는 해당 채권․채무관계 정산시까지
- 전자상거래에서의 계약․청약철회, 대금결제, 재화 등 공급기록 : 5년


3. 정보주체와 법정대리인의 권리·의무 및 그 행사방법 이용자는 개인정보주체로써 다음과 같은 권리를 행사할 수 있습니다.

① 정보주체는 부산여행(‘busan’이하 ‘부산여행) 에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.
1. 개인정보 열람요구
2. 오류 등이 있을 경우 정정 요구
3. 삭제요구
4. 처리정지 요구



4. 처리하는 개인정보의 항목 작성

① <부산여행>('busan'이하 '부산여행')은(는) 다음의 개인정보 항목을 처리하고 있습니다.

1<제공받는 정보>
- 필수항목 : 이메일, 비밀번호, 로그인ID, 성별, 생년월일, 이름
- 선택항목 : 자택주소




5. 개인정보의 파기<부산여행>('부산여행')은(는) 원칙적으로 개인정보 처리목적이 달성된 경우에는 지체없이 해당 개인정보를 파기합니다. 파기의 절차, 기한 및 방법은 다음과 같습니다.

-파기절차
이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 이용되지 않습니다.

-파기기한
이용자의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 5일 이내에, 개인정보의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다.



6. 개인정보 자동 수집 장치의 설치•운영 및 거부에 관한 사항

① 부산여행 은 개별적인 맞춤서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 ‘쿠기(cookie)’를 사용합니다. ② 쿠키는 웹사이트를 운영하는데 이용되는 서버(http)가 이용자의 컴퓨터 브라우저에게 보내는 소량의 정보이며 이용자들의 PC 컴퓨터내의 하드디스크에 저장되기도 합니다. 가. 쿠키의 사용 목적 : 이용자가 방문한 각 서비스와 웹 사이트들에 대한 방문 및 이용형태, 인기 검색어, 보안접속 여부, 등을 파악하여 이용자에게 최적화된 정보 제공을 위해 사용됩니다. 나. 쿠키의 설치•운영 및 거부 : 웹브라우저 상단의 도구>인터넷 옵션>개인정보 메뉴의 옵션 설정을 통해 쿠키 저장을 거부 할 수 있습니다. 다. 쿠키 저장을 거부할 경우 맞춤형 서비스 이용에 어려움이 발생할 수 있습니다.


7. 개인정보 보호책임자 작성


① 부산여행(‘busan’이하 ‘부산여행) 은(는) 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.

▶ 개인정보 보호책임자
성명 :(주)부산
직책 :직원
직급 :직원
연락처 :010-0000-0000, ryu@gmail.net,
※ 개인정보 보호 담당부서로 연결됩니다.

▶ 개인정보 보호 담당부서
부서명 :
담당자 :
연락처 :, ,
② 정보주체께서는 부산여행(‘busan’이하 ‘부산여행) 의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. 부산여행(‘busan’이하 ‘부산여행) 은(는) 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다.



8. 개인정보 처리방침 변경

①이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.



9. 개인정보의 안전성 확보 조치 <부산여행>('부산여행')은(는) 개인정보보호법 제29조에 따라 다음과 같이 안전성 확보에 필요한 기술적/관리적 및 물리적 조치를 하고 있습니다.

1. 내부관리계획의 수립 및 시행
개인정보의 안전한 처리를 위하여 내부관리계획을 수립하고 시행하고 있습니다.

			</textarea></td>
				<tr>
					<td align="center">
						<input type="radio" name="privacy"
						value="1">동의합니다 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="privacy" value="2" checked="checked">동의하지 않습니다</td>
				</tr>
				<tr>
					<td align="center"><br />
						 <input type="button" id="btn1" value="회&nbsp;원&nbsp;가&nbsp;입" onclick="inputCheck()">
				</tr>

			</table>
		</form>
	</div>
</body>
</html>
