<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form id="ihform" method="post" action="${ctx}/mcInfomationM/certUpdate" onsubmit="return dialogAjaxDone(this);" class="layui-form">
	<input type="hidden" id="id" name="id" value="${certInfoById.id}">
	<%--<input type="text" id="ihId"  value="${ihId}">--%>
	<input type="hidden" id="strCertificateNo" name="strCertificateNo" value="${certInfoById.strCertificateNo}">
	<div class="dialogContent">
	<div class="layui-form-item" style="padding-top:30px">
		<div class="layui-inline">
			<label class="layui-form-label required-input">证书编码:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strCertNo" value="${certInfoById.strCertNo}" lay-verify="required" />
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label required-input">证书名称:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strCertificateName" value="${certInfoById.strCertificateName}" lay-verify="required" />
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label required-input">发证单位:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strIssueUnit" value="${certInfoById.strIssueUnit}" lay-verify="required" />
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label required-input">证书内容:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strCertificateContent" value="${certInfoById.strCertificateContent}" lay-verify="required" />
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label required-input">发证日期:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strIssueDate" id="strIssueDate" value="${certInfoById.strIssueDate}" lay-verify="required" />
			</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label required-input">有效日期:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strIssueEndDate" id="strIssueEndDate" value="${certInfoById.strIssueEndDate}" lay-verify="required" />
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-form-text" style="width: 630px">
		<label class="layui-form-label">备注:</label>
		<div class="layui-input-block">
			<textarea name="strRemarkCert" placeholder="请输入内容(字数不得超过100)" class="layui-textarea">${certInfoById.strRemarkCert}</textarea>
		</div>
	</div>
	<div class="layui-form-item" style="width: 630px">
		<label class="layui-form-label">证书上传</label>
		<div class="layui-input-block">
			<c:import url="/WEB-INF/views/publicConfigure/mcInformation/fileUpload.jsp">
				<c:param name="relativedId" value="${certInfoById.strCertificateNo}" />
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
	<div class="dialogFooter"><button type="submit" class="layui-btn" onclick="updatethis()">提交</button></div>
</form>
<script type="text/javascript">
	laydate.render({
		elem:'#strIssueDate'
	});

	laydate.render({
		elem:'#strIssueEndDate'
	});

	//保存刷新
	function updatethis(){
		var id = $("#ihId").val();
		$.ajax({
			type: "post",
			url: "${ctx}/mcInfomationM/certUpdate",
			data: $("#ihform").serialize(),
			datatype: "json",
			success: function (rst) {
				var data = JSON.parse(rst);
				var rel = data.rel;
				if (data.statusCode == 200) {
					$('#editMcInformation').load("${ctx}/mcInfomationM/preUpdateCertInfo/"+id , function () {
					});
					var dialogIndex = Dialog.getCurrentDialog().attr("times");
					if (dialogIndex) {
						layer.close(dialogIndex);
					}
					Dialog.success(data.message);
				} else {
					Dialog.error(data.message);
				}
			},
			error: function (msg) {
				Dialog.warn(msg.message);
			}
		});

	}


</script>
</body>
</html>