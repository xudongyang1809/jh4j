<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 编辑画面
	 @author 毛敏 022325
	 @date 2019-05-29 13:51:08
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<style>
    .layui-form-label{
        width: 120px;
    }
</style>
<script type="text/javascript">
    function loadTab(num) {
    	debugger;
    	var relativedId = $('#relativedId').val();
		var strSettleNumber = $('#strSettleNumber').val();/*销售结算单号*/
		var strVendorNo = $('#strVendorNoMpplan').val();/*供应商编号*/
        var loadingIndex = Dialog.load();
		if (num == '1')
			$('#MsSettlementMUpdateId06').load("${ctx}/msSettlementM/preUpdate?id="+relativedId,{},
					function () {
						layer.close(loadingIndex);
					}
			);
        if (num == '2')
            $('#tab'+num).load("${ctx}/msSettlementD/detailList?strSettleNumber="+strSettleNumber+"&strVendorNo="+strVendorNo,{},
                function () {
                    layer.close(loadingIndex);
                }
            );
    }
    function updateMsSettlementM(){
    	debugger;
    	var strVendorNoMpplan = $('#strVendorNoMpplan').val();
    	if (!strVendorNoMpplan){
    		Dialog.warn("供应商编号不能为空",{icon:2});
    		return false;
		}
        $.ajax({
            type:"post",
            url:"${ctx}/msSettlementM/update",
            data:$("#updateMsSettlementMId").serialize(),
            dataType:"json",
            success:function (rst) {
                if (rst.statusCode == 200){
                    Dialog.success(rst.message);
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
					$('#MsSettlementMUpdateId06').load("${ctx}/msSettlementM/preUpdate?id="+relativedId,{},function () {});
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
					$('#MsSettlementMUpdateId06').load("${ctx}/msSettlementM/preUpdate?id="+relativedId,{},function () {});
					$('#msSettlementMListId').load("${ctx}/msSettlementM/list",{},function () {});
				} else{
					Dialog.error(rst.message);
				}
			}
		});
	}
	layui.use('laydate',function () {
        var laydate = layui.laydate;
        laydate.render({
            elem:"#strSettleDate"
        });
    });
</script>
<div id="MsSettlementMUpdateId06">
<div class="layui-tab">
	<ul class="layui-tab-title">
		<li class="layui-this" onclick="loadTab('1')">结算主档</li>
		<li onclick="loadTab('2')">结算明细</li>
	</ul>
	<div class="layui-tab-content">
		<div id="tab1" class="layui-tab-item layui-show">
			<div id="t23131">
            <div class="tab-bars">
                <shiro:hasPermission name="MsSettlementM:edit">
                    <a class="add" onclick="updateMsSettlementM()">保存</a>
                </shiro:hasPermission>
				<shiro:hasPermission name="MsSettlementM:create">
					<a class="confirm" onclick="confirmInvoiceapp()">开票确认</a>
				</shiro:hasPermission>
				<shiro:hasPermission name="MsSettlementM:create">
					<a class="cancelConfirm" onclick="cancelConfirmInvoiceapp()">取消开票确认</a>
				</shiro:hasPermission>
            </div>
			<form id="updateMsSettlementMId" class="layui-form" method="post" action="${ctx}/msSettlementM/update" onsubmit="return dialogAjaxDone(this, 'update')">
					<input type="hidden" id="relativedId" name="id" value="${msSettlementM.id}">
					<input type="hidden" id="strStus005" value="${msSettlementM.strStus}">
                    <div class="layui-form-item"></div>
					<div class="layui-form-item">
						<label class="layui-form-label">销售结算单号:</label>
						<div class="layui-input-inline">
							<input type="text" id="strSettleNumber" name="strSettleNumber" readonly class="layui-input" placeHolder="请输入销售结算单号" value="${msSettlementM.strSettleNumber}" />
						</div>
						<%--<label class="layui-form-label">销售订单编号:</label>
						<div class="layui-input-inline">
							<input type="text" name="strOrderNo" class="layui-input" placeHolder="请输入销售订单编号" value="${msSettlementM.strOrderNo}" />
						</div>--%>
						<label class="layui-form-label">供应商编号:</label>
						<div class="layui-input-inline">
							<%--<input type="text" name="strVendorNo" class="layui-input" placeHolder="请挑选供应商" value="${msSettlementM.strVendorNo}" />--%>
							<div class="layui-input-inline">
								<input type="hidden" >
								<input type="text" lay-verify="required" id="strVendorNoMpplan" name="strVendorNo"<%--id="strVendorNoNameMpplan"--%> value="${msSettlementM.strVendorNo}"  readonly="readonly" placeholder="请挑选客户编号" style="background-color: white" class="layui-input" postField="keyword" lookupGroup="org2t"/>
								<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
								<a class="layui-btn layui-btn-sm select-btn"
								   href="${ctx}/mcInfomationM/listMerchant?strVendorNo1=strVendorNoMpplan&strVendorName1=strVendorNameMpplan&strVendorNoName=strVendorNoNameMpplan"
								   lookupGroup="org2t" target="dialog" dialogId="selectMerchantDialog" rel="selectCmMerchant" title="供应商" width="800" height="480"><i class="layui-icon layui-icon-search"></i></a>
							</div>
						</div>
						<label class="layui-form-label">结算金额:</label>
						<div class="layui-input-inline">
							<input type="text" name="bdSettleAmt" class="layui-input" readonly style="background-color: white" placeholder="请先进行明细挑选" value="${msSettlementM.bdSettleAmtZH}" />
						</div>
					</div>
					<div class="layui-form-item">

                        <label class="layui-form-label">开票金额:</label>
                        <div class="layui-input-inline">
                            <input type="text" name="bdInvoiceSumAmt" class="layui-input" readonly style="background-color: white" placeholder="请先进行明细挑选" value="${msSettlementM.bdInvoiceSumAmtZH}" />
                        </div>
                        <label class="layui-form-label">开票日期:</label>
                        <div class="layui-input-inline">
                            <input type="text" name="strSettleDate" id="strSettleDate" style="background-color: white" readonly class="layui-input" placeHolder="点击挑选结算日期" value="${msSettlementM.strSettleDate}" />
                        </div>
						<label class="layui-form-label">状态:</label>
						<div class="layui-input-inline">
							<input type="hidden" name="strStus" value="${msSettlementM.strStus}">
							<input type="text" readonly class="layui-input" placeHolder="" value="${msSettlementM.strStusZH}" />
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">备注:</label>
						<div class="layui-input-inline">
							<%--<input type="text" name="strRemark" class="layui-input" placeHolder="请输入备注" value="${msSettlementM.strRemark}" />--%>
						    <textarea type="text" name="strRemark" style="width: 890px;height: 80px" class="layui-input" placeHolder="请输入备注" >${msSettlementM.strRemark}</textarea>
                        </div>
					</div>
				<%--<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>--%>
			</form>
		</div>
		</div>
		<div id="tab2" class="layui-tab-item"></div>
	</div>
</div>
</div>
