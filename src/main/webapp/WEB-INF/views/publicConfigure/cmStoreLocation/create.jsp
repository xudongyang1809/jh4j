<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form id="form" method="post" action="${ctx}/cmStoreLocation/create" onsubmit="return dialogAjaxDone(this);" class="layui-form">
	<input type="hidden" id="relativedId" name="id" value="${id}">
	<div class="layui-form-item" style="padding-top:30px">
		<div class="layui-inline">
			<label class="layui-form-label required-input">储位编码:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strSn" value="" lay-verify="required" />
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label required-input">储位名称:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strName" value="" lay-verify="required" />
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label required-input">储位分类:</label>
			<div class="layui-input-inline">				
				<select  name="storeType" id="storeType" lay-verify="required">
					<c:forEach items="${dictDtlList}" var="field" >
						<option value='${field.id}'>${field.strValue}</option>
					</c:forEach>
				</select>
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label required-input">创建时间:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="createDateTime" value="${createDateTime }" lay-verify="required" disabled="disabled"/>
			</div>
		</div>
	</div>
	<div class="layui-form-item" style="padding-left:150px">
		<button type="submit" class="layui-btn">提交</button>
	</div>
</form>
</body>
</html>