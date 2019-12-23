<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<style>
#createColumnDialog .layui-form-label {
	padding: 9px 10px;
	width: 90px;
}
</style>
<form method="post" action="${ctx}/smModel/create/${tabObj.id}" class="layui-form" onsubmit="return dialogAjaxDone(this, 'create', '.detailFrame');">
	<div class="dialogContent" style="right: 20px;">
		<div class="layui-form-item">
			<label class="layui-form-label">字段名称:</label>
			<div class="layui-input-inline">
				<input type="text" name="colName" class="layui-input" lay-verify="required" placeholder="请输入字段名称..." />
			</div>
			<label class="layui-form-label">字段中文名称:</label>
			<div class="layui-input-inline">
				<input type="text" name="colNameCn" class="layui-input" lay-verify="required" placeholder="请输入字段中文名称" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">是否主键:</label>
			<div class="layui-input-inline" style="width: 100px;">
		 		<input type="checkbox" name="colPrikey" lay-skin="switch" lay-text="是|否" />
			</div>
			<label class="layui-form-label">可否为空:</label>
			<div class="layui-input-inline" style="width: 100px;">
				<input type="checkbox" name="colNull" checked="checked" lay-skin="switch" lay-text="可以|不可以" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">字段类型:</label>
			<div class="layui-input-block">
				<input type="radio" name="colType" value="VARCHAR" title="VARCHAR" checked>
				<input type="radio" name="colType" value="INT" title="INT">
				<input type="radio" name="colType" value="DATE" title="DATE">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">字段长度:</label>
			<div class="layui-input-inline">
				<input type="text" name="colSize" class="layui-input" lay-verify="number" maxlength="1000" value="10"/>
			</div>
			<label class="layui-form-label">页面显示形式:</label>
			<div class="layui-input-inline">
				<select name="colDisplayType" style="width: 145px;" id="colDisplayType" lay-filter="colDisplayType">
					<option selected value="text">Text</option>
					<option value="textarea">TextArea</option>
					<option value="select">Select</option>
					<option value="checkbox">CheckBox</option>
					<option value="radio">Radio</option>
					<option value="switch">Switch【开关】</option>
					<option value="hidden">Hidden</option>
					<option value="password">PassWord</option>
					<option value="date">Date</option>
					<option value="datetime">DateTime</option>
					<option value="file">File</option>
					<option value="img">Image</option>
				</select>
			</div>
		</div>
		<div class="layui-form-item" style="display: none;" id="selectInfalteCreate">
			<label class="layui-form-label">内容填充:</label>
			<div class="layui-input-block">
				<textarea name="contentInfalte" class="layui-textarea" placeholder="请输入填充内容(格式为value1=text2;value2=text2... 或者 填写select语句，比如select value,text from ***)"></textarea>
			</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label">默认值:</label>
			<div class="layui-input-inline">
				<input type="text" name="defaultValue" class="layui-input" size="20" placeHolder="请输入默认值" maxlength=""/>
			</div>
			<label class="layui-form-label">页面显示宽度:</label>
			<div class="layui-input-inline">
				<input type="text" name="colDisplayWidth" class="layui-input" lay-verify="number" size="20" placeholder="请输入页面显示宽度" maxlength=""/>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">字段校验规则:</label>
			<div class="layui-input-inline">
				<select name="colValidation" class="layui-input">
					<option value="">请选择校验规则</option>
					<option value="required">Required【必填】</option>
					<option value="phone">Phone【手机】</option>
					<option value="email">Email【邮箱】</option>
					<option value="url">Url【网址】</option>
					<option value="number">Number【数值】</option>
					<option value="date">Date【日期】</option>
					<option value="identity">Identity【身份证】</option>
					<option value="letter">Letter【字母】</option>
					<option value="file">File【文件】</option>
				</select>
			</div>
			
			<label class="layui-form-label">作为查询条件:</label>
			<div class="layui-input-inline">
				<input id="isLookupCondition" name="isLookupCondition" type="checkbox" lay-skin="switch" lay-text="是|否" style="vertical-align: bottom;" value="Y" onclick="changeChxValue0(this)" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">是否只读:</label>
			<div class="layui-input-inline">
				<input id="colReadonly" name="colReadonly" type="checkbox" lay-skin="switch" lay-text="是|否" style="vertical-align: bottom;" value="readonly" onclick="changeChxValue(this)">
			</div>
			<label class="layui-form-label">是否隐藏:</label>
			<div class="layui-input-inline">
				<input id="colHidden" name="colHidden" type="checkbox" lay-skin="switch" lay-text="是|否" style="vertical-align: bottom;" value="none" onclick="changeChxValue(this)">
			</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label">字段描述:</label>
			<div class="layui-input-block">
				<textarea name="colDes" class="layui-textarea" placeholder="请输入字段描述"></textarea>
			</div>
		</div>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
<script>
form.on('select(colDisplayType)', function(data) {
	if (data.value == "select" || data.value == "radio" || data.value == "checkbox") {
		$('#selectInfalteCreate').show();
		$('#selectInfalteCreate').find('textarea[name="contentInfalte"]').attr("lay-verify", "required");
	} else {
		$('#selectInfalteCreate').hide();
		$('#selectInfalteCreate').find('textarea[name="contentInfalte"]').removeAttr("lay-verify");
	}
});
</script>
