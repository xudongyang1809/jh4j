<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>

<div class="pageContent">
	<form id="form" method="post" action="${ctx}/mcInfomationM/create" onsubmit="return dialogAjaxDone(this);" class="layui-form">
		<div class="dialogContent">
		<div class="layui-tab" >
			<ul class="layui-tab-title">
				<li class="layui-this">基本</li>
				<li>信用</li>
			</ul>
			<div class="layui-tab-content">
				<!-- 选项卡1 -->
    			<div class="layui-tab-item layui-show">
					<input type="hidden" id="id" name="id" value="${id}">
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">企业编码:</label>
							<div class="layui-input-inline">
								<select  name="code1" id="code1" lay-filter="code11">
									<c:forEach items="${cityNoList}" var="MerchantClass" >
										<option value='${MerchantClass.strSn}' strSn="${MerchantClass.strValue}">${MerchantClass.strValue}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">企业类型：</label>
							<div class="layui-input-block">
								<input type="radio" name="strType" value="1" title="商户" checked>
								<input type="radio" name="strType" value="0" title="客户">
								<input type="radio" name="strType" value="2" title="两者都是">
							</div>
						</div>
    				</div>
    				<div class="layui-form-item">
    					<div class="layui-inline">
							<label class="layui-form-label required-input">企业名称:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strVendorName" value="" lay-verify="required" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label required-input">企业简称:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strAbbrevName" value="" lay-verify="required" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">企业英文名:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strEngName" value=""  />
							</div>
						</div>
    				</div>
    				<div class="layui-form-item">
    					<div class="layui-inline">
							<label class="layui-form-label required-input">企业地址:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strAddress" value="" lay-verify="required" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label required-input">税号:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strUniform" value="" lay-verify="required"/>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label required-input">营业执照注册号:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strBussinessNo" id="strBelongIndus" value="" lay-verify="required"/>
							</div>
						</div>
    				</div>
    				<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">企业性质:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strEnterpriseType" value="" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">经营方式:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strBussinessPractice" value="" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">企业规模:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strScale" value="" />
							</div>
						</div>
    				</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">评价等级:</label>
							<div class="layui-input-inline">
								<select  name="strAppraise" id="strAppraise">
									<option value="1">一级</option>
									<option value="2">二级</option>
									<option value="3">三级</option>
									<option value="4">其他</option>
								</select>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">有效期限:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strValldDate" id="strValldDate"
									   value="" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">企业所在省:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strProvinceId" value="" />
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">企业所在市:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strCityId" value="" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">网址:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strWebsite" value="" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">邮箱:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strEmail" value="" />
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">传真:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strFax" value="" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">邮政编码:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strZipCode" value="" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">档案号:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strFN" value="" />
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">是否合格商家:</label>
							<div class="layui-input-inline">
								<select  name="strQualified" >
									<option value="Y">是</option>
									<option value="N">否</option>
								</select>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">入网日期:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strStartDate" id="strStartDate" value="" />
							</div>
						</div>
					</div>
					<div class="layui-form-item" style="width: 950px">
						<label class="layui-form-label">备注:</label>
						<div class="layui-input-block">
							<textarea name="strRemark" placeholder="请输入内容(字数不得超过100)" class="layui-textarea"></textarea>
						</div>
					</div>
				</div>
    			
    			<!-- 选项卡2 -->
				<div class="layui-tab-item">
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label required-input">委托代理人:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strAgent" value="" lay-verify="required"/>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">委托代理人职位:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strAgentPlace" value="" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label required-input">委托代理人电话:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strAgentTel" value="" lay-verify="required"/>
							</div>
						</div>

					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label required-input">委托代理人手机:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strAgentMobile" value="" lay-verify="required"/>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">委托代理人传真:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strAgentFax" value="" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">委托代理人邮箱:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strAgentMail" value="" />
							</div>
						</div>

					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">委托代理人起始日期:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strProxyStartDate" id="strProxyStartDate" value="" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">委托代理人结束日期:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strProxyEndDate" id="strProxyEndDate" value="" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label">币种:</label>
							<div class="layui-input-inline">
								<select  name="strCrcy" id="strCrcy">
									<option value="1">人民币</option>
									<option value="2">美元</option>
									<option value="3">欧元</option>
									<option value="4">港币</option>
								</select>
							</div>
						</div>

					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label">资信证号:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strCreditNo" value="" />
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label required-input">开户银行:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strCreditRank" value="" lay-verify="required"/>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label required-input">银行账号:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="strBankAccount" value="" lay-verify="required"/>
							</div>
						</div>

					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label required-input">注册资金:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="decCapital" value="" lay-verify="required"/><span>(万元)</span>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label required-input">流动资金:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="decliuCapital" value="" lay-verify="required"/><span>(万元)</span>
							</div>
						</div>


					</div>
					<div class="layui-form-item">
						<div class="layui-inline">
							<label class="layui-form-label required-input">负债总额:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="decOwes" value="" lay-verify="required"/><span>(万元)</span>
							</div>
						</div>
						<div class="layui-inline">
							<label class="layui-form-label required-input">固定资产:</label>
							<div class="layui-input-inline">
								<input type="text" class="layui-input" name="decEquipment" value="" lay-verify="required"/><span>(万元)</span>
							</div>
						</div>

					</div>
					<div class="layui-form-item" style="width: 950px">
						<label class="layui-form-label">企业概况:</label>
						<div class="layui-input-block">
							<textarea name="strBrief" placeholder="请输入内容(字数不得超过100)" class="layui-textarea"></textarea>
						</div>
					</div>
					<div class="layui-form-item" style="width: 950px">
						<label class="layui-form-label">企业备注:</label>
						<div class="layui-input-block">
							<textarea name="strEnterpriseMeno" placeholder="请输入内容(字数不得超过100)" class="layui-textarea"></textarea>
						</div>
					</div>
				</div>

  			</div>
		</div>
		</div>
		<div class="dialogFooter"><button type="submit" class="layui-btn" >提交</button></div>
	</form>
</div>
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

		laydate.render({
			elem: '#strIssueDate',
			type:'date'
			,trigger: 'click'
		});

		laydate.render({
			elem: '#strIssueEndDate',
			type:'date'
			,trigger: 'click'
		});
	});

</script>




