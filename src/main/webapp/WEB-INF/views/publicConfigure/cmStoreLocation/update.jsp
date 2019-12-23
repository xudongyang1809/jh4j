<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>

<form id="form" method="post" action="${ctx}/cmStoreLocation/update" onsubmit="return dialogAjaxDone(this);" class="layui-form">
	<input type="hidden" id="relativedId" name="id" value="${cmStoreLocation.id}">
	<div class="layui-form-item" style="padding-top:30px">
		<div class="layui-inline">
			<label class="layui-form-label required-input">储位编码:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strSn" value="${cmStoreLocation.strSn}" lay-verify="required" />
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label required-input">储位名称:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strName" value="${cmStoreLocation.strName}" lay-verify="required" />
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label required-input">储位分类:</label>
			<div class="layui-input-inline">				
				<select  name="storeType" id="storeType" lay-verify="required" disabled="disabled">
					<c:forEach items="${dictDtlList}" var="field" >
						<option value='${field.id}' ${cmStoreLocation.storeType eq field.id ? 'selected':'' }>${field.strValue}</option>
					</c:forEach>
				</select>
			</div>
		</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label required-input">创建时间:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="createDateTime" value="${cmStoreLocation.createDateTime }" lay-verify="required" disabled="disabled"/>
			</div>
		</div>
	</div>
	<div class="layui-form-item" style="padding-left:150px">
		<button type="submit" class="layui-btn">提交</button>
	</div>
</form>
