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
<script>
	function loadTab(num){
		var id=$("#demandMRelativedId").val();
		var strApplyNo = $('#strApplyNo').val();
		var strOrderNo=$("#strOrderNoName001").val();
		var loadingIndex = Dialog.load();
		if(num == '1')
			$("#updateMdDemandId1").load("${ctx}/mdDemandM/preUpdate?id="+id,{},
					function(){
						layer.close(loadingIndex);
					});
		if(num == '2')
			$("#tab"+num).load("${ctx}/mdDemandM/demandDetail?strApplyNo="+strApplyNo+"&strOrderNo="+strOrderNo,{},
					function(){
						layer.close(loadingIndex);
					});
	}
	layui.use('laydate', function(){
		var laydate = layui.laydate;
		laydate.render({
			elem: '#strPlanYearMo002',
			format:'yyyyMM'
		});
		laydate.render({
			elem: '#strDemandDate002',
			type:'date'
			,trigger: 'click'
		});
	});
	function updateMdDemandM(){
		debugger;
		var id = $('#demandMRelativedId').val();
		var strVendorNoMpplan = $('#strVendorNoMpplan').val();//客户编号
		var username1_strRecipientId02 = $('#username1_strRecipientId02').val();//平衡接收人
		if (!strVendorNoMpplan) {
			top.layer.msg("客户编号不能为空",{icon:2});
			return false;
		}
		if (!username1_strRecipientId02) {
			top.layer.msg("平衡接收人不能为空",{icon:2});
			return false;
		}
		$.ajax({
			type:"post",
			url:"${ctx}/mdDemandM/update",
			data:$("#updateMdDemandM").serialize(),
			dataType:"json",
			success:function (rst) {
				if (rst.statusCode == 200){
					Dialog.success(rst.message);
					$("#updateMdDemandId1").load("${ctx}/mdDemandM/preUpdate?id="+id,{},function () {});
					$('#mdDemandMId').load("${ctx}/mdDemandM/list",{},function () {});
				} else{
					Dialog.error(rst.message);
				}
			},
			error:function(msg){
				Dialog.warn(msg.message);
			}
		});
	}
	/*选择申请部门的回调方法*/
	function selectSingleDepartmentCallback02(deptId, deptNo, deptName) {
		$('#deptId1_strDept02').val(deptId);
		$('#deptNo1_strDept02').val(deptNo);
		$('#deptName1_strDept02').val(deptName);
	}
	/*选择平衡接收人的回调方法*/
	function selectStrRecipientId02(userId, userNo, username) {
		$('#userId1_strRecipientId02').val(userId);
		$('#userNo1_strRecipientId02').val(userNo);
		$('#username1_strRecipientId02').val(username);
	}
	/*选择申请人员的回调方法*/
	function selectStrDemandUserId02(userId, userNo, username) {
		$('#userId1_strDemandUserId02').val(userId);
		$('#userNo1_strDemandUserId02').val(userNo);
		$('#username1_strDemandUserId02').val(username);
	}
</script>
<div id="updateMdDemandId1">
<div class="layui-tab" id="layui-tab">
	<ul class="layui-tab-title">
		<li class="layui-this" onclick="loadTab('1')">需求申报主档</li>
		<li onclick="loadTab('2')">需求申报明细档</li>
	</ul>
	<div class="layui-tab-content">
		<div id="tab1" class="layui-tab-item layui-show">
			<div class="tab-bars">
                <c:if test="${strStus != 'S'}">
                    <shiro:hasPermission name="MsOrderM:create">
                        <a class="add" href="#" onclick="updateMdDemandM()"><span>保存</span></a>
                    </shiro:hasPermission>
                </c:if>
                <c:if test="${strStus == 'S'}">
                    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px">
                        <legend>非新增状态不可修改</legend>
                    </fieldset>
                </c:if>
			</div>
			<form id="updateMdDemandM" class="layui-form" method="post" action="${ctx}/mdDemandM/update" onsubmit="return dialogAjaxDone(this, 'update')">
				<input type="hidden" id="demandMRelativedId" name="id" value="${mdDemandM.id}">
                <input type="hidden" value="${strStus}">
				<div class="layui-form-item"></div>
				<div class="layui-form-item">
					<label class="layui-form-label">需求计划编号:</label>
					<div class="layui-input-inline">
						<input type="text" id="strApplyNo" name="strApplyNo" lay-verify="required" readonly class="layui-input" placeHolder="" value="${mdDemandM.strApplyNo}" />
					</div>
					<label class="layui-form-label">销售订单编号:</label>
					<div class="layui-input-inline">
						<div class="layui-input-inline" style="width: 190px">
							<input id="strOrderNoName001" name="strOrderNo" value="${mdDemandM.strOrderNo}" class="layui-input" type="text" readonly style="padding-right: 50px;background-color: white;" placeHolder="请挑选销售订单编号"/>
							<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
							<a class="layui-btn layui-btn-sm" href="${ctx}/mdDemandM/orderList?strOrderNo=strOrderNoName" title="请挑选销售订单编号" target="dialog" width="1000" height="500" dialogId="selectStrOrdNoDialogId1" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
						</div>
					</div>
					<label class="layui-form-label">需求计划名称:</label>
					<div class="layui-input-inline">
						<input type="text" name="strApplyName" class="layui-input" lay-verify="required" placeHolder="请输入需求计划名称" value="${mdDemandM.strApplyName}" />
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">业务类型:</label>
					<div class="layui-input-inline">
						<select  id="strTypeId020200202" name="strTypeId" class="layui-input" lay-verify="required" lay-filter="Type_Id">
							<c:forEach items="${strDemandType}" var="item">
								<option  value="${item.strValue}" ${mdDemandM.strTypeId eq item.strValue ? 'selected' : ' '}>${item.strDescDtl}</option>
							</c:forEach>
						</select>
					</div>
					<%--<div class="layui-input-inline">
						<select  class="layui-input" id="strTypeId02020" name="strTypeId" autocomplete="off" lay-verify="required">
							<c:forEach items="${strDemandType}" var="item">
								<option id="strTypeId0233044" value="${item.strValue}" ${mdDemandM.strTypeId eq item.strValue ? 'selected' : ''}>${item.strDescDtl}</option>
							</c:forEach>
						</select>
					</div>--%>
					<label class="layui-form-label">计划申报年月:</label>
					<div class="layui-input-inline">
						<input type="text"id="strPlanYearMo002" name="strPlanYearMo" lay-verify="required" readonly class="layui-input" placeHolder="点击选择计划申报年月" value="${mdDemandM.strPlanYearMo}" />
					</div>
					<label class="layui-form-label">客户编号:</label>
					<div class="layui-input-inline">
						<input type="text" name="strVendorNo" id="strVendorNo" readonly="readonly" class="layui-input" lay-verify="required" placeHolder="请选择客商编号" value="${mdDemandM.strVendorNo}" />
							<%--<input type="hidden" &lt;%&ndash;id="strVendorNoMpplan"&ndash;%&gt;id="strVendorNoNameMpplan"&lt;%&ndash; name="strVendorNo"&ndash;%&gt;>--%>
							<%--<input type="text" lay-verify="required"  readonly="readonly" id="strVendorNoMpplan" name="strVendorNo" value="${mdDemandM.strVendorNo}"  placeholder="请挑选客户编号" style="background-color: white" class="layui-input" postField="keyword" lookupGroup="org2t"/>--%>
							<%--<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>--%>
							<%--<a class="layui-btn layui-btn-sm select-btn"
							   href="${ctx}/mcInfomationM/listMerchant?strVendorNo1=strVendorNoMpplan&strVendorName1=strVendorNameMpplan&strVendorNoName=strVendorNoNameMpplan"
							   lookupGroup="org2t" target="dialog" dialogId="selectMerchantDialog" rel="selectCmMerchant" title="供应商" width="800" height="480"><i class="layui-icon layui-icon-search"></i></a>--%>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">申请部门:</label>
					<div class="layui-input-inline">
						<%--<input type="text" name="strDept" class="layui-input" lay-verify="required" placeHolder="请选择申请部门" value="${mdDemandM.strDept}" />--%>
						<input type="hidden" id="deptId1_strDept02" name="dept.id" />
						<input type="hidden" id="deptNo1_strDept02" name="dept.strSn" />
						<input type="text" id="deptName1_strDept02" name="strDept" value="${mdDemandM.strDept}"  placeholder="选择部门..." readonly class="layui-input" style="background-position: 107% 0;" />
						<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
						<button type="button" class="layui-btn layui-btn-sm" style="position: absolute; top: 4px; right: 5px;" onPickDept="selectSingleDepartmentCallback02">
							<i class="layui-icon">&#xe615;</i>
						</button>
					</div>
					<label class="layui-form-label">申请人员:</label>
					<div class="layui-input-inline">
						<%--<input type="text" name="strDemandUserId" class="layui-input" lay-verify="required" placeHolder="请选择申请人员" value="${mdDemandM.strDemandUserIdZH}" />--%>
						<input type="hidden" id="userId1_strDemandUserId02"  name="strDemandUserId"/>
						<input type="hidden" id="userNo1_strDemandUserId02" />
						<input type="text" id="username1_strDemandUserId02" value="${mdDemandM.strDemandUserIdZH}" placeholder="点击挑选人员..." readonly class="layui-input" style="padding-right: 50px;" />
						<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
						<a class="layui-btn layui-btn-sm" onPickUser="selectStrDemandUserId02" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
					</div>
					<label class="layui-form-label">申请日期:</label>
					<div class="layui-input-inline">
						<input type="text" id="strDemandDate002" name="strDemandDate" readonly style="background-color: white" class="layui-input" placeHolder="点击输入申请日期" value="${mdDemandM.strDemandDate}" />
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">平衡接收人:</label>
					<div class="layui-input-inline">
						<%--<input type="text" name="strRecipientId" class="layui-input" lay-verify="required" placeHolder="请选择采购部门接收人" value="${mdDemandM.strRecipientId}" />--%>
						<input type="hidden" id="userId1_strRecipientId02"  name="strRecipientId"/>
						<input type="hidden" id="userNo1_strRecipientId02" />
						<input type="text" id="username1_strRecipientId02" value="${mdDemandM.strRecipientIdZH}"  placeholder="点击挑选人员..." readonly class="layui-input" style="padding-right: 50px;" />
						<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
						<a class="layui-btn layui-btn-sm" onPickUser="selectStrRecipientId02" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
					</div>
					<label class="layui-form-label">状态:</label>
					<div class="layui-input-inline">
						<input type="hidden" name="strStus" value="${mdDemandM.strStatu}">
						<input type="text" readonly class="layui-input" placeHolder="" value="${mdDemandM.strStatuZH}" />
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">备注:</label>
					<div class="layui-input-block">
						<textarea type="text" name="strRemark" style="width: 540px;height: 80px" class="layui-input" placeHolder="请输入备注">${mdDemandM.strRemark}</textarea>
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
