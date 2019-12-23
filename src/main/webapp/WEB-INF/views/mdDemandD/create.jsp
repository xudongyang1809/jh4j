<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 创建画面
	 @author 超级管理员 admin
	 @date 2019-05-10 11:32:22
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<script>
	function validateCreateDemandDetail(){
		var strMatrlNo02 = $('#strMatrlNo02').val();//销售存货编号
		var bdPlanPrice = $('#bdPlanPrice01').val();//建议单价
		var bdApplyNumber = $('#bdApplyNumber01').val();//计划申报数量
		if (!strMatrlNo02){
			top.layer.msg("请挑选销售存货编号",{icon:2});
			return true;
		}
		if (!bdPlanPrice) {
			top.layer.msg("建议单价不能为空",{icon:2});
			return true;
		}
		if (!bdApplyNumber) {
			top.layer.msg("计划申报数量不能为空",{icon:2});
			return true;
		}
		return false;
	}
	function createDemandDDetail() {
		if (validateCreateDemandDetail()) {
			var strApplyNo = $('#strApplyNo').val();
			$.ajax({
				type:"post",
				url:"${ctx}/mdDemandD/create",
				data:$('#DemandDetail_Id').serialize(),
				dataType:"json",
				success:function(rst){
					if(rst.statusCode == 200) {
						var dialogIndex = Dialog.getCurrentDialog().attr("times");
						if (dialogIndex) {
							layer.close(dialogIndex);
						}
						$("#mdDemandDId").load("${ctx}/mdDemandM/demandDetail?strApplyNo="+strApplyNo+"&strOrderNo="+"",{},function(){});
						Dialog.success(rst.message);
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
</script>
<div class="tab-bars">
	<shiro:hasPermission name="MdDemandD:create">
		<a class="add" onclick="createDemandDDetail()">保存</a>
	</shiro:hasPermission>
</div>
<form class="layui-form" id="DemandDetail_Id" method="post" action="${ctx}/mdDemandD/create" onsubmit="return dialogAjaxDone(this, 'create')">
	<input type="hidden" id="strApplyNo" value="${strApplyNo}">
		<div class="layui-form-item"></div>
		<div class="layui-form-item">
			<label class="layui-form-label">需求计划编号:</label>
	    	<div class="layui-input-inline">
				<input type="text" class="layui-input" value="${strApplyNo}" name="strApplyNo" readonly autocomplete="off"/>
			</div>
			<label class="layui-form-label">需求计划项次号:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" value="${strApplyItem}" name="strApplyItem" autocomplete="off" readonly placeHolder="请输入需求计划项次号" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">销售存货编号:</label>
	    	<div class="layui-input-inline">
				<input type="text" class="layui-input" id="strMatrlNo02" name="strMatrlNo" readonly style="background-color: white" autocomplete="off" placeHolder="请挑选存货编号" />
				<a class="layui-btn layui-btn-sm" href="${ctx}/mdDemandD/selectSaleMatrlNo" title="请挑选销售订单编号" target="dialog" width="1000" height="500" dialogId="selectStrMatrlNoId002" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
			</div>
			<label class="layui-form-label">存货名称:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="strMatrlName02" name="strMatrlName" readonly style="background-color: white" autocomplete="off" placeHolder="" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">品牌:</label>
	    	<div class="layui-input-inline">
				<input type="text" class="layui-input" id="strBrand02" name="strBrand" readonly style="background-color: white" autocomplete="off" placeHolder="" />
			</div>
			<label class="layui-form-label">库存单位:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="strUnit02" name="strUnit" readonly style="background-color: white" autocomplete="off" placeHolder="" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">型号规格:</label>
	    	<div class="layui-input-inline">
				<input type="text" class="layui-input" id="strSpec02" name="strSpec" readonly style="background-color: white" autocomplete="off" placeHolder="" />
			</div>
			<label class="layui-form-label">建议单价:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" id="bdPlanPrice01" name="bdPlanPrice" autocomplete="off" placeHolder="请输入建议单价" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">计划申报数量:</label>
	    	<div class="layui-input-inline">
				<input type="text" class="layui-input" id="bdApplyNumber01" name="bdApplyNumber" autocomplete="off" placeHolder="请输入计划申报数量" />
			</div>
			<%--<label class="layui-form-label">状态:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strStus" autocomplete="off" placeHolder="" />
			</div>--%>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注:</label>
	    	<div class="layui-input-block">
				<textarea type="text" class="layui-input" style="width:540px;height: 100px" name="strRemark" autocomplete="off" placeHolder="请输入备注" ></textarea>
			</div>
		</div>
	<%--<div class="dialogFooter"><button class="layui-btn">提交</button></div>--%>
</form>
