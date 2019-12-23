<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 创建画面
	 @author 毛敏 022325
	 @date 2019-05-09 08:55:40
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<style>
	.layui-form-label{
		width: 120px;
	}
</style>
<div id="mdDemandId1">
<script>
	function loadTab(num){
	    debugger;
		var id=$("#msOrderM").val();
		var strApplyNo = $('#strApplyNo').val();
		var strOrderNo=$("#strOrderNoName001").val();
		//alert(strOrderNo);
		var strTypeId = $("#strTypeId02020").val();
		//alert(strTypeId);
		var loadingIndex = Dialog.load();
		if(num == '2'){
			 $("#tab"+num).load("${ctx}/mdDemandM/demandDetail?strApplyNo="+strApplyNo+"&strOrderNo="+strOrderNo,{},
	                    function(){
	                        layer.close(loadingIndex);
	                    });
		}
		 layer.close(loadingIndex);
	}
	layui.use('laydate', function(){
		var laydate = layui.laydate;
		/*laydate.render({
			elem: '#strPlanYearMo',
			type:'month'
			,trigger: 'click'
		});*/
        laydate.render({
            elem: '#strPlanYearMo'
           ,format: 'yyyyMM'
        });
		laydate.render({
			elem: '#strDemandDate01',
				type:'date'
				,trigger: 'click'
	    });
	});
	function valiMdDemandM() {
		var strApplyNo = $('#strApplyNo').val();
		var strOrderNo = $('#strOrderNoName001').val();
		var strApplyName = $('#strApplyName').val();
		debugger;
		var strTypeId = $('#strTypeId02330').val();/*销售类型*/
		form.render('select');
		var strPlanYearMo = $('#strPlanYearMo').val();
		var strDept = $('#deptName1_strDept').val();
		var strRecipientId = $('#username1_strRecipientId').val();
		var strDemandUserId = $('#username1_strDemandUserId').val();
		/*var strVendorNoNameMpplan = $('#strVendorNoNameMpplan').val();*/
		var strDemandDate01 = $('#strDemandDate01').val();
		if (!strApplyNo){
			top.layer.msg("需求计划编号不能为空" ,{icon:2});
			return false;
		}
		if (!strApplyName){
			top.layer.msg("需求计划名称不能为空",{icon:2});
			return false;
		}
		/*if(!strTypeId){
			top.layer.msg("计划类型不能为空",{icon:2});
			return false;
		}*/
		if (!strPlanYearMo){
			top.layer.msg("计划年月不能为空",{icon:2});
			return false;
		}
		if(!strDept){
			top.layer.msg("申请部门不能为空",{icon:2});
			return false;
		}
		if (!strRecipientId){
			top.layer.msg("请挑选平衡接收人",{icon:2});
			return false;
		}
		if (!strDemandUserId){
			top.layer.msg("申请人不能为空",{icon:2});
			return false;
		}
		/*if (!strVendorNoNameMpplan){
			top.layer.msg("客户编号不能为空",{icon:2});
			return flase;
		}*/
		if (!strDemandDate01){
			top.layer.msg("申请日期不能为空",{icon:2});
			return false;
		}
		return true;
	}
	function createMdDemandM() {
		if(valiMdDemandM()){
			var id;
			$.ajax({
				type:"post",
				url:"${ctx}/mdDemandM/create",
				data:$('#mdDemand_1').serialize(),
				datatype:"json",
				success:function (rst) {
					debugger;
					var data = JSON.parse(rst);
					if(data.statusCode == 200){
						Dialog.success(data.message);
						debugger;
						var id1 = data.rel;
						$("#mdDemandMId0220").load("${ctx}/mdDemandM/preUpdate?id="+id1,{},function(){});
						$('#mdDemandMId').load("${ctx}/mdDemandM/list",{},function () {});
					}else {
						Dialog.error(data.message);
					}
				},
				error:function () {
					Dialog.warn(warn.message);
				}
			});
		}
	}
	/*挑选销售订单号后带回供应商编号*/
	/*function selectStrOrd(){
		debugger;
		$.ajax({
			type:"post",
			url:"${ctx}/mdDemandM/orderList?strOrderNo1=strOrderNoName",
			dataType:"json",
			success:function (rst) {
				alert(rst);
			},
			error:function () {
				Dialog.warn(warn.message);
			}
		});
	}*/
	/*选择申请部门的回调方法*/
	function selectSingleDepartmentCallback(deptId, deptNo, deptName) {
		$('#deptId1_strDept').val(deptId);
		$('#deptNo1_strDept').val(deptNo);
		$('#deptName1_strDept').val(deptName);
	}
	/*选择平衡接收人的回调方法*/
	function selectStrRecipientId(userId, userNo, username) {
		$('#userId1_strRecipientId').val(userId);
		$('#userNo1_strRecipientId').val(userNo);
		$('#username1_strRecipientId').val(username);
	}
	/*选择申请人员的回调方法*/
	function selectStrDemandUserId(userId, userNo, username) {
		$('#userId1_strDemandUserId').val(userId);
		$('#userNo1_strDemandUserId').val(userNo);
		$('#username1_strDemandUserId').val(username);
	}
</script>
<div id="mdDemandMId0220">
<div class="layui-tab" id="layui-tab">
	<ul class="layui-tab-title">
		<li class="layui-this" onclick="loadTab('1')">需求申报主档</li>
		<li onclick="loadTab('2')">需求申报明细</li>
	</ul>
	<div class="layui-tab-content">
		<div id="tab1" class="layui-tab-item layui-show">
			<div class="tab-bars">
				<shiro:hasPermission name="MdDemandM:create">
					<a class="add" href="#" onclick="createMdDemandM()"><span>保存</span></a>
				</shiro:hasPermission>
			</div>
			<form class="layui-form" method="post" action="${ctx}/mdDemandM/create" id="mdDemand_1" onsubmit="return dialogAjaxDone(this, 'create')">
				<div class="layui-form-item"></div>
					<div class="layui-form-item">
						<label class="layui-form-label">需求计划编号:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" id="strApplyNo" name="strApplyNo" readonly value="${strApplyNo}" autocomplete="off" lay-verify="required" placeHolder="请输入需求计划编号" />
						</div>
						<label class="layui-form-label">销售订单编号:</label>
						<div class="layui-input-inline">
							<div class="layui-input-inline" style="width: 190px">
								<input id="strOrderNoName001" name="strOrderNo" class="layui-input" type="text" readonly style="padding-right: 50px;background-color:white;" placeHolder="请挑选销售订单编号"/>
								<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
								<a class="layui-btn layui-btn-sm" href="${ctx}/mdDemandM/orderList?strOrderNo1=strOrderNoName" title="请挑选销售订单编号" target="dialog" width="1000" height="500" dialogId="selectStrOrdNoDialogId1" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
							</div>
						</div>
						<label class="layui-form-label">需求计划名称:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" id="strApplyName" name="strApplyName" lay-verify="required" autocomplete="off" placeHolder="请输入需求计划名称" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">业务类型:</label>
						<div class="layui-input-inline">
                            <select  class="layui-input" id="strTypeId02020" name="strTypeId" autocomplete="off" lay-filter="Type_Id" lay-verify="required">
                                <c:forEach items="${strDemandType}" var="item">
                                    <option id="strTypeId02330" value="${item.strValue}" ${mdDemandM.strTypeId eq item.strValue ? 'selected' : ''}>${item.strDescDtl}</option>
                                </c:forEach>
                            </select>
						</div>
						<label class="layui-form-label">计划申报年月:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" id="strPlanYearMo" name="strPlanYearMo" style="background-color: white" readonly lay-verify="required" autocomplete="off" placeHolder="点击挑选计划申报年月" />
						</div>
						<label class="layui-form-label">客户编号:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" id="strVendorNo" name="strVendorNo" readonly autocomplete="off" lay-verify="required" placeHolder="请输入客商编号" />
							<%--<div class="layui-input-inline">
								<input type="hidden" id="strVendorNoMpplan" name="strVendorNo">
								<input type="text" lay-verify="required" id="strVendorNoNameMpplan" readonly="readonly" placeholder="请挑选客户编号" style="background-color: white" class="layui-input" postField="keyword" lookupGroup="org2t" id="strVendorNo"/>
								<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
								<a class="layui-btn layui-btn-sm select-btn layui-icon"
								   href="${ctx}/mcInfomationM/listMerchant?strVendorNo1=strVendorNoMpplan&strVendorName1=strVendorNameMpplan&strVendorNoName=strVendorNoNameMpplan"
								   lookupGroup="org2t" target="dialog" dialogId="selectMerchantDialog" rel="selectCmMerchant" title="供应商" width="800" height="480"><i class="layui-icon layui-icon-search"></i></a>
							</div>--%>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">申请部门:</label>
						<div class="layui-input-inline">
							<%--<input type="text" class="layui-input" id="strDept" name="strDept" autocomplete="off" lay-verify="required" placeHolder="请输入申请部门" />--%>
							<input type="hidden" id="deptId1_strDept" name="dept.id" />
							<input type="hidden" id="deptNo1_strDept" name="dept.strSn" />
							<input type="text" id="deptName1_strDept" name="strDept" placeholder="选择部门..." readonly class="layui-input" style="background-position: 107% 0;" />
							<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
							<button type="button" class="layui-btn layui-btn-sm" style="position: absolute; top: 4px; right: 5px;" onPickDept="selectSingleDepartmentCallback">
								<i class="layui-icon">&#xe615;</i>
							</button>
						</div>
						<label class="layui-form-label">申请人员:</label>
						<div class="layui-input-inline">
							<%--<input type="text" class="layui-input" id="strDemandUserId" name="strDemandUserId" autocomplete="off" lay-verify="required" placeHolder="请输入申请人员" />--%>
							<div class="layui-input-inline">
								<input type="hidden" id="userId1_strDemandUserId" name="strDemandUserId" />
								<input type="hidden" id="userNo1_strDemandUserId" />
								<input type="text" id="username1_strDemandUserId" placeholder="点击挑选人员..." readonly class="layui-input" style="padding-right: 50px;" />
								<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
								<a class="layui-btn layui-btn-sm" onPickUser="selectStrDemandUserId" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
							</div>
						</div>
						<label class="layui-form-label">申请日期:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" id="strDemandDate01" name="strDemandDate" style="background-color: white" readonly autocomplete="off" placeHolder="点击挑选申请日期" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">平衡接收人:</label>
						<div class="layui-input-inline">
							<input type="hidden" id="userId1_strRecipientId" name="strRecipientId" />
							<input type="hidden" id="userNo1_strRecipientId" />
							<input type="text" id="username1_strRecipientId" placeholder="点击挑选人员..." readonly class="layui-input" style="padding-right: 50px;" />
							<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
							<a class="layui-btn layui-btn-sm" onPickUser="selectStrRecipientId" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
						</div>
						<label class="layui-form-label">状态:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="strStus" readonly autocomplete="off" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">备注:</label>
						<textarea type="text" class="layui-input" name="strRemark" style="width: 540px;height: 80px" autocomplete="off" placeHolder="请输入备注"></textarea>
					</div>
				<%--<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>--%>
			</form>
		</div>
		<div id="tab2" class="layui-tab-item">
		</div>
	</div>
</div>
</div>
</div>