<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"	trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新平台-登录页</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<link rel="shortcut icon" href="${ctx}/static/image/favicon.png" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="${ctx}/static/plugin/layui/css/layui.css" />
<link href="${ctx}/static/plugin/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${ctx}/static/style/login.css" />
<script src="${ctx}/static/plugin/layui/layui.js"></script>
<body class="layui-layout-body">
<div class="background" role="presentation" data-bind="css: { app: isAppBranding }, style: { background: backgroundStyle }">
	<div class="backgroundImage" data-bind="backgroundImage: backgroundImageUrl()" style="background-image: url(${ctx}/static/image/login-background-image2.jpg);"></div>
	<div class="background-overlay"></div>
</div>
<div id="LAY_app">
	<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login">
	  	<div class="layadmin-user-login-main" style="${isNeedValidateCode eq 0 ? 'height: 370px' : ''}">
		    <div class="layadmin-user-login-box layadmin-user-login-header">
			    <h2 style="color: #45a6f1;">新平台</h2>
			    <p>金恒信息科技股份有限公司出品</p>
		    </div>
		    <form class="layadmin-user-login-box layadmin-user-login-body layui-form" method="post" action="">
		    	<div class="layui-form-item">
		    		<label class="layadmin-user-login-icon layui-icon layui-icon-component" for="LAY-user-login-company" style="z-index: 1000;"></label>
		         	<select id="companyId" name="companyId">
						<c:forEach var="item" items="${companies}">
							<option value="${item.id}">${item.strName}</option>
						</c:forEach>
					</select>
		      	</div>
		    	<div class="layui-form-item">
			        <label class="layadmin-user-login-icon layui-icon layui-icon-username"></label>
			        <input type="text" name="username_1" id="LAY-user-login-username" value="${username == null ? '' : username}" lay-verify="required" placeholder="用户名" class="layui-input">
		      		<input type="hidden" name="username" id="username">
		      	</div>
				<div class="layui-form-item">
					<label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password">
					</label>
					<input type="password" name="password" id="LAY-user-login-password" lay-verify="required" placeholder="密码" class="layui-input">
				</div>
				<c:if test="${isNeedValidateCode eq 1}">
					<div class="layui-form-item">
				        <div class="layui-row">
				        	<div class="layui-col-xs7">
					            <label class="layadmin-user-login-icon layui-icon layui-icon-vercode" for="LAY-user-login-vercode"></label>
					            <input type="text" name="code" id="LAY-user-login-vercode" lay-verify="required" placeholder="图形验证码" autocomplete="off" class="layui-input">
				          	</div>
				          	<div class="layui-col-xs5">
					            <div style="margin-left: 10px; border: 1px solid #c2c2c2;">
				              		<img src="${ctx}/getCode" class="layadmin-user-login-codeimg" style="height: 35px; margin-top: 1px;" title="换一张" onclick="changeImg()" id="imgObj">
					            </div>
				          	</div>
				     	</div>
					</div>
				</c:if>
			    <div class="layui-form-item">
			    	<button class="layui-btn layui-btn-fluid" style="background: #45a6f1;" lay-submit lay-filter="login-btn">登 录</button>
			    </div>
			    <div class="layui-form-item" style="margin-bottom: 20px;">
			        <a href="/user/forget" class="layadmin-user-jump-change layadmin-link" style="margin-top: 7px;">忘记密码？</a>
			  	</div>
			</form>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
layui.use(['form', 'layer', 'jquery'], function() {
	var form = layui.form;
	var layer = layui.layer;
	$ = layui.$;
	var msg = '${msg}';
	if (msg != '') {
		layer.msg(msg, {icon: 2});
	}
	form.on('submit(login-btn)', function(data) {
		var companyId = $("#companyId").val();
		var username = $("#LAY-user-login-username").val();
		$("#username").val(username + ":" + companyId);
	  	return true;
	});
});

function changeImg() {
    var imgSrc = $("#imgObj");
    var src = imgSrc.attr("src");
    imgSrc.attr("src", changeUrl(src));
}

/*
 * 为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳
 */
function changeUrl(url) {
    var timestamp = (new Date()).valueOf();
    url = url.substring(0, 20);
    if ((url.indexOf("&") >= 0)) {
        url = url + "×tamp=" + timestamp;
    } else {
        url = url + "?timestamp=" + timestamp;
    }
    return url;
}
</script>
</html>