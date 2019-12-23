<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<style type="text/css">
	.sticky {
		position: -webkit-sticky;
		position: sticky;
		top: 0;
	}
	.layui-form-select dl dd{
		color: black;
		padding: 0 10px;
		line-height: 36px;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}

</style>

<script>
	//全选操作
	form.on('checkbox(checkboxMpPonoPoissue)', function(data) {

		if ($(data.elem).hasClass("checkAllMpPonoPoissue")) {
			if (data.elem.checked) {
				$("#table22").find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$("#table22").find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});




	function epPreparationAddLine() {
		var totalstrPayment =$("#totalstrPayment").val();
		if(totalstrPayment == 1 ){
			layer.msg("付款比例满足100%,不可新增");

		}
		var strPoNo= $("#strPoNo1").val();
		var index = $("tbody[name='ep_enquiry_item']").find("tr").length;
		var num = $("#epPreparationAddLineNumber").val() || 1;
		var html = '';
		for(var n = 0; n < num; n++){
			html += '<tr class="unitBox">'
					+ '<td style="width:18px;"><input type="checkbox"  name="" lay-skin="primary"></td>'
					+ '<td><input type="text"  name="plist[' + index + '].strPoNo" id="strPoNo"  readonly="readonly"  class="layui-input layui-bg-gray"  value=""  /></td>'
					+ '<td><input type="text"  name="plist[' + index + '].strPayItem"   id="strPayItem"     readonly="readonly"   class="layui-input"  class="layui-input layui-bg-gray"  /></td>'
					+'<td>'
					+'<div class="layui-input-inline">'
					+'<select id="strPayStale" name="plist['+index+'].strPayStale" lay-verify="required">'
					+'<option value="">请选择职类</option>'
					+'<c:forEach  items="${strPayStale}" var="dict" varStatus="status" >'
					+'<option value="${dict.strValue}"  selected="selected">${dict.strValue}</option>'
					+'</c:forEach>'
					+'</select>'
					+'</div>'
					+ '</td>'
					+ '<td><input type="text"  name="plist[' + index + '].strPayment"  id="strPayment'+index+'"  style="width:70px ;position: relative;"  lay-verify="required|number" onmouseleave=\"ShowStrPayment(this)" class="layui-input"/></td>'
					+ '<td><input type="text"  name="plist[' + index + '].strPrePayAmt" id="strPrePayAmt'+index+'" lay-verify="required"  class="layui-input"  /></td>'
					+ '<td ><input type="text" name="plist[' + index + '].strRealPayAmt" id="strRealPayAmt"   class="layui-input" /></;td>'
					+ '<td><input type="date"  name="plist[' + index + '].strPrePayDate"  id="plist[\' + index + \'].strPrePayDate" layer-ve class="layui-input"  /></td>'
					+ '<td><input type="date"  name="plist[' + index + '].strBillDate"  id="strBillDate"  class="layui-input"/></td>'
					+ '<td><input type="text"  name="plist[' + index + '].strBillNo"  id="strBillNo"  class="layui-input"/></td>'
					+ '<td><input type="text"  name="plist[' + index + '].strMemo"  id="strMemo"  class="layui-input"/></td>'
					+ '<td><input type="text"  name="plist[' + index + '].strStatue"  id="strStatue"  class="layui-input"/></td>'
					+'<td><input name="" class="layui-btn layui-btn-xs" type="button" value="删除"  onclick=\"deltr(this)\"/></td>'
					+ '</tr>';
			index++;
		}
		$("tbody[name='ep_enquiry_item']").append(html);
		form.render('checkbox');
		form.render('select');

	}
	<!-- 新增时校验应付预付款金额-->
	function ShowStrPayment(obj){
		debugger;
		var tr = obj.parentNode.parentNode;                   // 获取tr
		var indexme = tr.rowIndex;                               // tr的行数
		var strPayment ="strPayment";
		var strPrePayAmt ="strPrePayAmt";
		var strPaymentId = strPayment+indexme;  //指定id
		var strPrePayAmtId=strPrePayAmt+indexme;  //预付款金额 应填写

		var strPaymentValue = $("#"+strPaymentId).val();  //获取税率   1
		var bdMpPonoAmt     = $("#bdMpPonoAmt").val();     //总额     2
		var bdPayAmt = bdMpPonoAmt * strPaymentValue  ;    // 实际金额 3
		$("#"+strPrePayAmtId).val(bdPayAmt);
		var totalstrPayment =$("#totalstrPayment").val();
		//alert(totalstrPayment +"+++"+ strPaymentValue);
		var sum = parseFloat(totalstrPayment) +parseFloat(strPaymentValue);
		if( sum >1){
			Dialog.error("付款比例超过 100%,不可新增");

		}
	}

	 // 修改时校验
        function updateStrPayment (obj){
		debugger;
		var tr = obj.parentNode.parentNode;                   // 获取tr
		var indexme = tr.rowIndex;                               // tr的行数
		var strPayment ="strPayment";
		var strPrePayAmt ="strPrePayAmt";
		var strPaymentId = strPayment+indexme;  //指定id
		var strPrePayAmtId=strPrePayAmt+indexme;  //预付款金额 应填写

		var strPaymentValue = $("#"+strPaymentId).val();  //获取税率
		var bdMpPonoAmt     = $("#bdMpPonoAmt").val();   //总金额
		var bdPayAmt = bdMpPonoAmt * strPaymentValue  ;
		$("#"+strPrePayAmtId).val(bdPayAmt);

		var totalstrPayment =$("#totalstrPayment").val();
		var sum = parseFloat(strPaymentValue) ;   //+parseFloat(strPaymentValue)

		if( sum >1){
			Dialog.error("付款比例超过 100%,不可新增");

		}
	}



	// 新增一行删除一行删除当前一行
	function deltr(opp){
		$(opp).parent().parent().remove();

	}
	// 保存按钮
	function mpPonoPaySave() {
		$("#mpPonoPoissue").submit();
	}

	function dialogInsertPlanDone(result) {
		try {
			/* var result = JSON.parse(msg); */
			var id = result.rel;
			if(result.statusCode=='200'){
				Dialog.success("保存成功")
				$("#tab3").load("${ctx}/mpPonoPay/preCreate?ihid="+id,{},function(){
				});
				NavTab.reloadWithPagination(result.navTabId);
			}else{
				Dialog.error(result.message);
			}
		} catch (e) {
			console.log(result);
			Dialog.error(e.message);
		}
	}

	<!--编辑修改功能-->
	function editrowPoissue(obj) {
		var btbedit = document.getElementsByName("btneditPoissue");   // 获取button
		var tr = obj.parentNode.parentNode;                   // 获取tr
		var trid = tr.rowIndex;                               // tr的行数
		btbedit[trid].disabled = true;
		var size = obj.parentNode.parentNode.cells.length;      // 计算列数
		for ( var i = 1; i < size - 1; i++) {

			var tempTd = tr.cells[i];


			var tdText = tempTd.innerHTML;      //html()函数针对非value属性，val()针对value属性
			var name = "";
			var id ="" ;
			switch (i) {
				case 1:
					name = "plist[" + trid + "].strPoNo";
					break;
				case 2:
					name = "plist[" + trid + "].strPayItem"   ;

					break;
				case 3:
					name = "plist[" + trid + "].strPayStale";
					break;
				case 4:
					name = "plist[" + trid + "].strPayment";
					id="strPayment"+ trid ;
					break;
				case 5:
					name = "plist[" + trid + "].strPrePayAmt";
					id="strPrePayAmt"+ trid;
					break;
				case 6:
					name = "plist[" + trid + "].strRealPayAmt";
					break;
				case 7 :
					name = "plist[" + trid + "].strPrePayDate";
					break;
				case 8 :
					name = "plist[" + trid + "].strBillDate";
					break;
				case 9:
					name = "plist[" + trid + "].strBillNo";
					break;
				case 10 :
					name = "plist[" + trid + "].strMemo";
					break;
				case 11 :
					name = "plist[" + trid + "].strStatue";
					break;
			}
			if (i == 2)
				tempTd.innerHTML = "<input type='text'  class='layui-input' lay-verify='required' value='" + tdText + "' size='10' name='" + name + "'/>";
			else if (i == 3)
				tempTd.innerHTML = "<input type='text'  class='layui-input' lay-verify='required' readonly='readonly'    value='" + tdText + "'  size='10'  name='" + name + "'     />";
			else if (i == 4)
				tempTd.innerHTML = "<input type='text'    class='layui-input'lay-verify='required|number'  value='" + tdText + "' size='10' name='" + name + "'   id='" + id  + "'  onmouseleave= \"updateStrPayment(this)\" />";
			else if (i == 5)
				tempTd.innerHTML = "<input type='text'  class='layui-input' lay-verify='required'  value='" + tdText + "' size='10' name='" + name + "'   id='" + id  + "'   />";
			else if (i == 7)
				tempTd.innerHTML = "<input type='date'  class='layui-input'   value='" + tdText + "' size='10' name='" + name + "'    />";
			else if (i == 8)
				tempTd.innerHTML = "<input type='date'  class='layui-input' type='date'  value='" + tdText + "' size='10' name='" + name + "'     />";

			else
				tempTd.innerHTML = "<input type='text' class='layui-input' value='" + tdText + "' size='10' name='" + name + "'/>";
		}
	}

	//批量删除明细
	function mpPonoPayDelete() {
		var aa = document.getElementsByName("checkitemMpponoPay");
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
				$.post("${ctx}/mpPonoPay/deletePayitem?ids="+ids  , function (msg) {
					try {
						var result = JSON.parse(msg);
						var messages=result.message;
						Ajax.ajaxDone(result);
						if (result.statusCode == 200) {
							Dialog.success(messages);
							refreshindex3();
						}
						else {
							Dialog.error(result.message);
						}
					}catch (e) {
						console.log(msg);
					}
				})
			})
		}
	}

	// 刷新当前页
	function  refreshindex3 () {
		var loadingIndex = Dialog.load();
		var id = $("#ihid").val();
		var strPoNo	= $("#strPoNo1").val();
		$("#tab3").load("${ctx}/mpPonoPay/preCreate?ihid="+id+"&strPoNo="+strPoNo,{},function(){
			layer.close(loadingIndex)
		})
	}



</script>

<div>
	<form id="pagerForm" method="post" action="${ctx}/mpPonoPay/preCreate?id=${ihid}">
		<input type="hidden" name="pageNum" value="${page.pageNum}" />
		<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
		<input type="hidden" name="orderField" value="${page.orderField}" />
		<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
		<input type="hidden" name="keywords" value="${keywords}"/>
		<input type="hidden" name="tab" value="3"/>
		<input type="hidden" name ="ihid" value="${ihid}"/>
	</form>
	<div class="tab-bars">
		<a class="edit btn-small" onclick="mpPonoPaySave()"><span>保存</span></a>
		<a class="delete btn-small" href="#" onclick="mpPonoPayDelete()"><span>删除</span></a>
		<div>
			<button class="layui-btn layui-btn-xs" onclick="epPreparationAddLine()">新增项次</button>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="epPreparationAddLineNumber" value="1">
			</div>
		</div>
		<!--合同总金额隐藏-->
		<input type="hidden" id="bdMpPonoAmt" value="${bdMpPonoAmt}">
		<input type="hidden" id="totalstrPayment" value="${totalstrPayment}">

	</div>
	<div class="tab-header" style="border:0px;"></div>

	<div class="tab-content">
		<form method="post" action="${ctx}/mpPonoPay/bachcreat" class="layui-form"  autocomplete="off"
			  onsubmit="return validateCallback(this, dialogInsertPlanDone);" id="mpPonoPoissue" >
			<input  type="hidden" name="ihid"    id="ihid" value="${ihid}" >
			<input type="hidden" name="strPoNo"  id="strPoNo1"  value="${strPoNo}" >
			<table class="frog-table" style="width: 100%; max-width: 100%;table-layout: fixed; word-break: break-all; word-wrap: break-word" id="mpPonoPoissueTable">
				<thead>
					<tr>
						<th style="width:18px;text-align: center;">
							<input type="checkbox" lay-skin="primary" class="checkAllMpPonoPoissue" lay-filter="checkboxMpPonoPoissue" />
						</th>
						<th type="text"   name="plist[#index#].strPoNo"  size="15" > 采购合同号</th>
						<th type="text"   name="plist[#index#].strPayItem" size="5" >付款次数</th>
						<th type="text"  name="plist[#index#].strPayStale" size="5">付款方式</th>
						<th type="text"  name="plist[#index#].strPayment" size="5" style="width:120px">付款比例</th>
						<th type="text"  name="plist[#index#].strPrePayAmt" size="5" >预付款金额</th>
						<th type="text"  name="plist[#index#].strRealPayAmt" size="5" >实际付款金额</th>
						<th type="text"  name="plist[#index#].strPrePayDate" size="5" >预计付款日期</th>
						<th type="text"  name="plist[#index#].strBillDate" size="5" >报账日期</th>
						<th type="text"  name="plist[#index#].strBillNo" size="5">报支单号</th>
						<th type="text" name="plist[#index#].strMemo">备注</th>
						<th type="text"  name="plist[#index#].strStatue">状态</th>
						<th >操作</th>
					</tr>
				</thead>
			</table>
			<table id="table22" class="frog-table"style="width: 100%; max-width: 120%;table-layout: fixed; word-break: break-all; word-wrap: break-word">
				<tbody name="ep_enquiry_item" style="overflow-y:auto; ">
				<c:forEach items="${ponoPoissueList}" var="mpPonoPoissue" varStatus="status">
					<tr target="slt_uid" rel="${mpPono.id}"ondblclick="showTaskDetail(this)">
						<td style="width:18px;text-align: center;">
							<input type="checkbox" lay-skin="primary"  name="checkitemMpponoPay" id="${mpPonoPoissue.id}"  lay-filter="checkboxMpPonoPoissue" />
							<input type="hidden" id="payid" value="${mpPonoPoissue.id}">
						</td>
						<input  type="hidden" name="plist[${page.pageBeginCount+status.index}].id" value="${mpPonoPoissue.id}">
						<td>${mpPonoPoissue.strPoNo}</td>
						<td>${mpPonoPoissue.strPayItem}</td>
						<td>${mpPonoPoissue.strPayStale}</td>
						<td>${mpPonoPoissue.strPayment}</td>
						<td>${mpPonoPoissue.strPrePayAmt}</td>
						<td>${mpPonoPoissue.strRealPayAmt}</td>
						<td>${mpPonoPoissue.strPrePayDate}</td>
						<td>${mpPonoPoissue.strBillDate}</td>
						<td>${mpPonoPoissue.strBillNo}</td>
						<td>${mpPonoPoissue.strMemo}</td>
						<td>${mpPonoPoissue.strStatue}</td>
						<td>
							<button type="button" class="edit" onclick="editrowPoissue(this)" name="btneditPoissue">编辑</button>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</form>
	</div>

	<!-- 分页 -->
	<c:import url="/WEB-INF/views/aaSystem/pager/dialogPagerBar.jsp">
		<c:param name="container" value="#tab3"/>
	</c:import>
</div>
