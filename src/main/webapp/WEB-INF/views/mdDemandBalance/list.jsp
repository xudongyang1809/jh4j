<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author 毛敏 022325
	 @date 2019-05-22 14:30:40
	 @copyRight: 江苏金恒信息科技股份有限公司
 -->
<script type="text/javascript">
	/*确认分配*/
	function confirmDistribute() {
		debugger;
		var ids = "";
		$('.frog-table', NavTab.getCurrentPanel()).find('tbody input[type="checkbox"]').each(function() {
			if ($(this).prop("checked")) {
				var id = $(this).parents('tr:first').attr("rel");
				if (ids == "") {
					ids = id;
				}else{
					ids += "," + id;
				}
			}
		});
		if (!ids) {
			Dialog.warn("未选中一条数据");
			return false;
		}
		var userNo = $('#userId1_strBalanceUserId').val();
		var username1_strBalanceUserId = $('#username1_strBalanceUserId').val();
		if (!username1_strBalanceUserId) {
			top.layer.msg("请挑选采购部门接收人",{icon:2});
			return false;
		}
		var strMatrlNo = $('#strMatrlNo').val();
		var strTypeId = $('#strTypeId001').val();
			$.ajax({
				type:"post",
				url:"${ctx}/mdDemandM/confirmDistribute?ids="+ids+"&strBalanceUserId="+userNo+"&strMatrlNo="+strMatrlNo+"&strTypeId="+strTypeId,
				datatype:"json",
				success:function (rst) {
					debugger;
					var data = JSON.parse(rst);
					if(data.statusCode == 200){
						Dialog.success(data.message);
						$('#balanceListId').load("${ctx}/mdDemandM/balanceList",{},function () {});
					}else {
						Dialog.error(data.message);
					}
				},
				error:function () {
					Dialog.warn(warn.message);
				}
			});

	}
    /*退回*/
	function sendBackBalanceList(){
		debugger;
        var flg = "R";
        var ids = "";
		var btbedit = document.getElementsByName("check_HW03");
		var j=0;
		for ( var i = 0; i < btbedit.length; i++) {
			if (btbedit.item(i).checked) {
				j=j+1;
				debugger;
				var tr = btbedit.item(i).parentNode.parentNode;
				var trId = $(tr).attr("rel");
				//alert(trId);
				if (ids == ""){
					ids = trId;
				} else{
					ids += "," + trId;
				}
			}
		}
		$.ajax({
			type:"post",
			url:"${ctx}/mdDemandM/updateBalanceStatue?ids="+ids+"&flg="+flg,
			data:"json",
			success:function (rst) {
				debugger;
				var data = JSON.parse(rst);
				if(data.statusCode == 200){
					Dialog.success(data.message);
					$('#balanceListId').load("${ctx}/mdDemandM/balanceList",{},function () {});
				}else {
					Dialog.error(data.message);
				}
			},
			error:function () {
				Dialog.warn(warn.message);
			}
		});
	}
	/*选择申请人员的回调方法*/
	function selectStrBalanceUserId(userId, userNo, username) {
		$('#userId1_strBalanceUserId').val(userId);
		$('#userNo1_strBalanceUserId').val(userNo);
		$('#username1_strBalanceUserId').val(username);
	}
	/*需采购*/
	function toPurchase(){
		debugger;
		var trId;
		var bdBalanceQty;
		var strBalanceUserId;
		var ids = "";
		var j = 0;
		var btbedit = document.getElementsByName("check_HW03");
		for (var i = 0;i<btbedit.length;i++){
			if (btbedit.item(i).checked) {
				j = j + 1;
				debugger;
				var tr = btbedit.item(i).parentNode.parentNode;
				trId = $(tr).attr("rel");
				bdBalanceQty = btbedit.item(i).parentNode.parentNode.cells[18].childNodes[0].value;
				strBalanceUserId = btbedit.item(i).parentNode.parentNode.cells[19].childNodes[0];
				if (ids == "") {
					ids = trId;
				}else{
					ids += "," + trId;
				}
			}
		}
		if (trId == undefined || trId == ""){
			Dialog.warn("未选中一条数据");
			return;
		}
		if (bdBalanceQty == undefined || bdBalanceQty == "" || bdBalanceQty == 0.000000){
			Dialog.warn("请输入平衡数量并保存");
			return;
		}
		if (strBalanceUserId == undefined || strBalanceUserId == ""){
			Dialog.warn("请分配采购部门接收人");
			return;
		}
		flg = "Y";
		$.ajax({
			type:"post",
			url:"${ctx}/mdDemandM/updateBalanceStatueToPurchase?ids="+ids+"&flg="+flg,
			dataType:"json",
			success:function (rst) {
				if (rst.statusCode == 200){
					Dialog.success(rst.message);
					$('#balanceListId').load("${ctx}/mdDemandM/balanceList",{},function () {});
				} else{
					Dialog.error(rst.message);
				}
			}
		});
	}
	/*无需采购*/
	function noPurchase(){
		debugger;
		var trId;
		var ids = "";
		var j = 0;
		var btbedit = document.getElementsByName("check_HW03");
		for (var i = 0;i<btbedit.length;i++){
			if (btbedit.item(i).checked) {
				j = j + 1;
				debugger;
				var tr = btbedit.item(i).parentNode.parentNode;
				trId = $(tr).attr("rel");
				if (ids == "") {
					ids = trId;
				}else{
					ids += "," + trId;
				}
			}
		}
		if (trId == undefined || trId == ""){
			Dialog.warn("未选中一条数据");
			return;
		}
		flg = "N";
		$.ajax({
			type:"post",
			url:"${ctx}/mdDemandM/updateBalanceStatueToPurchase?ids="+ids+"&flg="+flg,
			dataType:"json",
			success:function (rst) {
				if (rst.statusCode == 200){
					Dialog.success(rst.message);
					$('#balanceListId').load("${ctx}/mdDemandM/balanceList",{},function () {});
				} else{
					Dialog.error(rst.message);
				}
			}
		});
	}
	/*批量选择*/
	form.on('checkbox(checkAllMdDemandD)', function(data) {
		if ($(data.elem).hasClass("checkAllMdDemandD")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});

	form.render();
</script>
<div id="balanceListId">
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
	<form method="post" action="${ctx}/mdDemandM/balanceList" class="layui-form" onsubmit="return navTabSearch(this)">
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
			  		<select name="strBalanceStus" class="layui-input" >
						<option value="" ${mdDemandM.strBalanceStus eq '' ? 'selected' : ''}>-请选择状态-</option>
						<option value="Y" ${mdDemandM.strBalanceStus eq 'Y' ? 'selected' : ''}>需采购</option>
						<option value="N" ${mdDemandM.strBalanceStus eq 'N' ? 'selected' : ''}>无需采购</option>
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
	<div class="layui-input-inline">
		<input type="hidden" id="userId1_strBalanceUserId" name="strBalanceUserId" />
		<input type="hidden" id="userNo1_strBalanceUserId" />
		<input type="text" id="username1_strBalanceUserId" placeholder="请挑选采购部门接收人" readonly class="layui-input" style="padding-right: 5px;padding-bottom: 5px" />
		<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
		<a class="layui-btn layui-btn-sm" onPickUser="selectStrBalanceUserId" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
	</div>
	<shiro:hasPermission name="MdDemandM:view">
		<a class="confirm" onclick="confirmDistribute()">确认分配</a>
	</shiro:hasPermission>
    <shiro:hasPermission name="MdDemandM:create">
        <a class="add" onclick="saveQty()">保存</a>
    </shiro:hasPermission>
	<shiro:hasPermission name="MdDemandM:delete">
		<%--<a class="approve"  target="ajaxTodo" href="${ctx}/mdDemandM/updateBalanceStatueToPurchase/{slt_uid}?flg=Y">需采购</a>--%>
		<a class="approve" onclick="toPurchase()">需采购</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="MdDemandM:view">
		<%--<a class="view" target="ajaxTodo" href="${ctx}/mdDemandM/updateBalanceStatueToPurchase?id={slt_uid}?flg=N" >无需采购</a>--%>
		<a class="view" onclick="noPurchase()">无需采购</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="MdDemandM:view">
		<a class="sendback" onclick="sendBackBalanceList()">退回</a>
	</shiro:hasPermission>
</div>
<div class="tab-content layui-form">
	<table class="frog-table">
		<thead>
			<tr>
				<th><input type="checkbox" lay-skin="primary" class="checkAllMdDemandD" lay-filter="checkAllMdDemandD"></th>
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
                <th><div style="width: 30px"></div>库存数量</th>
				<th><div style="width: 30px;"></div>平衡数量</th>
				<th><div style="width: 80px;"></div>采购部门接收人</th>
				<th><div style="width: 55px;"></div>计划申报年月</th>
				<th><div style="width: 30px;"></div>客商编号</th>
				<th><div style="width: 30px;"></div>需求计划名称</th>
				<th><div style="width: 30px;"></div>申请部门</th>
				<th><div style="width: 30px;"></div>申请人员</th>
				<th><div style="width: 30px;"></div>申请日期</th>
				<th><div style="width: 30px;"></div>状态</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="mdDemandM" varStatus="status">
				<tr target="slt_uid" rel="${mdDemandM.id}" id="${mdDemandM.id}">
					<td><input type="checkbox" name="check_HW03" data-value="${mdDemandM.id}" lay-skin="primary" lay-filter="checkAllMdDemandD"/></td>
				    <td>${page.pageBeginCount + status.index + 1}</td>
					<td width="110px">${mdDemandM.strApplyNo}</td><%--需求计划编号--%>
					<td>${mdDemandM.strApplyName}</td><%--需求计划名称--%>
					<td>${mdDemandM.strOrderNo}</td><%--销售订单编号--%>
                    <td style="display: none">${mdDemandM.strTypeId1}</td>
					<td>${mdDemandM.strTypeId1}</td><%--计划类型--%>
					<td>${mdDemandM.strApplyItem}</td><%--计划项次--%>
					<td>${mdDemandM.strMatrlNo}</td><%--存货编号--%>
					<td>${mdDemandM.strUnit}</td><%--库存单位--%>
					<td>${mdDemandM.strMatrlName}</td><%--品名--%>
					<td>${mdDemandM.strBrand}</td><%--品牌--%>
					<td>${mdDemandM.strSpec}</td><%--型号--%>
					<td>${mdDemandM.bdSalePrice}</td><%--销售单价--%>
					<td>${mdDemandM.bdPlanQty}</td><%--销售数量--%>
					<td>${mdDemandM.bdApplyNumber}</td><%--计划申报数量--%>
					<td>${mdDemandM.bdPlanPrice}</td><%--建议单价--%>
					<c:if test="${mdDemandM.bdQtyZH == null}">
						<td>0</td>
					</c:if>
					<c:if test="${mdDemandM.bdQtyZH != null}">
						<td>${mdDemandM.bdQtyZH}</td><%--库存数量--%>
					</c:if>
					<td><input type="text" style="width: 70px" class="layui-input" value="${mdDemandM.bdBalanceQty}"></td><%--平衡数量--%>
					<td>${mdDemandM.strBalanceUserIdZH}</td><%--采购部门接收人--%>
					<td>${mdDemandM.strPlanYearMo}</td><%--计划申报年月--%>
					<td>${mdDemandM.strVendorNo}</td><%--客商编号--%>
					<td>${mdDemandM.strApplyName}</td><%--需求计划名称--%>
					<td>${mdDemandM.strDept}</td><%--申请部门--%>
					<td>${mdDemandM.strDemandUserIdZH}</td><%--申请人员--%>
					<td>${mdDemandM.strDemandDate}</td><%--申请日期--%>
					<td>${mdDemandM.strBalanceStusZH}</td><%--平衡状态--%>
					<input style="display: none" id="relativedId131" value="${mdDemandM.id}">
					<input style="display: none" id="strMatrlNo" value="${mdDemandM.strMatrlNo}">
					<input style="display: none" id="strTypeId001" value="${mdDemandM.strTypeId}">
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
</div>
<script type="text/javascript">
	/**
	 * 保存平衡数量
	 */
	function saveQty() {
		debugger;
		var btbedit = document.getElementsByName("check_HW03");
		var j=0;
		for ( var i = 0; i < btbedit.length; i++) {
			if (btbedit.item(i).checked) {
				j=j+1;
				debugger;
				var tr = btbedit.item(i).parentNode.parentNode;
				var trId = $(tr).attr("rel");
				//alert(trId);
				var bdBalanceQty = btbedit.item(i).parentNode.parentNode.cells[18].childNodes[0].value;
			}
		}
		if (trId == null || trId == undefined){
			Dialog.warn("未选中一条数据");
			return;
		}
		$.ajax({
            type:"post",
            url:"${ctx}/mdDemandM/saveQty?id="+trId+"&bdBalanceQty="+bdBalanceQty,
            dataType:"json",
            success:function (rst) {
                if (rst.statusCode == 200){
                    Dialog.success(rst.message);
                    $('#balanceListId').load("${ctx}/mdDemandM/balanceList",{},function () {});
                } else{
                    Dialog.error(rst.message);
                }
            },
            error:function () {
				Dialog.warn(warn.message);
            }
        });
	}
</script>