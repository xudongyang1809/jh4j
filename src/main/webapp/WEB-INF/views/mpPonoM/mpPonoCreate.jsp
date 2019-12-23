<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 创建画面
	 @author 王梦奇 022347
	 @date 2019-04-29 16:17:37
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<style>
	.layui-form-label{
	width:110px;
	padding: 12px 0px 2px 0px;
	text-align: center
	}
	.layui-input-block{
	margin-right:5px;
	width: 180px;
	}
</style>
<script>
	////
	layui.use('laydate', function(){
		var laydate = layui.laydate;
		var startDate=laydate.render({
			elem: '#strBeginDatenew',
			type: 'date',
			done: function(value, date){
				endDate.config.min ={		//控制 开始有效日期
					year:date.year,
					month:date.month-1,
					date: date.date
				};
			}
		});
		var endDate= laydate.render({
			elem: '#strEndDatenew',
			type: 'date',
			done: function(value,date){    // 生效结束日期
				startDate.config.max={
					year:date.year,
					month:date.month-1,
					date: date.date
				}
			}
		});
	})
	layui.use('laydate', function(){
		var laydate = layui.laydate;
		laydate.render({
			elem: '#strComfirmDate'     //结案日期
			,type: 'month'
		});

		laydate.render({
			elem: '#strPoDate'    // 订购日期


		});
	})

	function loadTab(num){
		debugger;
		var id=$("#mpPonoM").val();
		var strVendorNo=$("#strVendorNoMpPoNos").val();
		var loadingIndex = Dialog.load();
		var strPoNo =$("#strPoNo").val()
		if(num =='1' && id !=''){
			$("#alls").load("${ctx}/mpPonoM/preUpdate/"+id,function(){
			});
		}else if(num =='1' && id =='') {
            $("#alls").load("${ctx}/mpPonoM/preCreate",{},function(){
            });
        }
		else if(num=='2'){
				$("#tab"+num).load("${ctx}/mpPonoD/preCreate?ihid="+id+'&strVendorNo='+strVendorNo,{}, function(){
					layer.close(loadingIndex);
				});
			}
		else if(num=='3'){
				$("#tab"+num).load("${ctx}/mpPonoPay/preCreate?ihid="+id+"&strPoNo="+strPoNo,{},function(){
					layer.close(loadingIndex)
				});
			}
	}

 <!-- 新增保存回调方法-->
	function dialogInsertPlanDone(result) {
		try {
			var messages=result.message;
			var rel = result.rel;
            $("#mpPonoM").val(rel);
			//alert(rel);
			if((result.statusCode==200)){
				Dialog.success(messages);

				$("#alls").load("${ctx}/mpPonoM/preUpdate/"+rel,{},function(){
				})
				NavTab.reloadWithPagination(result.navTabId);

			}else{
				Dialog.error(messages);
			}
		} catch (e) {
			console.log(msg);
			Dialog.error(e.message);
		}
	}

	function beforeSubmitaaMpPono(obj)
	{

		// 判断状态
		var MpPonoMstrStus = $("#MpPonoMstrStus").val();
		if(MpPonoMstrStus == 'S' ){
			layer.msg("生效后，无法进行修改！");
		}else{
			if (validateForm($('#saveMpPonoForm'))) {
				$('#saveMpPonoForm').submit();
			}
		}

	}

	//新增版本
	function createEdition(){

		var id= $("#mpPonoM").val();
		var strRevision = $("#strRevision1").val();
		var strIsActiveCont = $("#strIsActiveCont").val();
		if(strIsActiveCont !='Y'){
			layer.msg("请切换至最高版本，再进行版本新增");
		}else {
			layer.confirm("确认新增版本吗？", function () {
             $.post("${ctx}/mpPonoM/createEdition?id="+id+'&strRevision='+strRevision, function (msg) {
                try {
                    var result = JSON.parse(msg);
                    var messages=result.message;
                    var  rel = result.rel;
                    Ajax.ajaxDone(result);
                    if (result.statusCode == 200) {
                        Dialog.success(messages);
						$("#alls").load("${ctx}/mpPonoM/preUpdate/"+rel,{},function(){
						})
                    }
                    else {
                        Dialog.error(result.message);
                    }
                }catch (e) {
                    console.log(msg);
                    Dialog.error(e.message);
                }
            })
         });
		}
	}
	
	/**
	 * 上一版本
	 */
	function lastEdition() {

		var id= $("#mpPonoM").val();
		var strRevision = $("#strRevision1").val();
		var strPoNo =$  ("#strPoNo").val();
		if(strRevision == '00' || id =='' ){
			alert("当前为第一版本，无上一版")
		}
			$.post("${ctx}/mpPonoM/lastEdition?id="+id+'&strPoNo='+strPoNo+'&strRevision='+strRevision, function (msg) {
				try {
					debugger;
					var result = JSON.parse(msg);
					var messages=result.message;
					var rel = result.rel;
					Ajax.ajaxDone(result);
					if (result.statusCode == 200) {
						Dialog.success(messages);
						$("#alls").load("${ctx}/mpPonoM/preUpdate/"+rel,{},function(){
						})
					}
					else {
						Dialog.error(result.message);
					}
				}catch (e) {
					console.log(msg);
					Dialog.error(e.message);
				}
			})
	}

	//下一版
	function nextEdition() {
		var id= $("#mpPonoM").val();
		var strRevision = $("#strRevision1").val();
		var strPoNo =$("#strPoNo").val();
		$.post("${ctx}/mpPonoM/nextEdition?id="+id+'&strPoNo='+strPoNo+'&strRevision='+strRevision, function (msg) {
			try {
				var result = JSON.parse(msg);
				var messages=result.message;
				var rel = result.rel;
				Ajax.ajaxDone(result);
				if (result.statusCode == 200) {
					Dialog.success(messages);
					$("#alls").load("${ctx}/mpPonoM/preUpdate/"+rel,{},function(){
					})
				}
				else {
					Dialog.error(result.message);
				}
			}catch (e) {
				console.log(msg);
				Dialog.error(e.message);
			}
		})
	}
	//// 刷新当前页
	function  refreshindex () {
		var loadingIndex = Dialog.load();
		var rel = $("#mpPonoM").val();
			$("#alls").load("${ctx}/mpPonoM/preUpdate/"+rel,{},function(){
		})
	}

	/**
	 *生效
	 * */
	function effect() {
		var id= $("#mpPonoM").val();
		var strPoNo =$  ("#strPoNo").val();
		var strRevision = $("#strRevision1").val();
		var MpPonoMstrStus = $("#MpPonoMstrStus").val();

		layer.confirm("确认生效吗",function () {
			$.post("${ctx}/mpPonoM/effect?id="+id+"&strPoNo="+strPoNo+"&strRevision="+strRevision, function (msg) {
				try {
						var  result = JSON.parse(msg)
						var message = result.message;
					Ajax.ajaxDone(result);
						if(result.statusCode =='200'){
							Dialog.success(message);
							refreshindex();
							$("#alls").load("${ctx}/mpPonoM/preUpdate/"+id,{},function(){
							})
						}else {
							Dialog.error(message);
						}
				}catch (e) {
					Dialog.error(message);
				}
			})
		})
	}

	/**
	 * 取消生效
	 */
	function uneffect() {
		var id= $("#mpPonoM").val();
		var strPoNo =$  ("#strPoNo").val();
		var strRevision = $("#strRevision1").val();
		layer.confirm("确认取消生效吗",function () {
			$.post("${ctx}/mpPonoM/uneffect?id="+id+"&strPoNo="+strPoNo+"&strRevision="+strRevision, function (msg) {
				try {
					var  result = JSON.parse(msg)
					var message = result.message;
					Ajax.ajaxDone(result);
					if(result.statusCode == 200){
						Dialog.success(message);
						$("#alls").load("${ctx}/mpPonoM/preUpdate/"+id,{},function(){
						});
					}else {
						Dialog.error(message)
					}
				}catch (e) {
					console.log(message);
					Dialog.error(e.message)
				}
			})
		})
	}
	/**
	 * 删除版本
	 */
	function deleteEdition() {
		var id= $("#mpPonoM").val();
		var strPoNo =$  ("#strPoNo").val();
		var strRevision = $("#strRevision1").val();
		layer.confirm("确认删除该合同版本吗？",function (){
			$.post("${ctx}/mpPonoM/deleteEdition",{id:id,strPoNo:strPoNo,strRevision:strRevision}, function (msg) {
				try {
					var  result = JSON.parse(msg)
					var message = result.message;
					Ajax.ajaxDone(result);
					if(result.statusCode == 200){
						Dialog.success(message);
						$("#alls").load("${ctx}/mpPonoM/preUpdate/"+id,{},function(){
						});
					}else {
						Dialog.error(message)
					}
				}catch (e) {
					console.log(message);
					Dialog.error(e.message)
				}
			})
		})
	}


	/*
 * 选择单个人员的回调方法
 */
	function selectSingleUserCallback(userId, userNo, username) {
		$('#userIdstrRespEmpNo').val(userId);
		$('#usernamestrRespEmpNo').val(username);
	}

</script>
<div id="alls">
	<div class="layui-tab" id="layui-tab" lay-filter="test" >
		<ul class="layui-tab-title">
			<li class="layui-this" onclick="loadTab('1')" >合同主档</li>
			<li onclick="loadTab('2')">合同明细</li>
			<li onclick="loadTab('3')">合同付款条件</li>
		</ul>
		<div class="layui-tab-content">
			<div id="tab1" class="layui-tab-item layui-show">
				<div class="tab-bars">
					<shiro:hasPermission name="MpPonoM:create">
						<a class="add" href="#" onclick="beforeSubmitaaMpPono(this)"><span>保存</span></a>
					</shiro:hasPermission>

					<a class="add" href="#" onclick="createEdition(this)"><span>新增版本</span></a>
					<a class="view" href="#" onclick="lastEdition(this)"><span>上一版</span></a>
					<a class="preview" href="#" onclick="nextEdition(this)"><span>下一版</span></a>


					<a class="confirm" href="#" onclick="effect(this)"><span>生效</span></a>
					<a class="cancelConfirm" href="#" onclick="uneffect(this)"><span>取消生效</span></a>
				</div>
				<form  method="post" class="layui-form" action="${ctx}/mpPonoM/create" id="saveMpPonoForm" onsubmit=" return validateCallback(this, dialogInsertPlanDone);">
					<input type="hidden" id="mpPonoM" name="id" value="${mpPonoM.id}"/>
					<div class="layui-form-item">
						<div class="layui-col-xs3">
							<label class="layui-form-label">采购合同号:</label>
							<div class="layui-input-block">
								<input type="text" id="strPoNo" name="strPoNo" readonly="readonly" class="layui-input" placeHolder="请输入采购合同号" autocomplete="off" value="${mpPonoM.strPoNo}" />
							</div>
						</div>
						<div class="layui-col-xs3">
							<label class="layui-form-label">版本号:</label>
							<div class="layui-input-block">
								<input type="text" name="strRevision" id="strRevision1" readonly="readonly"  class="layui-input" placeHolder="请输入版本号"  autocomplete="off" value="${mpPonoM.strRevision}" />
							</div>
						</div>

						<div class="layui-col-xs3">
							<label class="layui-form-label">采购合同名称:</label>
							<div class="layui-input-block">
								<input type="text" name="strPoName"   class="layui-input" placeHolder="请输入采购合同名称" autocomplete="off" value="${mpPonoM.strPoName}" />
							</div>
						</div>
						<div class="layui-col-xs3">
							<label class="layui-form-label">采购合同类型:</label>
							<div class="layui-input-block">
								<select id="strTypeId" name="strTypeId">
									<option value="">--采购合同类型--</option>
									<c:forEach items="${procurementContract}" var="dict" varStatus="status">
										<c:choose>
											<c:when test="${dict.strValue==mpPonoM.strTypeId}">
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
							<label class="layui-form-label">供应商编号:</label>
							<div class="layui-input-block">
								<input type="text" lay-verify="required" id="strVendorNoMpPoNos" name="strVendorNo" readonly="readonly"  value="${mpPonoM.strVendorNo}" class="layui-input" placeholder="供应商编号" />
									<a class="layui-btn layui-btn-sm select-btn" href="${ctx}/mcInfomationM/listMerchant?strVendorNo1=strVendorNoMpPoNos&strVendorName1=strVendorName" lookupGroup="org2t" target="dialog" dialogId="selectMerchantDialog"    rel="selectCmMerchant" title="供应商" width="800" height="480"><i class="layui-icon layui-icon-search"></i></a>
							</div>
						</div>
						<div class="layui-col-xs3">
							<label class="layui-form-label">供应商名称:</label>
			   				<div class="layui-input-block">
								<input type="text" lay-verify="required" name="strVendorName" id="strVendorName"     readonly="readonly" class="layui-input"  value="${mpPonoM.strVendorName}" placeholder="供应商名称"  />
							</div>
						</div>
						<div class="layui-col-xs3">
							<label class="layui-form-label">税率:</label>
							<div class="layui-input-block">
								<input type="text" name="strRate" class="layui-input" 
									   placeHolder="请输入税率"  autocomplete="off" value="${mpPonoM.strRate}" lay-verify="required" />
							</div>
						</div>
						<div class="layui-col-xs3">
							<label class="layui-form-label">币种:</label>
							<div class="layui-input-block">
								<input type="text" name="strCurrencyId"    class="layui-input" placeHolder="请输入币种" autocomplete="off" value="${mpPonoM.strCurrencyId}" />
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-col-xs3">
							<label class="layui-form-label">开始有效日期:</label>
							<div class="layui-input-block">
								<input type="text"  id="strBeginDatenew" name="strBeginDate"  lay-verify="required" class="layui-input" placeHolder="请输入开始有效日期" autocomplete="off" value="${mpPonoM.strBeginDate}" />
							</div>
						</div>
						<div class="layui-col-xs3">
							<label class="layui-form-label">结束有效日期:</label>
							<div class="layui-input-block">
								<input type="text" id="strEndDatenew" name="strEndDate"    lay-verify="required"  class="layui-input" placeHolder="请输入结束有效日期"  autocomplete="off" value="${mpPonoM.strEndDate}" />
							</div>
						</div>
						<div class="layui-col-xs3">
							<label class="layui-form-label">运输方式:</label>
							<div class="layui-input-block">
								<select id="strTransType" name="strTransType">
									<option value="">--请选择运输方式--</option>
									<c:forEach items="${dicTransType}" var="dict" varStatus="status">
										<c:choose>
											<c:when test="${dict.strValue==mpPonoM.strTransType}">
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
							<label class="layui-form-label">采购承办人</label>
							<div class="layui-input-block">
								<input type="hidden" id="userIdstrRespEmpNo" name="strRespEmpNo" value="${mpPonoM.strRespEmpNo}" />
								<input type="text"	 id="usernamestrRespEmpNo" placeholder="点击挑选人员"value="${mpPonoM.strRespEmpName}" readonly class="layui-input" style="padding-right: 50px;" />
								<i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
								<a class="layui-btn layui-btn-sm"   onPickUser="selectSingleUserCallback" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-col-xs3">
							<label class="layui-form-label">总数量:</label>
							<div class="layui-input-block">
								<input type="text" name="bdTotalQty"  class="layui-input" placeHolder="请输入总数量" readonly="readonly" value="${mpPonoM.bdTotalQty}" />
							</div>
						</div>

						<div class="layui-col-xs3">
							<label class="layui-form-label">总金额:</label>
							<div class="layui-input-block">
								<input type="text" name="bdTotalAmt"  class="layui-input" placeHolder="请输入总金额" readonly="readonly" autocomplete="off" value="${mpPonoM.bdTotalAmt}" />
							</div>
						</div>
						<div class="layui-col-xs3">
							<label class="layui-form-label">订购日期:</label>
							<div class="layui-input-block">
								<input type="text" id="strPoDate" name="strPoDate"  readonly="readonly" class="layui-input" placeHolder="请输入订购日期" autocomplete="off" value="${mpPonoM.strPoDate}" />
							</div>
						</div>
						<div class="layui-col-xs3">
							<label class="layui-form-label">状态:</label>
							<div class="layui-input-block">
								<input type="hidden" name="strStus" id="MpPonoMstrStus" value="${mpPonoM.strStus}" />
								<input type="text" name="strStusS"  id="" class="layui-input" placeHolder="请输入状态" autocomplete="off"
									   value="${mpPonoM.strStus eq 'N' ?'新增':(mpPonoM.strStus eq 'S'  ? '生效' : (mpPonoM.strStus eq 'D'?'删除' :(mpPonoM.strStus eq 'F' ?'作废':'') ))}" />
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-col-xs12">
							<label class="layui-form-label">备注:</label>
							<div class="layui-input-inline">
								<input type="text" name="strMemo" class="layui-input" placeHolder="请输入备注"   autocomplete="off" value="${mpPonoM.strMemo}" />
							</div>
						</div>
						<div class="layui-col-xs12">

							<div class="layui-input-inline">
								<input type="hidden" name="strIsActiveCont" id="strIsActiveCont" class="layui-input" placeHolder="请输入备注"   autocomplete="off" value="${mpPonoM.strIsActiveCont}" />
							</div>
						</div>
					</div>
				</form>
			</div>
			<div id="tab2" class="layui-tab-item">
			</div>
			<div id="tab3" class="layui-tab-item">
			</div>
		</div>
	</div>
</div>













