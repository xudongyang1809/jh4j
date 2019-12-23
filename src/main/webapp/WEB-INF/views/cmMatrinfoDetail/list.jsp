<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>

<!--excel导出用-->
<form id="pagerFormExcel" method="post" action="${ctx}/cmMatrinfoDetail/listReport" onsubmit="return navTabSearch(this,'#department-list-view')">
	<input type="hidden" name="parentId" value="${cmMatrinfoDetail.parentId}" id="parentId" />
	<input type="hidden" name="cmMatrinfocontrol" value="${cmMatrinfocontrol}"/>
	<input type="hidden" name="strSn" value="${cmMatrinfoDetail.strSn}" id="strSn" />
	<input type="hidden" name="strEasyCode" value="${cmMatrinfoDetail.strEasyCode}" />
	<input type="hidden" name="strName" value="${cmMatrinfoDetail.strName}" id="strName" />
	<input type="hidden" name="strSpec" value="${cmMatrinfoDetail.strSpec}"	id="strSpec" />
	<input type="hidden" name="strBrand" value="${cmMatrinfoDetail.strBrand}" id="strBrand" />
	<input type="hidden" name="strPrickle" value="${cmMatrinfoDetail.strPrickle}"  id="strPrickle" />
	<input type="hidden" name="strSnfro" value="${strSnfro}"   id="strSnfro" />
	<input type="hidden" name="strSnto" value="${strSnto}"   id="strSnto" />
</form>

<form id="pagerForm" method="post" action="${ctx}/cmMatrinfoDetail/list" onsubmit="return navTabSearch(this, '#department-list-view')">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="parentId" value="${cmMatrinfoDetail.parentId}" />
	<input type="hidden" name="cmMatrinfocontrol" value="${cmMatrinfocontrol}"/>
	<input type="hidden" name="strSn" value="${cmMatrinfoDetail.strSn}" />
	<input type="hidden" name="strEasyCode" value="${cmMatrinfoDetail.strEasyCode}" />
	<input type="hidden" name="strName" value="${cmMatrinfoDetail.strName}" />
	<input type="hidden" name="strSpec" value="${cmMatrinfoDetail.strSpec}" />
	<input type="hidden" name="strBrand" value="${cmMatrinfoDetail.strBrand}" />
</form>

<div class="tab-header">
	<form method="post" action="${ctx}/cmMatrinfoDetail/list" class="layui-form" onsubmit="return navTabSearch(this,'#department-list-view')">
		<input type="hidden" name="parentId" value="${cmMatrinfoDetail.parentId}" />
		<input type="hidden" name="cmMatrinfocontrol" value="${cmMatrinfocontrol}" />
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">存货编码：</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="strSn" value="${cmMatrinfoDetail.strSn}" />
				</div>
			</div>
			<%--<div class="layui-inline">
				<label class="layui-form-label">南钢编码：</label>
				<div class="layui-input-inline">
					<input typpe="text" class="layui-input" name="strEasyCode" value="${cmMatrinfoDetail.strEasyCode }"/>
				</div>
			</div>--%>
			<div class="layui-inline">
				<label class="layui-form-label">存货名称：</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="strName" value="${cmMatrinfoDetail.strName}" />
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">品牌：</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="strBrand" value="${cmMatrinfoDetail.strBrand}" />
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">型号：</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="strSpec" value="${cmMatrinfoDetail.strSpec}" />
				</div>
			</div>

			<div class="layui-inline">
				<button class="search">查询</button>
			</div>

		</div>
	</form>
</div>

<c:if test="${cmMatrinfocontrol ne '1'}">
	<div class="tab-bars" id="Matrinfolis">
		<shiro:hasPermission name="CmMatrinfo:create">
			<a class="add" target="dialog" width="950" height="550" dialogId="createOperaMatrinfoDetail" href="${ctx}/cmMatrinfoDetail/preCreate/${cmMatrinfoDetail.parentId}">新增</a>
		</shiro:hasPermission>
		<shiro:hasPermission name="CmMatrinfo:edit">
			<a class="edit" target="dialog" mask="true" rel="selectUsersEdit" dialogId="updateOperaMatrinfoDetail" width="950" height="550" href="${ctx}/cmMatrinfoDetail/preUpdate/{slt_uid}"><span>编辑</span></a>
			<a class="edit" style="display: none;" target="dialog" width="950" height="500" dialogId="preMatrinfoDetail" href="">物料维护</a>
		</shiro:hasPermission>
		<shiro:hasPermission name="CmMatrinfo:delete">
			<a class="delete" target="ajaxTodo" href="${ctx}/cmMatrinfoDetail/delete/{slt_uid}" title="确认要删除该记录吗?" refreshContainer="#department-list-view"><span>删除</span></a>
		</shiro:hasPermission>
		<%--<shiro:hasPermission name="CmMatrinfo:import">
			<a class="import" style="display:none;" target="dialog" width="450" height="400" dialogId="importInfo" href="${ctx}/cmMatrinfoDetail/preImportInfo">资料导入</a>
			<!-- <a class="import" onclick="cmMatrinfoDetailFExcel()"><span>EXCEL导入</span></a> -->
			<a class="import" target="dialog" width="450" height="250" dialogId="importExcel" href="${ctx}/cmMatrinfoDetail/preExcelImport/${cmMatrinfoDetail.parentId}">EXCEL导入</a>
			<a class="import" href="${ctx}/static/excelTemplate/CmMatrinfoTemplete.xls"><span>模板下载</span></a>
		</shiro:hasPermission>--%>
		<%--<shiro:hasPermission name="CmMatrinfo:export">
			<a class="export" onclick="exportCmMatrinfo(this)"><span>资料导出</span></a>
			<a class="export" id="exportCmMatrinfo" style="display: none;" target="dialog" width="1000" height="550" href="">资料导出</a>
		</shiro:hasPermission>--%>
	</div>
</c:if>

<div class="tab-content">
	<table class="frog-table" id="cmMatrinfoDetailTable">
		<thead>
			<tr>
				<th>序号</th>
				<th>存货编码</th>
				<%--<th>南钢编码</th>--%>
				<th>存货名称</th>
				<th>品牌</th>
				<th>型号</th>
				<th>计量单位</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="cmMatrinfoDetail" varStatus="status">
				<tr target="slt_uid" rel="${cmMatrinfoDetail.id}" id="${cmMatrinfoDetail.id}" ondblclick="showCmMatrinfoDetail(this)">
					<td>${page.pageBeginCount+status.index+1}</td>
					<td>${cmMatrinfoDetail.strSn}</td>
					<<%--td>${cmMatrinfoDetail.strEasyCode}</td>--%>
					<td>${cmMatrinfoDetail.strName}</td>
					<td>${cmMatrinfoDetail.strBrand}</td>
					<td>${fn:escapeXml(cmMatrinfoDetail.strSpec)}</td>
					<td>${cmMatrinfoDetail.strPrickleZH}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<c:import url="/WEB-INF/views/pager/dialogPagerBar.jsp">
	<c:param name="container" value="#department-list-view" />
</c:import>


<script type="text/javascript">
function showCmMatrinfoDetail(obj) {
	var trId = $(obj).attr("rel");
	$('a[dialogId="preMatrinfoDetail"]').attr('href', "${ctx}/cmMatrinfoDetail/preUpdate/" + trId);
	$('a[dialogId="preMatrinfoDetail"]').click();
}

/* function operaMatrinfoDetail(obj) {
	var parentId = $("#parentId").val();
	if (parentId) {
		Dialog.warn('请选择要添加的节点目录！');
		return;
	}
	if (obj == 'add') {
		var opt = {
			width : 900,
			height : 520,
			mask : true,
			mixable : true,
			minable : true,
			resizable : true,
			drawable : true,
			fresh : true
		};
		$.pdialog.open("${ctx}/cmMatrinfoDetail/preCreate/" + parentid + "", "", "添加", opt);
	}
}

function cmMatrinfoDetailFExcel() {
	var parentid = $("#parentid").val();
	var opt2 = {
		width : 700,
		height : 400,
		mask : true,
		mixable : true,
		minable : true,
		resizable : true,
		drawable : true,
		fresh : true
	};
	$.pdialog.open("${ctx}/common/preImportExcel?dataHandler=/cmMatrinfoDetail/importExcelData?parentid%3D" + parentid + "", "cmMatrinfoDetailexcel",
					"文件导入", opt2);
} */

function exportCmMatrinfo(obj) {
	var parentId = $("#parentId").val();
	var cmMatrinfocontrol = $("#cmMatrinfocontrol").val();
	var strSn = $("#strSn").val();
	var strName = $("#strName").val();
	var strSpec = $("#strSpec").val();
	var strBrand = $("#strBrand").val();
	var strPrickle = $("#strPrickle").val();
	var strSnto = $("#strSnto").val();
	var strSnfro = $("#strSnfro").val();
	$("#exportCmMatrinfo").attr('href',
	"${ctx}/cmMatrinfoDetail/listReport?parentId=" + parentId + "&strSn=" + strSn + "&strName=" + strName
	+ "&strSpec=" + strSpec + "&strBrand=" + strBrand + "&strPrickle=" + strPrickle + "&strSnto=" + strSnto + "&strSnfro=" + strSnfro);
	$("#exportCmMatrinfo").click();
}
</script>