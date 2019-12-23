<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 创建画面
	 @author 毛敏 022325
	 @date 2019-04-29 18:27:16
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<style>
	.layui-form-label{
		width:110px;
	}
</style>
<script>
	/*批量选择*/
	form.on('checkbox(checkAllMsOrderD)', function(data) {
		if ($(data.elem).hasClass("checkAllMsOrderD")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});
	/*编辑*/
	function updateMsOrderDetail(){
	    debugger;
		var btbedit = document.getElementsByName("check_OrderD");
		var trId;
		var j=0;
		for ( var i = 0; i < btbedit.length; i++) {
			if (btbedit.item(i).checked) {
				j=j+1;
				debugger;
				var tr = btbedit.item(i).parentNode.parentNode;
				trId = $(tr).attr("rel");
			}
		}
		if (trId == undefined){
		    Dialog.warn("未选中一条数据");
		    return;
        }
        $.post("${ctx}/msOrderD/preUpdate?id="+trId,"",function(content){
            top.layer.open({
                type : 1,
                area : [ '1100px', '580px' ],
                title : "编辑销售订单明细",
                shadeClose : true,
                offset : "0px",
                maxmin : true,
                anim : 5,
                content : content
            });
        });
	}
	/*批量删除*/
	function deleteMsOrderD() {
		debugger;
		var strOrderNo = $("#strOrderNo").val();
		/*var msOrderDId = $("#msOrderDId").val();*/
		var msOrderMId = $('#msOrderMId098').val();
		var ids = "";

		var btbedit = document.getElementsByName("check_OrderD");
		var trId;
		var j=0;
		for ( var i = 0; i < btbedit.length; i++) {
			if (btbedit.item(i).checked) {
				j=j+1;
				debugger;
				var tr = btbedit.item(i).parentNode.parentNode;
				trId = $(tr).attr("rel");
				if (ids == "") {
					ids = trId;
				} else {
					ids += "," + trId;
				}
			}
		}
		if (trId == "" || trId == undefined) {
			Dialog.warn("未选中一条以上的数据");
			return;
		}
		layer.confirm("确定删除吗?", {
			btn: ['确定','取消'] //按钮
		}, function()
		{
			$.post("${ctx}/msOrderD/delete?ids="+ids,
					function(msg) {
						try {
							var result = JSON.parse(msg);
							Ajax.ajaxDone(result);
							debugger;
							if (result.statusCode == 200) {

								//$("#msOrderMId0202").load("${ctx}/msOrderM/preUpdate?id="+msOrderMId,{},function(){});
								$('#msOrderDListId').load("${ctx}/msOrderD/preCreateList?strOrderNo="+strOrderNo,{},function(){});
								$('#msOrderMListId').load("${ctx}/msOrderM/list",{},function(){});/*刷新销售订单主页面*/
							}
						} catch (e) {
							console.log(msg);
							Dialog.error(e.message);
						}
					});
		}, function()
		{
			layer.close();
		})
	}
</script>
<div id="msOrderDListId">
	<input type="hidden" id="msOrderMId098" value="${msOrderMId}">
<div class="tab-bars">
	<c:if test="${strStus == null || strStus == 'N'}">
		<shiro:hasPermission name="MsOrderD:create">
			<a class="add" width="1050" height="490" target="dialog" dialogId="createMsOrderDDialog" href="${ctx}/msOrderD/preCreate/?strOrderNo=${strOrderNo}">添加</a>
			<%--<a class="add"  onclick="createMsOrderD()">添加</a>--%>
		</shiro:hasPermission>
		<shiro:hasPermission name="MsOrderD:edit">
			<a class="edit" width="1050" height="490" target="dialog" dialogId="upadteMsOrderDDialog" href="${ctx}/msOrderD/preUpdate?id={slt_uid}">编辑</a>
			<%--<a class="edit" onclick="updateMsOrderDetail()">编辑</a>--%>
		</shiro:hasPermission>
		<shiro:hasPermission name="MsOrderD:delete">
			<%--<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/msOrderD/delete/{slt_uid}">删除</a>--%>
			<a class="deleteList"  onclick="deleteMsOrderD()">批量删除</a>
		</shiro:hasPermission>
	</c:if>
	<c:if test="${strStus == 'S' || strStus == 'X' }">
		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px">
			<legend>非新增状态不可修改</legend>
		</fieldset>
	</c:if>
</div>
	<div class="layui-form">
<table class="frog-table">
	<thead>
	<tr>
		<th><input type="checkbox" lay-skin="primary" class="checkAllMsOrderD" lay-filter="checkAllMsOrderD" ></th>
		<th>序号</th>
		<th>销售订单项次</th>
		<th>销售订单编号</th>
		<th>存货编号</th>
		<th>品名</th>
		<th>品牌</th>
		<th>库存单位</th>
		<th>型号规格</th>
		<th>销售单价</th>
		<th>销售数量</th>
		<%--<th>采购单价</th>
		<th>采购数量</th>--%>
		<th>销售单项总金额</th>
		<th>交货期限</th>
		<th>备注</th>
		<th>状态</th>
	</tr>
	</thead>
	<tbody id="msOrderDBody">
	<c:forEach items="${list}" var="msOrderD" varStatus="status">
		<tr target="slt_uid" rel="${msOrderD.id}" id="${msOrderD.id}">
			<td><input type="checkbox" name="check_OrderD" data-value="${msOrderD.id}" lay-skin="primary"  lay-filter="checkAllMsOrderD"/></td>
			<td>${page.pageBeginCount + status.index + 1}</td>
			<td>${msOrderD.strOrderItem}</td>
			<td>${msOrderD.strOrderNo}</td>
			<td>${msOrderD.strMatrlNo}</td>
			<td>${msOrderD.strMatrlName}</td>
			<td>${msOrderD.strBrand}</td>
			<td>${msOrderD.strUnit}</td>
			<td>${msOrderD.strSpec}</td>
			<td>${msOrderD.bdSalePrice}</td>
			<td>${msOrderD.bdSaleQty}</td>
			<%--<td>${msOrderD.bdPurchasePrice}</td>
			<td>${msOrderD.bdPurchaseQty}</td>--%>
			<td>${msOrderD.bdItemAmt}</td>
			<td>${msOrderD.strDate}</td>
			<td>${msOrderD.strRemark}</td>
			<td>${msOrderD.strStatuZH}</td>
			<td style="display:none" id="strOrderNo" value="${msOrderD.strOrderNo}"></td>
			<td style="display:none">
				<input type="hidden" id="msOrderDId" value="${msOrderD.id}"/>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
	</div>
</div>