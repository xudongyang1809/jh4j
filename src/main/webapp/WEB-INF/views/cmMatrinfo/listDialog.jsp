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
  function addopera(obj){
	 
	  $("#parentid").val($(obj).attr("id"));

  };
</script>
</head>
<div class="pageContent">
			<div>
				<div layoutH="0" style="float:left; display:block; overflow:auto; width:240px; border:solid 1px #CCC; line-height:21px; background:#fff">
					<input type="hidden" id="bringflg" value="${bringflg}"></input>
					<input type="hidden" id="parentid"></input>
				    <ul class="tree treeFolder " id="treeul">
						${treeMatrinfo1}						
				    </ul>
				</div>
				
				<div id="Matrinfolis1" class="unitBox" style="margin-left:246px;">
					<!--#include virtual="list1.html" -->
					
				</div>
	
			</div>

</div>
</html>

