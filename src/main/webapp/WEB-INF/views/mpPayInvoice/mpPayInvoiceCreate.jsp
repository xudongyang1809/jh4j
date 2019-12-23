<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<style type="text/css">
	.sticky {
		position: -webkit-sticky;
		position: sticky;
		top: 0;
	}
</style>

<script>

	function dialogInsertPlanDone(result) {
		try {

			var loadingIndex = Dialog.load();
			var id = result.rel;
			var strPayNo = $("#strPayNo").val();
			if(result.statusCode=='200'){
				Dialog.success("保存成功")
				$("#tab3").load("${ctx}/mpPayInvoice/preCreate?id="+id+"&strPayNo="+strPayNo, function(){
					layer.close(loadingIndex);
				});

			}else{
				Dialog.error(result.message);
			}
		} catch (e) {
			console.log(result);
			Dialog.error(e.message);
		}
	}


	//全选操作
	form.on('checkbox(checkboxmpPayInvoice)', function(data) {
		if ($(data.elem).hasClass("checkAllmpPayInvoice")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});
	// 刷新当前页
	function  refreshMpPayInvoice () {
		var loadingIndex = Dialog.load();
		var id=$("#ihid").val();
		var strPayNo=$("#strPayNo").val();
		$("#tab3").load("${ctx}/mpPayInvoice/preCreate?id="+id+"&strPayNo="+strPayNo , function(){
			layer.close(loadingIndex);
		})
	}

	//新增插入行
	function epPreparationAddLine() {
		debugger;
		var index = $("tbody[name='ep_enquiry_item']").find("tr").length;
		var num = $("#epPreparationAddLineNumber").val() || 1;
		var html = '';
		for(var n = 0; n < num; n++){
			html += '<tr class="unitBox">'
					+ '<td style="width:18px;">'
					+ '<input type="checkbox"  name="" lay-skin="primary"></td>'
					+ '<td><input type="text"  name="plist[' + index + '].strPayNo" id="strPayNo"  class="layui-input"   /></td>'
					+ '<td><input type="text"  name="plist[' + index + '].strInvoiceNo" id="strInvoiceNo" class="layui-input"  /></td>'
					+ '<td ><input type="text" name="plist[' + index + '].strBillDocType" id="strBillDocType" class="layui-input" /></td>'
					+ '<td ><input type="date" name="plist[' + index + '].strInvoiceDate" id="strInvoiceDate" class="layui-input" /></td>'
					+ '<td ><input type="text" name="plist[' + index + '].strRateType" id="strRateType" class="layui-input" /></td>'
					+ '<td ><input type="text" name="plist[' + index + '].strMemo" id="strMemo" class="layui-input" /></td>'
					+ '<td ><input type="text" name="plist[' + index + '].bdAmt"      id="bdAmt'+index+'" class="layui-input" /></td>'
					+ '<td ><input type="text" name="plist[' + index + '].bdTaxRate"  id="bdTaxRate'+index+'" class="layui-input" /></td>'
					+ '<td ><input type="text" name="plist[' + index + '].bdTaxAmt"   id="bdTaxAmt'+index+'" class="layui-input" /></td>'
					+ '<td ><input type="text" name="plist[' + index + '].bdTotalAmt" id="bdTotalAmt'+index+'" class="layui-input" /></td>'
					+'<td><input name="" class="layui-btn layui-btn-xs" type="button" value="删除"  onclick=\"deltr(this)\"/></td>'
					+ '</tr>';
			index++;

		}
		$("tbody[name='ep_enquiry_item']").append(html);
		var countbdAmt = $("#countbdAmt").val();

		var load= index-1;
		$("#bdAmt"+load).val(countbdAmt);
		$("#bdTaxRate"+load).val("0.13");
		$("#bdTaxAmt"+load).val(countbdAmt*0.13);
		$("#bdTotalAmt"+load).val(parseFloat(countbdAmt*(1+0.13)));


		form.render('checkbox');
		form.render('select');
	}
	// 新增一行删除一行删除当前一行
	function deltr(opp){
		$(opp).parent().parent().remove();

	}
	// 保存方法
	function mpPayInvoiceSave() {
		$("#mpPayInvoiceform").submit();
	}
	//批量删除明细
	function mpPayInvoiceDelete() {
		var aa = document.getElementsByName("checkitemmpPayDetail");
		var num =0;
		var ids = "";

		for (var i = 0; i < aa.length; i++) {
			if(aa.item(i).checked){
				num++ ;
				var tr = aa.item(i).parentNode.parentNode;
				var id = $(tr.cells[0]).children("#payid").val();   // id
				if(ids == ''){
					ids = id;
				}else
					ids = ids+","+id;   // id 拼接
			}
		}
		if (num == 0) {
			layer.alert("请至少选择一条信息!");
		}else{
			layer.confirm("确定删除吗？" ,function () {
				$.post("${ctx}/mpPayInvoice/deleteInvoiceDtl?ids="+ids , function (msg) {
					try {
						var result = JSON.parse(msg);
						var messages=result.message;
						Ajax.ajaxDone(result);
						if (result.statusCode == 200) {
							Dialog.success(messages);
							refreshMpPayInvoice();   // 刷新当前页
						}
						else {
							Dialog.error(result.message);
						}
					}catch (e) {
						console.log(msg);
					}
				})
			})
		}  //else 结束
	}
	<!--编辑修改功能-->
	function editrow(obj) {
		debugger;
		var btbedit = document.getElementsByName("btnedit");   // 获取button
		var tr = obj.parentNode.parentNode;  // 获取tr
		var trid = tr.rowIndex -1;      // tr的行数
		btbedit[trid].disabled = true;
		var size = obj.parentNode.parentNode.cells.length;      // 计算列数
		for ( var i = 1; i < size-1 ; i++) {
			var tempTd = tr.cells[i];
			var tdText = tempTd.innerHTML;      //html()函数针对非value属性，val()针对value属性
			var name = "";
			switch (i) {
				case 1:
					name = "plist[" + trid + "].strPayNo";
					break;
				case 2:
					name = "plist[" + trid + "].strInvoiceNo";
					break;
				case 3:
					name = "plist[" + trid + "].strBillDocType";
					break;
				case 4:
					name = "plist[" + trid + "].strInvoiceDate";
					break;
				case 5:
					name = "plist[" + trid + "].strRateType";
					break;
				case 6:
					name = "plist[" + trid + "].strMemo";
					break;
				case 7:
					name = "plist[" + trid + "].bdAmt";
					break;
				case 8:
					name = "plist[" + trid + "].bdTaxRate";
					break;
				case 9:
					name = "plist[" + trid + "].bdTaxAmt";
					break;
				case 10:
					name = "plist[" + trid + "].bdTotalAmt";
					break;
			}
			if (i == 1)
				tempTd.innerHTML = "<input type='text'  lay-verify='required' value='" + tdText + "' size='10' name='" + name + "'/>";
			else if (i == 2)
				tempTd.innerHTML = "<input type='text' lay-verify='required' value='" + tdText + "' size='10' name='" + name + "'/>";
			else
				tempTd.innerHTML = "<input type='text' value='" + tdText + "' size='10' name='" + name + "'/>";
		}
	}



</script>

<div>
	<form id="pagerForm" method="post" action="${ctx}/mpPayInvoice/create">
		<input type="hidden" name="pageNum" value="${page.pageNum}" />
		<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
		<input type="hidden" name="orderField" value="${page.orderField}" />
		<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
		<input type="hidden" name="keywords" value="${keywords}"/>

		<input type="hidden" name="ihid"  value="${ihid}"/>
		<input type="hidden" name="strPayNo"  value="${strPayNo}"/>
	</form>
	<div class="tab-bars">
		<a class="edit btn-small" onclick="mpPayInvoiceSave()"><span>保存</span></a>
		<a class="delete btn-small" href="#" onclick="mpPayInvoiceDelete()"><span>删除</span></a>
		<div>
			<button class="layui-btn layui-btn-xs" onclick="epPreparationAddLine()">新增项次</button>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="epPreparationAddLineNumber" value="1" readonly="readonly">
			</div>
		</div>
	</div>
	<div class="tab-header" style="border:0px;"></div>
	<div class="tab-content">
		<form id="mpPayInvoiceform" method="post" class="layui-form" action="${ctx}/mpPayInvoice/create" autocomplete="off"onsubmit="return validateCallback(this, dialogInsertPlanDone);" >

			<input type="hidden" name="ihid" id="ihid" value="${ihid}"/>
			<input type="hidden" name="strPayNo" id="strPayNo" value="${strPayNo}"/>
			<input type="hidden"  id="countbdAmt" value="${countbdPayAmt}"/>
			<div id="keyupeven">
				<table class="frog-table sticky" style="width: 100%;">
					<thead>
					<tr  id="firstRow">
						<th>
							<input type="checkbox" lay-skin="primary" class="checkAllmpPayInvoice" name="checkitemAdvancePay"   lay-filter="checkboxmpPayInvoice" >
						</th>
						<th type="text" name="plist[#index#].strPayNo">报账单号</th>
						<th type="text" name="plist[#index#].strInvoiceNo">发票号码</th>
						<th type="text" name="plist[#index#].strBillDocType">报支单据类别</th>
						<th type="text" name="plist[#index#].strInvoiceDate">发票日期</th>
						<th type="text" name="plist[#index#].strRateType">税率代码</th>
						<th type="text" name="plist[#index#].strMemo">备注</th>
						<th type="text" name="plist[#index#].bdAmt">税前金额</th>
						<th type="text" name="plist[#index#].bdTaxRate">税率</th>
						<th type="text" name="plist[#index#].bdTaxAmt">税额</th>
						<th type="text" name="plist[#index#].bdTotalAmt">税后金额</th>
						<th type="del">操作</th>
					</tr>
					</thead>
					<tbody name="ep_enquiry_item" style="overflow-y:auto; ">
					<c:forEach items="${mpPayInvoiceList}" var="mpPayInvoice" varStatus="status">
						<tr target="slt_uid" rel="${mpPayInvoice.id}" id="${mpPayInvoice.id}" >
							<td style="width:18px;text-align: center;">
								<input type="checkbox" name="checkitemmpPayDetail"  lay-skin="primary" lay-filter="checkboxmpPayInvoice">
								<input type="hidden" id="payid" value="${mpPayInvoice.id}">
							</td>
							<input type="hidden" name="plist[${page.pageBeginCount+status.index}].id" value="${mpPayInvoice.id}">
							<td>${mpPayInvoice.strPayNo}</td>
							<td>${mpPayInvoice.strSupplierId}</td>
							<td>${mpPayInvoice.strInvoiceNo}</td>
							<td>${mpPayInvoice.strInvoiceDate}</td>
							<td>${mpPayInvoice.strRateType}</td>
							<td>${mpPayInvoice.strMemo}</td>
							<td>${mpPayInvoice.bdAmt}</td>
							<td>${mpPayInvoice.bdTaxRate}</td>
							<td>${mpPayInvoice.bdTaxAmt}</td>
							<td>${mpPayInvoice.bdTotalAmt}</td>
							<td><button type="button" onclick="editrow(this)" class="edit"  id="btnedit" name="btnedit">编辑</button>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</form>
	</div>
	<!-- 分页 -->
	<c:import url="/WEB-INF/views/aaSystem/pager/dialogPagerBar.jsp">
		<c:param name="container" value="#tab3"/>
	</c:import>
</div>
