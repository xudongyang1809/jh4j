<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<div id="selectmpPoNo">
	<form id="pagerForm" method="post"  action="${ctx}/mpPayD/mpPayDSelect">
		<input type="hidden" name="pageNum" value="${page.pageNum}" />
		<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
		<input type="hidden" name="orderField" value="${page.orderField}" />
		<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
		<input type="hidden" name="strVendorNo" value="${strVendorNo}" />
		<input type="hidden"  name="ihid" value="${ihid}">
		<input type="hidden"  name="strPayNo" value="${strPayNo}">
	</form>
	<div class="tab-header">
		<form method="post" action='${ctx}/mpPayD/mpPayDSelect'  class="layui-form" onsubmit="return dialogSearch(this)">
			<div class="layui-form-item">
				<div class="layui-inline">
				</div>


			</div>
		</form>
	</div>

	<div class="tab-content layui-form" style="overflow:auto;">
		<div class="panelBar" style="margin-left: 5px;">
			<a class="add" onclick="selectMpPayHasArrival()"><span>确定</span></a>
		</div>
        <input type="hidden" id="ihid" value="${ihid}">
		<input type="hidden" id="strVendorNo" name="strVendorNo" value="${strVendorNo}" />
		<input type="hidden" id="strPayNo" name="strPayNo" value="${strPayNo}" />
		<table  class="frog-table" id="" style="width: 300%; max-width: 400%">
			<thead>
				<tr>
					<td style="width: 20px;">
						<input type="checkbox" lay-skin="primary"  class="checkClassSelectMpPayDSelect" lay-filter="checkboxSelectMpPayDSelect" />
					</td>
					<th>序号</th>
					<th>入库单号</th>
					<th>入库项次号</th>
					<th>采购合同号</th>
					<th>采购合同项次</th>
					<th>销售订单编号</th>
					<th>销售订单项次</th>
					<th>需求计划编号</th>
					<th>需求计划明细号</th>
					<%--<th>到货明细ID</th>--%>
				<%--	<th>储位</th>--%>
					<th>存货编号</th>
					<th>品名</th>
					<th>品牌</th>
					<th>型号规格</th>
					<th>入库单价</th>
					<th>入库量</th>
					<th>到货数量</th>
					<th>合格量 </th>
					<th>让步接收量</th>
					<th>退货量</th>
					<th>采购总金额</th>
					<th>备注</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${labelList}"  var="miAcceptanceD" varStatus="status">
			<tr target="slt_uid" rel="${miAcceptanceD.id}" id="${miAcceptanceD.id}" pageCont="${page.pageBeginCount + status.index + 1}">
					<td>
						<input type="checkbox"  name="checkitemLabel" lay-skin="primary" lay-filter="checkboxSelectMpPayDSelect" />
						<input type="hidden"id="labelId" name="labelId" value="${miAcceptanceD.id}">
					</td>
				<td>${page.pageBeginCount + status.index + 1}</td>
				<td>${miAcceptanceD.strInspNo}</td>
				<td>${miAcceptanceD.strInspItem}</td>
				<td>${miAcceptanceD.strPoNo}</td>
				<td>${miAcceptanceD.strPoItemNo}</td>
				<td>${miAcceptanceD.strOrderNo}</td>
				<td>${miAcceptanceD.strOrderItem}</td>
				<td>${miAcceptanceD.strReqNo}</td>
				<td>${miAcceptanceD.strReqItem}</td>
				<%--<td>${miAcceptanceD.strArrId}</td>--%>
		<%--		<td>${miAcceptanceD.strAreaId}</td>--%>
				<td>${miAcceptanceD.strMatrlNo}</td>
				<td>${miAcceptanceD.strMatrlName}</td>
				<td>${miAcceptanceD.strBrand}</td>
				<td>${miAcceptanceD.strSpec}</td>
				<td>${miAcceptanceD.bdBuyPrice}</td>
				<td>${miAcceptanceD.bdInStoreQty}</td>
				<td>${miAcceptanceD.bdArrQty}</td>
				<td>${miAcceptanceD.bdPassQty}</td>
				<td>${miAcceptanceD.bdConcessionQty}</td>
				<td>${miAcceptanceD.bdReturnQty}</td>
				<td>${miAcceptanceD.bdTotalAmt}</td>
				<td>${miAcceptanceD.strMemo}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</div>
	<c:import url="/WEB-INF/views/aaSystem/pager/dialogPagerBar.jsp">
		<c:param name="container" value="#mpPayDSelect"> </c:param>
	</c:import>

<script type="text/javascript">

	form.on('checkbox(checkboxSelectMpPayDSelect)', function(data) {
		if ($(data.elem).hasClass("checkClassSelectMpPayDSelect")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});

	// 挑选的方法
	function selectMpPayHasArrival() {
		debugger;
		var ihid = $("#ihid").val();                  //主档id
		var strVendorNo = $("#strVendorNo").val();
		var strPayNo = $("#strPayNo").val();
		var aa = document.getElementsByName("checkitemLabel");
		var num = 0;
		var qty = "" ;
		var result ='';

		for (var i = 0; i < aa.length; i++) {
			if (aa.item(i).checked) {
				num++;
				var tr = aa.item(i).parentNode.parentNode;
				var labelId = $(tr.cells[0]).children("#labelId").val();   // id

				if (result == '')
					result = labelId;
				else
					result = result + "," + labelId;       //id拼接

			}
		}

		if (num == 0) {
			layer.alert("请至少选择一条信息!");
		} else {
			layer.confirm("确认挑选进行报账吗?", {
				btn : [ '确定', '取消' ]
				//按钮
			}, function() {
				$.post("${ctx}/mpPayD/mpPayDSure?ihid=" + ihid + "&ids=" + result , function(msg) {
					try {
						var result = JSON.parse(msg);
						Ajax.ajaxDone(result);
						if (result.statusCode == 200) {
							$("#tab2").load("${ctx}/mpPayD/preCreate",{id:ihid,strPayNo:strPayNo,strVendorNo:strVendorNo},function(){
							});

							$("#mpPayDSelect").load("${ctx}/mpPayD/mpPayDSelect",{strPayNo:strPayNo,ihid:ihid,strVendorNo:strVendorNo},function(){
							});
						}
					} catch (e) {
						console.log(msg);
						Dialog.error(e.message);
					}
				});
			}, function() {
				layer.close();
			})
		}
	}




</script>


