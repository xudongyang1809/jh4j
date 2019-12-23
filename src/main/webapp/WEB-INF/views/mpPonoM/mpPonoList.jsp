<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>

<form id="pagerForm" method="post" action="${ctx}/mpPonoM/list" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
	<input type="hidden" name="strPoNo" value="${mpPonoM.strPoNo}" />
	<input type="hidden" name="strRevision" value="${mpPonoM.strRevision}" />
	<input type="hidden" name="strVendorNo" value="${mpPonoM.strVendorNo}" />
</form>
<div class="tab-header">
	<form method="post" action="${ctx}/mpPonoM/list" class="layui-form" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">采购合同号</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strPoNo" class="layui-input" value="${mpPonoM.strPoNo}"  autocomplete="off" placeholder="请输入采购合同号"   />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">版本号</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strRevision" class="layui-input" value="${mpPonoM.strRevision}"  autocomplete="off" placeholder="请输入版本号" />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">供应商编号</label>
				<div class="layui-input-block">
					<input type="hidden"  id="strVendorNoMpPoNo" name="strVendorNo"  value="${mpPonoM.strVendorNo}" class="layui-input"  />
					<input type="text"  id="strVendorNoNameMpPoNo"  name="strVendorName" class="layui-input" value="${strVendorName}"  value=""  autocomplete="off"  placeholder="请挑选供应商" />
					<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
					<a class="layui-btn layui-btn-sm select-btn"
					   href="${ctx}/mcInfomationM/listMerchant?strVendorNo1=strVendorNoMpPoNo&strVendorNoName=strVendorNoNameMpPoNo"
					   lookupGroup="org2t" target="dialog" dialogId="selectMerchantDialog"
					   rel="selectCmMerchant" title="供应商" width="800" height="480"><i class="layui-icon layui-icon-search"></i></a>
				</div>
			</div>
	 		<div class="layui-inline">
	    		<button class="search">查询</button>
	    	</div>
		</div>
	</form>
</div>
<div class="tab-bars">
	<shiro:hasPermission name="MpPonoM:create">
   		<a class="add" max="true" target="dialog" dialogId="upadteMpPonoMDialog" href="${ctx}/mpPonoM/preCreate">添加</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MpPonoM:edit">
   		<a class="edit" width="1000" height="800" max="true" target="dialog" dialogId="upadteMpPonoMDialog" href="${ctx}/mpPonoM/preUpdate/{slt_uid}">编辑</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MpPonoM:delete">
   		<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/mpPonoM/delete?ids={slt_uid}">删除</a>
		<a class="deleteList" onclick="deleteMpPoNo()">批量删除</a>
   	</shiro:hasPermission>
</div>
<div class="tab-content layui-form">
	<table class="frog-table" style="width: 200%;max-width: 300%">
		<thead>
			<tr>
				<td style="width: 10px;">
					<input type="checkbox" lay-skin="primary" class="checkAllMpPono" lay-filter="checkboxMpPoNo" />
				</td>
				<th>序号</th>
				<th>采购合同号</th>
				<th>版本号</th>
				<th>采购合同名称</th>
				<th>状态</th>
				<th>采购合同类型</th>
				<th>开始有效日期</th>
				<th>结束有效日期</th>
				<th>供应商编号</th>
				<th>供应商名称</th>
				<th>币种</th>
				<th>税率</th>
				<th>总数量</th>
				<th>总金额</th>
				<th>运输方式</th>
				<th>采购承办人</th>
				<th>订购日期</th>
				<th>备注</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="mpPonoM" varStatus="status">
				<tr target="slt_uid" rel="${mpPonoM.id}" id="${mpPonoM.id}">
					<td><input type="checkbox" lay-skin="primary" lay-filter="checkboxMpPoNo" /></td>
				    <td>${page.pageBeginCount + status.index + 1}</td>
					<td>${mpPonoM.strPoNo}</td>
					<td>${mpPonoM.strRevision}</td>
					<td>${mpPonoM.strPoName}</td>
					<td>
						<c:if test="${mpPonoM.strStus eq 'N'}">新增</c:if>
						<c:if test="${mpPonoM.strStus eq 'S'}">生效</c:if>
						<c:if test="${mpPonoM.strStus eq 'F'}">作废</c:if>
						<c:if test="${mpPonoM.strStus eq 'D'}">删除</c:if>
					</td>
					<td>
						<c:if test="${mpPonoM.strTypeId eq 'AA'}">无</c:if>
						<c:if test="${mpPonoM.strTypeId eq 'YX'}">项目研发</c:if>
						<c:if test="${mpPonoM.strTypeId eq 'TY'}">通用</c:if>
						<c:if test="${mpPonoM.strTypeId eq 'GD'}">固定资产</c:if>
						<c:if test="${mpPonoM.strTypeId eq 'WT'}">委托加工</c:if>
						<c:if test="${mpPonoM.strTypeId eq 'ZB'}">备件经营</c:if>
						<c:if test="${mpPonoM.strTypeId eq 'LX'}">项目建设</c:if>
						<c:if test="${mpPonoM.strTypeId eq 'BG'}">办公用品</c:if>
						<c:if test="${mpPonoM.strTypeId eq 'GC'}">工程</c:if>
						<c:if test="${mpPonoM.strTypeId eq 'XT'}">系统维护</c:if>
						<c:if test="${mpPonoM.strTypeId eq 'YJ'}">硬件</c:if>
						<c:if test="${mpPonoM.strTypeId eq 'RJ'}">软件</c:if>
					</td>
					<td>${mpPonoM.strBeginDate}</td>
					<td>${mpPonoM.strEndDate}</td>
					<td>${mpPonoM.strVendorNo}</td>
					<td>${mpPonoM.strVendorName}</td>
					<td>${mpPonoM.strCurrencyId}</td>
					<td>${mpPonoM.strRate}</td>
					<td>${mpPonoM.bdTotalQty}</td>
					<td>${mpPonoM.bdTotalAmt}</td>
					<td>${mpPonoM.strTransType}</td>
					<td>${mpPonoM.strRespEmpName}</td>
					<td>${mpPonoM.strPoDate}</td>
					<td>${mpPonoM.strMemo}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
<script>


	form.on('checkbox(checkboxMpPoNo)', function(data) {
		if ($(data.elem).hasClass("checkAllMpPono")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	})


	function deleteMpPoNo() {
		debugger;
		var ids = "";
		$('.frog-table', NavTab.getCurrentPanel()).find('tbody input[type="checkbox"]').each(function () {
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
		layer.confirm("确定删除吗?", {
					btn: ['确定','取消'] //按钮
				},
				function()
				{
					$.post("${ctx}/mpPonoM/delete",{ids:ids}, function(msg) {
						try {
							var result = JSON.parse(msg);
							var messages=result.message;
							Ajax.ajaxDone(result);
							if (result.statusCode == 200) {
								NavTab.reloadWithPagination(result.navTabId);
								Dialog.success(messages);
							}
						} catch (e) {
							console.log(msg);
							Dialog.error(e.message);
						}
					});
				}, function()
				{
					layer.close();
				})
	}

</script>