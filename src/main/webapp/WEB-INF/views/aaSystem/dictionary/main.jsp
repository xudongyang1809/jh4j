<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#dictionary-tree-container {
	width: 260px;
	position: absolute;
	top: 0px;
	left: 0px;
	bottom: 0px;
	border-right: 1px solid #ccc;
	overflow: auto;
}
</style>
</head>
<body>
	<div id="dictionary-tree-container">
		<div style="padding: 5px 5px 0 5px;">
			<input type="text" class="layui-input" placeHolder="输入词典名称查询" onkeyup="searchDic(this)" />
		</div>
		<ul id="dictionary-tree-tab" class="ztree">
			
		</ul>
	</div>
	<div id="dictionary-list-view" style="position: absolute; top: 0px; left: 261px; bottom: 0px; right: 0px;">
		
	</div>
</body>
<script type="text/javascript">
//树结构的配置信息
var setting = {
	callback: {
		onClick: clickSelectDict
	}
};
var json = '${treeMapListJson}';
var treeMapList = JSON.parse(json);
$.fn.zTree.init($("#dictionary-tree-tab"), setting, treeMapList);

function clickSelectDict(event, treeId, treeNode, clickFlag) {
	$('#dictionary-list-view', NavTab.getCurrentPanel()).html("");
	if (treeNode.id == "") {
		$('#dictionary-list-view', NavTab.getCurrentPanel()).load("${ctx}/dict/list", function () {
			$('#dictionary-list-view', NavTab.getCurrentPanel()).attr("url", "${ctx}/dict/list");
		});
	} else {
		$('#dictionary-list-view', NavTab.getCurrentPanel()).load("${ctx}/dictdtl/list?dictId=" + treeNode.id, function () {
			$('#dictionary-list-view', NavTab.getCurrentPanel()).attr("url", "${ctx}/dictdtl/list?dictId=" + treeNode.id);
		});
	}
}

function searchDic(obj) {
	var tobj = $.fn.zTree.getZTreeObj("dictionary-tree-tab");
	var serchContent = obj.value;
	$("#dictionary-tree-tab").find("a").each(function() {
		var atitle = this.title;
		if (serchContent != '') {
			if (atitle.search(serchContent) != -1) {
				$(this).css("color", "red");
				if(atitle.match(serchContent).length==1){
					var id = $(this).parent("li").attr("id");
					var node = tobj.getNodeByTId(id);
					tobj.selectNode(node);
				}
			} else {
				$(this).css("color", "black");
			}
		} else {
			$(this).css("color", "black");
		}
	});
}
</script>
</html>