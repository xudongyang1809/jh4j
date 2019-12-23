<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>

<div class="layui-upload" style="margin-top: 40px; margin-left: 50px">
	<button type="button" class="layui-btn" id="test10"><i class="layui-icon"></i>选择文件</button>
	<br>
	<button type="button" class="layui-btn layui-btn-normal" id="test11" style="margin-top: 5px">开始上传</button>
</div>


<script type="text/javascript">
layui.use('upload', function() {
	upload = layui.upload;
	upload.render({
		elem : '#test10',
		url : '${ctx}/cmMatrinfoDetail/importInfo',
		auto : false,
		accept: 'file', 
		exts : 'xls|xlsx',
		bindAction : '#test11',
		done : function(res) {
			debugger;
			if(res.statusCode != 200){
				return Dialog.error("导入失败,请检查文件中数据是否有误!!");
			}
			var loadingIndex = Dialog.load();
			Dialog.success(res.message);
			reloadContainer('#department-list-view', true);
			layer.close(loadingIndex);
		}
	});
});
</script>