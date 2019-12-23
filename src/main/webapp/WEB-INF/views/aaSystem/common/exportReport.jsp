<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ include file="/WEB-INF/views/include.inc.jsp"%>
<html>
<head>
</head>
<body>
<div style="height: 30px; background-color: buttonshadow;">
	<a href="${ctx}/servlets/pdf" target="_blank" title="导出PDF"><img src="${ctx}/static/custom/img/pdf.png"></a>
	<a href="${ctx}/servlets/docx" title="导出Word"><img src="${ctx}/static/custom/img/word.png"></a>
	<a href="${ctx}/servlets/xls" title="导出Excel"><img src="${ctx}/static/custom/img/excel.png"></a>
	<a href="${ctx}/servlets/pptx" title="导出PPT"><img src="${ctx}/static/custom/img/ppt.png"></a>
</div>
</body>
</html>