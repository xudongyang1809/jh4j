<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>

<form id="pagerForm" method="post" action="${ctx}/dcMetrology/list">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
</form>

<div class="tab-header">
	<form method="post" action="${ctx}/dcMetrology/list" class="layui-form" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
			
			<div class="layui-inline">
				<label class="layui-form-label">名称</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" name="strName" value="${dcMetrologyDM.strName}" placeholder="请输入名称"/>
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">符号</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" name="strSymbol" value="${dcMetrologyDM.strSymbol}" placeholder="请输入符号"/>
				</div>
			</div>
			
			<div class="layui-inline">
				<label class="layui-form-label">计量类别</label>
				<div class="layui-input-block">				
					<select name="dictionaryDtl.id" id="dcMetrology_groupType">
						<option value="">请选择类别</option>
						<c:forEach items="${groupTypes}" var="type">
							<option value="${type.id}" ${dcMetrologyDM.dictionaryDtl.id eq type.id ? 'selected':'' }>${type.strValue }</option>
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
	<shiro:hasPermission name="dcMetrology:create">
		<a class="add" target="dialog" width="600" height="400" dialogId="dcMetrologyCreate" href="${ctx}/dcMetrology/preCreate"><span>添加</span></a>
	</shiro:hasPermission>
	<shiro:hasPermission name="dcMetrology:edit">
		<a class="edit" target="dialog" width="600" height="400" dialogId="dcMetrologyUpdate" href="${ctx}/dcMetrology/preUpdate/{slt_uid}" ><span>编辑</span></a>
	</shiro:hasPermission>
	<shiro:hasPermission name="dcMetrology:delete">
		<a class="delete" target="ajaxTodo" href="${ctx}/dcMetrology/delete/{slt_uid}" title="确认要删除该记录吗?"><span>删除</span></a>
	</shiro:hasPermission>
</div>

<div class="tab-content">
	<table class="frog-table">
		<thead>
			<tr>
				<th>序号</th>
				<th>计量单位名称</th>
				<th>计量单位符号</th>
				<th>计量类别</th>
				<th>是否基本单位</th>
				<th>换算比例</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="dcMetrology" varStatus="status">
				<tr target="slt_uid" rel="${dcMetrology.id}" id="${dcMetrology.id}" intIsActive="${dcMetrology.intIsActive }">
					<td>${page.pageBeginCount+status.index+1}</td>
					<td>${dcMetrology.strName}</td>
					<td>${dcMetrology.strSymbol}</td>
					<td>${dcMetrology.dictionaryDtl.strValue}</td>
					<td>${dcMetrology.isBasic eq 'Y' ? '是':'否'}</td>
					<td>${dcMetrology.bdScale}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<!-- 分页 -->
<c:import url="/WEB-INF/views/pager/layuiPagerBar.jsp"></c:import>
