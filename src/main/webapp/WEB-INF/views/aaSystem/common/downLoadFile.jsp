<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<html>
<head> 
</head>
<div class="tab-content">
	<table class="layui-table">
		<thead>
			<tr>
				<th>序号</th>
				<th>文件名称</th>
				<th>大小</th>
				<th>类型</th>
				<th>上传者</th>
				<th>上传时间</th>
				<th width="150px">操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${fileList}" var="file" varStatus="status">
				<tr target="slt_uid" rel="${file.strPath}">
					<td>${status.index + 1}</td>
					<td>${file.strName}</td>
					<td>${file.doubleSize}</td>
					<td>${file.strDocType}</td>
					<td>${file.createUserId}</td>
					<td>${file.createDateTime}</td>
					<td>
					<a class="view" target="_blank" href="${ctx}${file.strPath}">下载</a>
					<a class="delete" target="ajaxTodo" title="确认要删除此数据吗?" href="${ctx}/common/deleteFile?id=${file.id}">删除</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</html>