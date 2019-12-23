<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>



<div class="pageContent">
	<form id="form" method="post" action="${ctx}/mcInfomationM/update" onsubmit="return dialogAjaxDone(this);" class="layui-form">
		<div class="dialogContent">
		<div class="layui-tab" >
			<ul class="layui-tab-title">
				<li class="layui-this">基本</li>
				<li>信用</li>
			</ul>
			<div class="layui-tab-content">
				<!-- 选项卡1 -->
    			<div class="layui-tab-item layui-show">
					<input type="hidden" id="relativedId" name="relativedId" value="${mcInfomationM.id}">
					<input type="hidden" id="strStatusId" name="strStatusId" value="${mcInfomationM.strStatusId}">

					<input type="hidden" id="aaid" name="id" value="${mcInfomationM.id}">
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label required-input">企业编码:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strVendorNo" value="${mcInfomationM.strVendorNo}" lay-verify="required" readonly="readonly"/>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">企业类型：</label>
							<div class="layui-input-block">
								<input type="radio" name="strType" value="1" title="商户" ${mcInfomationM.strType eq '1'? 'checked' : ''}>
								<input type="radio" name="strType" value="0" title="客户" ${mcInfomationM.strType eq '0'? 'checked' : ''}>
								<input type="radio" name="strType" value="2" title="两者都是" ${mcInfomationM.strType eq '2'? 'checked' : ''}>
							</div>
						</div>
    				</div>
    				<div class="layui-form-item">
    					<div class="layui-inline">
							<label class="layui-form-label required-input">企业名称:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strVendorName" value="${mcInfomationM.strVendorName}" lay-verify="required" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label required-input">企业简称:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strAbbrevName" value="${mcInfomationM.strAbbrevName}" lay-verify="required" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">企业英文名:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strEngName" value="${mcInfomationM.strEngName}"  />
							</div>
						</div>
    				</div>
    				<div class="layui-form-item">
    					<div class="layui-inline">
							<label class="layui-form-label required-input">企业地址:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strAddress" value="${mcInfomationM.strAddress}" lay-verify="required" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">税号:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strUniform" value="${mcInfomationM.strUniform}" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">营业执照注册号:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strBussinessNo" id="strBussinessNo" value="#${mcInfomationM.strBussinessNo}" />
							</div>
						</div>
    				</div>
    				<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">企业性质:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strEnterpriseType" value="${mcInfomationM.strEnterpriseType}" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">经营方式:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strBussinessPractice" value="${mcInfomationM.strBussinessPractice}" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">企业规模:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strScale" value="${mcInfomationM.strScale}" />
							</div>
						</div>
    				</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">评价等级:</label>
							<div class="layui-input-inline">
								<select  name="strAppraise" id="strAppraise">
									<option value="1" ${mcInfomationM.strAppraise eq '1' ? 'checked' : ''}>一级</option>
									<option value="2" ${mcInfomationM.strAppraise eq '2' ? 'checked' : ''}>二级</option>
									<option value="3" ${mcInfomationM.strAppraise eq '3' ? 'checked' : ''}>三级</option>
									<option value="4" ${mcInfomationM.strAppraise eq '4' ? 'checked' : ''}>其他</option>
								</select>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">有效期限:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strValldDate" id="strValldDate"
									   value="${mcInfomationM.strValldDate}" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">企业所在省:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strProvinceId" value="${mcInfomationM.strProvinceId}" />
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">企业所在市:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strCityId" value="${mcInfomationM.strCityId}" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">网址:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strWebsite" value="${mcInfomationM.strWebsite}" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">邮箱:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strEmail" value="${mcInfomationM.strEmail}" />
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">传真:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strFax" value="${mcInfomationM.strFax}" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">邮政编码:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strZipCode" value="${mcInfomationM.strZipCode}" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">档案号:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strFN" value="${mcInfomationM.strFN}" />
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">是否合格商家:</label>
							<div class="layui-input-inline">
								<select  name="strQualified" >
									<option value="Y" ${mcInfomationM.strQualified eq 'Y' ? 'chenked' : ''}>是</option>
									<option value="N" ${mcInfomationM.strQualified eq 'N' ? 'chenked' : ''}>否</option>
								</select>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">入网日期:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strStartDate" id="strStartDate" value="${mcInfomationM.strStartDate}" />
							</div>
						</div>
					</div>
					<div class="layui-form-item" style="width: 950px">
						<label class="layui-form-label">备注:</label>
						<div class="layui-input-block">
							<textarea name="strRemark" placeholder="请输入内容(字数不得超过100)" class="layui-textarea">${mcInfomationM.strRemark}</textarea>
						</div>
					</div>
				</div>
    			
    			<!-- 选项卡2 -->
				<div class="layui-tab-item">
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label required-input">委托代理人:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" lay-verify="required" name="strAgent" value="${mcInfomationM.informationAgentEntity.strAgent}" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">委托代理人职位:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strAgentPlace" value="${mcInfomationM.informationAgentEntity.strAgentPlace}" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label required-input">委托代理人电话:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" lay-verify="required" name="strAgentTel" value="${mcInfomationM.informationAgentEntity.strAgentTel}" />
							</div>
						</div>

					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label required-input">委托代理人手机:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" lay-verify="required" name="strAgentMobile" value="${mcInfomationM.informationAgentEntity.strAgentMobile}" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">委托代理人传真:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strAgentFax" value="${mcInfomationM.informationAgentEntity.strAgentFax}" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">委托代理人邮箱:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strAgentMail" value="${mcInfomationM.informationAgentEntity.strAgentMail}" />
							</div>
						</div>

					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">委托代理人起始日期:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strProxyStartDate" id="strProxyStartDate" value="${mcInfomationM.informationAgentEntity.strProxyStartDate}" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">委托代理人结束日期:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strProxyEndDate" id="strProxyEndDate" value="${mcInfomationM.informationAgentEntity.strProxyEndDate}" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">币种:</label>
							<div class="layui-input-inline">
								<select  name="strCrcy" id="strCrcy">
									<option value="1" ${mcInfomationM.informationAgentEntity.strCrcy eq '1' ? 'checked' : ''}>人民币</option>
									<option value="2" ${mcInfomationM.informationAgentEntity.strCrcy eq '2' ? 'checked' : ''}>美元</option>
									<option value="3" ${mcInfomationM.informationAgentEntity.strCrcy eq '3' ? 'checked' : ''}>欧元</option>
									<option value="4" ${mcInfomationM.informationAgentEntity.strCrcy eq '4' ? 'checked' : ''}>港币</option>
								</select>
							</div>
						</div>

					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">资信证号:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strCreditNo" value="${mcInfomationM.informationAgentEntity.strCreditNo}" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label required-input">开户银行:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" lay-verify="required" name="strCreditRank" value="${mcInfomationM.informationAgentEntity.strCreditRank}" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label required-input">银行账号:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strBankAccount" lay-verify="required" value="${mcInfomationM.informationAgentEntity.strBankAccount}" />
							</div>
						</div>

					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label required-input">注册资金:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="decCapital" lay-verify="required" value="${mcInfomationM.informationAgentEntity.decCapital}" /><span>(万元)</span>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label required-input">流动资金:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="decliuCapital" lay-verify="required" value="${mcInfomationM.informationAgentEntity.decliuCapital}" /><span>(万元)</span>
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label required-input">负债总额:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="decOwes" lay-verify="required" value="${mcInfomationM.informationAgentEntity.decOwes}" /><span>(万元)</span>
							</div>
						</div>
                        <div class="layui-inline">
							<label class="layui-form-label required-input">固定资产:</label>
                            <div class="layui-input-inline">
                                <input type="text" class="layui-input" lay-verify="required" name="decEquipment" value="${mcInfomationM.informationAgentEntity.decEquipment}" /><span>(万元)</span>
                            </div>
                        </div>
					</div>
					<div class="layui-form-item" style="width: 950px">
						<label class="layui-form-label">企业概况:</label>
						<div class="layui-input-block">
							<textarea name="strBrief" placeholder="请输入内容(字数不得超过100)" class="layui-textarea">${mcInfomationM.informationAgentEntity.strBrief}</textarea>
						</div>
					</div>
					<div class="layui-form-item" style="width: 950px">
						<label class="layui-form-label">企业备注:</label>
						<div class="layui-input-block">
							<textarea name="strEnterpriseMeno" placeholder="请输入内容(字数不得超过100)" class="layui-textarea">${mcInfomationM.informationAgentEntity.strEnterpriseMeno}</textarea>
						</div>
					</div>
				</div>
  			</div>
		</div>
		</div>
		<div class="dialogFooter"><button type="submit" class="layui-btn" >提交</button></div>
	</form>

	<script type="text/javascript">
		layui.use('laydate', function(){
			var laydate = layui.laydate;
			laydate.render({
				elem: '#strValldDate',
				type:'date'
				,trigger: 'click'
			});
			laydate.render({
				elem: '#strStartDate',
				type:'date'
				,trigger: 'click'
			});

			laydate.render({
				elem: '#strProxyStartDate',
				type:'date'
				,trigger: 'click'
			});

			laydate.render({
				elem: '#strProxyEndDate',
				type:'date'
				,trigger: 'click'
			});


		});

	</script>
</div>





