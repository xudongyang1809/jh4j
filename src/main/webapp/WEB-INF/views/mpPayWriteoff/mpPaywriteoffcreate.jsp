<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<script>
	//全选操作
	form.on('checkbox(checkAllmpPayWriteOff)', function(data) {
		if ($(data.elem).hasClass("checkAllmpPayWriteOff")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	})

	function mppaycreateWriteoff(){                //自动冲销
		var ihid =	 $("#ihid").val();             //主档id
		var strPayNo = $("#strPayNo").val();       // 报账单号
		var strVendorNo = $("#strVendorNo").val();  // 供应商
		$.post("${ctx}/mpPayWriteoff/autoWriteOff",{ihid:ihid ,strPayNo:strPayNo,strVendorNo:strVendorNo}, function(msg){
			try {
				var result = JSON.parse(msg);
				Ajax.ajaxDone(result);
				if (result.statusCode == 200) {
					Dialog.success(result.message);
					$("#tab4").load("${ctx}/mpPayWriteoff/preCreate",{id:ihid,strPayNo:strPayNo,strVendorNo:strVendorNo},function(){
					})
					NavTab.reloadWithPagination(result.navTabId);
				}else{
					Dialog.error(result.message);
				}
			} catch (e) {
				console.log(msg);
				Dialog.error(e.message);
			}
		});
	}


	// 删除已挑选
	function deletempWriteoff(){
		debugger;
		var ihid =	 $("#ihid").val();             //主档id
		var strPayNo = $("#strPayNo").val();       // 报账单号
		var strVendorNo = $("#strVendorNo").val();  // 供应商
		var aa = document.getElementsByName("checkitemmpPayDetail");
		var num = 0;
		var result ='';
		for (var i = 0; i < aa.length; i++) {
			if (aa.item(i).checked) {
				num++;
				var tr = aa.item(i).parentNode.parentNode;
				var labelId = $(tr.cells[0]).children("#payid").val();   // id
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
				$.post("${ctx}/mpPayWriteoff/deleteWriteoff",{result:result,mpPaynoId:ihid} , function(msg) {
					try {
						var result = JSON.parse(msg);
						Ajax.ajaxDone(result);
						if (result.statusCode == 200) {
							$("#tab4").load("${ctx}/mpPayWriteoff/preCreate",{id:ihid,strPayNo:strPayNo,strVendorNo:strVendorNo},function(){
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


</script>
<div>
<form id="pagerForm" method="post" action="${ctx}/mpPayWriteoff/preCreate" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
	<input type="hidden"  name="id" value="${ihid}"/>
	<input type="hidden" name="strPayNo" value="${strPayNo}"/>
</form>

<div class="tab-bars">
	<a class="add" href="#" onclick="mppaycreateWriteoff(this)"><span>预付款自动冲销</span></a>
	<a class="delete" href="#" onclick="deletempWriteoff(this)"><span>冲销删除</span></a>
	<input type="hidden" id="ihid" name="ihid" value="${ihid}">
	<input type="hidden" id="strPayNo" name="strPayNo" value="${strpayNo}">
	<input type="hidden" id="strVendorNo" name="strVendorNo" value="${strVendorNo}">

</div>
<form method="post" action="${ctx}/mpPayWriteoff/create" class="layui-form"  onsubmit="return validateCallback(this, dialogAjaxDone);">
	<div class="tab-content1 layui-form">
		<table class="frog-table " id="mpPonoWriteOff">
			<thead>
			<tr>
				<th>
					<input type="checkbox" lay-skin="primary" class="checkAllmpPayWriteOff" name="checkitemAdvancePay"   lay-filter="checkAllmpPayWriteOff" >
				</th>
				<th>序号</th>
				<th>报账编号</th>
				<th>合同号</th>
				<th>币种</th>
				<th>已付款金额</th>
				<th>冲销预付金额</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${list}" var="mpPayWriteoff" varStatus="status">
				<tr target="slt_uid" rel="${mpPayWriteoff.id}" id="${mpPayWriteoff.id}">
					<td style="width:18px;text-align: center;">
						<input type="checkbox" name="checkitemmpPayDetail"  lay-skin="primary" lay-filter="checkAllmpPayWriteOff">
						<input type="hidden" id="payid" value="${mpPayWriteoff.id}">
					</td>
					<td>${page.pageBeginCount + status.index + 1}</td>
					<td>${mpPayWriteoff.strPayNo}</td>
					<td>${mpPayWriteoff.strPoNo}</td>
					<td>${mpPayWriteoff.strCrcy}</td>
					<td>${mpPayWriteoff.bdPrePayedAmt}</td>
					<td>${mpPayWriteoff.bdWriteOffPrePayAmt}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</form>
<!-- 分页 -->
<c:import url="/WEB-INF/views/aaSystem/pager/dialogPagerBar.jsp">
	<c:param name="container" value="#tab4"/>
</c:import>
</div>
