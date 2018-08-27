<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>유저 CRUD</title>
	
<style type="text/css">
    .orange {
        color: #fef4e9;
        border: solid 1px #da7c0c;
        background: #f78d1d;
        background: -webkit-gradient(linear, left top, left bottom, from(#faa51a), to(#f47a20));
        background: -moz-linear-gradient(top,  #faa51a,  #f47a20);
        filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#faa51a', endColorstr='#f47a20');
        vertical-align:middle;
        cursor:pointer;
        color:black;
        font-weight:bold;
        font-size:13;
        font-family:굴림; 
        align:right;
        width:40px;
        height:22px;
        margin-right:5px;
    }
    .orange2 {
        color: #fef4e9;
        border: solid 1px #da7c0c;
        background: #f78d1d;
        background: -webkit-gradient(linear, left top, left bottom, from(#faa51a), to(#f47a20));
        background: -moz-linear-gradient(top,  #faa51a,  #f47a20);
        filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#faa51a', endColorstr='#f47a20');
        vertical-align:middle;
        cursor:pointer;
        color:black;
        font-weight:bold;
        font-size:13;
        font-family:굴림; 
        align:right;
        width:90px;
        height:22px;
        margin-right:5px;
    }
    .orange3 {
        color: #fef4e9;
        border: solid 1px #da7c0c;
        background: #f78d1d;
        background: -webkit-gradient(linear, left top, left bottom, from(#faa51a), to(#f47a20));
        background: -moz-linear-gradient(top,  #faa51a,  #f47a20);
        filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#faa51a', endColorstr='#f47a20');
        vertical-align:middle;
        cursor:pointer;
        color:black;
        font-weight:bold;
        font-size:13;
        font-family:굴림; 
        align:right;
        width:100%;
        height:44;
        margin-right:5px;
    }
    .orange4 {
        color: #fef4e9;
        border: solid 1px #da7c0c;
        background: #f78d1d;
        background: -webkit-gradient(linear, left top, left bottom, from(#faa51a), to(#f47a20));
        background: -moz-linear-gradient(top,  #faa51a,  #f47a20);
        filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#faa51a', endColorstr='#f47a20');
        vertical-align:middle;
        cursor:pointer;
        color:black;
        font-weight:bold;
        font-size:13;
        font-family:굴림; 
        align:right;
        width:100%;
        height:100%;
        margin-right:5px;
    }
    
.line1{border-bottom:1px solid red; border-top:1px solid red;}

.line2{border-bottom:1px solid red; border-top:1px solid red; border-right:1px solid red;}

.line3{border-bottom:1px solid black; border-right:1px solid black; border-top:1px solid black;}

.line4{border-bottom:1px solid black; border-top:1px solid black;}

.line5{border-bottom:1px solid black; border-right:1px solid black; border-left:1px solid black; border-top:1px solid black;}

.line6{border-bottom:1px solid black;}

	.select1 {
	    height: 22px;
	    width: 74px;
	    text-align:center;
	}
	.select2 {
	    height: 22px;
	    width: 77px;
	    text-align:center;
	}
</style>

<SCRIPT>
	
	function nameLength(obj, maxByte) { // onkeyup에서 글자 제한 바이트 단위로 계산..
	  // 자바 스크립트 함수 chkword... 이름에 들어오는 문자열의 길이, 특수문자, 공백 판별을 통해 적절히 처리
	  var strValue = obj.value; // input object에서 value를 받아 저장할 변수
	  var strLen = strValue.length; // 문자열 길이를 저장할 변수
	  var totalByte = 0; // 총 Byte를 저장할 변수
	  var len = 0;       // 특정 시점까지 저장된 문자 수를 저장할 변수
	  var oneChar = "";  // 한 글자가 임시로 저장될 변수
	  var str2 = "";     // 처리 결과를 반환할 문자열이 저장될 변수
	
	  for (var i = 0; i < strLen; i++) { // 문자열 길이만큼 반복할 for문
	      oneChar = strValue.charAt(i);  // 한 글자씩 끊어와서 oneChar에 저장
	      if (escape(oneChar).length > 4) { // escape 함수를 써서 유니코드 값을 뱉어내도록 해줌
	          totalByte += 2;               // 유니코드 값이 4 자리를 넘으면 총 바이트에 +2
	      } else {
	          totalByte++;                  // 유니코드 값이 4 이하면 총 바이트에 +1
	      }
	      // 입력한 문자 길이보다 넘치면 잘라내기 위해 저장
	      if (totalByte <= maxByte) {
	          // 처음에 지정받은 maxByte보다 작을 때 까지 문자열 자를 길이 len 을 +1 해줌.. 이렇게 함으로써 한글이 잘려 에러가 나는걸 방지가능
	          len = i + 1;
	      }
	  }

	  if (totalByte > maxByte) { // 넘어가는 글자는 자른다.
	      alert("너무 긴 이름은 사용하실 수 없습니다."); // 문자열 초과시 경고창 띄움
	      str2 = strValue.substr(0, len); // len만큼만 잘라서 넣어줌
	      obj.value = str2;               // input 오브젝트에 세팅
	  }
	}
	
	function chkNull(obj) { // 필수입력사항 null 체크
		if (obj.length != 0) {
		      return true;
		} else {
		      alert("필수 입력사항을 입력하세요.");
		}
	}
	
    function submitFunction(mode) {
        if(mode == "user_insert") {
        	console.log("user_insert");
    		if(chkNull(fm.name)&&nameLength(fm.name, 20)&&chkNull(fm.age)&&chkNull(fm.sex)&&chkNull(fm.address1)&&chkNull(fm.address2)) {
        	    fm.action = "user_insert";
    		}
        } else if (mode == "user_update") {
        	console.log("user_update");
        	if(chkNull(fm.name)&&chkNull(fm.age)&&chkNull(fm.sex)&&chkNull(fm.address1)&&chkNull(fm.address2)) {
            	fm.action = "user_update";
        	}
        } else if(mode == "phone_insert") {
        	console.log("phone_insert");
        	if(chkNull(fm.phonenumber)&&chkNull(fm.telecom)) {
            	fm.action = "phone_insert";
        	}
        } else if (mode == "phone_update") {
        	console.log("phone_update");
        	if(chkNull(fm.phonenumber)&&chkNull(fm.telecom)) {
            	fm.action = "phone_update";
        	}
        } else {
        	console.log("else");
        }
    	fm.submit();
    }
    
    function urlMaker(url, mode1, mode2) {
    	
   		if (mode1 != null) {
   			if(mode1.length != 0) {
   				url = url + "&searchusername=" + mode1;
   			}
   		}
   		
   		if (mode2 != null) {
   			if (mode2.length != 0) {
   				url = url + "&searchphonenumber=" + mode2;
   			}
   		}
   		return url;
    }
    
    function phoneListFunction(mode1, mode2, mode3) {
    	
   		var url = "user_1?idpl="+ mode1;
   		
   		url = urlMaker(url, mode2, mode3);

   		window.location = url;
    }
    
    function insertUserFunction(mode1, mode2, mode3) {
   		var url = "user_1?userinsert="+ mode1;
   		
   		url = urlMaker(url, mode2, mode3);

   		window.location = url;
    }
    
    function updateUserFunction(mode1, mode2, mode3) {
   		var url = "user_1?userup="+ mode1;
   		
   		url = urlMaker(url, mode2, mode3);

   		window.location = url;
    }
    
    function deleteUserFunction(mode1, mode2, mode3) {
       	var conf = confirm("해당 유저를 삭제하면 유저에게 등록된 모든 정보가 삭제됩니다.\n\n정말로 삭제하시겠습니까?");
    	if(conf) {
    		var url = "user_delete?userdel="+ mode1;
    		
       		url = urlMaker(url, mode2, mode3);

    		window.location = url;
    	}
    }
    
    function insertPhoneFunction(mode1, mode2, mode3, mode4) {

   		var url = "user_1?idpl="+ mode1 +"&phinsert="+ mode2;
   		
   		url = urlMaker(url, mode3, mode4);

   		window.location = url;
    }

    
    function updatePhoneFunction(mode1, mode2, mode3, mode4) {

   		var url = "user_1?idpl="+ mode1 +"&phup="+ mode2;
   		
   		url = urlMaker(url, mode3, mode4);

   		window.location = url;
    }
    

    function deletePhoneFunction(mode1, mode2, mode3, mode4) {
       	var conf = confirm("해당 핸드폰 정보를 삭제하려고 합니다.\n\n정말로 삭제하시겠습니까?");
    	if(conf) {
    		var url = "phone_delete?idpl="+ mode1 +"&phdel="+ mode2;
    		
       		url = urlMaker(url, mode3, mode4);

    		window.location = url;
    	}
    }
    
</SCRIPT>

</head>
<body>

<table width=1160>
	<tr align=center width=1150>
		<td cellspacing=2 cellpadding=2 border=1 >
			<h1><a href="user_1" style="text-decoration:none">고객 관리 프로그램</a></h1>
		</td>
	</tr>
</table>

<div style="width:1160">
<table>
<FORM METHOD="POST" name="usersearch" action="user_search">
	<tr>
		<td width=950 align=right>
			<span style="color:red"><strong>유저명 검색</strong></span>
		</td>
		<td class="line5">
			<input type=text name=searchusername value=${searchusername} >
		</td>
		<td>
			<input type=submit value="검색" class="orange">
		</td>
	</tr>
</FORM>
<FORM METHOD="POST" name="phonesearch" action="phone_search">
	<tr>
		<td width=950 align=right>
			<span style="color:red"><strong>핸드폰 검색</strong></span>
		</td>
		<td class="line5">
			<input type=text name=searchphonenumber value=${searchphonenumber} >
		</td>
		<td>
			<input type=submit value="검색" OnClick="window.location='phone_search'" class="orange">
		</td>
	</tr>
</FORM>
</table>

<FORM  METHOD="POST" name="fm">
	<input type=hidden name=searchusername value="${searchusername }"><!-- 무한루프 가능하도록... -->
	<input type=hidden name=searchphonenumber value="${searchphonenumber }">

<table style="cellspacing:1; border:0;"><!-- 유저 리스트 테이블 시작 -->
	<tr bgcolor=yellow>
		<td width=200 class="line2"><p align=center><strong><span style="color:red">사용자명</span></strong></p></td>
		<td width=80 class="line2"><p align=center><strong><span style="color:red">나이</span></strong></p></td>
		<td width=80 class="line2"><p align=center><strong><span style="color:red">성별</span></strong></p></td>
		<td width=250 class="line2"><p align=center><strong><span style="color:red">주소1</span></strong></p></td>
		<td width=400 class="line2"><p align=center><strong><span style="color:red">주소2</span></strong></p></td>
		<td width=50 class="line2"><p align=center><strong><span style="color:red">수정</span></strong></p></td>
		<td width=50 class="line2"><p align=center><strong><span style="color:red">삭제</span></strong></p></td>
		<td width=50 class="line1"><p align=center><strong><span style="color:red">핸드폰</span></strong></p></td>
	</tr>
		
	<c:forEach items="${users}" var="user"><!-- 유저 한 명의 정보 뿌리는 forEach문 시작 -->
		<!-- 사용자용 url 모음 -->
		<c:url value="user_1" var="phoneListUrl"><!-- 핸드폰 리스트 버튼에 걸어줄 url.. idpl : phoneList 가져올 파라미터 변수 -->
    		<c:param name="idpl" value="${user.id}" />
    		<c:param name="searchusername" value="${searchusername}" />
			<c:param name="searchphonenumber" value="${searchphonenumber}" />
		</c:url>
		<c:url value="user_1" var="userUpdateUrl"><!-- 사용자 수정 버튼에 걸어줄 url.. userup : 업데이트시킬 사용자 아이디를 가진 파라미터 변수 -->
    		<c:param name="userup" value="${user.id}" />
    		<c:param name="searchusername" value="${searchusername}" />
			<c:param name="searchphonenumber" value="${searchphonenumber}" />
		</c:url>

      	<tr><!-- 사용자 한 줄 씩 출력할 tr 시작 -->
			<!-- 사용자 수정 눌렀을 때 userup 변수를 파라미터로 받아서 input태그로 나오도록 choose문.. -->
			<c:choose>
				<c:when test="${userup == user.id}">
				<!-- 사용자 수정 라인 시작 -->
					<input type=hidden name=userup value="${user.id}">
					<td class="line3"><p align=center><input type=text name="name" value="${user.name }" style="text-align:center; width:195;"></p></td>
					<td class="line3"><p align=center><input type=number name="age" value="${user.age }" style="text-align:center; width:75;"></p></td>
					<td class="line3">
						<p align=center>
							<select name="sex" class=select1>
							    <option value="남" <c:if test="${user.sex eq '남'}">SELECTED</c:if>><strong>남</strong></option>
							    <option value="여" <c:if test="${user.sex eq '여'}">SELECTED</c:if>><strong>여</strong></option>
							</select>
						</p>
					</td>
					<td class="line3"><p align=left><input type=text name="address1" value="${user.address1 }" style="text-align:left; width:245;"></p></td>
					<td class="line3"><p align=left><input type=text name="address2" value="${user.address2 }" style="text-align:left; width:395;"></p></td>
					<td class="line3"><p align=center><input type=button value="등록" OnClick="submitFunction('user_update');" class="orange4"></p></td>
					<td class="line3"><p align=center><input type=button value="삭제" OnClick='deleteUserFunction(${user.id}, "${searchusername}", "${searchphonenumber}");' class="orange4"></p></td>
					<td class="line4"><p align=center><input type=button value="리스트" OnClick='phoneListFunction(${user.id}, "${searchusername}", "${searchphonenumber}");' class="orange4"></p></td>
				</c:when>
				<c:otherwise>
				<!-- 사용자 리스트 출력 라인 시작 -->
					<td class="line3"><p align=center>${user.name }</p></td>
					<td class="line3"><p align=center>${user.age }</p></td>
					<td class="line3"><p align=center>${user.sex }</p></td>
					<td class="line3"><p align=left>&emsp;${user.address1 }</p></td>
					<td class="line3"><p align=left>&emsp;${user.address2 }</p></td>
					<td class="line3"><p align=center><input type=button value="수정" OnClick='updateUserFunction(${user.id}, "${searchusername}", "${searchphonenumber}");' class="orange4"></p></td>
					<td class="line3"><p align=center><input type=button value="삭제" OnClick='deleteUserFunction(${user.id}, "${searchusername}", "${searchphonenumber}");' class="orange4"></p></td>
					<td class="line4"><p align=center><input type=button value="리스트" OnClick='phoneListFunction(${user.id}, "${searchusername}", "${searchphonenumber}");' class="orange4"></p></td>
				<!-- 사용자 리스트 출력 라인 끝 -->	
				</c:otherwise>
			</c:choose>
		</tr><!-- 사용자 한 줄 씩 출력할 tr 종료 -->
		
			<c:if test="${idpl == user.id }"><!-- 리스트 버튼을 누른 유저와 동일한 라인일 때 아래에 다음을 추가 -->
				<tr><!-- 핸드폰 리스트 테이블이 들어갈 tr 시작 -->
					<td colspan=8 style="border-bottom:1px solid black;">
						<div><!-- 핸드폰 리스트 테이블을 감싸줄 div 시작 -->
							<table cellspacing=1 border=0><!-- 핸드폰 리스트 테이블 시작 -->
								<tr>
									<c:choose>
										<c:when test="${fn:length(user.phoneList) == 0}"><!-- 핸드폰 리스트가 없으면 rowspan을 +2를 해줘야하고 그 외에는 1을 해줘야한다.-->
											<td rowspan="${fn:length(user.phoneList)+2}" width=191><p align=center><strong>☞</strong></td><!-- 핸드폰 테이블 공백부분임 -->
										</c:when>
										<c:otherwise>
											<td rowspan="${fn:length(user.phoneList)+1}" width=191><p align=center><strong>☞</strong></td><!-- 핸드폰 테이블 공백부분임 -->
										</c:otherwise>
									</c:choose>
									
									<td bgcolor=yellow width=160 class="line5"><p align=center><strong><span style="color:red">핸드폰번호</span></strong></p></td>
									<td bgcolor=yellow width=80 class="line3"><p align=center><strong><span style="color:red">통신사</span></strong></p></td>
									<td bgcolor=yellow width=50 class="line3"><p align=center><strong><span style="color:red">수정</span></strong></p></td>
									<td bgcolor=yellow width=50 class="line3"><p align=center><strong><span style="color:red">삭제</span></strong></p></td>
								<c:choose>
									<c:when test="${phinsert}"><!-- 해당 유저에게 핸드폰 추가 할 때 -->
										<!-- 여기서는 아무것도 하지 출력하지 않는다! -->
									</c:when>
									<c:otherwise><!-- 리스트를 보거나 수정하기만 할 때는 핸드폰 등록 버튼이 떠있어야 한다. -->
										<td rowspan="${fn:length(user.phoneList)+2}" valign=bottom><p align=center><input type=button value="핸드폰등록" OnClick='insertPhoneFunction(${idpl}, "true", "${searchusername}", "${searchphonenumber}");' class="orange3"></p></td>
									</c:otherwise>
								</c:choose>
								
								</tr>
								<c:forEach items="${user.phoneList}" var="phone" varStatus="status">

									<tr>
										<!-- 핸드폰 수정 눌렀을 때 phup 변수를 파라미터로 받아서 input태그로 나오도록 choose문.. -->
										<c:choose>
											<c:when test="${phup == phone.id }">
											<!-- 핸드폰 수정 라인 시작 -->
											<!--<td width=140></td>핸드폰 테이블 공백부분이었는데 윗 줄 첫 칸의 rowspan 때문에 필요없어짐 -->
												<input type=hidden name=idpl value="${user.id}">
												<input type=hidden name=phid value="${phone.id}">
												<td class="line5"><p align=center><input type=text name="phonenumber" value="${phone.phonenumber}" style="text-align:center; width:148;"></p></td>
												<td class="line3">
													<p align=center>
														<select name="telecom" class=select2>
														    <option value="KT" <c:if test="${phone.telecom eq 'KT'}">SELECTED</c:if>><strong>KT</strong></option>
														    <option value="SKT" <c:if test="${phone.telecom eq 'SKT'}">SELECTED</c:if>><strong>SKT</strong></option>
														    <option value="LGU" <c:if test="${phone.telecom eq 'LGU'}">SELECTED</c:if>><strong>LGU</strong></option>
														    <option value="알뜰폰" <c:if test="${phone.telecom eq '알뜰폰'}">SELECTED</c:if>><strong>알뜰폰</strong></option>
														</select>
													</p>
												</td>
												<td class="line3"><p align=center><input type=button value="등록" OnClick="submitFunction('phone_update');" class="orange4"></p></td>
												<td class="line3"><p align=center><input type=button value="삭제" OnClick='deletePhoneFunction(${user.id}, "${phone.id}", "${searchusername}", "${searchphonenumber}");' class="orange4"></p></td>
											<!-- 핸드폰 리스트 출력 라인 끝 -->
											</c:when>
											<c:otherwise>
												<!-- 핸드폰 리스트 출력 라인 시작 -->
											<!--<td width=140></td>핸드폰 테이블 공백부분이었는데 윗 줄 첫 칸의 rowspan 때문에 필요없어짐 -->
												<td class="line5"><p align=center>${phone.phonenumber }</p></td>
												<td class="line3"><p align=center>${phone.telecom }</p></td>
												<td class="line3"><p align=center><input type=button value="수정" OnClick='updatePhoneFunction(${user.id}, "${phone.id}", "${searchusername}", "${searchphonenumber}");' class="orange4"></p></td>
												<td class="line3"><p align=center><input type=button value="삭제" OnClick='deletePhoneFunction(${user.id}, "${phone.id}", "${searchusername}", "${searchphonenumber}");' class="orange4"></p></td>
											<!-- 핸드폰 리스트 출력 라인 끝 -->	
											</c:otherwise>
										</c:choose>
									</tr>

				 				</c:forEach>
				      			<c:if test="${fn:length(user.phoneList) == 0}"><!-- 해당 유저에게 phonelist가 없을 때 if 시작 -->
					      				<tr>
					      					<td class="line5" colspan=4><span style="color:red">&emsp;※핸드폰이 등록되지 않은 고객입니다</span></td>
					      				</tr>
								</c:if><!-- 해당 유저에게 phonelist가 없을 때 if 종료-->
								<c:if test="${phinsert}"><!-- 해당 유저에게 핸드폰을 추가할 때 -->
									<input type=hidden name=idpl value="${user.id}">
									<input type=hidden name=searchusername value="${searchusername}">
									<input type=hidden name=searchphonenumber value="${searchphonenumber}">
				      				<tr>
				      					<td width=140 border-top:1px solid red;><p align=center><span style="color:red;">핸드폰등록</span></p></td>
				      					<td class="line5"><p align=center><input type=text name="phonenumber" style="text-align:center; width:149;"></p></td>
										<td class="line3">
											<p align=center>
												<select name="telecom" class=select2>
												    <option value="KT"><strong>KT</strong></option>
												    <option value="SKT"><strong>SKT</strong></option>
												    <option value="LGU"><strong>LGU</strong></option>
												    <option value="알뜰폰"><strong>알뜰폰</strong></option>
												</select>
											</p>
										</td>
										<td class="line3"><p align=center><input type=button value="등록" OnClick="submitFunction('phone_insert');" class="orange" style="width:100%; height:100%;"></p></td>
										<td class="line3"><p align=center><input type=button value="취소" OnClick="history.back();" class="orange" style="width:100%; height:100%;"></p></td>
				      				</tr>
								</c:if><!-- 해당 유저에게 phonelist가 없을 때 if 종료-->
							</table><!-- 핸드폰 리스트 테이블 종료 -->

						</div><!-- 핸드폰 리스트 테이블을 감싸줄 div 종료 -->
					</td>
				</tr><!-- 핸드폰 리스트 테이블이 들어갈 tr 종료 -->
			</c:if><!-- 리스트 버튼을 누른 유저와 동일한 라인일 때 리스트 출력 종료 -->

	</c:forEach><!-- 유저 한 명의 정보 뿌리는 forEach문 종료 -->
									
	<tr><!-- 테이블 마지막 줄에 사용자 등록 라인 시작 -->
		<c:url value="user_1" var="userInsertUrl"><!-- 유저 등록 버튼에 걸어줄 url.. userinsert : user입력인지 판단할 파라미터 변수 -->
	   		<c:param name="userinsert" value="true" />
	   		<c:param name="searchusername" value="${searchusername}" />
			<c:param name="searchphonenumber" value="${searchphonenumber}" />
		</c:url>
		
		<!-- 유저등록버튼을 출력하거나 유저등록창을 나타낼 c:choose 태그 시작 -->
		<c:choose>
			<c:when test="${userinsert}"><!-- 유저등록버튼을 누른 상황일 때 : 테이블 마지막 줄을 input 창으로 변경 -->
				<td class="line3"><p align=center><input type=text name="name" style="text-align:center; width:190;"></p></td>
				<td class="line3"><p align=center><input type=number name="age" style="text-align:center; width:70;"></p></td>
				<td class="line3">
					<p align=center>
						<select name="sex" class=select1>
						    <option value="남">남</option>
						    <option value="여">여</option>
						</select>
					</p>
				</td>
				<td class="line3"><p align=right><input type=text name="address1" style="text-align:left; width:240;"></p></td>
				<td class="line3"><p align=right><input type=text name="address2" style="text-align:left; width:390;"></p></td>
				<td class="line3" colspan=2><p align=center><input type=button value="사용자등록완료" OnClick="submitFunction('user_insert');" class="orange4"></p></td>
				<td class="line4"><p align=center><input type=button value="취소" OnClick="history.back();" class="orange4"></p></td>
			</c:when>
			<c:otherwise><!-- 유저등록버튼을 누른 상황이 아닐 때 : colspan 때린 td 하나면 됨 -->
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td colspan=3><p align=center><input type=button value="사용자등록" OnClick='insertUserFunction(true, "${searchusername}", "${searchphonenumber}");' class="orange4"></p></td>
			</c:otherwise>
		</c:choose>
		<!-- 유저등록버튼을 출력하거나 유저등록창을 나타낼 c:choose 태그 종료 -->
		
	</tr><!-- 테이블 마지막 줄에 사용자 등록 라인 종료 -->
</table><!-- 유저 리스트 테이블 종료 -->
</FORM>
</div>

</body>
</html>