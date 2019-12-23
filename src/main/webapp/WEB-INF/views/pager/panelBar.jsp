<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="panelBar">
	<div class="pages">
		<span>每页显示</span>
		<select name="numPerPage" onchange="navTabPageBreak({numPerPage:this.value})">
			<c:forEach begin="15" end="200" step="15" varStatus="s">
				<option value="${s.index}" ${page.numPerPage eq s.index ? 'selected="selected"' : ''}>${s.index}</option>
			</c:forEach>
		</select>
		<span>总条数: ${page.totalCount}</span>
	</div>
	
	<div class="pagination" targetType="navTab" totalCount="${page.totalCount}" numPerPage="${page.numPerPage}" pageNumShown="10" currentPage="${page.pageNum}"></div>
</div>