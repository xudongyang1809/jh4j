<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<style>
#treeDiv {
	width: 200px;
	position: absolute;
	top: 0px;
	left: 0px;
	bottom: 0px;
	border-right: 1px solid #ccc;
	overflow: auto;
}
</style>
<script type="text/javascript">
var setting = {
	data: {
		simpleData: {
			enable: true
		}
	},
	callback: {
		onClick: zTreeOnClick
	}
};

$(function() {
	var zNodes = JSON.parse('${treeData}');
	$.fn.zTree.init($("#domainTree"), setting, zNodes);
});

function zTreeOnClick(event, treeId, treeNode) {
	if (treeNode.id != 1) {
		$(".detailFrame").load("${ctx}/smModel/getModelDetailList/" + treeNode.id + "?tabName=" + treeNode.name, function() {
			$(".detailFrame").attr("url", "${ctx}/smModel/getModelDetailList/" + treeNode.id + "?tabName=" + treeNode.name);
		});
	}
}
</script>
<div class="row">
	<div id="treeDiv">
		<ul id="domainTree" class="ztree"></ul>
	</div>
	<div class="detailFrame" style="position: absolute; top: 0px; left: 201px; bottom: 0px; right: 0px;">
		
	</div>
</div>
