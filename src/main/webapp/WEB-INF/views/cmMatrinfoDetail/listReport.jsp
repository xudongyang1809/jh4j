<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="/WEB-INF/views/include.inc.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="tab-bars">
	<c:import url="/WEB-INF/views/common/exportReport.jsp"></c:import>
</div>

<div class="tab-content" id="viewReportDiv" 
	url="${ctx}/cmMatrinfoDetail/listReportContent?parentId=${cmMatrinfoDetail.parentId}&strSn=${cmMatrinfoDetail.strSn}&strName=${cmMatrinfoDetail.strName}&strSpec=${cmMatrinfoDetail.strSpec}&strBrand=${cmMatrinfoDetail.strBrand}&strPrickle=${cmMatrinfoDetail.strPrickle}&strSnto=${strSnto}&strSnfro=${strSnfro}">
</div>
</body>
</html>


<script type="text/javascript">
$(function(){
	var id = '${id}';
	$('#viewReportDiv').load($("#viewReportDiv").attr('url'), function() {
		//$('#preSaleDiv').attr("url", url);
		form.render();
	});
})
</script>