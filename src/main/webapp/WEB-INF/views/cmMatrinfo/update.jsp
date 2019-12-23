<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<html>
<!-- Hints:
     1. The code was automatic created;
     2. Any other questions can ask the software engineer for help.
	 @author sysadmin
	 @date 2014-03-24
 -->
<head>
<script type="text/javascript">

</script>
</head>
<body>
<form id="form" method="post" action="${ctx}/cmMatrinfo/update" class="layui-form" onsubmit="return dialogAjaxDone(this)">
	<div class="dialogContent">
		<input type="hidden" id="relativedId" name="id" value="${cmMatrinfo.id}">
			
		<div class="layui-form-item">
	    	<label class="layui-form-label">分类编码:</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strSn" lay-verify="required" value="${cmMatrinfo.strSn}" placeholder="分类编码..如:01,02.." autocomplete="off" class="layui-input"  >
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">分类名称:</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strName" lay-verify="required" value="${cmMatrinfo.strName}" placeholder="分类名称.." autocomplete="off" class="layui-input"  >
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">备注:</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strRmark" placeholder="备注.." value="${cmMatrinfo.strRmark}" autocomplete="off" class="layui-input"  >
		    </div>
	  	</div>	
			
			
	</div>
			
	<div class="dialogFooter">
		<button type="submit" class="layui-btn">提交</button>
		<button type="button" class="layui-btn" onclick="parent.layer.closeAll();">关闭</button>
	</div>
</form>
</body>
</html>