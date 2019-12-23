<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>

<form id="form" method="post" action="${ctx}/dcMetrology/create" class="layui-form" style="margin:10px 10px;" onsubmit="return dialogAjaxDone(this);">
	<input type="hidden" id="relativedId" name="id" value="${id}">
	
	<div class="layui-form-item">
		<label class="layui-form-label required-input" style="width:120px;">计量单位名称</label>
		<div class="layui-input-block" style="margin-left:150px;">			
			<input type="text" name="strName" class="layui-input" lay-verify="required" placeholder="请输入计量单位名称"/>
		</div>
	</div>
	
	<div class="layui-form-item">
		<label class="layui-form-label" style="width:120px;">计量单位符号</label>
		<div class="layui-input-block" style="margin-left:150px;">
			<input type="text" name="strSymbol" class="layui-input" placeholder="请输入计量单位符号"/>			
		</div>
	</div>
	
	<div class="layui-form-item">
		<label class="layui-form-label" style="width:120px;">计量类别</label>
		<div class="layui-input-block" style="margin-left:150px;">			
			<select name="dictionaryDtl.id" id="dcMetrology_groupType_create">
				<c:forEach items="${groupTypes}" var="type">
					<option value="${type.id}">${type.strValue }</option>
				</c:forEach>
			</select>
		</div>
	</div>
	
	<div class="layui-form-item">
		<label class="layui-form-label required-input" style="width:120px;">换算比例</label>
		<div class="layui-input-block" style="margin-left:150px;">			
			<input type="text" name="bdScale" class="layui-input" lay-verify="required|number" placeholder="请输入换算比例"/>
		</div>
	</div>
	
	<div class="layui-form-item">
		<label class="layui-form-label" style="width:120px;">是否基本单位</label>
		<div class="layui-input-block" style="margin-left:150px;">			
			<input type="checkbox" name="isBasic" id="metro_isBasic" lay-ignore style="margin-top:15px;"/> <!-- onclick="checkMetroBaiscExist_Create(this)"/> -->
		</div>
	</div>
		
	<div class="layui-form-item" style="text-align:center;">
		<button class="layui-btn" type="submit">确定</button>
		<button class="layui-btn layui-btn-primary" type="button" onclick="closeThisDialog('dcMetrologyCreate')">关闭</button>
	</div>
</form>

<script type="text/javascript">
function closeThisDialog(dialogId){
	var index = $("#" + dialogId).parent().attr("times");
	layer.close(index);
}

/* function checkMetroBaiscExist_Create(obj) {
	var groupType = $("#dcMetrology_groupType_create").val();
	$.get("${ctx}/dcMetrology/checkExist?groupType=" + groupType + "&isBasic=Y", function(msg) {
		if (msg == 'Y' && obj.checked) {
			Dialog.warn("该类别下基本单位已存在,系统禁止该操作!");
			obj.checked = false;
		}
	})
} */
</script>