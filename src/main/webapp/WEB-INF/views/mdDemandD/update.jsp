<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 编辑画面
	 @author 超级管理员 admin
	 @date 2019-05-10 11:32:22
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<head>
<script type="text/javascript">
	function validateUpdateDemandDetail(){
		var strMatrlNo001 = $('#strMatrlNo001').val();
		var bdPlanPrice02 = $('#bdPlanPrice02').val();
		var bdApplyNumber02 = $('#bdApplyNumber02').val();
		if (!strMatrlNo001){
			top.layer.msg("请挑选销售存货编号",{icon:2});
			return true;
		}
		if (!bdPlanPrice02){
			top.layer.msg("建议销售单价不能为空",{icon:2});
			return true;
		}
		if (!bdApplyNumber02){
			top.layer.msg("计划申报数量不能为空",{icon:2});
			return true;
		}
		return false;
	}
	function updateMdDemandDetail() {
		if (validateUpdateDemandDetail()){
			var strApplyNo = $('#strApplyNo').val();
			alert(strApplyNo);
			$.ajax({
				type:"post",
				url:"${ctx}/mdDemandD/update",
				data:$('#DemandDetail_Id1').serialize(),
				dataType:"json",
				success:function (rst) {
					if (rst.statusCode == 200){
						debugger;
						var dialogIndex = Dialog.getCurrentDialog().attr("times");
						if (dialogIndex) {
							layer.close(dialogIndex);
						}
						Dialog.success(rst.message);
						$('#mdDemandDId').load("${ctx}/mdDemandM/demandDetail?strApplyNo="+strApplyNo+"&strOrderNo="+"",{},function () {});
					}else{
						Dialog.error(rst.message);
					}
				},
				error:function (msg) {
					Dialog.warn(msg.message);
				}
			});
		}
	}
</script>
</head>
<div class="tab-bars">
	<shiro:hasPermission name="MdDemandD:edit">
		<a class="edit" onclick="updateMdDemandDetail()">保存</a>
	</shiro:hasPermission>
</div>
<form id="DemandDetail_Id1" class="layui-form" method="post" action="${ctx}/mdDemandD/update" onsubmit="return dialogAjaxDone(this, 'update')">
		<input type="hidden" id="relativedId" name="id" value="${mdDemandD.id}">
		<div class="layui-form-item"></div>
		<div class="layui-form-item">
			<label class="layui-form-label">需求计划编号:</label>
			<div class="layui-input-inline">
				<input type="text" id="strApplyNo" name="strApplyNo" readonly class="layui-input" placeHolder="" value="${mdDemandD.strApplyNo}" />
			</div>
			<label class="layui-form-label">需求计划项次号:</label>
			<div class="layui-input-inline">
				<input type="text" name="strApplyItem" readonly class="layui-input" autocomplete="off" value="${mdDemandD.strApplyItem}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">销售存货编号:</label>
			<div class="layui-input-inline">
				<input type="text" id="strMatrlNo001" name="strMatrlNo" readonly style="background-color: white" class="layui-input" autocomplete="off" placeHolder="请挑选存货编号" value="${mdDemandD.strMatrlNo}" />
				<a class="layui-btn layui-btn-sm" href="${ctx}/mdDemandD/selectSaleMatrlNo" title="请挑选存货编号" target="dialog" width="1000" height="500" dialogId="selectStrMatrlNoId002" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
			</div>
			<label class="layui-form-label">存货名称:</label>
			<div class="layui-input-inline">
				<input type="text" id="strMatrlName02" name="strMatrlName" readonly style="background-color: white" class="layui-input" autocomplete="off" placeHolder="请输入库存单位" value="${mdDemandD.strMatrlName}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">品牌:</label>
			<div class="layui-input-inline">
				<input type="text" id="strBrand02" name="strBrand" readonly style="background-color: white" class="layui-input" autocomplete="off" placeHolder="请输入品名" value="${mdDemandD.strBrand}" />
			</div>
			<label class="layui-form-label">库存单位:</label>
			<div class="layui-input-inline">
				<input type="text" id="strUnit02" name="strUnit" readonly style="background-color: white" class="layui-input" autocomplete="off" placeHolder="请输入品牌" value="${mdDemandD.strUnit}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">型号规格:</label>
			<div class="layui-input-inline">
				<input type="text" id="strSpec02" name="strSpec" readonly style="background-color: white" class="layui-input" autocomplete="off" placeHolder="请输入型号规格" value="${mdDemandD.strSpec}" />
			</div>
			<label class="layui-form-label">建议单价:</label>
			<div class="layui-input-inline">
				<input type="text" id="bdPlanPrice02" name="bdPlanPrice" class="layui-input" autocomplete="off" placeHolder="请输入建议单价" value="${mdDemandD.bdPlanPrice}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">计划申报数量:</label>
			<div class="layui-input-inline">
				<input type="text" id="bdApplyNumber02" name="bdApplyNumber" class="layui-input" autocomplete="off" placeHolder="请输入计划申报数量" value="${mdDemandD.bdApplyNumber}" />
			</div>
			<label class="layui-form-label">状态:</label>
			<div class="layui-input-inline">
				<input type="hidden" name="strStus" value="${mdDemandD.strStus}">
				<input type="text" readonly class="layui-input" autocomplete="off" placeHolder="请输入状态" value="${mdDemandD.strStatuZH}" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注:</label>
			<div class="layui-input-block">
				<textarea type="text" name="strRemark" style="width:540px;height: 100px" class="layui-input" autocomplete="off" placeHolder="请输入备注" value="${mdDemandD.strRemark}"></textarea>
			</div>
		</div>
	<%--<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>--%>
</form>