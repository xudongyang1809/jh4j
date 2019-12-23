<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<style>
#selectUserInlineDiv i.layui-icon-close {
	position: absolute; top: 11px; right: 45px; bottom: 0px; cursor: pointer; display: none;
}

#selectUserInlineDiv:hover i.layui-icon-close {
	display: inline;
}

div[tabId="Program"] .layui-form-checkbox {
	padding-left: 0px;
}
</style>
<div class="tab-header">
	<form class="layui-form" action="${ctx}/program/list" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
	  		<div class="layui-inline">
	    		<label class="layui-form-label">模糊查询</label>
	    		<div class="layui-input-inline">
	      			<input type="text" name="strSnOrName" value="${strSnOrName}" placeholder="输入编码或名称..." class="layui-input" />
	    		</div>
	    	</div>
	    	<div class="layui-inline">
	    		<button class="search">查询</button>
	    	</div>
	  	</div>
	 </form>
</div>
<div class="tab-bars">
	<shiro:hasPermission name="Program:save">
		<a class="add" target="dialog" width="600" height="550" dialogId="createProgram" href="${ctx}/program/preCreate">新增</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="Program:edit">
		<a class="edit" target="dialog" width="600" height="550" dialogId="updateProgram" href="${ctx}/program/preUpdate/{slt_uid}">编辑</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="Program:delete">
		<a class="delete" target="ajaxTodo" title="确认要删除此数据吗?" href="${ctx}/program/delete?id={slt_uid}">删除</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="Program:deleteList">
		<a class="deleteList" onclick="deleteListProgram()">批量删除</a>
	</shiro:hasPermission>
</div>
<form id="pagerForm" method="post" action="${ctx}/program/list">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
	<input type="hidden" name="strSnOrName" value="${strSnOrName}" />
</form>
<div class="tab-content layui-form">
	<table class="frog-table">
		<thead>
			<tr>
				<td style="width: 20px;"><input type="checkbox" lay-skin="primary" class="checkAllProgram" lay-filter="checkboxProgram" /></td>
				<th style="width: 30px;">序号</th>
				<th>程序编码</th>
				<th>程序名称</th>
				<th>程序URL</th>
				<th>打开方式</th>
				<th>优先级</th>
				<th>描述</th>
				<th>创建人</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="program" varStatus="status">
				<tr target="slt_uid" rel="${program.id}"> 
					<td><input type="checkbox" lay-skin="primary" lay-filter="checkboxProgram" /></td>
					<td title="序号">${page.pageBeginCount + status.index + 1}</td>
		   			<td title="程序编码">${program.strSn}</td>
			     	<td title="程序名称">${program.strName}</td>
			     	<td title="程序URL">${program.strUrl}</td>
			     	<td title="打开方式">${program.viewTypeName}</td>
			     	<td title="优先级">${program.intPriority}</td>
			     	<td title="程序描述">${program.strDesc}</td>
			     	<td title="创建人">${program.createUserName}</td>
			     	<td title="创建时间">${program.createDateTime}</td>
				 </tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
<script>
form.on('checkbox(checkboxProgram)', function(data) {
	if ($(data.elem).hasClass("checkAllProgram")) {
		if (data.elem.checked) {
			$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
		} else {
			$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
		}
		form.render('checkbox');
	}
});

function deleteListProgram() {
	var ids = "";
	$('.frog-table', NavTab.getCurrentPanel()).find('tbody input[type="checkbox"]').each(function() {
		if ($(this).prop("checked")) {
			var id = $(this).parents('tr:first').attr("rel");
			if (ids == "") {
				ids = id;
			} else {
				ids += "," + id;
			}
		}
	});
	if (ids == "") {
		Dialog.warn("未选中一条以上的入口程序");
		return;
	}
	layer.confirm('确定批量删除选中的入口程序？', function(index) {
		var loadingIndex = Dialog.load();
		$.post("${ctx}/program/delete", {id: ids}, function(msg) {
			layer.close(index);
			try {
				var result = JSON.parse(msg);
				Ajax.ajaxDone(result);
				if (result.statusCode == 200) {
					NavTab.reloadWithPagination(result.navTabId);				
				}
			} catch (e) {
				console.log(msg);
				Dialog.error(e.message);
			} finally {
				layer.close(loadingIndex);
			}
		});
	}); 
}
</script>
