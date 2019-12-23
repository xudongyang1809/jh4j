<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<html>
<head>
<style type="text/css">
.layui-elem-field {
	border-color: grey;
}
</style>
</head>
<body>
<div style="padding: 10px;">
	<fieldset class="layui-elem-field">
  		<legend>小按钮列表</legend>
	  	<div class="layui-field-box">
    		<button class="add btn-small">新增</button>
			<button class="edit btn-small">编辑</button>
			<button class="delete btn-small">删除</button>
			<button class="deleteList btn-small">批量删除</button>
			<button class="view btn-small">查看</button>
			<button class="preview btn-small">预览</button>
			<button class="search btn-small">搜索</button>
			<button class="import btn-small">导入</button>
			<button class="export btn-small">导出</button>
			<button class="sendback btn-small">退回</button>
			<button class="approve btn-small">批准</button>
			<button class="grant btn-small">发放</button>
			<button class="confirm btn-small">确认</button>
			<button class="cancelConfirm btn-small">取消确认</button>
			<button class="print btn-small">打印</button>
			<button class="choose btn-small">挑选</button>
			<button class="report btn-small">报表</button>
			<button class="delivery btn-small">配送</button>
			<button class="cancelDelivery btn-small">取消配送</button>
			<button class="end btn-small">结束</button>
			<button class="database btn-small">数据库</button>
			<button class="lock btn-small">锁定</button>
			<button class="unlock btn-small">解锁</button>
			<button class="build btn-small">生成</button>
			<button class="download btn-small">下载</button>
			<button class="upload btn-small">上传</button>
			<button class="code btn-small">代码</button>
	  	</div>
	</fieldset>
	<fieldset class="layui-elem-field">
  		<legend>普通按钮列表</legend>
	  	<div class="layui-field-box">
    		<button class="add">新增</button>
			<button class="edit">编辑</button>
			<button class="delete">删除</button>
			<button class="deleteList">批量删除</button>
			<button class="view">查看</button>
			<button class="preview">预览</button>
			<button class="search">搜索</button>
			<button class="import">导入</button>
			<button class="export">导出</button>
			<button class="sendback">退回</button>
			<button class="approve">批准</button>
			<button class="grant">发放</button>
			<button class="confirm">确认</button>
			<button class="cancelConfirm">取消确认</button>
			<button class="print">打印</button>
			<button class="choose">挑选</button>
			<button class="report">报表</button>
			<button class="delivery">配送</button>
			<button class="cancelDelivery">取消配送</button>
			<button class="end">结束</button>
			<button class="database">数据库</button>
			<button class="lock">锁定</button>
			<button class="unlock">解锁</button>
			<button class="build">生成</button>
			<button class="download">下载</button>
			<button class="upload">上传</button>
			<button class="code">代码</button>
	  	</div>
	</fieldset>
	<fieldset class="layui-elem-field">
  		<legend>大按钮列表</legend>
	  	<div class="layui-field-box">
    		<button class="add btn-big">新增</button>
			<button class="edit btn-big">编辑</button>
			<button class="delete btn-big">删除</button>
			<button class="deleteList btn-big">批量删除</button>
			<button class="view btn-big">查看</button>
			<button class="preview btn-big">预览</button>
			<button class="search btn-big">搜索</button>
			<button class="import btn-big">导入</button>
			<button class="export btn-big">导出</button>
			<button class="sendback btn-big">退回</button>
			<button class="approve btn-big">批准</button>
			<button class="grant btn-big">发放</button>
			<button class="confirm btn-big">确认</button>
			<button class="cancelConfirm btn-big">取消确认</button>
			<button class="print btn-big">打印</button>
			<button class="choose btn-big">挑选</button>
			<button class="report btn-big">报表</button>
			<button class="delivery btn-big">配送</button>
			<button class="cancelDelivery btn-big">取消配送</button>
			<button class="end btn-big">结束</button>
			<button class="database btn-big">数据库</button>
			<button class="lock btn-big">锁定</button>
			<button class="unlock btn-big">解锁</button>
			<button class="build btn-big">生成</button>
			<button class="download btn-big">下载</button>
			<button class="upload btn-big">上传</button>
			<button class="code btn-big">代码</button>
	  	</div>
	</fieldset>
	<fieldset class="layui-elem-field">
  		<legend>超大按钮列表</legend>
	  	<div class="layui-field-box">
    		<button class="add btn-huge">新增</button>
			<button class="edit btn-huge">编辑</button>
			<button class="delete btn-huge">删除</button>
			<button class="deleteList btn-huge">批量删除</button>
			<button class="view btn-huge">查看</button>
			<button class="preview btn-huge">预览</button>
			<button class="search btn-huge">搜索</button>
			<button class="import btn-huge">导入</button>
			<button class="export btn-huge">导出</button>
			<button class="sendback btn-huge">退回</button>
			<button class="approve btn-huge">批准</button>
			<button class="grant btn-huge">发放</button>
			<button class="confirm btn-huge">确认</button>
			<button class="cancelConfirm btn-huge">取消确认</button>
			<button class="print btn-huge">打印</button>
			<button class="choose btn-huge">挑选</button>
			<button class="report btn-huge">报表</button>
			<button class="delivery btn-huge">配送</button>
			<button class="cancelDelivery btn-huge">取消配送</button>
			<button class="end btn-huge">结束</button>
			<button class="database btn-huge">数据库</button>
			<button class="lock btn-huge">锁定</button>
			<button class="unlock btn-huge">解锁</button>
			<button class="build btn-huge">生成</button>
			<button class="download btn-huge">下载</button>
			<button class="upload btn-huge">上传</button>
			<button class="code btn-huge">代码</button>
	  	</div>
	</fieldset>
</div>
</body>
</html>
