<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>

<style>
	.layui-form-label{
		width:110px;
		padding: 12px 0px 2px 0px;
		text-align: center
	}
</style>
<script>
	function loadTab(num){
		var id=$("#relativedId").val();
		var strPayNo=$("#strPayNo").val();
		var strVendorNo =$("#strVendorNo").val();
		var loadingIndex = Dialog.load();
		if(num =='1'){
			$('#alls').load("${ctx}/mpPayM/preCreate?id="+id,function(){
				layer.close(loadingIndex);
			});
		}
		else if(num =='2'){
			$("#tab"+num).load("${ctx}/mpPayD/preCreate", {id:id,strpayNo:strPayNo , strVendorNo:strVendorNo},function(){
				layer.close(loadingIndex);
			})
		}
		else if(num =='3'){
			$("#tab"+num).load("${ctx}/mpPayInvoice/preCreate?",{id:id, strPayNo:strPayNo},function(){
				layer.close(loadingIndex);
			})
		}
		else if(num =='4'){
			$("#tab"+num).load("${ctx}/mpPayWriteoff/preCreate",{id:id,strPayNo:strPayNo,strVendorNo:strVendorNo},function(){
				layer.close(loadingIndex);
			})
		}
	}

	function CheckS() {
		var strVendorNoMpPayM = $("#strVendorNoMpPayM1").val();
		if (strVendorNoMpPayM == '' ){
			layer.msg("请填写供应商编号", {icon: 5});
			return false;
		}
		return true;
	}


	// 新增保存方法
	function beforeSubmiMpPayM() {
		if(CheckS() == false){
			return null ;
		}
		$.ajax({
				type:"post",
				url:"${ctx}/mpPayM/create",
				data:$("#mpPayM").serialize(),
				datatype:"json",
				success:function(rst){
					var data = JSON.parse(rst);
					var rel = data.rel;
					if(data.statusCode == 200) {
						$('#alls').load("${ctx}/mpPayM/preCreate?id="+rel,function(){
						});
						NavTab.reloadWithPagination(data.navTabId);

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


	function  effect () {
		var strPayStus1 = $("#strPayStus1").val();
		if(strPayStus1 == "S"){
			layer.msg("采购报账已生效，不能重复生效");
		}else
		{
			var id =$("#relativedId").val();
			$.ajax({
			type:"post",
			url:"${ctx}/mpPayM/effect",
			data:{id : id},
			datatype:"json",
			success:function(rst){
				var data = JSON.parse(rst);
				var rel = data.rel;
				if(data.statusCode == 200) {
					$('#alls').load("${ctx}/mpPayM/preCreate?id="+rel,function(){
					});
					NavTab.reloadWithPagination(data.navTabId);

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

	function  uneffect() {

		var strPayStus1 = $("#strPayStus1").val();
		if(strPayStus1 != "S"){
			layer.msg("采购报账未生效，不能取消生效");
		}else {
			var id =$("#relativedId").val();
			$.ajax({
				type:"post",
				url:"${ctx}/mpPayM/uneffect",
				data:{id : id},
				datatype:"json",
			success:function(rst){
				var data = JSON.parse(rst);
				var rel = data.rel;
				if(data.statusCode == 200) {
					$('#alls').load("${ctx}/mpPayM/preCreate?id="+rel,function(){
					});
					NavTab.reloadWithPagination(data.navTabId);

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





</script>

<div id="alls">
	<div class="layui-tab" id="layui-tab">
		<ul class="layui-tab-title">
			<li class="layui-this"  onclick="loadTab('1')">采购报账主档</li>
			<li onclick="loadTab('2')">采购报账明细</li>
			<li onclick="loadTab('3')">发票资料</li>
			<li onclick="loadTab('4')">预付款冲销</li>
		</ul>
		<div class="layui-tab-content">
			<div id="tab1" class="layui-tab-item layui-show">
				<div class="tab-bars">
					<a class="add" href="#" onclick="beforeSubmiMpPayM(this)"><span>保存</span></a>
					<a class="add" href="#" onclick="effect(this)"><span>生效</span></a>
					<a class="delete" href="#" onclick="uneffect(this)"><span>取消确认</span></a>
				</div>
					<form class="layui-form" method="post" action="${ctx}/mpPayM/create" id="mpPayM" onsubmit=" return validateCallback(this, dialogInsertPlanDone);">
						<input type="hidden" id="relativedId" name="id" value="${mpPayM.id}">
						<div class="layui-form-item">
							<div class="layui-col-xs3">
								<label class="layui-form-label">报账单号:</label>
								<div class="layui-input-block">
									<input type="text" class="layui-input" id="strPayNo" name="strPayNo" value="${mpPayM.strPayNo}"  autocomplete="off"   readonly="readonly" placeHolder="请输入报账单号" />
								</div>
							</div>
							<div class="layui-col-xs3">
								<label class="layui-form-label">报支单号:</label>
								<div class="layui-input-block">
									<input type="text" class="layui-input" name="strBillNo"  value="${mpPayM.strBillNo}"  autocomplete="off" readonly="readonly"   placeHolder="请输入报支单号" />
								</div>
							</div>

							<div class="layui-col-xs3">
								<label class="layui-form-label">报账申请人:</label>
								<div class="layui-input-block">
									<input type="hidden" class="layui-input" name="strEmplNo"value="${mpPayM.strEmplNo}"  autocomplete="off" placeHolder="请输入报账申请人" />
									<input type="text" class="layui-input" value="${mpPayM.strEmplName}"  autocomplete="off" placeHolder="请输入报账申请人" />
								</div>
							</div>
							<div class="layui-col-xs3">
								<label class="layui-form-label">供应商编号:</label>
								<div class="layui-input-block">
									<input type="hidden" lay-verify="required" id="strVendorNoMpPayM1" name="strVendorNo" readonly="readonly"  value="${mpPayM.strVendorNo}" class="layui-input"  />
									<input type="text" lay-verify="required" id="strVendorNoNameMpPayM1"   placeholder="请挑选供应商编号" value="${mpPayM.strVendorNo}"  class="layui-input" />
									<a class="layui-btn layui-btn-sm select-btn" href="${ctx}/mcInfomationM/listMerchant?strVendorNo1=strVendorNoMpPayM1&strVendorNoName=strVendorNoNameMpPayM1" lookupGroup="org2t" target="dialog" dialogId="selectMerchantDialog"    rel="selectCmMerchant" title="供应商" width="800" height="480"><i class="layui-icon layui-icon-search"></i></a>
								</div>
							</div>
						</div>
						<div class="layui-form-item">
							<div class="layui-col-xs3">
								<label class="layui-form-label">报支人:</label>
								<div class="layui-input-block">
									<input type="hidden" class="layui-input" name="strBillEmplNo" value="${mpPayM.strBillEmplNo}"   autocomplete="off" placeHolder="请输入报支人" />
									<input type="text" class="layui-input" name="strBillEmplNo" value="${mpPayM.strBillEmplName}"   autocomplete="off" placeHolder="请输入报支人" />
								</div>
							</div>

							<div class="layui-col-xs3">
								<label class="layui-form-label">审批日期:</label>
								<div class="layui-input-block">
									<input type="text" class="layui-input" name="strCheckDate"value="${mpPayM.strCheckDate}" autocomplete="off"  readonly="readonly"  placeHolder="请输入审批日期" />
								</div>
							</div>
							<div class="layui-col-xs3">
								<label class="layui-form-label">报支日期:</label>
								<div class="layui-input-block">
									<input type="text" class="layui-input" name="strBillDate" value="${mpPayM.strBillDate}" autocomplete="off"  readonly="readonly " placeHolder="请输入报支日期" />
								</div>
							</div>
							<div class="layui-col-xs3">
								<label class="layui-form-label">报支状态:</label>
								<div class="layui-input-block">
									<input type="hidden" class="layui-input" id="strPayStus1" name="strPayStus" value="${mpPayM.strPayStus}"/>
									<input type="text" class="layui-input" name="" value="${mpPayM.strPayStus eq 'N' ?'新增':(mpPayM.strPayStus eq 'S'  ? '生效' : (mpPayM.strPayStus eq 'D'?'删除' :'' ))}"
										   readonly ="readonly" autocomplete="off"  placeHolder="请输入报支状态" />
								</div>
							</div>

						</div>

						<div class="layui-form-item">
							<div class="layui-col-xs3">
								<label class="layui-form-label">税前金额合计:</label>
								<div class="layui-input-block">
									<input type="text" class="layui-input" name="bdTotalAmt"value="${mpPayM.bdTotalAmt}"  autocomplete="off" placeHolder="请输入税前金额合计" />
								</div>
							</div>
							<div class="layui-col-xs3">
								<label class="layui-form-label">税额合计:</label>
								<div class="layui-input-block">
									<input type="text" class="layui-input" name="bdTotalTaxAmt "value="${mpPayM.bdTotalTaxAmt}"  autocomplete="off"  placeHolder="请输入税额合计" />
								</div>
							</div>
							<div class="layui-col-xs3">
								<label class="layui-form-label">总冲销总额:</label>
								<div class="layui-input-block">
									<input type="text" class="layui-input" name="bdTotalWriteOffAmt"  value="${mpPayM.bdTotalWriteOffAmt}"  placeHolder="请输入总冲销总额" />
								</div>
							</div>
							<div class="layui-col-xs3">
								<label class="layui-form-label">税后总额:</label>
								<div class="layui-input-block">
									<input type="text" class="layui-input" name="bdTotalAfterAmt"value="${mpPayM.bdTotalAfterAmt}" autocomplete="off"  placeHolder="请输入税后总额" />
								</div>
							</div>
						</div>

						<div class="layui-form-item">
							<div class="layui-col-xs3">
								<label class="layui-form-label">报支种类:</label>
								<div class="layui-input-block">
									<select id="strBillType" name="strBillType">
										<option value="YS">验收报账</option>
									</select>
								</div>
							</div>
							<div class="layui-col-xs3">
								<label class="layui-form-label">付款方式:</label>
								<div class="layui-input-block">
									<select id="strPayType" name="strPayType">
										<c:forEach items="${strPayType}" var="dict" varStatus="status">
											<c:choose>
												<c:when test="${dict.strValue == mpPayM.strPayType}">
													<option value="${dict.strValue}"  selected="selected">${dict.strDescDtl}</option>
												</c:when>
												<c:otherwise>
													<option value="${dict.strValue}">${dict.strDescDtl}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="layui-col-xs6">
								<label class="layui-form-label">备注:</label>
								<div class="layui-input-block">
									<input type="text" class="layui-input" name="strMemo" autocomplete="off" value="${mpPayM.strMemo}" placeholder="请输入备注" />
								</div>
							</div>
						</div>
					</form>
			</div>
			<div id="tab2" class="layui-tab-item">
			</div>
			<div id="tab3" class="layui-tab-item">
			</div>
			<div id="tab4" class="layui-tab-item">
			</div>
		</div>
	</div>
</div>





