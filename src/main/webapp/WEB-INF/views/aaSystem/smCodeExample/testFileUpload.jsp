<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form class="layui-form" action="">
	<div class="dialogContent" style="right: 60px;">
 		<div class="layui-form-item">
	    	<label class="layui-form-label">测试数据</label>
		    <div class="layui-input-block">
	      		<input type="text" name="testLabel" lay-verify="required" placeholder="请输入测试数据" autocomplete="off" class="layui-input">
		    </div>
		</div>
		<div class="layui-form-item">
	  		<label class="layui-form-label">附件</label>
			<div class="layui-input-block">
	    		<c:import url="/WEB-INF/views/aaSystem/smCodeExample/fileUpload.jsp">
					<c:param name="relativedId" value="98da4a7a-84c9-46d1-aedc-f9dd0ad337e2" />
					<c:param name="fileNum" value="10" />
					<c:param name="ext" value="application,image" />
					<c:param name="action" value="edit" />
					<c:param name="isRequired" value="1" />
					<c:param name="fileSizeLimit" value="102400"/>
					<c:param name="fileSingleSizeLimit" value="20480" />
				</c:import>
			</div>
		</div>
  	</div>
  	<div class="dialogFooter"><button type="submit" class="layui-btn" lay-submit lay-filter="submitTestFile">提交</button></div>
</form>
<script>
form.on('submit(submitTestFile)', function(data) {
	return false;
});
</script>