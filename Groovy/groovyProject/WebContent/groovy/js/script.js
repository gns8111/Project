/////////////////유효성 검사/////////////////////////////
function inputCheck(){
	if(document.regFrm.id.value==""){
		alert("아이디를 입력해 주세요.");
		document.regFrm.id.focus();
		return;
	}
	if(document.regFrm.pwd.value==""){
		alert("비밀번호를 입력해 주세요.");
		document.regFrm.pwd.focus();
		return;
	}
	if(document.regFrm.pwd2.value==""){
		alert("비밀번호를 확인해 주세요");
		document.regFrm.pwd2.focus();
		return;
	}
	if(document.regFrm.pwd.value != document.regFrm.pwd2.value){
		alert("비밀번호가 일치하지 않습니다.");
		document.regFrm.pwd2.value="";
		document.regFrm.pwd2.focus();
		return;
	}
	if(document.regFrm.name.value==""){
		alert("이름을 입력해 주세요.");
		document.regFrm.name.focus();
		return;
	}
	if(document.regFrm.nick.value==""){
		alert("닉네임을 입력해 주세요.");
		document.regFrm.nick.focus();
		return;
	}
	if(document.regFrm.email.value==""){
		alert("이메일을 입력해 주세요.");
		document.regFrm.email.focus();
		return;
	}
    var str=document.regFrm.email.value;	   
    var atPos = str.indexOf('@');
    var atLastPos = str.lastIndexOf('@');
    var dotPos = str.indexOf('.'); 
    var spacePos = str.indexOf(' ');
    var commaPos = str.indexOf(',');
    var eMailSize = str.length;
    if (atPos > 1 && atPos == atLastPos && 
	   dotPos > 3 && spacePos == -1 && commaPos == -1 
	   && atPos + 1 < dotPos && dotPos + 1 < eMailSize);
    else {
          alert('E-mail주소 형식이 잘못되었습니다.\n\r다시 입력해 주세요!');
	      document.regFrm.email.focus();
		  return;
    }
	if(document.regFrm.birthday.value==""){
		alert("생년월일을 입력해주세요.");
		document.regFrm.email.focus();
		return;
	}

	if(document.regFrm.hp.value==""){
		alert("연락처를 입력해 주세요.");
		document.regFrm.hp.focus();
		return;
	}

    if(document.regFrm.zipcode.value==""||document.regFrm.address.value==""){
		alert("우편번호를 검색해 주세요.");
		return;
	}
    if(document.regFrm.detailAddress.value==""){
    	alert("상세주소를 입력해 주세요.")
    	return;
    }
	document.regFrm.submit();
}

function win_close(){
	self.close();
}
///////////////////////////////////////////////////////
//////////////////id 중복검사//////////////////////////

function idCheck(id) {
	frm = document.regFrm;
	if(id==""){
		alert("아이디를 입력하세요.");
		frm.id.focus();
		return;//function을 벗어난다.
	}
	url = "idCheck.jsp?id="+id;
	window.open(url,"IDCheck","width=300,height=150");
}
////////////////////////////////////////////////////////////
//////////////이메일 셀렉트 박스//////////////////////////


////////////다음 주소 검색////////////////////////  

//우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                 }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("zipcode").value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 1; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth)  - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight)  - height)/2 - borderWidth) + 'px';
    }
////////////////////////////////다음 주소 검색 끝/////////////////////////////////////

/////////////////검색 창//////////////////////
    function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
	
	function list() {
		document.listFrm.action = "list.jsp";
		document.listFrm.submit();
	}
	
	function numPerFn(numPerPage) {
		document.readFrm.numPerPage.value=numPerPage;
		document.readFrm.submit();
	}
	
	function read(num) {
		document.readFrm.num.value = num;
		document.readFrm.action = "read.jsp";
		document.readFrm.submit();
	}
	



/*내가 만든*/
//로그인 경고창
		
function loginCheck() {
    		if (document.loginFrm.username.value == "") {
    			alert("아이디를 입력해 주세요.");
    			document.loginFrm.username.focus();
    			return;
    		}
    		if (document.loginFrm.pass.value == "") {
    			alert("비밀번호를 입력해 주세요.");
    			document.loginFrm.pass.focus();
    			return;
    		}
    		document.loginFrm.submit();
    	}


//이미지 업로드 부분        
function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
    		$('#blah').attr('src', e.target.result); 
			} 
			reader.readAsDataURL(input.files[0]); 
			}
        }

//텍스트 입력 값 제한
function numberMaxLength(e){
    if(e.value.length > e.maxLength){
        e.value = e.value.slice(0, e.maxLength);
    }
}



//검색버튼
function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}


