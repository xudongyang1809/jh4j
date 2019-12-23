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
function ValidateSpecialCharacter() {
    var code; 
    if (document.all) {
        code = window.event.keyCode; 
    } else { 
        code = arguments.callee.caller.arguments[0].which; 
    } 
    var character = String.fromCharCode(code);
    var pattern = /^[a-zA-Z\d\u4E00-\u9FA5]+$/i;
    if (!pattern.test(character)) {
        if (document.all) { 
            window.event.returnValue = false; 
        } else { 
            arguments.callee.caller.arguments[0].preventDefault(); 
        } 
    }
}

function create() {
	$.ajax({
		type: "post",
		url: "${ctx}/cmMatrinfo/create",
		data: $("#form").serialize(),
		datatype: "json",
		success: function (rst) {
			var data = JSON.parse(rst);
			var rel = data.rel;
			if (data.statusCode == 200) {

			} else {
				Dialog.error(data.message);
			}
		},
		error: function (msg) {
			Dialog.warn(msg.message);
		}
	});

}



</script>
</head>
<body>
<form id="form" method="post" action="${ctx}/cmMatrinfo/create" class="layui-form" onsubmit="return dialogAjaxDone(this, 'create')">
	<div class="dialogContent">
			<input type="hidden" name="parentId" value="${parentid}" class="" style="width: px;display:"   />

		<div class="layui-form-item">
	    	<label class="layui-form-label">分类编码:</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strSn" lay-verify="required" placeholder="分类编码..如:01,02.." autocomplete="off" class="layui-input"  >
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">分类名称:</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strName" lay-verify="required" placeholder="分类名称.." autocomplete="off" class="layui-input"  >
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	    	<label class="layui-form-label">备注:</label>
		    <div class="layui-input-block">
	      		<input type="text" name="strRmark" placeholder="备注.." autocomplete="off" class="layui-input"  >
		    </div>
	  	</div>
	</div>
			
	<div class="dialogFooter">
		<button type="submit" class="layui-btn" onclick="create()">提交</button>
		<button type="button" class="layui-btn" onclick="parent.layer.closeAll();">关闭</button>
	</div>
</form>
</body>
</html>

