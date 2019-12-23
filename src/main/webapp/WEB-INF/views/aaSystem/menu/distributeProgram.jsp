<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<html>
<head>
<style>
.layui-icon-choose,.layui-icon-selected {
	cursor: pointer;
	font-weight: bolder;
}

.layui-icon-choose:before {
	content: "\e626";
}

.layui-icon-choose:hover {
	color: #5FB878;
}

.layui-icon-selected {
	color: #5FB878;
}

.layui-icon-selected:before {
	content: "\e627";
}
</style>
</head>
<body>
<div>
	<div class="tab-header">
		<form class="layui-form" action="${ctx}/menu/preDistributeProgram/${fatherId}" onsubmit="return dialogSearch(this, '#selectProgram')">
			<div class="layui-form-item">
		  		<div class="layui-inline">
		    		<label class="layui-form-label">程序编号或名称</label>
		    		<div class="layui-input-inline">
		      			<input type="text" name="strSnOrName" value="${strSnOrName}" placeholder="程序名称或编号..." class="layui-input">
		    		</div>
		    	</div>
		    	<div class="layui-inline">
		    		<label class="layui-form-label">只显示自己创建的程序</label>
		    		<div class="layui-input-inline">
		      			<input type="checkbox" name="isShowMySelf" ${isShowMySelf == '1' ? 'checked' : ''} lay-skin="switch" lay-text="是|否" value="1" />
		    		</div>
		    	</div>
		    	<div class="layui-inline">
		    		<button class="search">查询</button>
		    	</div>
		  	</div>
	  	</form>
	</div>
	<form id="pagerForm" method="post" action="${ctx}/menu/preDistributeProgram/${fatherId}" onsubmit="return dialogSearch(this)">
		<input type="hidden" name="pageNum" value="${page.pageNum}" />
		<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
		<input type="hidden" name="orderField" value="${page.orderField}" />
		<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
		<input type="hidden" name="strSnOrName" value="${strSnOrName}" />
	</form>
	<div class="tab-content layui-form" style="top: 61px;">
		<table class="frog-table">
			<thead>
				<tr>
					<th style="width: 30px;">序号</th>
					<th style="width: 50px;" orderField="strSn">程序编码</th>
					<th>程序名称</th>
					<th>程序URL</th>
					<th style="width: 60px;">打开方式</th>
					<th>优先级</th>
					<th style="width: 60px;">创建人</th>
					<th>挑选</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="program" varStatus="status">
					<tr target="slt_uid" rel="${program.id}"> 
						<td title="序号">${page.pageBeginCount + status.index + 1}</td>
			   			<td title="程序编码">${program.strSn}</td>
				     	<td title="程序名称">${program.strName}</td>
				     	<td title="程序URL">${program.strUrl}</td>
				     	<td title="打开方式">${program.viewTypeName}</td>
				     	<td title="优先级">${program.intPriority}</td>
				     	<td title="创建人">${program.createUserName}</td>
				     	<td>
				     		<input type="checkbox" lay-skin="primary" lay-filter="check-program-filter" ${program.isSelected == 1 ? 'checked' : ''} />
			     		</td>
					 </tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<!-- 分页 -->
	<%@ include file="/WEB-INF/views/aaSystem/pager/dialogPagerBar.jsp" %>
</div>
</body>
<script type="text/javascript">
form.on('checkbox(check-program-filter)', function(data) {
	var loadingIndex = Dialog.load();
	var programId = $(data.elem).parents("tr:first").attr("rel");
	var fatherId = '${fatherId}';
	if (data.elem.checked) {
		$.post("${ctx}/menu/distributeProgram", {fatherId: fatherId, programId: programId}, function(msg) {
			try {
				var json = JSON.parse(msg);
				Ajax.ajaxDone(msg);
				if (json.statusCode == Ajax.statusCode.ok) {
					layer.close(loadingIndex);
				}
			} catch (e) {
				console.log(msg);
				Dialog.error(e.message);
			}
		});
	} else {
		//取消选中事件
		$.post("${ctx}/menu/removeProgram", {fatherId: fatherId, programId: programId}, function(msg) {
			try {
				var json = JSON.parse(msg);
				Ajax.ajaxDone(msg);
				if (json.statusCode == Ajax.statusCode.ok) {
					layer.close(loadingIndex);
				}
			} catch (e) {
				console.log(msg);
				Dialog.error(e.message);
			}
		})
	}
});
</script>
</html>
		
