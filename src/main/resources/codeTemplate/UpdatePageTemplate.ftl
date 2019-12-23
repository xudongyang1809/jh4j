<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 编辑画面
	 @author ${model.createUserName?if_exists}
	 @date ${model.createTime}
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<head>
<script type="text/javascript">
<#if clist?exists>
<#list clist as item>
<#if item.getColDisplayType()?if_exists=="checkbox">
var chx = '${r"${"}${model.className?uncap_first}.${item.getColName()?if_exists}}';
var arr = chx.split(",");
for(var i = 0; i < arr.length; i++) {
	$(":checkbox[value='"+arr[i]+"']").attr("checked", "checked");
}
</#if>
</#list>
</#if>
</script>
</head>
<form class="layui-form" method="post" action="${r"${ctx}"}/${model.className?uncap_first}/update" onsubmit="return dialogAjaxDone(this, 'update')">
	<div class="dialogContent" style="right: 60px;">
		<input type="hidden" id="relativedId" name="id" value="${r"${"}${model.className?uncap_first}.id}">
		<#if clist?exists> 
		<#list clist as item>
		<div class="layui-form-item">
			<label class="layui-form-label">${item.getColNameCn()?if_exists}:</label>
			<#if item.getColDisplayType()?if_exists=="textarea"||item.getColDisplayType()?if_exists=="file">
			<div class="layui-input-block">
			<#else>
			<div class="layui-input-block">
			</#if>
			<#if item.getColDisplayType()?if_exists=="select">
				<select id="${item.getColName()?if_exists}" name="${item.getColName()?if_exists}" style="width: ${item.getColDisplayWidth()?if_exists}px;display:${item.getColHidden()?if_exists}"<#if item.getColValidation()?if_exists!=""> lay-verify="${item.getColValidation()?if_exists}"</#if> ${item.getColReadonly()?if_exists}>
					<option value="">请选择</option>
${item.getContentInfalte()?if_exists}
				</select>
				<#elseif item.getColDisplayType()?if_exists=="file">
				<c:import url="/WEB-INF/views/aaSystem/smCodeExample/fileUpload.jsp">
					<c:param name="relativedId" value="${r"${"}${model.className?uncap_first}.id}" />
				</c:import>
				<#elseif item.getColDisplayType()?if_exists=="img">
				<img id="${item.getColName()?if_exists}" name="${item.getColName()?if_exists}" src="${item.getDefaultValue()?if_exists}" title="${item.colNameCn?if_exists}" style="width: ${item.getColDisplayWidth()?if_exists}px;height:200px;display:${item.getColHidden()?if_exists}"/>
				<#elseif item.getColDisplayType()?if_exists=="textarea">
				<textarea id="${item.getColName()?if_exists}" name="${item.getColName()?if_exists}" placeHolder="请输入${item.getColNameCn()?if_exists}" class="layui-textarea"<#if item.getColValidation()?if_exists!=""> lay-verify="${item.getColValidation()?if_exists}"</#if> ${item.getColReadonly()?if_exists}>${r"${"}${model.className?uncap_first}.${item.getColName()?if_exists}}</textarea>
				<#elseif item.getColDisplayType()?if_exists=="date">
				<input type="text" id="${item.getColName()?if_exists}" class="layui-input" name="${item.getColName()?if_exists}" value="${r"${"}${model.className?uncap_first}.${item.getColName()?if_exists}}" class="Wdate_new ${item.getColReadonly()?if_exists}" style="width: ${item.getColDisplayWidth()?if_exists}px;display:${item.getColHidden()?if_exists}" onfocus="WdatePicker()" ${item.getColReadonly()?if_exists}/>
				<#elseif item.getColDisplayType()?if_exists=="datetime">
				<input type="text" id="${item.getColName()?if_exists}" class="layui-input" name="${item.getColName()?if_exists}" value="${r"${"}${model.className?uncap_first}.${item.getColName()?if_exists}}" class="Wdate_new ${item.getColReadonly()?if_exists}" style="width: ${item.getColDisplayWidth()?if_exists}px;display:${item.getColHidden()?if_exists}" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" ${item.getColReadonly()?if_exists}/>
				<#elseif item.getColDisplayType()?if_exists=="checkbox">
${item.getContentInfalte()?if_exists}
				<#elseif item.getColDisplayType()?if_exists=="radio">
${item.getContentInfalte()?if_exists}
				<#elseif item.getColDisplayType()?if_exists=="switch">
				${item.getContentInfalte()?if_exists}
				<#else>
				<#if item.getColDisplayType()?if_exists=="button"||item.getColDisplayType()?if_exists=="reset"||item.getColDisplayType()?if_exists=="submit">
				<input type="${item.getColDisplayType()?if_exists}" id="${item.getColName()?if_exists}" name="${item.getColName()?if_exists}" value="${item.getDefaultValue()?if_exists}" class="${item.getColValidation()?if_exists}  ${item.getColReadonly()?if_exists}" style="width: ${item.getColDisplayWidth()?if_exists}px;display:${item.getColHidden()?if_exists}" ${item.getColReadonly()?if_exists}/>
				<#elseif item.getColDisplayType()?if_exists=="currency">
				<input type="text" id="${item.getColName()?if_exists}" name="${item.getColName()?if_exists}" displayType="currency" class="form-control" originValue="${r"${"}${model.className?uncap_first}.${item.getColName()?if_exists}}" value="${r"${"}${model.className?uncap_first}.${item.getColName()?if_exists}}" class="${item.getColValidation()?if_exists}  ${item.getColReadonly()?if_exists}" style="width: ${item.getColDisplayWidth()?if_exists}px;display:${item.getColHidden()?if_exists}" ${item.getColReadonly()?if_exists}  pattern="${item.getColFormat()?if_exists}"/>
				<#else>
				<input type="${item.getColDisplayType()?if_exists}" name="${item.getColName()?if_exists}" class="layui-input" placeHolder="请输入${item.getColNameCn()?if_exists}" value="${r"${"}${model.className?uncap_first}.${item.getColName()?if_exists}}"<#if item.getColValidation()?if_exists!=""> lay-verify="${item.getColValidation()?if_exists}"</#if> ${item.getColReadonly()?if_exists}/>
				</#if>
			</#if>
			</div>
		</div>
		</#list>
		</#if>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
