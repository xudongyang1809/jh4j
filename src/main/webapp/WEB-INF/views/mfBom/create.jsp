<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 创建画面
	 @author 超级管理员 admin
	 @date 2019-04-29 11:10:45
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<style>
	.layui-form-label{
		width: 120px;
	}
	.layui-input{
		width: 230px;
	}
</style>
<form class="layui-form" method="post" action="${ctx}/mfBom/create" onsubmit="return dialogAjaxDone(this, 'create')">
	<div class="dialogContent" style="right: 60px;">
		<div class="layui-form-item">
			<label class="layui-form-label" >产品存货编号:</label>
	    	<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strProdMatrlNo" lay-verify="required" autocomplete="off" placeHolder="请输入产品存货编号" />
			</div>
			<label class="layui-form-label">产品存货名称:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strMaterialName" lay-verify="required" autocomplete="off" placeHolder="请输入产品存货名称" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">项次号:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strItemNo" lay-verify="required" autocomplete="off" placeHolder="请输入项次号" />
			</div>
			<label class="layui-form-label">原料:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strMatrlNo" lay-verify="required" autocomplete="off" placeHolder="请输入原料" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">品名:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strMatrlName" autocomplete="off" placeHolder="请输入品名" />
			</div>
			<label class="layui-form-label">品牌:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strBrand" autocomplete="off" placeHolder="请输入品牌" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">库存单位:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strUnit" autocomplete="off" placeHolder="请输入库存单位" />
			</div>
			<label class="layui-form-label">型号规格:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="strSpec" autocomplete="off" placeHolder="请输入型号规格" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">原料数量:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="bdMatrlQty" lay-verify="required" autocomplete="off" placeHolder="请输入原料数量" />
			</div>
			<label class="layui-form-label">子项采购单价:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="bdItemPurPrice" lay-verify="required" autocomplete="off" placeHolder="请输入子项采购单价" />
			</div>
		</div>
		<div class="layui-form-item" style="display: none">
			<label class="layui-form-label">子项采购总价:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" name="bdItemSumPrice" autocomplete="off" placeHolder="请输入子项采购总价" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">供应商:</label>
			<div class="layui-input-inline">
				<input type="text" class="layui-input" style="width: 580px" name="strSaleVendor" autocomplete="off" placeHolder="请输入供应商" />
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">备注:</label>
	    	<div class="layui-input-block">
				<input type="text" class="layui-input" style="width: 580px" name="strRemark" autocomplete="off" placeHolder="请输入备注" />
			</div>
		</div>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn">提交</button></div>
</form>
