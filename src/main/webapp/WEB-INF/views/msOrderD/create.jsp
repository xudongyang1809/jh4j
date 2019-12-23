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
		width:100px;
	}
</style>
<script>
	function valiCreateMsOrderD(){
		var strOrderNo = $('#strOrderNo').val();
		var strMatrlNo = $('#strMatrlNo').val();
		var bdSalePrice = $('#bdSalePrice').val();
		var bdSaleQty = $('#bdSaleQty').val();
		if (!strOrderNo){
			top.layer.msg("请先添加主档信息");
			return false;
		}
		if(!strMatrlNo){
			top.layer.msg("请挑选销售存货编号",{icon:2});
			return false;
		}
		if(!bdSalePrice){
			top.layer.msg("销售单价不能为空",{icon:2});
			return false;
		}
		if(!bdSaleQty){
			top.layer.msg("销售数量不能为空",{icon:2});
			return false;
		}
		return true;
	}
	var strOrderNo = $("#strOrderNo").val();
	function createMsOrderD(){
		if(valiCreateMsOrderD()){
			debugger;
			var id1 = $('#id').val();
			$.ajax({
				type:"post",
				url:"${ctx}/msOrderD/create",
				data:$('#msOrderD_1').serialize(),
				dataType:"json",
				success:function(rst){
					/* Ajax.ajaxDone(rst); */
					if(rst.statusCode == 200) {
					    debugger;
						var dialogIndex = Dialog.getCurrentDialog().attr("times");
						if (dialogIndex) {
							layer.close(dialogIndex);
						}
						Dialog.success(rst.message);
						//$("#msOrderMId0202").load("${ctx}/msOrderM/preUpdate?id="+id1,{},function(){});
						$('#msOrderDListId').load("${ctx}/msOrderD/preCreateList?strOrderNo="+strOrderNo,{},function(){});/*刷新销售订单明细页面*/
						$('#msOrderMListId').load("${ctx}/msOrderM/list",{},function(){});/*刷新销售订单主页面*/
					}else{
						Dialog.error(rst.message);
					}
				},
				error:function(msg){
					Dialog.warn(msg.message);
				}
			});
		}
	}
	function selectByMatrlNo(){
	    var strMatrlNo = $('#strMatrlNo').val();
		$.ajax({
			type:"post",
			url:"${ctx}/msOrderD/selectSaleMatrlNo",
			dataType:"json",
			success:function (data) {
				// $('#strMatrlName').val(data.strMatrlName);
			}
		});
	}
</script>
<div class="tab-bars">
	<shiro:hasPermission name="MsOrderD:create">
		<%--<a class="add" width="500" height="500" target="dialog" dialogId="createMsOrderDDialog" href="${ctx}/msOrderD/preCreate">保存</a>--%>
		<a class="add" href="#" onclick="createMsOrderD()"><span>保存</span></a>
	</shiro:hasPermission>
	<%--<shiro:hasPermission name="MsOrderD:edit">
		<a class="edit" width="500" height="500" target="dialog" dialogId="upadteMsOrderDDialog" href="${ctx}/msOrderD/preUpdate/{slt_uid}">编辑</a>
	</shiro:hasPermission>
	<shiro:hasPermission name="MsOrderD:delete">
		<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/msOrderD/delete/{slt_uid}">删除</a>
	</shiro:hasPermission>--%>
</div>
<form class="layui-form" method="post" id="msOrderD_1" action="${ctx}/msOrderD/create" onsubmit="return dialogAjaxDone(this, 'create')">
	<input type="hidden" id="strOrderNo"  value="${strOrderNo}"/>
	<input type="hidden" id="id" value="${id}">
	<input type="hidden" id="strOrderStyle" value="${strOrderStyle}">
	<div class="layui-form-item"></div>
	<div class="layui-form-item">
		<label class="layui-form-label">销售订单编号:</label>
		<div class="layui-input-inline">
			<input type="text" class="layui-input" name="strOrderNo" value="${strOrderNo}" readonly autocomplete="off" placeHolder="请输入销售订单编号" />
		</div>
		<label class="layui-form-label">销售订单项次:</label>
		<div class="layui-input-inline">
			<input type="text" class="layui-input" id="strOrderItem" name="strOrderItem" value="${strOrderItem}" readonly autocomplete="off" placeHolder="请输入销售订单项次" />
		</div>
		<label class="layui-form-label">存货编号:</label>
		<div class="layui-input-inline">
			<input type="text"  class="layui-input" id="strMatrlNo" name="strMatrlNo" style="background-color: white" readonly lay-verify="required" autocomplete="off" placeHolder="请挑选存货编号" />
			<a class="layui-btn layui-btn-sm" href="${ctx}/msOrderD/selectSaleMatrlNo?strOrderStyle=${strOrderStyle}" title="请挑选销售订单编号" target="dialog" width="1000" height="500" dialogId="selectStrMatrlNoId001" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">品名:</label>
		<div class="layui-input-inline">
			<input type="text" id="strMatrlName" name="strMatrlName" value="" style="background-color: white" readonly class="layui-input" autocomplete="off" placeHolder="" value="${msOrderD.strMatrlName}" />
		</div>
		<label class="layui-form-label">品牌:</label>
		<div class="layui-input-inline">
			<input type="text" id="strBrand" name="strBrand" value="" style="background-color: white" readonly class="layui-input" autocomplete="off" placeHolder="" value="${msOrderD.strBrand}" />
		</div>
		<label class="layui-form-label">库存单位:</label>
		<div class="layui-input-inline">
			<input type="text" id="strUnit" name="strUnit" value="" style="background-color: white" readonly class="layui-input" autocomplete="off" placeHolder="" value="${msOrderD.strUnit}" />
		</div>
	</div>
	<div class="layui-form-item">
		<label class="layui-form-label">型号规格:</label>
		<div class="layui-input-inline">
			<input type="text" class="layui-input" id="strSpec" name="strSpec" value="" style="background-color: white" readonly autocomplete="off" placeHolder="" />
		</div>
		<label class="layui-form-label">销售单价:</label>
		<div class="layui-input-inline">
			<input type="text" class="layui-input" id="bdSalePrice" name="bdSalePrice" lay-verify="required" autocomplete="off" placeHolder="请输入销售单价" />
		</div>
		<label class="layui-form-label">销售数量:</label>
		<div class="layui-input-inline">
			<input type="text" class="layui-input" id="bdSaleQty" name="bdSaleQty" lay-verify="required" autocomplete="off" placeHolder="请输入销售数量" />
		</div>
	</div>
	<div class="layui-form-item">
		<%--<label class="layui-form-label">采购单价:</label>
		<div class="layui-input-inline">
			<input type="text" class="layui-input" id="bdPurchasePrice" name="bdPurchasePrice" autocomplete="off" placeHolder="请输入采购单价" />
		</div>
		<label class="layui-form-label">采购数量:</label>
		<div class="layui-input-inline">
			<input type="text" class="layui-input" id="bdPurchaseQty" name="bdPurchaseQty" autocomplete="off" placeHolder="请输入采购数量" />
		</div>--%>
		<label class="layui-form-label">交货期限:</label>
		<div class="layui-input-inline">
			<input type="text" class="layui-input" id="strDate" name="strDate" autocomplete="off" placeHolder="请输入交货期限" />
		</div>
		<%--<label class="layui-form-label">销售单项总金额:</label>--%>
		<%--<div class="layui-input-inline">--%>
			<%--<input type="text" class="layui-input" name="bdItemAmt" autocomplete="off" placeHolder="请输入销售单项总金额" />--%>
		<%--</div>--%>
	</div>
	<%--<div class="layui-form-item">
		<label class="layui-form-label">状态:</label>
		<div class="layui-input-inline">
			<input type="text" class="layui-input" id="strStus" name="strStus" readonly autocomplete="off" placeHolder="" />
		</div>
	</div>--%>
	<div class="layui-form-item">
		<label class="layui-form-label">备注:</label>
		<div class="layui-input-inline">
			<textarea class="layui-input" id="strRemark" name="strRemark" style="width: 540px;height: 80px" autocomplete="off" placeHolder="请输入备注"></textarea>
		</div>
	</div>
	<%--<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>--%>
</form>

