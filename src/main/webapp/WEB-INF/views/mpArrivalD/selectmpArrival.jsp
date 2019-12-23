<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<div id="selectmpPoNo">
	<form id="pagerForm" method="post"  action="${ctx}/mpArrivalD/ihArrivalDtlSelect">
		<input type="hidden" name="pageNum" value="${page.pageNum}" />
		<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
		<input type="hidden" name="orderField" value="${page.orderField}" />
		<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
		<input type="hidden"  name="ihid" value="${ihid}">
		<input type="hidden"  name="strVendorNo" value="${strVendorNo}" />
		<input type="hidden" name="strPoNo" value="${strPoNo}" />
	</form>


	<div class="tab-content layui-form" style="overflow:auto;">
		<div class="panelBar" style="margin-left: 5px;">
			<a class="add" onclick="selectLabel()"><span>确定</span></a>
		</div>

		<input type="hidden" id="id" value="${ihid}">
		<input type="hidden" id="strVendorNo" name="strVendorNo" value="${strVendorNo}" />
		<input type="hidden" id="strPoNo" name="strPoNo" value="${strPoNo}" />
		<table  class="frog-table" id="" style="width: 300%; max-width: 400%">
			<thead>
				<tr>
					<td style="width: 20px;">
						<input type="checkbox" lay-skin="primary"  class="checkClassSelectArrival" lay-filter="checkboxSelectArrivaldtl" />
					</td>
					<th type="text">序号</th>
					<th type="text">采购合同号</th>
                    <th type="text">合同项次</th>
                    <th type="text">存货编号</th>
                    <th type="text">订购数量</th>
                    <th type="text">建议采购单价</th>
                    <th type="text">采购单价</th>
                    <th type="text">金额</th>
                    <th type="text">期望交货日期</th>
                    <th type="text">采购要求</th>
                    <th type="text">需求计划编号</th>
                    <th type="text">需求计划编项次</th>
                    <th type="text">需求申报单位</th>
                    <th type="text">销售订单号</th>
                    <th type="text">销售订项次号</th>
                    <th type="text">采购计划号</th>
					<th type="text">挑选数量</th>
                    <th type="text">未被挑选数量</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${labelList}"  var="mpPonoD" varStatus="status">
				<tr target="slt_uid" rel="${mpPonoD.id}" id="${mpPlan.id}"
					pageCont="${page.pageBeginCount + status.index + 1}">
					<td>
						<input type="checkbox"  name="checkitemLabel" lay-skin="primary" lay-filter="checkboxSelectArrivaldtl" />
						<input type="hidden"id="labelId" name="labelId" value="${mpPonoD.id}">
					</td>
					<td>${page.pageBeginCount + status.index + 1}</td>
					<td>${mpPonoD.strPoNo}</td>
                    <td>${mpPonoD.strPoItemNo}</td>
                    <td>${mpPonoD.strMatrlNo}</td>
                    <td>${mpPonoD.bdQty}</td>
                    <td>${mpPonoD.bdPlanPrice}</td>
                    <td>${mpPonoD.bdRealPrice}</td>
                    <td>${mpPonoD.bdAmt}</td>
                    <td>${mpPonoD.strPlanUseDate}</td>
                    <td>${mpPonoD.strMemo}</td>
                    <td>${mpPonoD.strApplyNo}</td>
                    <td>${mpPonoD.strApplyItem}</td>
                    <td>${mpPonoD.strReqDept}</td>
                    <td>${mpPonoD.strOrderNo}</td>
                    <td>${mpPonoD.strOrderItem}</td>
                    <td>${mpPonoD.strPlanNo}</td>
					<td><input type="" id="updQty" name="updQty"  originValue="${mpPonoD.strUnSelectQty}" displayType='currency' pattern='###.###' value="${mpPonoD.strUnSelectQty}" size="10" class="number" required="true"/></td>
                    <td>${mpPonoD.strUnSelectQty}</td>
                </tr>

			</c:forEach>
			</tbody>
		</table>
	</div>
</div>
	<c:import url="/WEB-INF/views/aaSystem/pager/dialogPagerBar.jsp">
		<c:param name="container" value="#ihArrivalDtlSelect"> </c:param>
	</c:import>

<script type="text/javascript">

	form.on('checkbox(checkboxSelectArrivaldtl)', function(data) {
		if ($(data.elem).hasClass("checkClassSelectArrival")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});

	function selectLabel() {
		var ihid = $("#id").val();                  //到货主档id
		var id= ihid;
		var strVendorNo = $("#strVendorNo").val();
		var strPoNo= $("#strPoNo").val();
		var aa = document.getElementsByName("checkitemLabel");
		var num = 0;
		var qty = "" ;
		var result ='';
		for (var i = 0; i < aa.length; i++) {
			if (aa.item(i).checked) {
				num++;
				var tr = aa.item(i).parentNode.parentNode;
				var upQty = $(tr.cells[17]).children("#updQty").val();     //数量
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
			layer.confirm("确认挑选吗库明细?", {
				btn : [ '确定', '取消' ]
				//按钮
			}, function() {
				$.post("${ctx}/mpArrivalD/ihArrivalDtlcreate?ihid=" + ihid + "&labelId=" + result + "&updQty=" + qty, function(msg) {
					try {
						var result = JSON.parse(msg);
						Ajax.ajaxDone(result);
						if (result.statusCode == 200) {
							$("#ihArrivalDtlSelect").load("${ctx}/mpArrivalD/ihArrivalDtlSelect?ihid="+ihid+"&strPoNo="+strPoNo+"&strVendorNo="+strVendorNo, function() {
							});
							$("#tab2").load("${ctx}/mpArrivalD/preCreate?id="+id+"&strPoNo="+strPoNo+"&strVendorNo="+strVendorNo, function() {
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

	$(document).ready(function() {
		$('#selectLabel').trigger('click');
	})
</script>


