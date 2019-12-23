<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 编辑画面
	 @author 毛敏 022325
	 @date 2019-04-29 18:27:16
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<style>
	.layui-form-label{
		width:120px;
	}
</style>
<script type="text/javascript">
	function valiUpdateMsOrderD(){
		var strMatrlNo = $('#strMatrlNo').val();
		var bdSalePrice = $('#bdSalePrice').val();
		var bdSaleQty = $('#bdSaleQty').val();
		if(!strMatrlNo){
			top.layer.msg("请挑选销售存货编号",{icon:2});
			return false;
		}
		if(!bdSalePrice){
			top.layer.msg("销售价格不能为空",{icon:2});
			return false;
		}
		if(!bdSaleQty){
			top.layer.msg("销售数量不能为空",{icon:2});
			return false;
		}
		return true;
	}
	function updateMsOrderD(){
		debugger;
		var id1 = $('#msOrderMId').val();
		var strOrderNo0202 = $('#strOrderNo0202').val();
		if(valiUpdateMsOrderD()){
			$.ajax({
				type:"post",
				url:"${ctx}/msOrderD/update",
				data:$('#msOrderD_2').serialize(),
				datatype:"json",
				success:function(rst){
					/* Ajax.ajaxDone(rst); */
					var data = JSON.parse(rst);
					if(data.statusCode == 200) {
						var dialogIndex = Dialog.getCurrentDialog().attr("times");
						if (dialogIndex) {
							layer.close(dialogIndex);
						}
						//$("#msOrderMId0202").load("${ctx}/msOrderM/preUpdate?id="+id1,{},function(){});
						$('#msOrderDListId').load("${ctx}/msOrderD/preCreateList?strOrderNo="+strOrderNo0202,{},function(){});
						$('#msOrderMListId').load("${ctx}/msOrderM/list",{},function(){});/*刷新销售订单主页面*/
					}else{
						Dialog.error(data.message);
					}
				},
				error:function(msg){
					Dialog.warn(msg.message);
				}
			});
		}
	}
</script>
<form class="layui-form" method="post" action="${ctx}/msOrderD/update" onsubmit="return dialogAjaxDone(this, 'update')" id="msOrderD_2">
		<input type="hidden" id="relativedId" name="id" value="${msOrderD.id}">
        <input type="hidden" id="strOrderNo0202" value="${strOrderNo}">
		<input type="hidden" id="msOrderMId" value="${msOrderMId}">
		<input type="hidden" value="${strOrderStyle}">
		<div class="layui-form-item"></div>
		<div class="layui-form-item">
			<label class="layui-form-label">销售订单编号:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strOrderNo" value="${msOrderD.strOrderNo}" readonly autocomplete="off" placeHolder="请输入销售订单编号" />
			</div>
			<label class="layui-form-label">销售订单项次:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strOrderItem" value="${msOrderD.strOrderItem}" readonly autocomplete="off" placeHolder="请输入销售订单项次" />
			</div>
			<label class="layui-form-label">存货编号:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="strMatrlNo" name="strMatrlNo" value="${msOrderD.strMatrlNo}" readonly lay-verify="required" autocomplete="off" placeHolder="请输入存货编号" />
				<a class="layui-btn layui-btn-sm" href="${ctx}/msOrderD/selectSaleMatrlNo?strOrderStyle=${strOrderStyle}" title="请挑选销售订单编号" target="dialog" width="1000" height="500" dialogId="selectStrMatrlNoId001" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">品名:</label>
			<div class="layui-input-inline">
				<input type="text" id="strMatrlName" name="strMatrlName" readonly class="layui-input" placeHolder="请输入品名" value="${msOrderD.strMatrlName}" />
			</div>
			<label class="layui-form-label">品牌:</label>
			<div class="layui-input-inline">
				<input type="text" id="strBrand" name="strBrand" readonly class="layui-input" placeHolder="请输入品牌" value="${msOrderD.strBrand}" />
			</div>
			<label class="layui-form-label">库存单位:</label>
			<div class="layui-input-inline">
				<input type="text" id="strUnit" name="strUnit" readonly class="layui-input" placeHolder="请输入库存单位" value="${msOrderD.strUnit}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">型号规格:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="strSpec" name="strSpec" readonly value="${msOrderD.strSpec}" autocomplete="off" placeHolder="请输入型号规格" />
			</div>
			<label class="layui-form-label">销售单价:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="bdSalePrice" name="bdSalePrice" value="${msOrderD.bdSalePrice}" lay-verify="required" autocomplete="off" placeHolder="请输入销售单价" />
			</div>
			<label class="layui-form-label">销售数量:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="bdSaleQty" name="bdSaleQty" value="${msOrderD.bdSaleQty}" lay-verify="required" autocomplete="off" placeHolder="请输入销售数量" />
			</div>
		</div>
		<div class="layui-form-item">
			<%--<label class="layui-form-label">采购单价:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="bdPurchasePrice" value="${msOrderD.bdPurchasePrice}" autocomplete="off" placeHolder="请输入采购单价" />
			</div>
			<label class="layui-form-label">采购数量:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="bdPurchaseQty" value="${msOrderD.bdPurchaseQty}" autocomplete="off" placeHolder="请输入采购数量" />
			</div>--%>
			<label class="layui-form-label">交货期限:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strDate" value="${msOrderD.strDate}"  autocomplete="off" placeHolder="请输入交货期限" />
			</div>
			<%--<label class="layui-form-label">销售单项总金额:</label>--%>
			<%--<div class="layui-input-inline">--%>
			<%--<input type="text" class="layui-input" name="bdItemAmt" autocomplete="off" placeHolder="请输入销售单项总金额" />--%>
			<%--</div>--%>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">状态:</label>
			<div class="layui-input-inline">
				<input type="hidden" name="strStus" value="${msOrderD.strStatu}">
				<input type="text" class="layui-input" value="${msOrderD.strStatuZH}" readonly autocomplete="off" placeHolder="请输入状态" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注:</label>
			<div class="layui-input-inline">
				<textarea class="layui-input" name="strRemark" style="width: 540px;height: 80px" autocomplete="off" placeHolder="请输入备注">${msOrderD.strRemark}</textarea>
			</div>
		</div>
	<div class="dialogFooter"><button <%--type="submit"--%> class="layui-btn" onclick="updateMsOrderD()">提交</button></div>
</form>
