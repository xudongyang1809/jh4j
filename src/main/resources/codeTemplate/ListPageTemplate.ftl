<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author ${model.createUserName?if_exists}
	 @date ${model.createTime}
	 @copyRight: 江苏金恒信息科技股份有限公司
 -->
<form id="pagerForm" method="post" action="${r"${ctx}"}/${model.className?uncap_first}/list" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${r"${page.pageNum}"}" />
	<input type="hidden" name="numPerPage" value="${r"${page.numPerPage}"}" /> 
	<input type="hidden" name="orderField" value="${r"${page.orderField}"}" />
	<input type="hidden" name="orderDirection" value="${r"${page.orderDirection}"}" />
	<input type="hidden" name="keywords" value="${r"${keywords}"}"/>
	<#if clist?exists> 
	<#list clist as item>
	<#if item.getIsLookupCondition()?if_exists=='Y'>
	<input type="hidden" name="${item.getColName()?if_exists}" value="${r"${"}${model.className?uncap_first}.${item.getColName()?if_exists}}" />
	</#if>
	</#list>
	</#if> 
</form>
<#if conditionlist?? && (conditionlist?size > 0)>
<div class="tab-header">
	<form method="post" action="${r"${ctx}"}/${model.className?uncap_first}/list" class="layui-form" onsubmit="return navTabSearch(this)">
		<#if conditionlist?exists> 
		<#assign x= 1>
		<div class="layui-form-item">
		<#list conditionlist as item>
			<div class="layui-inline">
				<label class="layui-form-label">${item.getColNameCn()?if_exists}</label>
			  	<div class="layui-input-inline">
				<#if item.getColDisplayType()?if_exists=='select'>
					<select name="${item.getColName()?if_exists}">
						<option value="">请选择</option>
${item.getContentInfalte()?if_exists}
					</select>
				<#elseif item.getColDisplayType()?if_exists=='radio'>
				${item.getContentInfalte()?if_exists}
				<#elseif  item.getColDisplayType()?if_exists=='text'>
					<input type="text" name="${item.getColName()?if_exists}" class="layui-input" value="${r"${"}${model.className?uncap_first}.${item.getColName()?if_exists}}"   style="width: ${item.getColDisplayWidth()?if_exists}px;" />
				</#if>
			  	</div>
			</div>
			<#assign x=x+1>
		</#list>
	 		<div class="layui-inline">
	    		<button class="search">查询</button>
	    	</div>
		</div>
		</#if>
	</form>
</div>
</#if>
<div class="tab-bars">
	<shiro:hasPermission name="${model.className}:create">
   		<a class="add" width="500" height="500" target="dialog" dialogId="create${model.className?cap_first}Dialog" href="${r"${ctx}"}/${model.className?uncap_first}/preCreate">添加</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="${model.className}:edit">
   		<a class="edit" width="500" height="500" target="dialog" dialogId="upadte${model.className?cap_first}Dialog" href="${r"${ctx}"}/${model.className?uncap_first}/preUpdate/{slt_uid}">编辑</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="${model.className}:delete">
   		<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${r"${ctx}"}/${model.className?uncap_first}/delete/{slt_uid}">删除</a>
   	</shiro:hasPermission>
</div>
<div class="tab-content">
	<#if haveLookupCondition?if_exists=='Y'>
	<table class="frog-table">
	<#else>
	<table class="frog-table">
	</#if>
		<thead>
			<tr>
				<th>序号</th>
				<#if clist?exists> 
				<#list clist as item>
				<#if item.getColDisplayType()?if_exists!='file'&&item.getColDisplayType()?if_exists!='img'&&item.getColDisplayType()?if_exists!='checkbox'>
				<th>${item.getColNameCn()?if_exists}</th>
				</#if>
				<#if item.getColDisplayType()?if_exists=='file'>
				<th>${item.getColNameCn()?if_exists}</th>
				</#if>
				</#list>
				</#if> 
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${r"${list}"}" var="${model.className?uncap_first}" varStatus="status">
				<tr target="slt_uid" rel="${r"${"}${model.className?uncap_first}.id}" id="${r"${"}${model.className?uncap_first}.id}">
				    <td>${r"${page.pageBeginCount + status.index + 1}"}</td>
					<#if clist?exists> 
					<#list clist as item>
					<#if item.getColDisplayType()?if_exists!='file'&&item.getColDisplayType()?if_exists!='img'&&item.getColDisplayType()?if_exists!='checkbox'>
					<#if item.getColDisplayType()?if_exists=='currency'>
					<td displayType='currency' pattern="${item.getColFormat()?if_exists}">${r"${"}${model.className?uncap_first}.${item.getColName()}${r"}"}</td>
					<#else>
					<td>${r"${"}${model.className?uncap_first}.${item.getColName()}${r"}"}</td>
					</#if>
					</#if>
					<#if item.getColDisplayType()?if_exists=='file'>
			     	<td id="cutstoma" align="center"><a href="${r"${ctx}"}/common/downloadFile/${r"${"}${model.className?uncap_first}.id}" target="dialog" width="800" height="400" mask=true title="文件下载">${r"${"}${model.className?uncap_first}.attachNum} </a></td>
					</#if>
					</#list>
					</#if> 
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
