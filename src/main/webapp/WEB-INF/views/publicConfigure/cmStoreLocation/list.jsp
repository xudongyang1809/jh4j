<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>

<script type="text/javascript">
function beforeEditStoreLocation(tr) {
	debugger;
	var intIsActive = $(tr).attr("intIsActive");
	if (intIsActive == 1) {
		Dialog.warn("该记录已启动不可编辑！");
		return false;
	} else {
		return true;
	}
}
	
</script>

<form id="pagerForm" method="post" action="${ctx}/cmStoreLocation/list">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
</form>

<div class="tab-header">
	<form action="${ctx}/cmStoreLocation/list" method="post" class="layui-form" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
		
			<div class="layui-inline">
				<label class="layui-form-label">储位编码：</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" name="strSn" value="${cmStoreLocation.strSn}" placeholder="请输入储位编码"/>
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">储位名称：</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" name="strName" value="${cmStoreLocation.strName}" placeholder="请输入储位名称"/>
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">储位分类：</label>
				<div class="layui-input-block">				
					<select name="storeType" id="cmStoreLocation_storeType">
						<option value="">请选择类别</option>
						<c:forEach items="${dictDtlList}" var="field">
							<option value="${field.id}" ${field.id eq cmStoreLocation.storeType ? 'selected':'' }>${field.strValue}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="layui-inline">
				<button class="search" >搜索</button>
			</div>
		</div>
	</form>
</div>

<div class="tab-bars">
	<shiro:hasPermission name="CmStoreLocation:create">
		<a class="add" target="dialog" width="400"  height="400" href="${ctx}/cmStoreLocation/preCreate"><span>添加</span></a></li>
	</shiro:hasPermission>
	<shiro:hasPermission name="CmStoreLocation:edit">
		<a class="edit" target="dialog" dialogId="editStoreLocationDialog" width="400"  height="400" beforeOpenCallback="beforeEditStoreLocation" href="${ctx}/cmStoreLocation/preUpdate/{slt_uid}" title="确定要修改吗？"><span>编辑</span></a>
	</shiro:hasPermission>
	<shiro:hasPermission name="CmStoreLocation:delete">
		<a class="delete" target="ajaxTodo" href="${ctx}/cmStoreLocation/delete/{slt_uid}" title="确定要删除吗？"><span>删除</span></a>
	</shiro:hasPermission>
	<shiro:hasPermission name="CmStoreLocation:delete">
		<a class="approve" target="ajaxTodo"  href="${ctx}/cmStoreLocation/active/{slt_uid}" title="确定要启用吗？"><span>启用</span></a>
	</shiro:hasPermission>
	<shiro:hasPermission name="CmStoreLocation:delete">
		<a class="cancelConfirm" target="ajaxTodo" href="${ctx}/cmStoreLocation/invalid/{slt_uid}" title="确定要禁用吗？"><span>禁用</span></a>
	</shiro:hasPermission>
	<shiro:hasPermission name="CmStoreLocation:save">
		<a class="export" target="dialog" href="${ctx}/static/excelTemplate/CmMerchantTemplete.xls" ><span>模板下载</span></a>
	</shiro:hasPermission>
</div>
<div class="tab-content">
	<table class="frog-table">
		<thead>
			<tr>
				<th>序号</th>
				<th>储位编码</th>
				<th>储位名称</th>
				<th>储位分类</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="cmStoreLocation" varStatus="status">
				<tr target="slt_uid" rel="${cmStoreLocation.id}" id="${cmStoreLocation.id}" intIsActive="${cmStoreLocation.intIsActive}" ondblclick="cmmerchantdetail(this)">
				    <td>${page.pageBeginCount+status.index+1}</td>
					<td>${cmStoreLocation.strSn}</td>
					<td>${cmStoreLocation.strName}</td>
					<td>${cmStoreLocation.storeType}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>


<!-- 分页 -->
<c:import url="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp"></c:import>

