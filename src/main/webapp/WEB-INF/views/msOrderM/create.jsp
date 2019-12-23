<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 创建画面
	 @author 超级管理员 admin
	 @date 2019-04-29 17:54:44
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<style>
	.layui-form-label{
		width: 120px;
	}
</style>
<script>
	debugger;
	function loadTab(num){
		//alert(num);
		debugger;
		var id=$("#msOrderM").val();
		var strOrderNo=$("#strOrderNo").val();
		var loadingIndex = Dialog.load();
		if(num == '2'){
		     $("#tab"+num).load("${ctx}/msOrderD/preCreateList?strOrderNo="+strOrderNo,{},
		                function(){
		                    layer.close(loadingIndex);
		                });
		}
		 layer.close(loadingIndex);
	}
    layui.use('laydate', function(){
        var laydate = layui.laydate;
        laydate.render({
            elem: '#strDeliveryDate001'
				,trigger: 'click'
        });
        form.render();
       /* laydate.render({
            elem: '#strDateFrom001'
				,trigger: 'click'
        });
        laydate.render({
            elem: '#strDateTo001'
				,trigger: 'click'
        });*/
		var startDate=laydate.render({
			elem: '#strDateFrom001',
		/*	type: 'datetime',*/
			trigger: 'click',
			done: function(value, date){
				endDate.config.min ={		//控制 结束日期不能比开始日期 早
					year:date.year,
					month:date.month-1,
					date: date.date
				};
			}
		});
		var endDate= laydate.render({
			elem: '#strDateTo001',
			/*type: 'datetime',*/
			trigger: 'click',
			done: function(value,date){
				startDate.config.max={
					year:date.year,
					month:date.month-1,
					date: date.date
				}
			}
		});
    });
	form.render();
	function valiMsOrderM(){
		var strOrderNo = $('#strOrderNo').val();
		var strOrderStyle = $('#strOrderStyle').val();
		var strOrderName = $('#strOrderName').val();
		var strVendorNo = $('#strVendorNoNameMpplan').val();
		if(!strOrderNo){
			top.layer.msg("销售订单编号不能为空",{icon: 2});
			return false;
		}
		if(!strOrderStyle){
			top.layer.msg("销售订单类型不能为空",{icon: 2});
			return false;
		}
		if(!strOrderName){
			top.layer.msg("销售订单名称不能为空",{icon: 2});
			return false;
		}
		if(!strVendorNo){
			top.layer.msg("客户编号不能为空",{icon: 2});
			return false;
		}
		return true;
	}
    function createMsOrderM(){
		debugger;
		var id1;
		if(valiMsOrderM()){
			$.ajax({
				type:"post",
				url:"${ctx}/msOrderM/create",
				data:$('#msOrderM_1').serialize(),
				datatype:"json",
				success:function(rst){
					/* Ajax.ajaxDone(rst); */
					var data = JSON.parse(rst);
					if(data.statusCode == 200) {
						debugger;
						id1 = data.rel;
						$("#msOrderMId0202").load("${ctx}/msOrderM/preUpdate?id="+id1,{},function(){});
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
	function selectSingleUserCallback(userId, userNo, username) {
		$('#userId1_strOperator').val(userId);
		$('#userNo1_strOperator').val(userNo);
		$('#username1_strOperator').val(username);
	}
	/*选择甲方经办人的回调方法*/
	function selectSingleUserCallback02(userId, userNo, username) {
		$('#userId1_strApplyUserId').val(userId);
		$('#userNo1_strApplyUserId').val(userNo);
		$('#username1_strApplyUserId').val(username);
	}
</script>
<div id="msOrderMId0202">
<div class="layui-tab" id="layui-tab">
	<ul class="layui-tab-title">
		<li class="layui-this" onclick="loadTab('1')" >订单主档</li>
		<li onclick="loadTab('2')">订单明细</li>
	</ul>
	<div class="layui-tab-content">
		<div id="tab1" class="layui-tab-item layui-show">
			<div class="tab-bars">
				<shiro:hasPermission name="MsOrderM:create">
					<a class="add" href="#" onclick="createMsOrderM()"><span>保存</span></a>
				</shiro:hasPermission>
			</div>
			<form class="layui-form" method="post" id="msOrderM_1" action="${ctx}/msOrderM/create" onsubmit="return dialogAjaxDone(this, 'create')">
			 <%--  <input type="hidden" id="msOrderM" name="id" value="${msOrderM.id}">--%>
					<div class="layui-form-item"></div>
					<div class="layui-form-item">
						<label class="layui-form-label">销售订单编号:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" id="strOrderNo" name="strOrderNo" value="${strOrderNo}" readonly autocomplete="off" placeHolder="请输入销售订单编号" />
						</div>
						<label class="layui-form-label">销售订单类型:</label>
						<div class="layui-input-inline">
							<select class="layui-input" id="strOrderStyle" name="strOrderStyle" lay-verify="required">
								<c:forEach items="${msOrderType}" var="item">
									<option value="${item.strValue}" ${msOrderM.strOrderStyle eq item.strValue ? 'selected' : '' }>${item.strDescDtl}</option>
								</c:forEach>
							</select>
						</div>
						<label class="layui-form-label">销售订单名称:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" id="strOrderName" name="strOrderName" value="${MsOrderM.strOrderName}" lay-verify="required" autocomplete="off" placeHolder="请输入销售订单名称" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">客户编号:</label>
						<div class="layui-input-inline">
							<input type="hidden" id="strVendorNoMpplan" name="strVendorNo">
							<input type="text" lay-verify="required" id="strVendorNoNameMpplan" readonly="readonly" placeholder="请挑选客户编号" style="background-color: white" class="layui-input" postField="keyword" lookupGroup="org2t" id="strVendorNo"/>
							<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
							<a class="layui-btn layui-btn-sm select-btn"
								   <%--href="${ctx}/cmMerchant/listMerchant?strMersn=strVendorNo&strMerName=strVendorName431&flg=1" --%>
							   href="${ctx}/mcInfomationM/listMerchant?strVendorNo1=strVendorNoMpplan&strVendorName1=strVendorNameMpplan&strVendorNoName=strVendorNoNameMpplan"
							   lookupGroup="org2t" target="dialog" dialogId="selectMerchantDialog" rel="selectCmMerchant" title="供应商" width="800" height="480"><i class="layui-icon layui-icon-search"></i></a>
						</div>
						<label class="layui-form-label">甲方经办人:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="strOperator" value="${MsOrderM.strOperator}"  autocomplete="off" placeHolder="请输入甲方经办人" />
							<%--<div class="layui-input-inline">
								<input type="hidden" id="userId1_strOperator" name="strOperator" />
								<input type="hidden" id="userNo1_strOperator" />
								<input type="text" id="username1_strOperator" placeholder="点击挑选人员..." readonly class="layui-input" style="padding-right: 50px;" />
								<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
								<a class="layui-btn layui-btn-sm" onPickUser="selectSingleUserCallback" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
							</div>--%>
						</div>
						<label class="layui-form-label">销售订单金额:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="bdPlanAmt" value="${bdPlanAmt}" readonly autocomplete="off" placeHolder="销售订单金额" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">业务人员:</label>
						<div class="layui-input-inline">
							<%--<input type="text" class="layui-input" name="strApplyUserId" value="${MsOrderM.strApplyUserId}" autocomplete="off" placeHolder="请输入业务人员" />--%>
							<div class="layui-input-inline">
								<input type="hidden" id="userId1_strApplyUserId" name="strApplyUserId" />
								<input type="hidden" id="userNo1_strApplyUserId" />
								<input type="text" id="username1_strApplyUserId" placeholder="点击挑选人员..." readonly class="layui-input" style="padding-right: 50px;" />
								<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
								<a class="layui-btn layui-btn-sm" onPickUser="selectSingleUserCallback02" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
							</div>
						</div>
						<label class="layui-form-label">订单开始日期:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" id="strDateFrom001" name="strDateFrom" value="${MsOrderM.strDateFrom}" autocomplete="off" placeHolder="点击挑选订单开始日期" />
						</div>
						<label class="layui-form-label">订单结束日期:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" id="strDateTo001" name="strDateTo" value="${MsOrderM.strDateTo}" autocomplete="off" placeHolder="点击挑选订单结束日期" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">交期:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" id="strDeliveryDate001" name="strDeliveryDate" value="${MsOrderM.strDeliveryDate}" autocomplete="off" placeHolder="点击选择交期" />
						</div>
						<label class="layui-form-label">状态:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="strStus" readonly value="${MsOrderM.strStus}" autocomplete="off" />
						</div>
						<%--<label class="layui-form-label">税率:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="bdTaxRate" value="${MsOrderM.bdTaxRate}" autocomplete="off" placeHolder="请输入税率" />
						</div>--%>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">备注:</label>
						<div class="layui-input-inline">
							<textarea class="layui-input" name="strRemark" style="width: 540px;height: 80px" value="${MsOrderM.strRemark}" autocomplete="off" placeHolder="请输入备注"></textarea>
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