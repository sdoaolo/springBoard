<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>join</title>
</head>
<script type="text/javascript">
	
	$j(document).ready(function(){
		
		//�Է� ���� (name:�ѱ�/id:����,����/phone:����)
		function onlyInput(t, regexp, type){
			v = t.val();
			if (regexp.test(v)) {
                alert(type+"�� �Է°��� �մϴ�.");
                t.val(v.replace(regexp, ''));
            }
		}
		 $j("#name").keyup(function (event) {
            regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
            onlyInput( $j(this),regexp,"�ѱ�" );
            
            if ($j(this).val().length > $j(this).attr('maxlength')) { 
				alert('���ѱ��� �ʰ�'); 
				$j(this).val($j(this).val().substr(0, $j(this).attr('maxlength'))); 
			}
        });
			
		$j("#id").keyup(function(event){
			regexp = /[^a-z0-9]/gi;
			onlyInput( $j(this),regexp,"����, ����" );
			idCheckComplete = false
		});

		//���ڸ� �Է�, ��ȣ �Է� 4�ڸ��� focus �̵�
		$j('#phone-2, #phone-3').keyup(function (event) {
            regexp = /[^0-9]/gi;
            onlyInput( $j(this),regexp,"����" );
            var mch = $j(this).val().match(/[0-9]/g)
            if( mch != null && mch.length == 4 )
            {
          	  $j(this).next('input').focus();
            }
        });
		
		//postNo �ڵ� ������
		$j('input[name="userAddr1"]').keyup(function (event) {
			regexp = /[^\d-]/gi;
			var oldData = $j(this).val().replace(/[^0-9]/gi, "");
			var newData = oldData.replace(/([0-9]{3})([0-9]{3})$/,"$1-$2").replace("-", "-"); 
			$j(this).val(newData);
		});
		

		//�ǽð� pw check ���� �� �ǵ��
		$j("#pwCheck, #pw").on("change keyup paste", function(){
			var pwCheck = $j("#pwCheck").val();
			var pw = $j("#pw").val();
			if(pw != pwCheck){
				$j('#pwcheckMsg').text("��й�ȣ�� ��ġ���� �ʽ��ϴ�."); //
			}else{
				$j('#pwcheckMsg').text("��й�ȣ�� ��ġ�մϴ�.")
			}
		})		

		//input �� ��ȿ�� Ȯ��
		function checkValid(){
			
			var validChk=0;
			
			var pw = $j("#pw").val();
			var pwCheck = $j("#pwCheck").val();
			
			var phoneRegExp = /^\d{4}$/;	
			var phone2 = $j('input[name="userPhone2"]').val();
			var phone3 = $j('input[name="userPhone3"]').val();
			
			var postRegExp = /^\d{3}-\d{3}$/;
			var postNo = $j('input[name="userAddr1"]').val();
			
			//�ʼ��� üũ
			$j(".necVal").each(function(){
				if($j(this).val()== ""){
					alert($j(this).attr('id') + " : �ʼ� ���Դϴ�");
					validChk += 1;
					$j(this).focus();
				}
			});
			
			//��й�ȣ 6~12�ڸ�, ��ġ���� Ȯ�� 
			if(pw.length < 6 || pw.length > 12){
				alert("��й�ȣ�� 6~12 �ڸ� �̳��� �Է����ּ���");
				validChk += 1;
				$j("#pw").focus();
			}else if(pw != pwCheck){
				validChk += 1;
				alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
				$j("#pwCheck").focus();
			}
			
			// phone ���� üũ
			if(!phoneRegExp.test(phone2)){
				alert("phone�� 4�ڸ� ���ڷ� �Է����ּ���");
				validChk += 1;
				$j('input[name="userPhone2"]').focus();
			}else if(!phoneRegExp.test(phone3)){
				alert("phone�� 4�ڸ� ���ڷ� �Է����ּ���");
				validChk += 1;
				$j('input[name="userPhone3"]').focus();
			}
			
			//postNo ���� üũ
			if(postNo.length > 0){
				if(!postRegExp.test(postNo)) {            
	           		alert("postNo�� 6�ڸ� ���ڷ� �Է����ּ���.");
	           		validChk += 1;
	           		$j('input[name="userAddr1"]').focus();
				}
			}
			return validChk;
		}
		
		
		$j("#join").on("click",function(){
			var check = checkValid();
			if(check == 0){
				dataSubmit();
			}
		});
		
		function dataSubmit(){
			if(idCheckComplete==true){
				var $frm = $j('.userJoin :input');
				var param = $frm.serialize();
				
				$j.ajax({
				    url : "/user/userJoinAction.do",
				    dataType: "json",
				    type: "POST",
				    data : param,
				    success: function(data, textStatus, jqXHR)
				    {
						alert("ȸ������ �Ϸ�");
						
						console.log(data.success);
						
						location.href = "/board/boardList.do?";
				    },
				    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	alert("����");
				    }
				});
			}else{
				alert("���̵� �ߺ� Ȯ���� �ϼ���");
			}
		}
		
		var idCheckComplete = false;
		
		$j("#checkIdOverlap").on("click",function(){
			//���� ���̵��� �ߺ�üũ ID �ߺ� �� Ȯ�ν� ȸ������ �Ұ� alertâ / �ߺ��޼��� ���
			console.log("check Id overlap");
			
			var $frm = $j('.userJoin :input[name="userId"]');
			var param = $frm.serialize();
			
			console.log("idcheck: " ,param);
			
			if(param != "userId="){
				$j.ajax({
				    url : "/user/userCheck.do",
				    dataType: "json",
				    type: "POST",
				    data : param,
				    success: function(data, textStatus, jqXHR)
				    {
						if(data.success == "NotUnique"){
							alert("�̹� �����ϴ� ���̵� �Դϴ�.");
						}else{
							alert("��밡���� ���̵� �Դϴ�.");
							idCheckComplete = true;
						}
				    },
				    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	alert("����");
				    }
				});
			}else {
				alert("id�� �Է����ּ���");
			}	
		});	
	});

</script>
<body>
	<form class="userJoin" >
	<table align="center">
		<tr>
			<td align="left">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
		
		<tr>
			<td>
				<table id="joinTbl" border ="1"> 
					<tr>
						<td width="120" align="center">
						id
						</td>
						<td width="300">
						<input name="userId" type="text" size="15" class="necVal" id="id" maxlength="15" value="${user.userId}"> 
						<input id="checkIdOverlap" type="button" size="15" value="�ߺ�Ȯ��"> 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						pw
						</td>
						<td width="300">
						<input name="userPw" type="password" size="20"  class="necVal"  id="pw" value="${user.userPw}"> 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						pw check
						</td>
						<td width="300">
						<input name="userPwCheck" type="password"  class="necVal" id="pwCheck" size="20" > 
						<p style="color:red; font-size:5px;" id = "pwcheckMsg" ></p>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						name
						</td>
						<td width="300">
						<input name="userName" type="text" size="20"   class="necVal" id="name" value="${user.userName}" maxlength='5'> 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						phone
						</td>
						<td width="300">
							<select name="userPhone1"  class="necVal" >
								<c:forEach items="${menuList}" var="list">
									<option value=${list.menuId}> ${list.menuName} </option>
								</c:forEach>
							</select>
							-
							<input name="userPhone2" type="text" size="4" class="necVal"  id="phone-2" maxlength='4' > 
							-
							<input name="userPhone3" type="text" size="4"  class="necVal" id="phone-3" maxlength='4' > 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						postNo
						</td>
						<td width="300">
						<input name="userAddr1" type="text" size="20" maxlength='6' > 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						address
						</td>
						<td width="300">
						<input name="userAddr2" type="text" size="20"  maxlength='50' value="${user.userAddr1}"> 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						company
						</td>
						<td width="300">
						<input name="userCompany" type="text" size="20" maxlength='20' value="${user.userAddr1}"> 
						</td>
					</tr>
					
				</table>
			</td>
		</tr>
		<tr>
		<td align="right">
			<input id="join" type="button" value="Join">
		</td>
	</tr>	
	</table>
</form>
</body>
</html>




