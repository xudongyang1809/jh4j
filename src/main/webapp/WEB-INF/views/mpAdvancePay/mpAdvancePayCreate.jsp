<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>

<script >

	function loadTab(num){
		debugger;
		 var id=$("#mpAdvanceid").val();
		var strPayNo=$("#strPayNo").val();
		var loadingIndex = Dialog.load();
		if(num == '1')
			$('#alls').load("${ctx}/mpAdvancePay/preCreate?id="+id,function(){
				layer.close(loadingIndex);
			});
		if(num == '2')
			$("#tab"+num).load("${ctx}/mpAdvancePay/advanceDtl?id="+id+"&strPayNo="+strPayNo, function(){
					layer.close(loadingIndex);
			});
	}


	function  loadIndexmpAdvance() {
		var loadingIndex = Dialog.load();
		var rel  = $("#mpAdvanceid").val();
		$('#alls').load("${ctx}/mpAdvancePay/preCreate?id="+rel,function(){
			layer.close(loadingIndex);
		});
	}

	function CheckAdvance() {
		var strVendorNo = $("#strVendorNoMpAdvance").val();
		if (strVendorNo == '' ){
			layer.msg("请填写供应商编号", {icon: 5});
			return false;
		}
		return true;
	}

// 回调函数
	function submitAdvance() {
		if(!CheckAdvance()){
			return ;
		}

		$.ajax({
			type:"post",
			url:"${ctx}/mpAdvancePay/create",
			data:$("#mpAdvancePay111").serialize(),
			datatype:"json",
			success:function(rst){
				var data = JSON.parse(rst);
				var rel = data.rel;
				if(data.statusCode == 200) {
					$('#alls').load("${ctx}/mpAdvancePay/preCreate?id="+rel,function(){
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
		debugger;
		var id =$("#mpAdvanceid").val();
		$.ajax({
			type:"post",
			url:"${ctx}/mpAdvancePay/effect",
			data:{id : id},
			datatype:"json",
			success:function(rst){
				var data = JSON.parse(rst);
				var rel = data.rel;
				if(data.statusCode == 200) {
					$('#alls').load("${ctx}/mpAdvancePay/preCreate?id="+rel,function(){
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

	function  uneffect() {
		var id =$("#mpAdvanceid").val();
	/*	var ihid =$("#ihid").val();
		if (ihid =='' || ihid == null){
			layer.msg("请保存主档信息");
			return ;
		}*/
		$.ajax({
			type:"post",
			url:"${ctx}/mpAdvancePay/uneffect",
			data:{id : id},
			datatype:"json",
			success:function(rst){
				var data = JSON.parse(rst);
				var rel = data.rel;
				if(data.statusCode == 200) {
					$('#alls').load("${ctx}/mpAdvancePay/preCreate?id="+rel,function(){
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



</script>

<div id="alls">
	<div class="layui-tab" id="layui-tab">
		<ul class="layui-tab-title">
			<li class="layui-this" onclick="loadTab('1')" >预付款主档</li>
			<li onclick="loadTab('2')">预付款明细</li>
		</ul>
		<div class="layui-tab-content">
		<div id="tab1" class="layui-tab-item layui-show">
			<div class="tab-bars">
				<a class="add" href="#" onclick="submitAdvance(this)"><span>保存</span></a>
				<a class="add" href="#" onclick="effect(this)"><span>生效</span></a>
				<a class="delete" href="#" onclick="uneffect(this)"><span>取消生效</span></a>
			</div>
				<form class="layui-form" method="post" action="${ctx}/mpAdvancePay/create"  id="mpAdvancePay111">

					<input type="hidden" id="mpAdvanceid" name="id" value="${mpPayM.id}">
					<div class="layui-form-item">
						<div class="layui-col-xs3">
							<label class="layui-form-label">报账单号:</label>
							<div class="layui-input-block">
								<input type="text" id="strPayNo" class="layui-input" name="strPayNo" value="${mpPayM.strPayNo}"  readonly="readonly" placeHolder="请输入报账单号" />
							</div>
						</div>
						<div class="layui-col-xs3">
							<label class="layui-form-label">报支单号:</label>
							<div class="layui-input-block">
								<input type="text" class="layui-input" name="strBillNo" value="${mpPayM.strBillNo}" autocomplete="off" readonly="readonly" placeHolder="请输入报支单号" />
							</div>
						</div>

						<div class="layui-col-xs3">
							<label class="layui-form-label">厂商编号:</label>
							<div class="layui-input-block">
								<input type="hidden" lay-verify="required" id="strVendorNoMpAdvance" name="strVendorNo" readonly="readonly"  value="${mpPayM.strVendorNo}" class="layui-input"  />
								<input type="text"  lay-verify="required" id="strVendorNoNameMpAdvance"   value="${mpPayM.strVendorNo}"  class="layui-input" />
								<a class="layui-btn layui-btn-sm select-btn" href="${ctx}/mcInfomationM/listMerchant?strVendorNo1=strVendorNoMpAdvance&strVendorNoName=strVendorNoNameMpAdvance" lookupGroup="org2t" target="dialog" dialogId="selectMerchantDialog"    rel="selectCmMerchant" title="供应商" width="800" height="480"><i class="layui-icon layui-icon-search"></i></a>
							</div>
						</div>
						<div class="layui-col-xs3">
							<label class="layui-form-label">报账申请人:</label>
							<div class="layui-input-block">
								<input type="hidden" class="layui-input" name="strEmplNo" value="${mpPayM.strEmplNo}" autocomplete="off" placeHolder="请输入报账申请人" />
								<input type="text" class="layui-input"  value="${mpPayM.strEmplName}" autocomplete="off" placeHolder="请输入报账申请人" />
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-col-xs3">
							<label class="layui-form-label">报支确认人:</label>
							<div class="layui-input-block">
								<input type="hidden" class="layui-input" name="strBillEmplNo" value="${mpPayM.strBillEmplNo}" autocomplete="off" placeHolder="请输入报支人" />
								<input type="text" class="layui-input"  value="${mpPayM.strBillEmplName}" autocomplete="off" placeHolder="请输入报支人" />
							</div>
						</div>
						<div class="layui-col-xs3">
							<label class="layui-form-label">确认日期:</label>
							<div class="layui-input-block">
								<input type="text" class="layui-input" name="strBillDate"  value="${mpPayM.strBillDate}" autocomplete="off" readonly="readonly" placeHolder="请输入报支日期" />
							</div>
						</div>
						<div class="layui-col-xs3">
							<label class="layui-form-label">报支种类:</label>
							<div class="layui-input-block">
								<select id="strBillType" name="strBillType">
									<option value="">--请选择报支种类--</option>
									<c:forEach items="${YFstrBillType}" var="dict" varStatus="status">
										<c:choose>
											<c:when test="${dict.strValue==mpPayM.strBillType}">
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
						<div class="layui-col-xs3">
							<label class="layui-form-label">付款方式:</label>
							<div class="layui-input-block">
								<select id="strPayType" name="strPayType">
									<option value="">--请选择付款方式--</option>
									<c:forEach items="${YFstrPayType}" var="dict" varStatus="status">
										<c:choose>
											<c:when test="${dict.strValue== mpPayM.strPayType}">
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
					</div>
					<div class="layui-form-item">
						<div class="layui-col-xs3">
							<label class="layui-form-label">报支状态:</label>
							<div class="layui-input-block">
								<input type="text" class="layui-input" name="strPayStus"  readonly="readonly" value="${mpPayM.strPayStus eq 'N' ?'新增':(mpPayM.strPayStus eq 'S'  ? '生效' : (mpPayM.strPayStus eq 'D'?'删除' :'' ))}"	 autocomplete="off"  placeHolder="请输入报支状态" />
							</div>
						</div>
						<div class="layui-col-xs3">
							<label class="layui-form-label">预付款金额:</label>
							<div class="layui-input-block">
								<input type="text" class="layui-input" value="${mpPayM.bdTotalAfterAmt}" name="bdTotalAfterAmt" readonly="readonly" placeHolder="请输入税额合计" />
							</div>
						</div>

					<div class="layui-col-xs6">
						<label class="layui-form-label">备注:</label>
						<div class="layui-input-block">
							<input type="text" class="layui-input" name="strMemo" autocomplete="off" value="${mpPayM.strMemo}" laceHolder="请输入备注" />
						</div>
					</div>
					</div>
				</form>
			</div>
			<div id="tab2" class="layui-tab-item">
			</div>
		</div>
	</div>
</div>




























