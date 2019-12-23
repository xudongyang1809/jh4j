<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page session="false" %>
<% response.setStatus(200); %>
<!DOCTYPE html>
<html>
<head>
<meta name="keyword" content="19850e79-2aa1-485b-8a1a-45d2c291a442">
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
		    <i class="layui-icon" face>&#xe664;</i>
		    <div class="status-code">
				<span class="layui-anim layui-anim-loop layui-anim-">4</span> 
	        	<span class="layui-anim layui-anim-loop layui-anim-rotate">0</span> 
	        	<span class="layui-anim layui-anim-loop layui-anim-">4</span>
		    </div>
		    <div class="layui-text">
				<h1>
		        	页面找不到
		      	</h1>
			</div>
		</div>
	</div>
</body>
</html>