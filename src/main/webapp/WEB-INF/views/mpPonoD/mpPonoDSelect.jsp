<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<div id="selectmpPoNo">
	<form id="pagerForm" method="post"  action="${ctx}/mpPonoD/mpPonoDSelect">
		<input type="hidden" name="pageNum" value="${page.pageNum}" />
		<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
		<input type="hidden" name="orderField" value="${page.orderField}" />
		<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
		<input type="hidden" name="ihInventory" value="${ihInventory}" />
		<input type="hidden" name="reqItem" value="${reqItem}" />
		<input type="hidden" name="strReqNo" value="${strVendorNo}"  />
		<input type="hidden"  name="ihid" value="${ihid}">
	</form>
	<div class="tab-header">
		<form method="post" action='${ctx}/mpPonoD/mpPonoDSelect'  class="layui-form" onsubmit="return dialogSearch(this)">
			<div class="layui-form-item">
				<div class="layui-inline">
					<input type="hidden" id="id"  name="ihid" value="${ihid}" />
					<input type="hidden" id="strVendorNo" name="strVendorNo" value="${strVendorNo}" />
				</div>
				<div class="layui-inline" style="float:right;margin-right: 20px">
					<button class="search">查询</button>
				</div>
			</div>
		</form>
	</div>

	<div class="tab-content layui-form" style="overflow:auto;">
		<div class="panelBar" style="margin-left: 5px;">
			<a class="add" onclick="selectLabel()"><span>确定</span></a>
		</div>
		<table  class="frog-table"  style="width: 300%; max-width: 400%">
			<thead>
				<tr>
					<td style="width: 20px;">
						<input type="checkbox" lay-skin="primary"  class="checkClassSelectMpplan" lay-filter="checkboxSelectMpplan" />
					</td>
					<th>序号</th>
					<th>计划单号</th>
					<th>采购日期</th>
					<th>采购员</th>
					<th>采购部门</th>
					<th>采购要求</th>
					<th>供应商</th>
					<th>需求计划编号</th>
					<th>需求计划明细号</th>
					<th>存货编码</th>
					<th>料号名称</th>
					<th>期望交货日期</th>
					<th>需求人保人员</th>
					<th>需求申报人员部门</th>
					<th>销售订单编号</th>
					<th>销售订单项次</th>
					<th>建议采购单价</th>
					<th>采购计划量</th>
					<th>采购数量</th>
					<th>剩余采购量</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${labelList}"  var="mpPlan" varStatus="status">
			<tr target="slt_uid" rel="${mpPlan.id}" id="${mpPlan.id}"
					pageCont="${page.pageBeginCount + status.index + 1}">
					<td>
						<input type="checkbox"  name="checkitemLabel" lay-skin="primary" lay-filter="checkboxSelectMpplan" />
						<input type="hidden" id="labelId" name="labelId" value="${mpPlan.id}">

					</td>
					<td>${page.pageBeginCount + status.index + 1}</td>
					<td>${mpPlan.strPlanNo}</td>
					<td>${mpPlan.strPlanDate}</td>
					<td>${mpPlan.strBuyerName}</td>
					<td>${mpPlan.strBuyerDeptId}</td>
					<td>${mpPlan.strRemark}</td>
					<td>${mpPlan.strVendorNo}_${mpPlan.strVendorName}</td>
					<td>${mpPlan.strApplyNo}</td>
					<td>${mpPlan.strApplyItem}</td>
					<td>${mpPlan.strMatrlNo}</td>
					<td>${mpPlan.strMatrlName}</td>
					<td>${mpPlan.strPlanUseDate}</td>
					<td>${mpPlan.strReqEmpName}</td>
					<td>${mpPlan.strReqDept}</td>
					<td>${mpPlan.strOrderNo}</td>
					<td>${mpPlan.strOrderItem}</td>
					<td displayType='currency' pattern='###,###.###'>${mpPlan.bdPlanPrice}</td>
					<td displayType='currency' pattern='###,###.###'>${mpPlan.bdQty}</td>
					<td><input type="" id="updQty" name="updQty"  originValue="${mpPlan.bdPurchasesQty}" displayType='currency' pattern='###.###' value="${mpPlan.bdPurchasesQty}" size="10" class="number" required="true"/></td>
					<td>${mpPlan.bdPurchasesQty}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</div>
	<c:import url="/WEB-INF/views/aaSystem/pager/dialogPagerBar.jsp">
		<c:param name="container" value="#preSelectmpPono"> </c:param>
	</c:import>

<script type="text/javascript">

	form.on('checkbox(checkboxSelectMpplan)', function(data) {
		if ($(data.elem).hasClass("checkClassSelectMpplan")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});

	function selectLabel() {
		var ihid = $("#id").val();                  //主档id
		var strVendorNo = $("#strVendorNo").val();
		var aa = document.getElementsByName("checkitemLabel");
		var num = 0;
		var qty = "" ;
		var result ='';

		for (var i = 0; i < aa.length; i++) {
			if (aa.item(i).checked) {
				num++;
				var tr = aa.item(i).parentNode.parentNode;
				var upQty = $(tr.cells[19]).children("#updQty").val();     //数量
				var labelId = $(tr.cells[0]).children("#labelId").val();   // id
				if (result == '')
					result = labelId;
				else
					result = result + "," + labelId;       //id拼接
				if (qty == '')
					qty = upQty.replace(',', '');
				else
					qty = qty + "," + upQty.replace(',', '');
			}
		}

		if (num == 0) {
			layer.alert("请至少选择一条信息!");
		} else {
			layer.confirm("确认挑选采购合同?", {
				btn : [ '确定', '取消' ]
				//按钮
			}, function() {
				$.post("${ctx}/mpPonoD/selectMpPoNoDtl?ihid=" + ihid + "&labelId=" + result + "&updQty=" + qty, function(msg) {
					try {
						var result = JSON.parse(msg);
						Ajax.ajaxDone(result);
						if (result.statusCode == 200) {
							$("#selectmpPoNo").load("${ctx}/mpPonoD/mpPonoDSelect?strVendorNo="+strVendorNo+"&ihid="+ihid, function() {
							});
							$("#tab2").load("${ctx}/mpPonoD/preCreate?ihid="+ihid+'&strVendorNo='+strVendorNo , function() {
							})
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

	$(document).ready(function() {
		$('#selectLabel').trigger('click');
	})

    form.render();
</script>


