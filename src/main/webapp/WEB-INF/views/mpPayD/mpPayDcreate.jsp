<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<script>
	form.on('checkbox(checkboxMpPayD)', function(data) {
		if ($(data.elem).hasClass("checkAllMpPayD")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});


	function mpPayDelect() {
		var ihid = $("#ihid").val();
		var strPayNo	= $("#strPayNo").val();
		var strVendorNo	= $("#strVendorNoSelect").val();

		$.post("${ctx}/mpPayD/mpPayDSelect?strPayNo="+strPayNo+"&ihid="+ihid+"&strVendorNo="+strVendorNo, function(content) {
			top.layer.open({
				id : 'mpPayDSelect',
				type : 1,
				area : [ "80%", "85%" ],
				title : "挑选",
				shadeClose : true,
				offset : "48px",
				maxmin : true,
				anim : 5,
				content : content
			});
		})
	}

	// 删除已挑选
	function deleteSelectmpPayD(){
			debugger;
			var ihid = $("#ihid").val();
			var strPayNo	= $("#strPayNo").val();
			var strVendorNo	= $("#strVendorNoSelect").val();
			var aa = document.getElementsByName("checkitemMpPayDel");
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
				layer.confirm("确认删除吗?", {
					btn : [ '确定', '取消' ]
					//按钮
				}, function() {
					$.post("${ctx}/mpPayD/mpPayDdelete?ihid=" + ihid + "&ids=" + result , function(msg) {
						try {
							var result = JSON.parse(msg);
							Ajax.ajaxDone(result);
							if (result.statusCode == 200) {
								$("#tab2").load("${ctx}/mpPayD/preCreate",{id:ihid,strPayNo:strPayNo,strVendorNo:strVendorNo},function(){
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

<form method="post" action="${ctx}/mpPayD/create" class="layui-form"  onsubmit="return validateCallback(this, dialogAjaxDone);">
	<div class="tab-header" >
		<div class="tab-bars" style="position:relative;">
			<a class="choose"  onclick="mpPayDelect()"><span>挑选采购计划项次</span></a>
		<%--	<a class="edit" onclick="mpmpPayDSave()"><span>保存</span></a>--%>
			<a class="delete"  href="#" onclick="deleteSelectmpPayD()"><span>删除</span></a>
		</div>
	</div>
	<div class="tab-content layui-form"  style="overflow: auto;">
		<table class="frog-table " id="mpPonoDTable" style="width: 145%;z-index:5; max-width: 145%;table-layout: fixed; word-break: break-all; word-wrap: break-word">
			<thead>

				<input type="hidden" name="ihid" id="ihid" value="${ihid}" />
				<input type="hidden" name="" id="countbdPayAmt" value="${countbdPayAmt}" />
				<input type="hidden" name="strPayNo" id="strPayNo" value="${strPayNo}" />
				<input type="hidden" name="strVendorNo" id="strVendorNoSelect" value="${strVendorNo}" />
			<tr id="firstRow">
				<th style="width: 20px">
					<input type="checkbox" lay-skin="primary" class="checkAllMpPayD" lay-filter="checkboxMpPayD" />
				</td>
				<th>序号</th>
				<th>报账单项次</th>
				<th>验收入库单</th>
				<th>验收入库单项次</th>
				<th>合同号</th>
			<%--	<th>验收存货号</th>--%>
				<th>入库数量</th>
				<th>入库单价</th>
				<th>入库金额</th>
				<th>币种</th>
			<%--	<th>质保金</th>
				<th>发票调差</th>--%>
				<th>本次报支金额</th>
				<th>报支说明</th>
				<th>价税合计</th>
            </tr>
			</thead>
			<tbody name="mp_pono_detail" id="mp_pono_detail_id">
			<c:forEach items="${mpPayDDetailList}"  var="mpPayD" varStatus="status">
				<tr>
					<td style="width: 20px">
						<input type="checkbox" lay-skin="primary"  name="checkitemMpPayDel" lay-filter="checkboxMpPayD"/>
						<input type="hidden" id="labelId" name="labelId" value="${mpPayD.id}">
					</td>
					<td>${page.pageBeginCount + status.index + 1}</td>
					<td>${mpPayD.strPayItemNo}</td>
					<td>${mpPayD.strInspNo}</td>
					<td>${mpPayD.strInspItem}</td>
					<td>${mpPayD.strPoNo}</td>
				<%--	<td>${mpPayD.strMatrlNo}</td>--%>
					<td>${mpPayD.bdInspQty}</td>
					<td>${mpPayD.bdUnitPrice}</td>
					<td>${mpPayD.bdInspAmt}</td>
					<td>${mpPayD.strCrcy}</td>
				<%--	<td>${mpPayD.bdBondAmt}</td>
					<td>${mpPayD.bdVoucherAmt}</td>--%>
					<td>${mpPayD.bdPayAmt}</td>
					<td>${mpPayD.strMemo}</td>
					<td>${mpPayD.bdTotalAfterAmt}</td>
                </tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</form>

<c:import url="/WEB-INF/views/aaSystem/pager/dialogPagerBar.jsp">
    <c:param name="container" value="#tab2"/>
</c:import>




