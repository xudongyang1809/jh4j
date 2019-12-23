<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<style>
#updateColumnDialog .layui-form-label {
	padding: 9px 10px;
	width: 90px;
}
</style>
<script type="text/javascript">
</script>
<form method="post" action="${ctx}/smModel/update" class="layui-form" onsubmit="return dialogAjaxDone(this, 'create', '.detailFrame');">
	<div class="dialogContent" style="right: 20px;">
		<input type="hidden" name="id" value="${sqlColumn.id}" />
		<div class="layui-form-item">
			<label class="layui-form-label">字段名称:</label>
			<div class="layui-input-inline">
				<input type="text" name="colName" value="${sqlColumn.colName}" class="layui-input" required="required" placeholder="请输入字段名称..." />
			</div>
			<label class="layui-form-label">字段中文名称:</label>
			<div class="layui-input-inline">
				<input type="text" name="colNameCn" value="${sqlColumn.colNameCn}" class="layui-input" placeholder="请输入字段中文名称" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">是否主键:</label>
			<div class="layui-input-inline" style="width: 100px;">
		 		<input type="checkbox" name="colPrikey" ${sqlColumn.colPrikey eq 1 ? 'checked' : ''} lay-skin="switch" lay-text="是|否" />
			</div>
			<label class="layui-form-label">可否为空:</label>
			<div class="layui-input-inline" style="width: 100px;">
				<input type="checkbox" name="colNull" ${sqlColumn.colNull eq 'YES'? 'checked':''} lay-skin="switch" lay-text="可以|不可以" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">字段类型:</label>
			<div class="layui-input-block">
				<input type="radio" name="colType" value="VARCHAR" title="VARCHAR" ${sqlColumn.colType eq 'VARCHAR' ? 'checked' : ''}>
				<input type="radio" name="colType" value="INT" title="INT" ${sqlColumn.colType eq 'INT' ? 'checked' : ''}>
				<input type="radio" name="colType" value="DATE" title="DATE"  ${sqlColumn.colType eq 'DATE' ? 'checked' : ''}>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">字段长度:</label>
			<div class="layui-input-inline">
				<input type="text" name="colSize" class="layui-input" value="${sqlColumn.colSize}" maxlength="1000" value="10"/>
			</div>
			<label class="layui-form-label">页面显示形式:</label>
			<div class="layui-input-inline">
				<select name="colDisplayType" lay-filter="colDisplayType" style="width: 145px;" id="colDisplayType">
					<option value="text" ${sqlColumn.colDisplayType eq 'text' ? 'selected' : ''}>Text</option>
					<option value="textarea" ${sqlColumn.colDisplayType eq 'textarea' ? 'selected' : ''}>TextArea</option>
					<option value="select" ${sqlColumn.colDisplayType eq 'select' ? 'selected' : ''}>Select</option>
					<option value="checkbox" ${sqlColumn.colDisplayType eq 'checkbox' ? 'selected' : ''}>CheckBox</option>
					<option value="radio" ${sqlColumn.colDisplayType eq 'radio' ? 'selected' : ''}>Radio</option>
					<option value="switch" ${sqlColumn.colDisplayType eq 'switch' ? 'selected' : ''}>Switch【开关】</option>
					<option value="hidden" ${sqlColumn.colDisplayType eq 'hidden' ? 'selected' : ''}>Hidden</option>
					<option value="password" ${sqlColumn.colDisplayType eq 'password' ? 'selected' : ''}>PassWord</option>
					<option value="date" ${sqlColumn.colDisplayType eq 'date' ? 'selected' : ''}>Date</option>
					<option value="datetime" ${sqlColumn.colDisplayType eq 'datetime' ? 'selected' : ''}>DateTime</option>
					<option value="file" ${sqlColumn.colDisplayType eq 'file' ? 'selected' : ''}>File</option>
					<option value="img" ${sqlColumn.colDisplayType eq 'img' ? 'selected' : ''}>Image</option>
				</select>
			</div>
		</div>
		<div class="layui-form-item" style="${(sqlColumn.colDisplayType eq 'select' or sqlColumn.colDisplayType eq 'radio' or sqlColumn.colDisplayType eq 'checkbox') ? '' : 'display: none;'}" id="selectInfalteCreate">
			<label class="layui-form-label">内容填充:</label>
			<div class="layui-input-block">
				<textarea name="contentInfalte" class="layui-textarea" placeholder="请输入填充内容(格式为value1=text2;value2=text2... 或者 填写select语句，比如select value,text from ***)" ${(sqlColumn.colDisplayType eq 'select' or sqlColumn.colDisplayType eq 'radio' or sqlColumn.colDisplayType eq 'checkbox') ? 'lay-verify="required"' : ''}>${sqlColumn.contentInfalte}</textarea>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">默认值:</label>
			<div class="layui-input-inline">
				<input type="text" name="defaultValue" class="layui-input" size="20" value="${sqlColumn.defaultValue}" placeHolder="请输入默认值" maxlength=""/>
			</div>
			<label class="layui-form-label">页面显示宽度:</label>
			<div class="layui-input-inline">
				<input type="text" name="colDisplayWidth" class="layui-input" size="20" value="${sqlColumn.colDisplayWidth}" placeholder="请输入页面显示宽度" maxlength=""/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">字段校验规则:</label>
			<div class="layui-input-inline">
				<select name="colValidation" class="layui-input">
					<option value="">请选择校验规则</option>
					<option value="required" ${sqlColumn.colValidation eq 'required' ? 'selected' : ''}>Required【必填】</option>
					<option value="phone" ${sqlColumn.colValidation eq 'phone' ? 'selected' : ''}>Phone【手机】</option>
					<option value="email" ${sqlColumn.colValidation eq 'email' ? 'selected' : ''}>Email【邮箱】</option>
					<option value="url" ${sqlColumn.colValidation eq 'url' ? 'selected' : ''}>Url【网址】</option>
					<option value="number" ${sqlColumn.colValidation eq 'number' ? 'selected' : ''}>Number【数值】</option>
					<option value="date" ${sqlColumn.colValidation eq 'date' ? 'selected' : ''}>Date【日期】</option>
					<option value="identity" ${sqlColumn.colValidation eq 'identity' ? 'selected' : ''}>Identity【身份证】</option>
					<option value="letter" ${sqlColumn.colValidation eq 'letter' ? 'selected' : ''}>Letter【字母】</option>
					<option value="file" ${sqlColumn.colValidation eq 'file' ? 'selected' : ''}>File【文件】</option>
				</select>
			</div>
			<label class="layui-form-label">作为查询条件:</label>
			<div class="layui-input-inline">
				<input id="isLookupCondition" name="isLookupCondition" ${sqlColumn.isLookupCondition eq 'Y' ? 'checked' : ''} type="checkbox" value="Y" lay-skin="switch" lay-text="是|否" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">是否只读:</label>
			<div class="layui-input-inline">
				<input id="colReadonly" name="colReadonly" type="checkbox" ${sqlColumn.colReadonly eq 'readonly' ? 'checked' : ''} lay-skin="switch" value="readonly" lay-text="是|否" />
			</div>
			<label class="layui-form-label">是否隐藏:</label>
			<div class="layui-input-inline">
				<input id="colHidden" name="colHidden" type="checkbox" ${sqlColumn.colHidden eq 'none' ? 'checked' : ''} lay-skin="switch" lay-text="是|否" value="none" />
			</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label">字段描述:</label>
			<div class="layui-input-block">
				<textarea name="colDes" class="layui-textarea" placeholder="请输入字段描述">${sqlColumn.colDes}</textarea>
			</div>
		</div>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
<script>
form.on('select(colDisplayType)', function(data){
	if (data.value == "select" || data.value == "radio" || data.value == "checkbox") {
		$('#selectInfalteCreate').show();
		$('#selectInfalteCreate').find('textarea[name="contentInfalte"]').attr("lay-verify", "required");
	} else {
		$('#selectInfalteCreate').hide();
		$('#selectInfalteCreate').find('textarea[name="contentInfalte"]').removeAttr("lay-verify");
	}
});
</script>

