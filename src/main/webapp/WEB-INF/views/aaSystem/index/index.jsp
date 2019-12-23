<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"	trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>新平台</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	<link rel="shortcut icon" href="${ctx}/static/image/favicon.png" type="image/x-icon" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/plugin/font-awesome/css/font-awesome.min.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/plugin/icon-font/iconfont.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/style/button.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/plugin/layui/css/layui.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/plugin/zTree_v3/css/zTreeStyle/zTreeStyle.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/plugin/jquery-contextMenu/jquery.contextMenu.min.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/plugin/webuploader/webuploader.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/style/plugin.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/style/index.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/style/base.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/style/tab.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/static/style/dialog.css" />
</head>
<body>
<div class="header">
	<ul class="layui-nav" style="padding: 0; border-radius: 0; height: 50px;">
		<li class="layui-nav-item" lay-unselect style="padding-left: 10px;">
			<img src="${ctx}/static/image/favicon.png" style="margin-bottom: 6px;" />
			<a href="#" style="display: inline; padding-left: 5px; color: white; font-size: 18px; font-weight: bolder;">新平台</a>
		</li>
		<li class="layui-nav-item layui-hide-xs" style="float: right;" lay-unselect title="项目切换">
	    	<a href="javascript:;" onclick="switchProject()"><i class="layui-icon layui-icon-more-vertical"></i></a>
	    </li>
	    <li class="layui-nav-item" style="margin-left: 90px;" lay-unselect>
	        <div id="tp-weather-widget"></div>
		</li>
		<li class="layui-nav-item" style="float: right;">
			<a href="javascript:;">${user.strName}</a>
			<dl class="layui-nav-child">
				<dd><a href="">基本资料</a></dd>
				<dd><a href="">系统设置</a></dd>
				<dd><a href="javascript:void(0)" onclick="modifyPwd()">修改密码</a></dd>
				<dd style="text-align: center;"><a href="${ctx}/logout">退出</a></dd>
			</dl> 
		</li>
		<li class="layui-nav-item" style="float: right;" lay-unselect>
	        <a href="javascript:;">
	        	<i class="layui-icon layui-icon-notice"></i>
	           	<span class="layui-badge-dot"></span>
	        </a>
		</li>
	</ul>
</div>
<div class="layui-tab layui-tab-brief" id="navigationBar" lay-filter="layadmin-layout-navigation" style="margin: 0; background-color: white; border-bottom: 1px solid #ccc;">
	<ul class="layui-tab-title" style="border-bottom: 0px;">
		<c:forEach var="menu" items="${navigateMenuList}" varStatus="status">
			<li id="${menu.id}" class="${status.index == 0 ? 'layui-this' : ''}">${menu.strName}</li>
		</c:forEach>
	</ul>
</div>

<div class="side-menu">

</div>

<div class="layui-layer-shade" id="projectListDialog-shadow" onclick="closeProjectListDialog()"></div>
<div class="layui-layer layui-layer-page" id="projectListDialog" type="page" showtime="0" contype="string" style="z-index: 19891015; width: 300px;">
	<div class="layui-layer-title" style="cursor: move; height: 35px;">项目列表</div>
	<div class="layui-layer-content">
		<div><span>日志中心</span></div>
	</div>
	<span class="layui-layer-setwin">
		<a class="layui-layer-ico layui-layer-close layui-layer-close1" href="javascript:;" onclick="closeProjectListDialog()"></a>
	</span>
	<span class="layui-layer-resize"></span>
</div>

<div class="layui-control-panel">
	<div class="layadmin-pagetabs" id="lay_app_tabs"> 
		<div class="layui-tab layui-tab-brief" lay-allowclose="true" lay-filter="layadmin-layout-tabs"> 
			<div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>
			<div class="layui-icon layadmin-tabs-control layui-icon-next" layadmin-event="rightPage"></div> 
			<ul class="layui-tab-title" id="LAY_app_tabsheader">
				<li id="homePage" style="padding: 0 10px;" url="pageHome/menuPage" class="layui-this">
					<i class="layui-icon layui-icon-home"></i>
				</li>
			</ul>
		</div>
	</div>
	<div class="layui-body">
		
	</div>
</div>
<script>
ctx = '${ctx}';
</script>
<script src="${ctx}/static/plugin/layui/layui.js"></script>
<script src="${ctx}/static/javascript/jquery.min.js"></script>
<script src="${ctx}/static/javascript/jquery.form.js"></script>
<script src="${ctx}/static/javascript/jquery.cookie.js"></script>
<script src="${ctx}/static/plugin/zTree_v3/js/jquery.ztree.all.min.js"></script>
<script src="${ctx}/static/plugin/jquery-contextMenu/jquery.contextMenu.min.js"></script>
<script src="${ctx}/static/plugin/jquery-contextMenu/jquery.ui.position.min.js"></script>
<script src="${ctx}/static/plugin/echarts/echarts-v4.2.0/echarts.common.min.js"></script>
<script src="${ctx}/static/plugin/My97DatePicker/WdatePicker.js"></script>
<script src="${ctx}/static/plugin/webuploader/webuploader.js"></script>
<script src="${ctx}/static/javascript/frog.tool.js"></script>
<script src="${ctx}/static/javascript/frog.core.js"></script>
<script src="${ctx}/static/javascript/frog.dialog.js"></script>
<script src="${ctx}/static/javascript/frog.table.js"></script>
<script src="${ctx}/static/javascript/frog.ajax.js"></script>
<script src="${ctx}/static/javascript/frog.navTab.js"></script>
<script src="${ctx}/static/javascript/frog.attribute.js"></script>
<script src="${ctx}/static/javascript/frog.ui.js"></script>
<script src="${ctx}/static/javascript/frog.form.js"></script>
<script src="${ctx}/static/javascript/index.js"></script>
</body>
</html>