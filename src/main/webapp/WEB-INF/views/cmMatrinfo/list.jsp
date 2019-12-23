<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>

<style type="text/css">
#matrinfo-tree-container {
	width: 220px;
	position: absolute;
	top: 0px;
	left: 0px;
	bottom: 0px;
	border-right: 1px solid #ccc;
	overflow: auto;
}
.tab-bars a{
	margin-right: 0px
}
</style>

<input type="hidden" id="publicConfigureNodeId" />
<div id="matrinfo-tree-container">
	<div class="tab-bars">
		<shiro:hasPermission name="CmMatrinfo:create">
			<a class="add"  onclick="operaMatrinfo('add')"><span>新增</span></a>
			<a class="add" style="display: none;" target="dialog" width="550" height="350" dialogId="createCmMatrinfo" href="">新增</a>
		</shiro:hasPermission>
		<shiro:hasPermission name="CmMatrinfo:edit">
			<a class="edit" onclick="operaMatrinfo('edit')"><span>编辑</span></a>
			<a class="edit" style="display: none;" target="dialog" width="550" height="300" dialogId="updateCmMatrinfo" href="">编辑</a>
		</shiro:hasPermission>
		<shiro:hasPermission name="CmMatrinfo:delete">
			<a class="delete" onclick="operaMatrinfo('delete')"><span>删除</span></a>
			<a class="delete" style="display: none;" target="ajaxTodo" id="deleteCmMatrinfo" title="确认要删除此数据吗?" href="">删除</a>
		</shiro:hasPermission>
	</div>
	<ul id="matrinfo-tree-tab">
		
	</ul>
</div>
<div id="department-list-view" style="position: absolute; top: 0px; left: 223px; bottom: 0px; right: 0px;">
	
</div>

<script type="text/javascript">
try {
	layui.use('tree',function () {
	var json = '${treeMapListJson}';
	var treeMapList = JSON.parse(json);
	layui.tree({
		elem: '#matrinfo-tree-tab',
		nodes: treeMapList,
		click: function(node) {
			var nodeId = node.id;
			$("#publicConfigureNodeId").val(nodeId);
			if(nodeId){
				var dialogIndex = Dialog.load();
				$('#department-list-view', NavTab.getCurrentPanel()).load("${ctx}/cmMatrinfoDetail/findbyclass/" + nodeId, function () {
					layer.close(dialogIndex);
					form.render();
				});
			}
		}
	});
	$('#matrinfo-tree-tab .layui-tree-branch', NavTab.getCurrentPanel()).html("");
	$('#matrinfo-tree-tab .layui-tree-branch', NavTab.getCurrentPanel()).addClass("fa");
	$('#matrinfo-tree-tab .layui-tree-branch', NavTab.getCurrentPanel()).addClass("fa-folder");
	$('#matrinfo-tree-tab .layui-tree-branch', NavTab.getCurrentPanel()).removeClass("layui-icon");
	$('#matrinfo-tree-tab .layui-tree-branch', NavTab.getCurrentPanel()).removeClass("layui-tree-branch");
	$('#matrinfo-tree-tab', NavTab.getCurrentPanel()).find('a').click(function() {
		$('#matrinfo-tree-tab', NavTab.getCurrentPanel()).find('a').find('cite').css("background-color", "white");
		$('#matrinfo-tree-tab', NavTab.getCurrentPanel()).find('a').find('cite').css("color", "black");
		$(this).find('cite').css("background-color", "#1E9FFF");
		$(this).find('cite').css("color", "white");
	});
	});
} catch (e) {
	console.log(json);
	Dialog.error(e.message);
}


function operaMatrinfo(obj){
	var parentId = $("#publicConfigureNodeId").val() || "root";
	if(obj == 'add'){
		$('a[dialogId="createCmMatrinfo"]').attr('href','${ctx}/cmMatrinfo/preCreate/'+parentId);
		$('a[dialogId="createCmMatrinfo"]').click();
	}else if(obj == 'edit'){
		if(parentId === "root"){
			Dialog.warn("根节点不可编辑");
			return false;
		}
		$('a[dialogId="updateCmMatrinfo"]').attr('href','${ctx}/cmMatrinfo/preUpdate/'+parentId);
		$('a[dialogId="updateCmMatrinfo"]').click();
	}else if(obj == 'delete'){
		if(parentId === "root"){
			Dialog.warn("根节点不可删除");
			return false;
		}
		$('#deleteCmMatrinfo').attr('href','${ctx}/cmMatrinfo/delete/'+parentId);
		$('#deleteCmMatrinfo').click();
	}
}
</script>
