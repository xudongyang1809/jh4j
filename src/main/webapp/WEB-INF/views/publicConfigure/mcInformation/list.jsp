<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>

<form id="pagerForm" method="post" action="${ctx}/mcInfomationM/list">
	<input type="hidden" name="pageNum" value="${page.pageNum}" /> 
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" /> 
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}" />
	<input type="hidden" name="strVendorNo" value="${mcInfomationM.strVendorNo}" />
	<input type="hidden" name="strVendorName" value="${mcInfomationM.strVendorName}" />
	<input type="hidden" name="strAbbrevName" value="${mcInfomationM.strAbbrevName}" />
</form>

<div class="tab-header">
	<form method="post" class="layui-form" action="${ctx}/mcInfomationM/list"  onsubmit="return navTabSearch(this)">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">企业编码：</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="strVendorNo" id="strVendorNo" value="${mcInfomationM.strVendorNo}" placeholder="请输入企业编号"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">企业名称：</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="strVendorName" id="strVendorName" value="${mcInfomationM.strVendorName}" placeholder="请输入企业名称"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">企业简称：</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input" name="strAbbrevName" id="strAbbrevName" value="${mcInfomationM.strAbbrevName}" placeholder="请输入企业简称"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">企业类型:</label>
				<div class="layui-input-inline">				
					<select  name="strCusOrBus" id="strCusOrBus">
						<option value="1" ${mcInfomationM.strType eq '1' ? 'selected':''}>商户</option>
					 	<option value="0" ${mcInfomationM.strType eq '0' ? 'selected':''}>客户</option>
						<option value="2" ${mcInfomationM.strType eq '2' ? 'selected':''}>两者都是</option>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<button class="search" >搜索</button>
			</div>
		</div>
	</form>
</div>
<div class="tab-bars">
	<a class="add" target="dialog" width="800" height="600" dialogId="mcInformationCreate" max="true" href="${ctx}/mcInfomationM/preCreate"><span>添加</span></a>
	<a class="edit" title="修改" target="dialog" dialogId="editMcInformation" max="true"  beforeOpenCallback="beforeEditCmMerchantMethod" width="850px" height="550px" href="${ctx}/mcInfomationM/preUpdate/{slt_uid}"><span>编辑</span></a>
	<a class="delete" title="删除" target="ajaxTodo"    beforeOpenCallback="beforeEditCmMerchantMethod"  href="${ctx}/mcInfomationM/delete/{slt_uid}"><span>删除</span></a>
    <a class="edit" target="ajaxTodo" href="${ctx}/mcInfomationM/updateStatus/{slt_uid}?flg=0" title="确认要启用该记录吗?"><span>启用</span></a>
    <a class="delete" target="ajaxTodo" href="${ctx}/mcInfomationM/updateStatus/{slt_uid}?flg=1" title="确认要冻结该记录吗?"><span>冻结</span></a>
	<a class="edit" title="证书更新" target="dialog" dialogId="editMcInformation" max="true" width="850px" height="550px"  beforeOpenCallback="beforeEditCmMerchantMethod" href="${ctx}/mcInfomationM/preUpdateCertInfo/{slt_uid}"><span>点击更新证书</span></a>
</div>
<div class="tab-content" style="overflow: auto ">
	<table class="frog-table layui-table layui-table-cell" lay-size="sm">
		<thead>
			<tr>
				<th>序号</th><!-- 1 -->
				<th>企业编码</th><!-- 2 -->
				<th>企业名称</th><!-- 3 -->
				<th>企业简称</th><!-- 4 -->
				<th>税号</th><!-- 5 -->
				<th>开户银行</th><!-- 6 -->
				<th>银行账户</th><!-- 7 -->
				<th>评价等级</th><!-- 8 -->
				<th>委托代理人</th><!-- 9 -->
				<th>电话</th><!-- 10 -->
				<th>手机</th><!-- 11 -->
				<th>状态</th><!-- 12 -->
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="mcInfomationM" varStatus="status">
				<tr target="slt_uid" rel="${mcInfomationM.id}" id="${mcInfomationM.id}"  dblclick="cmmerchantdetail(this)" intIsActive="${mcInfomationM.intIsActive}">
					<td>${page.pageBeginCount+status.index+1}</td><!-- 1 -->
					<td>${mcInfomationM.strVendorNo}</td><!--2  -->
					<td>${mcInfomationM.strVendorName}</td><!--3  -->
					<td>${mcInfomationM.strAbbrevName}</td><!-- 4 -->
					<td>${mcInfomationM.strUniform}</td><!-- 5 -->
					<td>${mcInfomationM.informationAgentEntity.strCreditRank}</td><!-- 6 -->
					<td>${mcInfomationM.informationAgentEntity.strBankAccount}</td><!--  7-->
					<td><!-- 8 -->
						<c:choose>
							<c:when test="${mcInfomationM.strAppraise == '1'}">
								一级
						</c:when>
							<c:when test="${mcInfomationM.strAppraise == '2'}">
								二级
							</c:when>
							<c:when test="${mcInfomationM.strAppraise == '3'}">
								三级
							</c:when>
							<c:otherwise>
								其他
							</c:otherwise>
						</c:choose>
					</td>
					<td>${mcInfomationM.informationAgentEntity.strAgent}</td><!-- 9 -->
					<td>${mcInfomationM.informationAgentEntity.strAgentTel}</td><!-- 10 -->
					<td>${mcInfomationM.informationAgentEntity.strAgentMobile}</td><!-- 11 -->
					<td><!-- 12 -->
						<c:choose>
							<c:when test="${mcInfomationM.strStatusId == '1'}">
								启用
							</c:when>
							<c:otherwise>
								冻结
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>



<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>


