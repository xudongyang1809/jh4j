<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author 毛敏 022325
	 @date 2019-05-22 14:30:40
	 @copyRight: 江苏金恒信息科技股份有限公司
 -->
<script type="text/javascript">
	/*批量选择*/
	form.on('checkbox(checkAllMdDemandSummary)', function(data) {
		if ($(data.elem).hasClass("checkAllMdDemandSummary")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});

    /*退回*/
    function sendBackSumList(){
        debugger;
        var flg = "R";
        var ids = "";
        var btbedit = document.getElementsByName("check_HW04");
        var j=0;
        for ( var i = 0; i < btbedit.length; i++) {
            if (btbedit.item(i).checked) {
                j=j+1;
                debugger;
                var tr = btbedit.item(i).parentNode.parentNode;
                var trId1 = $(tr).attr("rel");
                if (ids == ""){
                	ids = trId1;
				} else {
                	ids += "," + trId1;
				}
            }
        }
        if (tr == null || tr == undefined) {
        	Dialog.warn("未选中一条数据");
        	return;
		}
        $.ajax({
            type:"post",
            url:"${ctx}/mdDemandM/updateSummaryStatue?ids="+ids+"&flg="+flg,
            data:"json",
            success:function (rst) {
                debugger;
                var data = JSON.parse(rst);
                if(data.statusCode == 200){
                    Dialog.success(data.message);
                    $('#summaryListId').load("${ctx}/mdDemandM/summaryList",{},function () {});
                }else {
                    Dialog.error(data.message);
                }
            }
        });
    }
	/**
	 * 生成采购计划
	 */
	function createPurchasePlan(){
		debugger;
		var btbedit = document.getElementsByName("check_HW04");
		var j = 0;
		var ids = "";
		for (var i = 0;i<btbedit.length;i++){
			if (btbedit.item(i).checked){
				debugger
				j = j + 1;
				var tr = btbedit.item(i).parentNode.parentNode;
				var id = $(tr).attr("rel");
				if(ids == ""){
					ids = id;
				}else{
					ids += "," + id;
				}
			}
		}
		if (ids == "" ) {
			Dialog.warn("未选中一条以上的数据");
			return;
		}
		$.ajax({
			type:"post",
			url:"${ctx}/mdDemandM/createPurchasePlan?ids="+ids,
			dataType:"json",
			success:function (rst) {
				if (rst.statusCode == 200){
					Dialog.success(rst.message);
					$('#summaryListId').load("${ctx}/mdDemandM/summaryList",{},function () {});
				} else{
					Dialog.error(rst.message);
				}
			}
		});
	}
</script>
<div id="summaryListId">
<form id="pagerForm" method="post" action="${ctx}/mdDemandM/balanceList" onsubmit="return navTabAjaxDone(this)">
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
	<form method="post" action="${ctx}/mdDemandM/summaryList" class="layui-form" onsubmit="return navTabSearch(this)">
		<%--<input type="hidden" id="relativedId" value="${mdDemandM.id}">--%>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">需求计划编号</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strApplyNo" class="layui-input" value="${mdDemandM.strApplyNo}"  />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">销售订单编号</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strOrderNo" class="layui-input" value="${mdDemandM.strOrderNo}"/>
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">业务类型</label>
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
					<input type="text" name="strVendorNo" class="layui-input" value="${mdDemandM.strVendorNo}"    />
			  	</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">需求计划名称</label>
			  	<div class="layui-input-inline">
					<input type="text" name="strApplyName" class="layui-input" value="${mdDemandM.strApplyName}"   />
			  	</div>
			</div>
			<%--<div class="layui-inline">
				<label class="layui-form-label" style="width:83px">状态</label>
			  	<div class="layui-input-inline">
					&lt;%&ndash;<input type="text" name="strStus" class="layui-input" value="${mdDemandM.strStus}"   style="width: px;" />&ndash;%&gt;
			  		<select name="strStus" class="layui-input" >
						<option value="" >-请选择状态-</option>
						<option value="N">新增</option>
						<option value="S">生效</option>
					</select>
				</div>
			</div>--%>
	 		<div class="layui-inline">
	    		<button class="search">查询</button>
	    	</div>
		</div>
	</form>
</div>
<div class="tab-bars">
	<shiro:hasPermission name="MdDemandM:view">
		<a class="confirm" onclick="createPurchasePlan()">生成采购计划</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="MdDemandM:view">
		<a class="sendback" onclick="sendBackSumList()">退回</a>
	</shiro:hasPermission>
</div>
<div class="tab-content layui-form">
	<table class="frog-table">
		<thead>
			<tr>
				<th><input type="checkbox" lay-skin="primary" class="checkAllMdDemandSummary" lay-filter="checkAllMdDemandSummary" ></th>
				<th>序号</th>
				<th><div style="width: 90px"></div>需求计划编号</th>
				<th><div style="width: 90px"></div>需求计划名称</th>
				<th><div style="width: 30px;"></div>销售订单编号</th>
				<th><div style="width: 30px;"></div>计划类型</th>
				<th><div style="width: 30px;"></div>计划项次</th>
				<th><div style="width: 30px;"></div>存货编号</th>
				<th><div style="width: 30px"></div>库存单位</th>
				<th><div style="width: 30px;"></div>品名</th>
				<th><div style="width: 30px;"></div>品牌</th>
				<th><div style="width: 30px;"></div>型号规格</th>

				<th><div style="width: 30px;"></div>销售单价</th>
				<th><div style="width: 30px;"></div>销售数量</th>
				<th><div style="width: 30px;"></div>计划申报数量</th>
				<th><div style="width: 30px;"></div>建议单价</th>
				<th><div style="width: 30px;"></div>平衡数量</th>
				<%--<th><div style="width: 80px;"></div>平衡接收人</th>--%>
				<th><div style="width: 55px;"></div>计划申报年月</th>
				<th><div style="width: 30px;"></div>客商编号</th>
				<th><div style="width: 30px;"></div>需求计划名称</th>
				<th><div style="width: 30px;"></div>申请部门</th>
				<th><div style="width: 30px;"></div>申请人员</th>
				<th><div style="width: 30px;"></div>申请日期</th>
				<%--<th><div style="width: 30px;"></div>状态</th>--%>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="mdDemandM" varStatus="status">
				<tr target="slt_uid" rel="${mdDemandM.id}" id="${mdDemandM.id}">
					<td><input type="checkbox" name="check_HW04" data-value="${mdDemandM.id}" lay-skin="primary"  lay-filter="checkAllMdDemandSummary"/></td>
				    <td>${page.pageBeginCount + status.index + 1}</td>
					<td width="110px">${mdDemandM.strApplyNo}</td>
					<td>${mdDemandM.strApplyName}</td>
					<td>${mdDemandM.strOrderNo}</td>
					<td>${mdDemandM.strTypeId1}</td>
					<td>${mdDemandM.strApplyItem}</td>

					<td>${mdDemandM.strMatrlNo}</td>
					<td>${mdDemandM.strUnit}</td>
					<td>${mdDemandM.strMatrlName}</td>
					<td>${mdDemandM.strBrand}</td>
					<td>${mdDemandM.strSpec}</td>

					<td>${mdDemandM.bdSalePrice}</td>
					<td>${mdDemandM.bdPlanQty}</td><%--销售数量--%>
					<td>${mdDemandM.bdApplyNumber}</td><%--计划申报数量--%>
					<td>${mdDemandM.bdPlanPrice}</td><%--建议单价--%>

					<td>${mdDemandM.bdBalanceQty}</td>
					<%--<td>${mdDemandM.strBalanceUserId}</td>--%>
					<td>${mdDemandM.strPlanYearMo}</td>
					<td>${mdDemandM.strVendorNo}</td>
					<td>${mdDemandM.strApplyName}</td>
					<td>${mdDemandM.strDept}</td>
					<td>${mdDemandM.strDemandUserIdZH}</td>
					<td>${mdDemandM.strDemandDate}</td>
					<%--<td>${mdDemandM.strSumStusZH}</td>--%>
					<input style="display: none" id="relativedId" value="${mdDemandM.id}">
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
</div>