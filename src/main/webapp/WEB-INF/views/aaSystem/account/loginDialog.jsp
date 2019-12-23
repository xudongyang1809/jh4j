<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<style>
#loginDialog .layui-form-label {
	width: 60px;
} 

#loginDialog .layui-input-block {
	margin-left: 90px;
}
</style>
<form class="layui-form" action="${ctx}/dialogLogin" onsubmit="return dialogAjaxDone(this)">
	<div class="dialogContent" style="right: 60px;">
		<div class="layui-form-item">
	    	<label class="layui-form-label">公司别:</label>
		    <div class="layui-input-block">
	      		<select id="companyId" name="companyId">
					<c:forEach var="item" items="${companies}">
						<option value="${item.id}">${item.strName}</option>
					</c:forEach>
				</select>
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">账号:</label>
		    <div class="layui-input-block">
	      		<input type="text" id="username_1" lay-verify="required" placeholder="请输入账号" autocomplete="off" class="layui-input">
	      		<input type="hidden" name="username" id="username">
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">密码:</label>
		    <div class="layui-input-block">
	      		<input type="password" name="password" lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
		    </div>
	  	</div>
	  	<c:if test="${isNeedValidateCode eq 1}">
		  	<div class="layui-form-item">
		  		<label class="layui-form-label">验证码:</label>
		        <div class="layui-input-block" style="position: relative;">
		        	<div style="position: absolute; top: 0px; left: 0px; bottom: 0px; right: 140px;">
		        		<input type="text" name="code" id="LAY-user-login-vercode" lay-verify="required" placeholder="图形验证码" autocomplete="off" class="layui-input">
		        	</div>
		        	<div style="position: absolute; top: 0px; bottom: 0px; right: 0px; width: 130px; border: 1px solid #c2c2c2; height: 36px;">
		        		<img src="${ctx}/getCode" class="layadmin-user-login-codeimg" style="width: 100%; height: 35px;" title="换一张" onclick="changeImg()" id="imgObj">
		        	</div>
		     	</div>
			</div>
	  	</c:if>
	</div>
	<div class="dialogFooter"><button type="submit" class="layui-btn" lay-submit lay-filter="dialog-login-btn">登录</button></div>
</form>
<script>
form.on('submit(dialog-login-btn)', function(data) {
	var companyId = $("#companyId", $('#loginDialog')).val();
	var username = $("#username_1", $('#loginDialog')).val();
	$("#username", $('#loginDialog')).val(username + ":" + companyId);
  	return true;
});

function changeImg() {
    var imgSrc = $("#imgObj", $('#loginDialog'));
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
