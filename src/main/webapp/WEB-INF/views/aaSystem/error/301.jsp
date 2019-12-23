<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<%@ page session="false" %>
<% response.setStatus(200); %>
<!DOCTYPE html>
<html>
<head>
<meta name="keyword" content="9dea8cd1-30a5-4087-b54e-65e16abf3080">
<style type="text/css">
.layadmin-tips .layui-icon[face] {
    display: inline-block;
    font-size: 250px;
    color: #393D49;
}

.layadmin-tips {
    margin-top: 30px;
    text-align: center;
}

.layadmin-tips .layui-text {
    width: 350px;
    margin: 10px auto;
    padding-top: 20px;
    border-top: 5px solid #FF5722;
    font-size: 16px;
}

.layadmin-tips h1 {
    font-size: 30px;
    line-height: 40px;
    color: #FF5722;
}

.status-code {
	font-size: 50px;
    line-height: 50px;
    color: #FF5722;
}

.layadmin-tips .status-code .layui-anim {
    display: inline-block;
}
</style>
</head>
<body>
	<div class="layui-fluid" style="position: absolute; top: 0px; left: 0px; right: 0px; bottom: 0px; background-color: #f2f2f2;">
		<div class="layadmin-tips">
		    <i class="layui-icon" face>&#xe69c;</i>
		    <div class="status-code">
				<span class="layui-anim layui-anim-loop layui-anim-">3</span> 
		       	<span class="layui-anim layui-anim-loop layui-anim-rotate">0</span> 
		       	<span class="layui-anim layui-anim-loop layui-anim-">1</span>
		    </div>
		    <div class="layui-text">
				<h1>
		        	登录超时，请<a style="text-decoration: underline; cursor: pointer;" onclick="dialogLogin()">重新登录</a>
		      	</h1>
			</div>
		</div>
	</div>
</body>
<script>
function dialogLogin() {
	$.post("${ctx}/preDialogLogin", function (content) {
		var layerOptions = {
			type: 1,
			id: 'loginDialog',
			title: '登录',
			area: ['450px', '350px'],
			maxmin: false,
			resize: false,
			closeBtn: 0,
			content: content,
			success: function(layero, index) {
				form.render();
			},
			cancel: function() {
				location.reload();
			}
		}
		var index = layer.open(layerOptions);
	});
}
</script>
</html>
