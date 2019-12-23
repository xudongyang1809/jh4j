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
				$("#tab2").load("${ctx}/mpAdvancePay/advanceDtl?id="+id+"&strPayNo="+strPayNo, function(){
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
    form.on('checkbox(checkboxmpPayDetail)', function(data) {
        if ($(data.elem).hasClass("checkAllmpPayDetail")) {
            if (data.elem.checked) {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
            } else {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
            }
            form.render('checkbox');
        }
    });
    // 刷新当前页
	function  refreshindexmpArrival () {
		var loadingIndex = Dialog.load();
		var id = $("#ihid").val();
		var strPayNo = $("#strPayNo").val();
		$("#tab2").load("${ctx}/mpAdvancePay/advanceDtl?id="+id+"&strPayNo="+strPayNo, function(){
			layer.close(loadingIndex);
		});
	}

    //新增插入行
	function epPreparationAddLine() {
		var index = $("tbody[name='ep_enquiry_item']").find("tr").length;
		var num = $("#epPreparationAddLineNumber").val() || 1;
		var html = '';
		for(var n = 0; n < num; n++){
			html += '<tr class="unitBox">'
					+ '<td style="width:18px;">'
                    + '<input type="checkbox"  name="" lay-skin="primary"></td>'
                    + '<td><input type="text"  name="plist['+ index +'].strPayItemNo" id="strPayItemNo"  readonly="readonly"  class="layui-input layui-bg-gray"  value=""  /></td>'
                    + '<td><input type="text"  name="plist['+ index +'].strPoNo"  id="strPoNo'+index+'" value="" lay-verify="required" id="mpArrivalMstrPoNo" placeholder="挑选采购合同" class="layui-input" />'
                    + '<a class="layui-btn layui-btn-sm select-btn" href=\"${ctx}/mpPonoM/findPoNoAndPayMoney?strMpPoNo=strPoNo'+index+'&bdPayAmt=bdPayAmt'+index+'" title="挑选采购合同" width="900" height="550" target="dialog" dialogId="selectmppono" ><i class="layui-icon layui-icon-search"></i></a>'
                    +'</td>'
					+ '<td><input type="text"  name="plist['+index+'].bdPayAmt" id="bdPayAmt'+index+'" value="" class="layui-input"  /></td>'
					+ '<td ><input type="text" name="plist['+index+'].strMemo" id="strMemo" class="layui-input" /></td>'
					+'<td><input name="" class="layui-btn layui-btn-xs" type="button" value="删除"  onclick=\"deltr(this)\"/></td>'
					+ '</tr>';
			index++;
		}
		$("tbody[name='ep_enquiry_item']").append(html);
		form.render('checkbox');
        form.render('select');
	}
    // 新增一行删除一行删除当前一行
    function deltr(opp){
        $(opp).parent().parent().remove();

    }
    // 保存方法
	function mpAdvanceSave() {
				//document.getElementsByName("btneditPoissue").disabled = false;

		$("#mpAdvancePayform").submit();
	}
	//批量删除明细
	function mpAdvanceDelete() {
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
				$.post("${ctx}/mpAdvancePay/deletedtl?ids="+ids  , function (msg) {
					try {
						var result = JSON.parse(msg);
						var messages=result.message;
						Ajax.ajaxDone(result);
						if (result.statusCode == 200) {
							Dialog.success(messages);
							refreshindexmpArrival();   // 刷新当前页
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
		var btbedit = document.getElementsByName("checkitemmpPayDetail");   // 获取button
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
					name = "plist[" + trid + "].strPayItemNo";
					break;
				case 2:
					name = "plist[" + trid + "].strPoNo";
					break;
				case 3:
					name = "plist[" + trid + "].bdPayAmt";
					break;
				case 4:
					name = "plist[" + trid + "].strMemo";
					break;

			}
			if (i == 1)
				tempTd.innerHTML = "<input type='text' lay-verify='required' value='" + tdText + "' size='10' name='" + name + "'/>";
			else if (i == 2)
				tempTd.innerHTML = "<input type='text' lay-verify='required' value='" + tdText + "' size='10' name='" + name + "'/>";
			else
				tempTd.innerHTML = "<input type='text' value='" + tdText + "' size='10' name='" + name + "'/>";
		}
	}



</script>

<div>
	<form id="pagerForm" method="post" action="${ctx}/mpAdvancePay/advanceDtl?id=${ihid}">
		<input type="hidden" name="pageNum" value="${page.pageNum}" />
		<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
		<input type="hidden" name="orderField" value="${page.orderField}" />
		<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
		<input type="hidden" name="keywords" value="${keywords}"/>
		<input type="hidden" name ="ihid" value="${ihid}"/>
	</form>
	<div class="tab-bars">
		<%--<div class="layui-input-block" >
			<input type="hidden" id="strPoNoname33" class="layui-input"  value=""/>
			<input type="text" id="bdPayAmt1" class="layui-input"  value=""/>
			<input name="strPoNo" lay-verify="required"  value="${mpArrivalM.sutrPoNo}" type="text" id="mpArrivalMstrPoNo" class="layui-input" />
			<a class="layui-btn layui-btn-sm select-btn" href="${ctx}/mpPonoM/findPoNoAndPayMoney?strMpPoNo=mpArrivalMstrPoNo&strMpPoName=strPoNoname33&bdPayAmt=bdPayAmt1 " title="挑选采购合同"
			   target="dialog" width="900" height="550" dialogId="selectmppono" ><i class="layui-icon layui-icon-search"></i></a>
		</div>--%>

		<a class="edit btn-small" onclick="mpAdvanceSave()"><span>保存</span></a>
		<a class="delete btn-small" href="#" onclick="mpAdvanceDelete()"><span>删除</span></a>
		<div>
			<button class="layui-btn layui-btn-xs" onclick="epPreparationAddLine()">新增项次</button>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="epPreparationAddLineNumber" value="1">
			</div>
		</div>


	</div>
    <div class="tab-header" style="border:0px;">

	</div>
	<div class="tab-content">
		<form id="mpAdvancePayform" method="post" class="layui-form" action="${ctx}/mpAdvancePay/saveDtl" autocomplete="off"onsubmit="return validateCallback(this, dialogInsertPlanDone);" >

			<input type="hidden" name="ihid" id="ihid" value="${ihid}"/>
			<input type="hidden" name="strPayNo" id="strPayNo" value="${strPayNo}"/>
			<div id="keyupeven">
				<table class="frog-table sticky" style="width: 100%;">
					<thead>
					<tr  id="firstRow">
						<th>
							<input type="checkbox" lay-skin="primary" class="checkAllmpPayDetail" name="checkitemAdvancePay"   lay-filter="checkboxmpPayDetail" >
						</th>
						<th type="text" name="plist[#index#].strPayItemNo" size="10" fieldClass="digits readonly">项次号</th>
						<th type="lookup" name="plist[#index#].strPoNo">合同号 <span style="color:#FF5722;margin-top:0px">*</span></th>
						<th type="text" name="plist[#index#].bdPayAmt">预付款金额<span style="color:#FF5722;margin-top:0px">*</span></th>
						<th type="text" name="plist[#index#].strMemo">说明备注</th>
						<th type="del">操作</th>
					</tr>
					</thead>
                    <tbody name="ep_enquiry_item" style="overflow-y:auto; ">
					<c:forEach items="${mpPayDetaillist}" var="mpPayDetail" varStatus="status">
						<tr target="slt_uid" rel="${mpPayDetail.id}" id="${mpPayDetail.id}" >
							<td style="width:18px;text-align: center;">
								<input type="checkbox" name="checkitemmpPayDetail"  lay-skin="primary" lay-filter="checkboxmpPayDetail">
								<input type="hidden" id="payid" value="${mpPayDetail.id}">
							</td>
							<input type="hidden" name="plist[${page.pageBeginCount+status.index}].id" value="${mpPayDetail.id}">
							<td>${mpPayDetail.strPayItemNo}</td>
							<td>${mpPayDetail.strPoNo}</td>
							<td>${mpPayDetail.bdPayAmt}</td>
							<td>${mpPayDetail.strMemo}</td>
						    <td><button type="button" onclick="editrow(this)" class="edit" name="btnedit">编辑</button>
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
		<c:param name="container" value="#tab2"/>
	</c:import>
</div>
