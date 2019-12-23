<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 创建画面
	 @author ${model.createUserName?if_exists}
	 @date ${model.createTime}
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<form class="layui-form" method="post" action="${r"${ctx}"}/${model.className?uncap_first}/create" onsubmit="return dialogAjaxDone(this, 'create')">
	<div class="dialogContent" style="right: 60px;">
		<#if isHasAttach?if_exists=="1">
		<input type="hidden" name="id" value="${r"${"}id}" />
		</#if>
		<#if clist?exists>
		<#list clist as item>
		<div class="layui-form-item">
			<label class="layui-form-label">${item.getColNameCn()?if_exists}:</label>
	    	<div class="layui-input-block">
				<#if item.getColDisplayType()?if_exists=="select">
				<select id="${item.getColName()?if_exists}" name="${item.getColName()?if_exists}" style="width: ${item.getColDisplayWidth()?if_exists}px; display: ${item.getColHidden()?if_exists}"<#if item.getColValidation()?if_exists!=""> lay-verify="${item.getColValidation()?if_exists}"</#if> ${item.getColReadonly()?if_exists}>
					<option value="">请选择</option>
${item.getContentInfalte()?if_exists}
				</select>
				<#elseif item.getColDisplayType()?if_exists=="file">
				<c:import url="/WEB-INF/views/aaSystem/smCodeExample/fileUpload.jsp">
					<c:param name="relativedId" value="${r"${"}id}" />
				</c:import>
				<#elseif item.getColDisplayType()?if_exists=="img">
				<img id="${item.getColName()?if_exists}" name="${item.getColName()?if_exists}" src="${item.getDefaultValue()?if_exists}" title="${item.colNameCn?if_exists}" style="width: ${item.getColDisplayWidth()?if_exists}px;height:200px;display:${item.getColHidden()?if_exists}"/>
				<#elseif item.getColDisplayType()?if_exists=="textarea">
				<textarea id="${item.getColName()?if_exists}" name="${item.getColName()?if_exists}" placeHolder="请输入${item.getColNameCn()?if_exists}" class="layui-textarea" <#if item.getColValidation()?if_exists!="">lay-verify="${item.getColValidation()?if_exists}"</#if>${item.getColReadonly()?if_exists}>${item.getDefaultValue()?if_exists}</textarea>
				<#elseif item.getColDisplayType()?if_exists=="date">
				<input type="text" id="${item.getColName()?if_exists}" class="layui-input" name="${item.getColName()?if_exists}" value="${item.getDefaultValue()?if_exists}" class="Wdate_new" style="width: ${item.getColDisplayWidth()?if_exists}px;display:${item.getColHidden()?if_exists}" onfocus="WdatePicker()" ${item.getColReadonly()?if_exists}/>
				<#elseif item.getColDisplayType()?if_exists=="datetime">
				<input type="text" id="${item.getColName()?if_exists}" class="layui-input" name="${item.getColName()?if_exists}" value="${item.getDefaultValue()?if_exists}" class="Wdate_new" style="width: ${item.getColDisplayWidth()?if_exists}px;display:${item.getColHidden()?if_exists}" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" ${item.getColReadonly()?if_exists} />
				<#elseif item.getColDisplayType()?if_exists=="checkbox">
${item.getContentInfalte()?if_exists}
				<#elseif item.getColDisplayType()?if_exists=="radio">
${item.getContentInfalte()?if_exists}
				<#elseif item.getColDisplayType()?if_exists=="switch">
				${item.getContentInfalte()?if_exists}
				<#elseif item.getColDisplayType()?if_exists=="currency">
				<input type="text" id="${item.getColName()?if_exists}" name="${item.getColName()?if_exists}" class="layui-input" displayType='currency' originValue="${item.getDefaultValue()?if_exists}" value="${item.getDefaultValue()?if_exists}" ${item.getColValidation()?if_exists} ${item.getColReadonly()?if_exists} style="width: ${item.getColDisplayWidth()?if_exists}px;display:${item.getColHidden()?if_exists}" ${item.getColReadonly()?if_exists}  pattern="${item.getColFormat()?if_exists}"/>
				<#else>
				<input type="${item.getColDisplayType()?if_exists}" class="layui-input" name="${item.getColName()?if_exists}" placeHolder="请输入${item.getColNameCn()?if_exists}"<#if item.getDefaultValue()?if_exists!=""> value="${item.getDefaultValue()?if_exists}"</#if><#if item.getColValidation()?if_exists!=""> lay-verify="${item.getColValidation()?if_exists}"</#if>${item.getColReadonly()?if_exists} />
				</#if>
			</div>
		</div>
		</#list>
		</#if>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
