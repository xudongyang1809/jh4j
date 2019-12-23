<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 编辑画面
	 @author 超级管理员 admin
	 @date 2019-04-29 17:54:44
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<style>
	.layui-form-label{
		width: 120px;
	}
</style>
<script type="text/javascript">
	var strOrderNo = $("#strOrderNo").val();
	function loadTab(num){
		var id=$("#relativedId").val();
		var loadingIndex = Dialog.load();
		if(num == '1')
			$("#updateMsOrderId123").load("${ctx}/msOrderM/preUpdate?id="+id,{},
					function(){
						layer.close(loadingIndex);
					});
		var strOrderNo=$('#strOrderNo').val();
		if(num == '2')
			$("#tab"+num).load("${ctx}/msOrderD/preCreateList?strOrderNo="+strOrderNo,{},
			function(){
				layer.close(loadingIndex);
			});
	}
	function validateupdateMsOrderM(){
		var strOrderName = $('#strOrderName02').val();
		var strVendorNo = $('#strVendorNoNameMpplan').val();
		if (!strOrderName) {
			Dialog.warn("销售订单名称不能为空",{icon:2});
			return false;
		}
		if (!strVendorNo){
			Dialog.warn("客户编号不能为空",{icon:2});
			return false;
		}
		return true;
	}
	/*保存*/
	function updateMsOrderM(){
		if (validateupdateMsOrderM()){
			$.ajax({
				type:"post",
				url:"${ctx}/msOrderM/update",
				data:$('#msOrderM_2').serialize(),
				datatype:"json",
				success:function(rst){
					/* Ajax.ajaxDone(rst); */
					var data = JSON.parse(rst);
					if(data.statusCode == 200) {
						$('#msOrderMListId').load("${ctx}/msOrderM/list",{},function(){});
						Dialog.success(data.message);
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
	/*
	 * 选择业务人员的回调方法
	 */
	function selectSingleUserCallback03(userId, userNo, username) {
		$('#userId1_strOperator01').val(userId);
		$('#userNo1_strOperator01').val(userNo);
		$('#username1_strOperator01').val(username);
	}
	/*选择甲方经办人的回调方法*/
	function selectSingleUserCallback04(userId, userNo, username) {
		$('#userId1_strApplyUserId01').val(userId);
		$('#userNo1_strApplyUserId01').val(userNo);
		$('#username1_strApplyUserId01').val(username);
	}
	layui.use('laydate', function(){
		var laydate = layui.laydate;
		laydate.render({
			elem: '#strDeliveryDate002'
			,trigger: 'click'
		});
		form.render();
		laydate.render({
			elem: '#strDateFrom002'
			,trigger: 'click'
		});
		laydate.render({
			elem: '#strDateTo002'
			,trigger: 'click'
		});
	});
	form.render();
</script>
<div id="updateMsOrderId123">
<div class="layui-tab" id="layui-tab">
	<ul class="layui-tab-title">
		<li class="layui-this" onclick="loadTab('1')">订单主档</li>
		<li onclick="loadTab('2')">订单明细</li>
	</ul>
	<div class="layui-tab-content">
		<div id="tab1" class="layui-tab-item layui-show">
			<div class="tab-bars">
				<c:if test="${msOrderM.strStus == null || msOrderM.strStus == 'N'}">
					<shiro:hasPermission name="MsOrderM:create">
						<a class="add" href="#" onclick="updateMsOrderM()"><span>保存</span></a>
					</shiro:hasPermission>
				</c:if>
				<c:if test="${msOrderM.strStus == 'S' || msOrderM.strStus == 'X'}">
					<fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px">
						<legend>非新增状态不可修改</legend>
					</fieldset>
				</c:if>
			</div>
			<form class="layui-form" method="post" id="msOrderM_2" action="${ctx}/msOrderM/update" onsubmit="return dialogAjaxDone(this, 'update')">
					<input type="hidden" id="relativedId" name="id" value="${msOrderM.id}">
				<div class="layui-form-item"></div>
					<div class="layui-form-item">
						<label class="layui-form-label">销售订单编号:</label>
						<div class="layui-input-inline">
							<input type="text" id="strOrderNo" name="strOrderNo" class="layui-input" readonly placeHolder="" value="${msOrderM.strOrderNo}" />
						</div>
						<label class="layui-form-label">销售订单类型:</label>
						<div class="layui-input-inline">
							<%--<input type="text" name="strOrderStyle" class="layui-input" placeHolder="请输入销售订单类型" value="${msOrderM.strOrderStyle}" />--%>
							<select class="layui-input" id="strOrderStyle" name="strOrderStyle" lay-verify="required">
								<c:forEach items="${msOrderType}" var="item">
									<option value="${item.strValue}" ${msOrderM.strOrderStyle eq item.strValue ? 'selected' : '' }>${item.strDescDtl}</option>
								</c:forEach>
							</select>
						</div>
						<label class="layui-form-label">销售订单名称:</label>
						<div class="layui-input-inline">
							<input type="text" name="strOrderName" id="strOrderName02" class="layui-input" placeHolder="请输入销售订单名称" value="${msOrderM.strOrderName}" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">客户编号:</label>
						<div class="layui-input-inline">
							<%--<input type="text" name="strVendorNo" class="layui-input" placeHolder="请输入客户编号" value="${msOrderM.strVendorNo}" />--%>
							<input type="hidden" id="strVendorNoMpplan" name="strVendorNo">
							<input type="text" lay-verify="required" id="strVendorNoNameMpplan" readonly="readonly" value="${msOrderM.strVendorNo}"  placeholder="请挑选客户编号" style="background-color: white" class="layui-input" postField="keyword" lookupGroup="org2t"/>
							<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
							<a class="layui-btn layui-btn-sm select-btn"
							   href="${ctx}/mcInfomationM/listMerchant?strVendorNo1=strVendorNoMpplan&strVendorName1=strVendorNameMpplan&strVendorNoName=strVendorNoNameMpplan"
							   lookupGroup="org2t" target="dialog" dialogId="selectMerchantDialog" rel="selectCmMerchant" title="供应商" width="800" height="480"><i class="layui-icon layui-icon-search"></i></a>
						</div>
						<label class="layui-form-label">甲方经办人:</label>
						<div class="layui-input-inline">
							<input type="text" name="strOperator" class="layui-input" placeHolder="请输入甲方经办人" value="${msOrderM.strOperator}" />
							<%--<div class="layui-input-inline">
								<input type="hidden" id="userId1_strOperator01" name="strOperator" />
								<input type="hidden" id="userNo1_strOperator01" />
								<input type="text" id="username1_strOperator01" value="${msOrderM.strOperatorZH}"  placeholder="点击挑选人员..." readonly class="layui-input" style="padding-right: 50px;" />
								<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
								<a class="layui-btn layui-btn-sm" onPickUser="selectSingleUserCallback03" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
							</div>--%>
						</div>
						<label class="layui-form-label">销售订单金额:</label>
						<div class="layui-input-inline">
							<input type="text" name="bdPlanAmt" class="layui-input" readonly placeHolder="销售订单金额" value="${msOrderM.bdPlanAmt}" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">业务人员:</label>
						<div class="layui-input-inline">
							<%--<input type="text" name="strApplyUserId" class="layui-input" placeHolder="请输入业务人员" value="${msOrderM.strApplyUserId}" />--%>
							<div class="layui-input-inline">
								<input type="hidden" id="userId1_strApplyUserId01" name="strApplyUserId" />
								<input type="hidden" id="userNo1_strApplyUserId01" />
								<input type="text" id="username1_strApplyUserId01" value="${msOrderM.strApplyUserIdZH}" placeholder="点击挑选人员..." readonly class="layui-input" style="padding-right: 50px;" />
								<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
								<a class="layui-btn layui-btn-sm" onPickUser="selectSingleUserCallback04" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
							</div>
						</div>
						<label class="layui-form-label">订单开始日期:</label>
						<div class="layui-input-inline">
							<input type="text" id="strDateFrom002" name="strDateFrom" class="layui-input" placeHolder="点击挑选订单开始日期" value="${msOrderM.strDateFrom}" />
						</div>
						<label class="layui-form-label">订单结束日期:</label>
						<div class="layui-input-inline">
							<input type="text" id="strDateTo002" name="strDateTo" class="layui-input" placeHolder="点击挑选订单结束日期" value="${msOrderM.strDateTo}" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">交期:</label>
						<div class="layui-input-inline">
							<input type="text" id="strDeliveryDate002" name="strDeliveryDate" class="layui-input" placeHolder="点击挑选交期" value="${msOrderM.strDeliveryDate}" />
						</div>
						<label class="layui-form-label">状态:</label>
						<div class="layui-input-inline">
							<input type="hidden" name="strStus" value="${msOrderM.strStatu}">
							<input type="text" class="layui-input" readonly placeHolder="" value="${msOrderM.strStatuZH}" />
						</div>
						<%--<label class="layui-form-label">税率:</label>
						<div class="layui-input-inline">
							<input type="text" name="bdTaxRate" class="layui-input" placeHolder="请输入税率" value="${msOrderM.bdTaxRate}" />
						</div>--%>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">备注:</label>
						<div class="layui-input-inline">
							<textarea class="layui-input" name="strRemark" style="width: 540px;height: 80px"  autocomplete="off" placeHolder="请输入备注">${msOrderM.strRemark}</textarea>
						</div>
					</div>
				<%--<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>--%>
			</form>
		</div>
		<div id="tab2" class="layui-tab-item">
		</div>
	</div>
</div>
</div>

