<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<ul class="layui-nav layui-nav-tree" lay-filter="test" style="height: 100%;">
	<c:forEach items="${menuModule.children}" var="menu">
		<li class="layui-nav-item">
		    <a href="javascript:;">
		    	<i class="layui-icon layui-icon-component"></i>
		    	<cite>${menu.strName}</cite>
	    	</a>
	    	<c:if test="${menu.children != null and fn:length(menu.children) > 0}">
	    		<dl class="layui-nav-child">
	    			<c:forEach items="${menu.children}" var="thirdMenu">
		    			<dd>
	    			  		<c:choose> 
								<c:when test="${fn:contains(thirdMenu.program.strUrl, '?')}"> 
						 			<a href="${thirdMenu.program.strUrl}&moduleListNavId=${thirdMenu.program.strSn}" strSn="${thirdMenu.program.strSn}">
							 			${thirdMenu.strName}
							 		</a>
								</c:when>
								<c:otherwise>
							 		<a href="${thirdMenu.program.strUrl}?moduleListNavId=${thirdMenu.program.strSn}" strSn="${thirdMenu.program.strSn}">
							 			${thirdMenu.strName}
							 		</a>
								</c:otherwise>
	    			  		</c:choose>   
				    	</dd>
	    			</c:forEach>
			    </dl>
	    	</c:if>
		</li>
	</c:forEach>
</ul>