<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
</head>
<body>
<form id="form" method="post" action=""  class="layui-form">
	<div class="dialogContent">
		<div class="layui-form-item" style="width: 630px">
			<label class="layui-form-label">证书上传</label>
			<div class="layui-input-block">
				<c:import url="/WEB-INF/views/publicConfigure/mcInformation/fileUpload.jsp">
					<c:param name="relativedId" value="${certByihId.strCertificateNo}" />
					<c:param name="fileNum" value="10" />
					<c:param name="ext" value="application,image" />
					<c:param name="action" value="edit" />
					<c:param name="isRequired" value="1" />
					<c:param name="fileSizeLimit" value="102400"/>
					<c:param name="fileSingleSizeLimit" value="20480" />
				</c:import>
			</div>
		</div>
	</div>
</form>

</body>
</html>