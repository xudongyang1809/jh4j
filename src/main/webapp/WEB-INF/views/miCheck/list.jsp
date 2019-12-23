<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<script>
	/*
	* 选择单个人员的回调方法
	*/
	function selectSingleUserCallback(userId, userNo, username) {
		$('#PickUserID').val(userId);
		$('#PickUser').val(username);
	}
	form.on('checkbox(checkboxInviter)', function(data) {
		if ($(data.elem).hasClass("checkAllInviter")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});
</script>
<form id="pagerForm" method="post" action="${ctx}/miCheck/list" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
	<input type="hidden" name="strApplyNo" value="${miCheck.strApplyNo}" />
	<input type="hidden" name="strSpecificUse" value="${miCheck.strSpecificUse}" />
	<input type="hidden" name="strApplyUser" value="${miCheck.strApplyUser}" />
	<input type="hidden" name="strTradingStatus" value="${miCheck.strTradingStatus}" />
	<input type="hidden" name="strAreaId" value="${miCheck.strAreaId}" />
	<input type="hidden" name="strCheckno" value="${miCheck.strCheckno}" />
	<input type="hidden" name="ihId" value="${miCheck.ihId}" />
</form>
<div class="tab-header">
	<form method="post" action="${ctx}/miCheck/list" class="layui-form" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">盘点单号</label>
				<div class="layui-input-inline">
					<input type="text" name="strCheckno" class="layui-input" value="${miCheck.strCheckno}"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">用途类别</label>
			  	<div class="layui-input-inline">
				<%--	<input type="text" name="strSpecificUse" class="layui-input" value="${miCheck.strSpecificUse}"    />--%>
					<select name="strStatus"  class="layui-input" >
						<option value="" ${miCheck.strSpecificUse eq '' ? 'selected':''}>-请选择-</option>
						<option value="1" ${miCheck.strSpecificUse eq '1' ? 'selected':''}>盘盈</option>
						<option value="2" ${miCheck.strSpecificUse eq '2' ? 'selected':''}>盘亏</option>
					</select>
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">申请人</label>
				<div class="layui-input-inline">
					<input type="hidden" id="PickUserID" name="strApplyUser"/>
					<input type="text" id="PickUser" placeholder="点击挑选人员..." readonly class="layui-input"
						   style="padding-right: 50px;"/>
					<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
					<a class="layui-btn layui-btn-sm" onPickUser="selectSingleUserCallback"
					   style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i
							class="layui-icon layui-icon-search"></i></a>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">状态</label>
				<div class="layui-input-inline">
					<select name="strTradingStatus" class="layui-input" value="${miCheck.strTradingStatus}">
						<option value="">请选择</option>
						<option value="1">新建</option>
						<option value="2"}>已盘点</option>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">盘点仓库</label>
				<div class="layui-input-inline">
					<select name="strAreaId" id="strAreaId" >
						<option value=''>请选择</option>
						<c:forEach items="${dictDtlList}" var="field">
							<option value='${field.id}'>${field.strValue}</option>
						</c:forEach>
					</select>
				</div>
			</div>
	 		<div class="layui-inline">
	    		<button class="search">查询</button>
	    	</div>
		</div>
	</form>
</div>
<div class="tab-bars">
	<shiro:hasPermission name="MiCheck:create">
   		<a class="add" width="1000" height="450" target="dialog" dialogId="createMiCheckDialog" href="${ctx}/miCheck/preCreate">添加</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MiCheck:edit">
   		<a class="edit" width="1000" height="450" target="dialog" dialogId="upadteMiCheckDialog" href="${ctx}/miCheck/preUpdate/{slt_uid}">编辑</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MiCheck:delete">
   		<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/miCheck/delete/{slt_uid}">删除</a>
   	</shiro:hasPermission>
	<a class="confirm" target="ajaxTodo" href="${ctx}/miCheck/updatestatue/{slt_uid}?flg=C" ><span>确认</span></a>
	<a class="cancelConfirm" target="ajaxTodo" href="${ctx}/miCheck/updatestatue/{slt_uid}?flg=N" ><span>取消确认</span></a>
</div>
<div class="tab-content layui-form">
	<table class="frog-table">
		<thead>
			<tr>
				<td style="width: 20px;"><input type="checkbox" lay-skin="primary" class="checkAllInviter" lay-filter="checkboxInviter" ></td>
				<th>序号</th>
				<th>盘点单号</th>
				<th>盘点仓库</th>
				<th>状态</th>
				<th>用途类别</th>
				<th>计划盘点日期</th>
				<th>申请单号</th>
				<th>申请人</th>
				<th>申请部门</th>
				<th>申请人联系方式</th>
				<th>申请日期</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="miCheck" varStatus="status">
				<tr target="slt_uid" rel="${miCheck.id}" id="${miCheck.id}">
					<td><input type="checkbox" data-value="${miCheck.id}" lay-skin="primary"  lay-filter="checkboxInviter"/></td>
				    <td>${page.pageBeginCount + status.index + 1}</td>
					<td>${miCheck.strCheckno}</td>
					<td>${miCheck.strAreaId}</td>
					<td  style="width: 10%" >${(miCheck.strTradingStatus eq '1'?"新建":(miCheck.strTradingStatus eq '2'?"已盘点":""))}</td>
					<td  style="width: 10%" >${(miCheck.strSpecificUse eq '1'?"盘盈":(miCheck.strSpecificUse eq '2'?"盘亏":""))}</td>
					<td>${miCheck.strplannedInventoryDate}</td>
					<td>${miCheck.strApplyNo}</td>
					<td>${miCheck.strApplyUser}</td>
					<td>${miCheck.strApplyDept}</td>
					<td>${miCheck.strApplyUserPhone}</td>
					<td>${miCheck.strApplyDate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
