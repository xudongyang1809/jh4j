<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author 毛敏 022325
	 @date 2019-05-09 08:55:40
	 @copyRight: 江苏金恒信息科技股份有限公司
 -->
<script>
	/*批量选择*/
	form.on('checkbox(checkAllMdDemandM)', function(data) {
		if ($(data.elem).hasClass("checkAllMdDemandM")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});
	/*批量删除*/
	function deleteListMdDemandM() {
	    debugger;
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
        var btbedit = document.getElementsByName("check_MdemandM");
        var trId;
		var strStatu;
        var j=0;
        for ( var i = 0; i < btbedit.length; i++) {
            if (btbedit.item(i).checked) {
                j=j+1;
                debugger;
                var tr = btbedit.item(i).parentNode.parentNode;
                trId = $(tr).attr("rel");
                strStatu = btbedit.item(i).parentNode.parentNode.cells[13].textContent;
            }
        }
		if (ids == "") {
			Dialog.warn("未选中一条以上的数据");
			return;
		}
		if(strStatu == "S"){
			Dialog.warn("生效状态下不可进行删除");
			return;
		}
		layer.confirm("确定删除吗?", {
			btn: ['确定','取消'] //按钮
		},function() {
			$.post("${ctx}/mdDemandM/delete", {ids: ids},
					function(msg) {
						try {
							var result = JSON.parse(msg);
							Ajax.ajaxDone(result);
							if (result.statusCode == 200) {
								NavTab.reloadWithPagination(result.navTabId);
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
	/*编辑*/
	function updateMdDemandMToList(){
		debugger;
		var btbedit = document.getElementsByName("check_MdemandM");
		var trId;
		var strStatu;
		var j=0;
		for ( var i = 0; i < btbedit.length; i++) {
			if (btbedit.item(i).checked) {
				j=j+1;
				debugger;
				var tr = btbedit.item(i).parentNode.parentNode;
				trId = $(tr).attr("rel");
				strStatu = btbedit.item(i).parentNode.parentNode.cells[13].textContent;
			}
		}
		if (trId == undefined) {
			Dialog.warn("未选中一条以上的数据");
			return;
		}
		$.post("${ctx}/mdDemandM/preUpdate?id="+trId+"&Status="+strStatu,"",function(content) {
			top.layer.open({
				type: 1,
				area: ['100%', '100%'],
				title: "编辑销售订单明细",
				shadeClose: true,
				offset: "0px",
				maxmin: true,
				anim: 5,
				content: content
			});
		});
	}
</script>
<div id="mdDemandMId">
<form id="pagerForm" method="post" action="${ctx}/mdDemandM/list" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
	<input type="hidden" name="strApplyNo" value="${mdDemandM.strApplyNo}" />
	<input type="hidden" name="strOrderNo" value="${mdDemandM.strOrderNo}" />
	<input type="hidden" name="strTypeId" value="${mdDemandM.strTypeId}" />
	<input type="hidden" name="strVendorNo" value="${mdDemandM.strVendorNo}" />
	<input type="hidden" name="strApplyName" value="${mdDemandM.strApplyName}" />
	<input type="hidden" name="strStus" value="${mdDemandM.strStus}" />
</form>
<div class="tab-header">
	<form method="post" action="${ctx}/mdDemandM/list" class="layui-form" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">需求计划编号</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strApplyNo" class="layui-input" value="${mdDemandM.strApplyNo}"   style="width: px;" />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">销售订单编号</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strOrderNo" class="layui-input" value="${mdDemandM.strOrderNo}"   style="width: px;" />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">计划类型</label>
			  	<div class="layui-input-inline">
			  		<select type="text" id="strTypeId" name="strTypeId" class="layui-input" value="${mdDemandM.strTypeId}" >
						<option value="" ${mdDemandM.strTypeId eq '' ? 'selected' : ''}>-请选择-</option>
						<option value="1" ${mdDemandM.strTypeId eq '1' ? 'selected' : ''}>生产型原料</option>
						<option value="2" ${mdDemandM.strTypeId eq '2' ? 'selected' : ''}>贸易型商品</option>
						<option value="3" ${mdDemandM.strTypeId eq '3' ? 'selected' : ''}>维护型备件</option>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">客商编号</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strVendorNo" class="layui-input" value="${mdDemandM.strVendorNo}"   style="width: px;" />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">需求计划名称</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strApplyName" class="layui-input" value="${mdDemandM.strApplyName}"   style="width: px;" />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label" style="width:83px">状态</label>
			  	<div class="layui-input-inline">
					<%--<input type="text" name="strStus" class="layui-input" value="${mdDemandM.strStus}"   style="width: px;" />--%>
			  		<select name="strStus" class="layui-input" >
						<option value="" ${mdDemandM.strStus eq '' ? 'selected' : ''}>-请选择状态-</option>
						<option value="N" ${mdDemandM.strStus eq 'N' ? 'selected' : ''}>新增</option>
						<option value="S" ${mdDemandM.strStus eq 'S' ? 'selected' : ''}>生效</option>
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
	<shiro:hasPermission name="MdDemandM:create">
   		<a class="add" width="1100" height="580" max="true" target="dialog" dialogId="createMdDemandMDialog" href="${ctx}/mdDemandM/preCreate">添加</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MdDemandM:edit">
   		<a class="edit" width="1100" height="580" max="true" target="dialog" dialogId="upadteMdDemandMDialog" href="${ctx}/mdDemandM/preUpdate?id={slt_uid}&Status="+${mdDemandM.strStus}>编辑</a>
		<%--<a class="edit" onclick="updateMdDemandMToList()">编辑</a>--%>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MdDemandM:delete">
		<a class="deleteList"  onclick="deleteListMdDemandM()">批量删除</a>
   	</shiro:hasPermission>
	<shiro:hasPermission name="MdDemandM:view">
		<a class="confirm" target="ajaxTodo" href="${ctx}/mdDemandM/updateStatue/{slt_uid}?flg=S" >生效</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="MdDemandM:view">
		<a class="cancelConfirm" target="ajaxTodo" href="${ctx}/mdDemandM/updateStatue/{slt_uid}?flg=N" >取消生效</a>
	</shiro:hasPermission>
</div>
<div class="tab-content layui-form">
	<table class="frog-table">
		<thead>
			<tr>
				<th><input type="checkbox" lay-skin="primary" class="checkAllMdDemandM" lay-filter="checkAllMdDemandM" ></th>
				<th>序号</th>
				<th>需求计划编号</th>
				<th>销售订单编号</th>
				<th>计划类型</th>
				<th>计划申报年月</th>
				<th>客商编号</th>
				<th>需求计划名称</th>
				<th>申请部门</th>
				<th>申请人员</th>
				<th>申请日期</th>
				<th>状态</th>
				<th>平衡接收人</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="mdDemandM" varStatus="status">
				<tr target="slt_uid" rel="${mdDemandM.id}" id="${mdDemandM.id}">
					<td><input type="checkbox" name="check_MdemandM" data-value="${mdDemandM.id}" lay-skin="primary"  lay-filter="checkAllMdDemandM"/></td>
				    <td>${page.pageBeginCount + status.index + 1}</td>
					<td>${mdDemandM.strApplyNo}</td>
					<td>${mdDemandM.strOrderNo}</td>
					<td>${mdDemandM.strTypeId1}</td>
					<td>${mdDemandM.strPlanYearMo}</td>
					<td>${mdDemandM.strVendorNo}</td>
					<td>${mdDemandM.strApplyName}</td>
					<td>${mdDemandM.strDept}</td>
					<td>${mdDemandM.strDemandUserIdZH}</td>
					<td>${mdDemandM.strDemandDate}</td>
					<td>${mdDemandM.strStatuZH}</td>
					<td>${mdDemandM.strRecipientIdZH}</td>
					<td style="display: none">${mdDemandM.strStus}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
</div>