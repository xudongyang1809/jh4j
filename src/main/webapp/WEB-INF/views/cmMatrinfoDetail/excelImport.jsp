<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!-- Hints:
     1. The code was automatic created;
     2. Any other questions can ask the software engineer for help.
	 @author sysadmin
	 @date 2018-08-14
	 @Copyright:江苏金恒信息科技股份有限公司
 -->


<head>
</head>


<div class="layui-upload" style="margin-top: 40px; margin-left: 50px">
	<button type="button" class="layui-btn" id="test8"><i class="layui-icon"></i>选择文件</button>
	<br>
	<button type="button" class="layui-btn layui-btn-normal" id="test9" style="margin-top: 5px">开始上传</button>
</div>


<script type="text/javascript">
	layui.use('upload', function() {
		upload = layui.upload;
		var parentId = '${parentId}';
		upload.render({
			elem : '#test8',
			url : '${ctx}/cmMatrinfoDetail/importExcel',
			auto : false,
			accept: 'file', 
			exts : 'xls|xlsx',
			bindAction : '#test9',
			before : function(obj) {
				this.data = {
					'parentId' : parentId
				};
			},
			done : function(res) {debugger;
				if(res.statusCode != 200){
					return Dialog.error(res.message);
				}
				var loadingIndex = Dialog.load();
				Dialog.success(res.message);
				reloadContainer('#department-list-view', true);
				layer.close(loadingIndex);
			}
		});
	});
</script>