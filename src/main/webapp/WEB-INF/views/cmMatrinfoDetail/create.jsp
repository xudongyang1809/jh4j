<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>

<form id="saveCmMatrinfoDetail_u" method="post" action="${ctx}/cmMatrinfoDetail/create" class="layui-form" onsubmit="return dialogAjaxDone(this, '','#department-list-view')" >
	<div class="dialogContent" style="right: 0px">
		<input type="hidden" id="relativedId" name="id" value="${id}">
		<input type="hidden" name="parentId" value="${parentId}" />
		<div class="layui-tab" style="margin-top: 0px">
			<ul class="layui-tab-title">
				<li class="layui-this" id="preSaleMain">基本</li>
				<li>其它</li>
			</ul>
			<div class="layui-tab-content">
				<div class="layui-tab-item layui-show">
					<div class="layui-form-item">
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 100px"><span style="color: #FF5722;">* </span>存货编码:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="strSn" value="${codeSn}" lay-verify="required" autocomplete="off" class="layui-input" placeholder="请输入存货编码..." readonly="readonly" style="background-color: WhiteSmoke">
							</div>
						</div>
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 100px"><span style="color: #FF5722;">* </span>存货名称:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="strName" value="" lay-verify="required" autocomplete="off" class="layui-input"  placeholder="请输入存货名称...">
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 100px">英文名称:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="strEnName" value="" autocomplete="off" class="layui-input" placeholder="请输入英文名称..." >
							</div>
						</div>
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 100px"><span style="color: #FF5722;">* </span>存货分类:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="strClass" value="${code1}-${className}" lay-verify="required" autocomplete="off" class="layui-input"  placeholder="请输入存货分类..." readonly="readonly" style="background-color: WhiteSmoke">
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<%--<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 120px">南钢编码:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="strEasyCode" value="" autocomplete="off" class="layui-input" placeholder="请输入南钢编码..." >
							</div>
						</div>--%>
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 100px"><span style="color: #FF5722;">* </span>型号:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="strSpec" value="" lay-verify="required" autocomplete="off" class="layui-input"  placeholder="请输入型号...">
							</div>
						</div>
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 100px">图档:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="strPicFile" value="" autocomplete="off" class="layui-input" placeholder="请输入图档..." >
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 100px"><span style="color: #FF5722;">* </span>品牌:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="strBrand" value="" autocomplete="off" lay-verify="required" class="layui-input" placeholder="请输入品牌..." >
							</div>
						</div>
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 100px">图号:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="strpicNo" value="" autocomplete="off" class="layui-input"  placeholder="请输入图号...">
							</div>
						</div>
					</div>
					<div class="layui-form-item">

						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 100px"><span style="color: #fffbe0;">* </span>计量单位:</label>
							<div class="layui-input-inline" style="width: 60%">
								<select id="strPrickle1212" name="strPrickle" lay-search="" lay-verify="required">
									<option value=''>--关键字检索--</option>
									<c:forEach items="${dcMetrologylis}" var="dcMetrology" >
										<option value='${dcMetrology.ID}'>${dcMetrology.STRNAME}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
					
					<fieldset>
						<legend>存货属性 </legend>
						<input type="checkbox" name="strIssoldInside" lay-skin="primary" title="内销">
						<input type="checkbox" name="strIssoldOutside" lay-skin="primary" title="外销">
						<input type="checkbox" name="strIsOutsource" lay-skin="primary" title="外购">
						<input type="checkbox" name="strIsEntrust" lay-skin="primary" title="委外">
						<input type="checkbox" name="strIsProductUse" lay-skin="primary" title="产耗用">
						<input type="checkbox" name="strCirculatChk" lay-skin="primary" title="循环品">
						<input type="checkbox" name="strHpriceChk" lay-skin="primary" title="高价品">
						<input type="checkbox" name="strNationType" lay-skin="primary" title="进口">
						<input type="checkbox" name="strMostlyexpend" lay-skin="primary" title="主要消耗品">
						<br/>
						<input type="checkbox" name="strSelfproduce" lay-skin="primary" title="自产">
						<input type="checkbox" name="strIsAccidentSpare" lay-skin="primary" title="事故件">
						<input type="checkbox" name="strIsWaitScrap" lay-skin="primary" title="待报废">
						<input type="checkbox" name="strIsPerformanceJob" lay-skin="primary" title="性能承包">
						<input type="checkbox" name="strAgManage" lay-skin="primary" title="零库存料号">
						<input type="checkbox" name="strBuyChk" lay-skin="primary" title="禁止请购">
						<input type="checkbox" name="strDutyPreferential" lay-skin="primary" title="税收优惠产品">
					</fieldset>
					
				</div>
			<!-- 其他 -->
				<div class="layui-tab-item">
					<div class="layui-form-item">
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 120px">单位重量:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="number" name="bdUnitWgtKg" value="" autocomplete="off" class="layui-input" placeholder="请输入单位重量..." >
							</div>
						</div>
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 100px">单位容积:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="number" name="bdUnitVolumeCc" value="" autocomplete="off" class="layui-input"  placeholder="请输入单位容积...">
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 120px">单位厚度:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="number" name="bdUnitThkMm" value="" autocomplete="off" class="layui-input" placeholder="请输入单位厚度..." >
							</div>
						</div>
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 100px">单位宽度:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="number" name="bdUnitWthMm" value="" autocomplete="off" class="layui-input"  placeholder="请输入单位宽度...">
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 120px">单位长度:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="number" name="bdUnitLthMm" value="" autocomplete="off" class="layui-input" placeholder="请输入单位长度..." >
							</div>
						</div>
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 100px">单位高度:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="number" name="bdUnitHthMm" value="" autocomplete="off" class="layui-input"  placeholder="请输入单位高度...">
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 120px">长度单位:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="bdUnitLth" value="" autocomplete="off" class="layui-input" placeholder="请输入长度单位..." >
							</div>
						</div>
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 100px">ABC分类:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="strabcClass" value="" autocomplete="off" class="layui-input"  placeholder="请输入ABC分类...">
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 120px">贯标文号:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="strCustumalNo" value="" autocomplete="off" class="layui-input" placeholder="请输入贯标文号..." >
							</div>
						</div>
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 100px">立项号:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="strProjNo" value="" autocomplete="off" class="layui-input"  placeholder="请输入立项号...">
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 120px"><span style="color: #FF5722;">* </span>计划价/售价:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="bdPlanPrice" value="0" autocomplete="off" lay-verify="required" class="layui-input" placeholder="计划价/售价..." >
							</div>
						</div>
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 100px"><span style="color: #FF5722;">* </span>参考成本:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="bdReferCost" value="0" autocomplete="off" lay-verify="required" class="layui-input"  placeholder="请输入参考成本...">
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 120px">最高库存:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="intMaxStorage" value="0" autocomplete="off" class="layui-input" placeholder="最高库存..." >
							</div>
						</div>
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 100px">最低库存:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="intMinStorage" value="0" autocomplete="off" class="layui-input"  placeholder="最低库存...">
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-col-md6">
							<label class="layui-form-label" style="width: 120px">安全库存:</label>
							<div class="layui-input-inline" style="width: 60%">
								<input type="text" name="intSafeStorage" value="0" autocomplete="off" class="layui-input" placeholder="请输入安全库存..." >
							</div>
						</div>
					</div>
				
				
				</div>
			</div>
		</div>
				
	</div>
	<div class="dialogFooter">
		<button type="submit" class="layui-btn">提交</button>
		<button type="button" class="layui-btn" onclick="parent.layer.closeAll();">关闭</button>
	</div>
</form>
