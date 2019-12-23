<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 创建画面
	 @author 毛敏 022325
	 @date 2019-05-29 13:51:08
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<style>
	.layui-form-label{
		width: 120px;
	}
</style>
<script>
	function loadTab(num) {
		debugger;
		var strSettleNumber = $('#strSettleNumber').val();/*销售结算单号*/
		//alert(strSettleNumber);
		var strVendorNo = $('#strVendorNoMpplan').val();/*供应商编号*/
		//alert(strVendorNo);
		var loadingIndex = Dialog.load();
		if (num == '2'){
		     $("#tab"+num).load("${ctx}/msSettlementD/detailList?strSettleNumber="+strSettleNumber+"&strVendorNo="+strVendorNo,{},
		                function () {
		                    layer.close(loadingIndex);
		            });
		}
		layer.close(loadingIndex);
	}
	/*保存*/
	function createMsSettlementM(){
		debugger;
		var relativedId = $('#relativedId').val();
		var strVendorNoMpplan = $('#strVendorNoMpplan').val();
		if (!strVendorNoMpplan) {
			Dialog.warn("供应商编号不能为空",{icon:2});
			return false;
			}
		$.ajax({
			type:"post",
			url:"${ctx}/msSettlementM/create",
			data:$("#createMsSettlementMId").serialize(),
			dataType:"json",
			success:function (rst) {
				if (rst.statusCode == 200){
					Dialog.success(rst.message);
					/*var id = rst.rel;
					alert(id);*/
					debugger;
					$('#MsSettlementMId002').load("${ctx}/msSettlementM/preUpdate?id="+relativedId,{},function () {});
					$('#msSettlementMListId').load("${ctx}/msSettlementM/list",{},function () {});
				}else{
					Dialog.error(rst.message);
				}
			}
		});
	}
	/*开票确认*/
	function confirmInvoiceapp(){
		debugger;
		var relativedId = $('#relativedId').val();
		var strStus = $('#strStus005').val();
		var flg = "C";
		$.ajax({
			type:"post",
			url:"${ctx}/msSettlementM/updateSettlementStatus?id="+relativedId+"&flg="+flg+"&strStus="+strStus,
			dataType:"json",
			success:function (rst) {
				debugger;
				if (rst.statusCode == 200){
					Dialog.success(rst.message);
					$('#MsSettlementMId002').load("${ctx}/msSettlementM/preUpdate?id="+relativedId,{},function () {});
					$('#msSettlementMListId').load("${ctx}/msSettlementM/list",{},function () {});
				} else{
					Dialog.error(rst.message);
				}
			}
		});
	}
	/*取消开票确认*/
	function cancelConfirmInvoiceapp(){
		debugger;
		var relativedId = $('#relativedId').val();
		var strStus = $('#strStus005').val();
		var flg = "N";
		$.ajax({
			type:"post",
			url:"${ctx}/msSettlementM/updateSettlementStatus?id="+relativedId+"&flg="+flg+"&strStus="+strStus,
			dataType:"json",
			success:function (rst) {
				if (rst.statusCode == 200){
					Dialog.success(rst.message);
					$('#MsSettlementMId002').load("${ctx}/msSettlementM/preUpdate?id="+relativedId,{},function () {});
					$('#msSettlementMListId').load("${ctx}/msSettlementM/list",{},function () {});
				} else{
					Dialog.error(rst.message);
				}
			}
		});
	}

	layui.use('laydate', function(){
		var laydate = layui.laydate;
		laydate.render({
			elem: '#strSettleDate'
			,trigger: 'click'
		});
	});
</script>
<div id="MsSettlementMId002">
<div class="layui-tab" id="layui-tab">
	<ul class="layui-tab-title">
		<li class="layui-this" onclick="loadTab('1')">结算主档</li>
		<li onclick="loadTab('2')">结算明细</li>
	</ul>
	<div class="layui-tab-content">
		<div id="tab1" class="layui-tab-item layui-show">
			<div class="tab-bars">
				<shiro:hasPermission name="MsSettlementM:create">
					<a class="add" onclick="createMsSettlementM()">保存</a>
				</shiro:hasPermission>
				<shiro:hasPermission name="MsSettlementM:create">
					<a class="confirm" onclick="confirmInvoiceapp()">开票确认</a>
				</shiro:hasPermission>
				<shiro:hasPermission name="MsSettlementM:create">
					<a class="cancelConfirm" onclick="cancelConfirmInvoiceapp()">取消开票确认</a>
				</shiro:hasPermission>
			</div>
			<form id="createMsSettlementMId" class="layui-form" method="post" action="${ctx}/msSettlementM/create" onsubmit="return dialogAjaxDone(this, 'create')">
					<div class="layui-form-item"></div>
					<input type="hidden" id="relativedId" name="id" value="${relativedId}">
					<input type="hidden" id="strStus" value="${msSettlementM.strStus}">
					<div class="layui-form-item">
						<label class="layui-form-label">销售结算单号:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" id="strSettleNumber" name="strSettleNumber" value="${strSettleNumber}" readonly autocomplete="off" placeHolder="请输入销售结算单号" />
						</div>
						<%--<label class="layui-form-label">销售订单编号:</label>
						<div class="layui-input-inline">
							&lt;%&ndash;<input type="text" class="layui-input" name="strOrderNo" autocomplete="off" placeHolder="请输入销售订单编号" />&ndash;%&gt;
                            <div class="layui-input-inline" style="width: 190px">
                                <input id="strOrderNoName001" name="strOrderNo" class="layui-input" type="text" readonly style="padding-right: 50px;background-color:white;" placeHolder="请挑选销售订单编号"/>
                                <a class="layui-btn layui-btn-sm" href="${ctx}/mdDemandM/orderList?strOrderNo=strOrderNoName" title="请挑选销售订单编号" target="dialog" width="1000" height="500" dialogId="selectStrOrdNoDialogId1" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
                            </div>
						</div>--%>
						<label class="layui-form-label">供应商编号:</label>
						<%--<div class="layui-input-inline">
							&lt;%&ndash;<input type="text" class="layui-input" name="strVendorNo" autocomplete="off" placeHolder="请挑选供应商" />&ndash;%&gt;
							<input type="text" lay-verify="required" id="strVendorNo" name="strVendorNo" readonly="readonly" value="${msSettlementM.strVendorNo}" style="background-color: white" class="layui-input" postField="keyword" lookupGroup="org2t" id="strVendorNo"/>
							<a class="layui-btn layui-btn-sm select-btn" href="${ctx}/cmMerchant/listMerchant?strMersn=strVendorNo&strMerName=strVendorName431&flg=1" lookupGroup="org2t" target="dialog" dialogId="selectMerchantDialog"    rel="selectCmMerchant" title="供应商" width="800" height="480"><i class="layui-icon layui-icon-search"></i></a>
						</div>--%>
						<div class="layui-input-inline">
							<input type="hidden" >
							<input type="text" lay-verify="required"  id="strVendorNoMpplan"  name="strVendorNo"<%--id="strVendorNoNameMpplan" --%>readonly="readonly" placeholder="请挑选客户编号" style="background-color: white" class="layui-input" postField="keyword" lookupGroup="org2t"/>
							<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
							<a class="layui-btn layui-btn-sm select-btn"
							<%--href="${ctx}/cmMerchant/listMerchant?strMersn=strVendorNo&strMerName=strVendorName431&flg=1" --%>
							   href="${ctx}/mcInfomationM/listMerchant?strVendorNo1=strVendorNoMpplan&strVendorName1=strVendorNameMpplan&strVendorNoName=strVendorNoNameMpplan"
							   lookupGroup="org2t" target="dialog" dialogId="selectMerchantDialog" rel="selectCmMerchant" title="供应商" width="800" height="480"><i class="layui-icon layui-icon-search"></i></a>
						</div>
						<label class="layui-form-label">结算金额:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="bdSettleAmt" style="background-color: white" readonly placeholder="请先进行明细挑选" autocomplete="off" placeHolder="" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">开票金额:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="bdInvoiceSumAmt" style="background-color: white" readonly placeholder="请先进行明细挑选"  autocomplete="off" placeHolder="" />
						</div>
						<label class="layui-form-label">开票日期:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" id="strSettleDate" name="strSettleDate" style="background-color: white" readonly autocomplete="off" placeHolder="点击挑选结算日期" />
						</div>
						<label class="layui-form-label">状态:</label>
						<div class="layui-input-inline">
							<input type="text" class="layui-input" name="strStus" autocomplete="off" readonly placeHolder="" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">备注:</label>
						<div class="layui-input-inline">
							<textarea type="text" name="strRemark" autocomplete="off" style="width: 890px;height: 80px" class="layui-input" placeholder="请输入备注"></textarea>
						</div>
					</div>
			</form>
		</div>
		<div id="tab2" class="layui-tab-item"></div>
	</div>
</div>
</div>
