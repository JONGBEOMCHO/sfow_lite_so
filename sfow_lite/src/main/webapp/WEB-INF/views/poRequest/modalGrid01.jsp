<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="conPath" value="<%=request.getContextPath()%>"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	var contextPath = '<%= request.getContextPath() %>';
	
	const grid = new tui.Grid({
	    el: document.getElementById('grid'),
	    columns: [
	        { header: '거래처번호', 
	        	align:'center',
	        	name: 'mno' },
	        { header: '거래처코드', 
	        	align:'center',
	        	name: 'mclient_code' },
	        { header: '거래처명', 
	        	align:'center',
	        	name: 'mclient_name' }
	    ]
	});
	
	// 서버에서 데이터를 가져와서 그리드에 데이터를 설정합니다.
	function loadGridData() {
	    $.ajax({
	        url: contextPath + '/reqCCMList', // 실제 데이터를 가져올 URL을 입력해주세요.
	        method: 'GET',
	        dataType : "JSON",
	        success: function(result) {
	        	//alert("성공"+ result);
	        	//console.log("result"+result);
	        	grid.resetData(result);
	        },
	        error: function(xhr, status, errorThrown) {
	            console.log('Error occurred:', status, errorThrown);
	            alert('에러');
	        }
	    });
	}
	
	loadGridData();
	
	$('#confirmBtn').on('click', function() {
	    const selectedRow = grid.getRow(grid.getFocusedCell()["rowKey"]);
	    selectedRow.type = "CLIENT";
	    window.opener.postMessage(selectedRow, '*');
	    window.close();
	});
	
});
</script>
</head>
<body>
    <div id="grid"></div>
    <button id="confirmBtn">확인</button>
</body>
</html>