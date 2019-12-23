<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author 王梦奇 022347
	 @date 2019-05-08 18:55:38
	 @copyRight: 江苏金恒信息科技股份有限公司
 -->

<script>
	// 人员回调
	function selectSingleUserCallback(userId, userNo, username) {
		$('#strApplyUserIdArrivalM').val(userId);
		$('#strApplyUserNameArrivalM').val(username);
	}

	form.on('checkbox(checkboxMpArrivalM)', function(data) {
		if ($(data.elem).hasClass("checkAllMpArrivalM")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});

    function deleteMpArrival() {
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
                $.post("${ctx}/mpArrivalM/delete",{ids:ids}, function(msg) {
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
<form id="pagerForm" method="post" action="${ctx}/mpArrivalM/list" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
	<input type="hidden" name="strInspNo" value="${mpArrivalM.strInspNo}" />
	<input type="hidden" name="strPoNo" value="${mpArrivalM.strPoNo}" />
	<input type="hidden" name="strVendorNo" value="${mpArrivalM.strVendorNo}" />
	<input type="hidden" name="strApplyUserId" value="${mpArrivalM.strApplyUserId}" />
</form>

<div class="tab-header">
	<form method="post" action="${ctx}/mpArrivalM/list" class="layui-form" onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">到货单号</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strInspNo" class="layui-input" value="${mpArrivalM.strInspNo}"  autocomplete="off" placeholder="请输入到货单号"  />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">采购合同号</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strPoNo" class="layui-input" value="${mpArrivalM.strPoNo}"  autocomplete="off" placeholder="请输入采购合同号" />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">供应商编号</label>
				<div class="layui-input-block">
					<input type="hidden"  id="strVendorNompArrivalM" name="strVendorNo"  value="${mpArrivalM.strVendorNo}" class="layui-input"  />
					<input type="text"  id="strVendorNoNamempArrivalM"  name="strVendorName" class="layui-input" value="${strVendorName}"  value=""  autocomplete="off"  placeholder="请挑选供应商" />
					<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
					<a class="layui-btn layui-btn-sm select-btn"
					   href="${ctx}/mcInfomationM/listMerchant?strVendorNo1=strVendorNompArrivalM&strVendorNoName=strVendorNoNamempArrivalM"
					   lookupGroup="org2t" target="dialog" dialogId="selectMerchantDialog"
					   rel="selectCmMerchant" title="供应商" width="800" height="480"><i class="layui-icon layui-icon-search"></i></a>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">采购承办人</label>
				<div class="layui-input-inline">
					<input type="hidden" id="strApplyUserIdArrivalM" name="strApplyUserId" value="${mpPlan.strApplyUserId}" />
					<input type="text"	 id="strApplyUserNameArrivalM" placeholder="点击挑选人员"  readonly class="layui-input" style="padding-right: 50px; width: 150px"   />
					<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
					<a class="layui-btn layui-btn-sm"   onPickUser="selectSingleUserCallback" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
				</div>
			</div>

	 		<div class="layui-inline">
	    		<button class="search">查询</button>
	    	</div>
		</div>
	</form>
</div>
<div class="tab-bars">
	<shiro:hasPermission name="MpArrivalM:create">
   		<a class="add" width="800" height="550" max="true"  target="dialog" dialogId="createMpArrivalMDialog" href="${ctx}/mpArrivalM/preCreate">添加</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MpArrivalM:edit">
   		<a class="edit" width="800" height="500"  max="true" target="dialog" dialogId="upadteMpArrivalMDialog" href="${ctx}/mpArrivalM/preUpdate/?id={slt_uid}">编辑</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MpArrivalM:delete">
   		<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/mpArrivalM/delete?ids={slt_uid}">删除</a>
        <a class="deleteList" onclick="deleteMpArrival()">批量删除</a>
   	</shiro:hasPermission>
</div>
<div class="tab-content layui-form">
	<table class="frog-table">
		<thead>
			<tr>
				<th style="width: 10px;">
					<input type="checkbox" lay-skin="primary" class="checkAllMpArrivalM" lay-filter="checkboxMpArrivalM" />
				</th>
				<th>序号</th>
				<th>到货单号</th>
				<th>采购合同号</th>
				<th>供应商编号</th>
				<th>状态</th>
				<th>备注</th>
				<th>生效人员</th>
				<th>生效日期</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="mpArrivalM" varStatus="status">
				<tr target="slt_uid" rel="${mpArrivalM.id}" id="${mpArrivalM.id}">
					<td><input type="checkbox" lay-skin="primary" lay-filter="checkboxMpArrivalM" /></td>
				    <td>${page.pageBeginCount + status.index + 1}</td>
					<td>${mpArrivalM.strInspNo}</td>
					<td>${mpArrivalM.strPoNo}</td>
					<td>${mpArrivalM.strVendorNo}</td>
					<td>
						<c:if test="${mpArrivalM.strStus eq 'S'}">生效</c:if>
						<c:if test="${mpArrivalM.strStus eq 'N'}">新增</c:if>
					</td>
					<td>${mpArrivalM.strMemova}</td>
					<td>${mpArrivalM.strCfmEmpName}</td>
					<td>${mpArrivalM.strCfmDateTime}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
