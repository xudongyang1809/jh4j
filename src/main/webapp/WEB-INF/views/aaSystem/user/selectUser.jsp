<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<style>
#dept-user-tree li.selected>a cite {
	background-color: #5FB878;
    color: white;
}
</style>
<script type="text/javascript">
var dialogIndex = $('#dept-user-tree').parents(".layui-layer:first").attr("times");
/* 初始化树结构 */
var singleflag = eval("${singleFlag}");
//整个树结构的对象
var zTreeObj;
//树结构的配置信息
var setting = {
	callback: {
		onClick: selectUser
	}
};
$(function() {
	$.post("${ctx}/user/getDeptUserTree", function(jsonData) {
		try {
			$('#dept-user-tree').html('<ul id="treeDemo" class="ztree"></ul>');
			var treeMapList = JSON.parse(jsonData);
			zTreeObj = $.fn.zTree.init($("#dept-user-tree #treeDemo"), setting, treeMapList);
		} catch (e) {
			console.log(jsonData);
			Dialog.error(e.message);
		}
	});
});

/*
 * 挑选人员
 */
function selectUser(event, treeId, treeNode) {
	if (treeNode.isUser == 1) {
		if ('${callbackMethod}' != '') {
			if (typeof(eval('${callbackMethod}')) == "function") {
				var func = eval('${callbackMethod}');
				func(treeNode.id, treeNode.strSn, treeNode.strName);
				layer.close(dialogIndex);
			} else {
				Dialog.warn("提供的回调方法不存在，请修改！");
			}
		} else {
			var userIdFilter = '${userIdFilter}';
			var userNoFilter = '${userNoFilter}';
			var usernameFilter = '${usernameFilter}';
			if (userIdFilter == '' && userNoFilter == '' && usernameFilter == '') {
				Dialog.warn("提供的数据回填的dom元素不存在，请修改！");
			} else {
				var strAccount = treeNode.strSn;
				var userId = treeNode.id;
				var strName = treeNode.strName;
				if (userIdFilter != '') {
					if ($('#' + userIdFilter).is('input')) {
						$('#' + userIdFilter).val(userId);
					} else {
						$('#' + userIdFilter).text(userId);
					}
				}
				if (userNoFilter != '') {
					if ($('#' + userNoFilter).is('input')) {
						$('#' + userNoFilter).val(strAccount);
					} else {
						$('#' + userNoFilter).text(strAccount);
					}
				}
				if (usernameFilter != '') {
					if ($('#' + usernameFilter).is('input')) {
						$('#' + usernameFilter).val(strName);
					} else {
						$('#' + usernameFilter).text(strName);
					}
				}
				layer.close(dialogIndex);
			}
		}
	}
}

function searchUser(obj) {
	var tobj = $.fn.zTree.getZTreeObj("treeDemo");
	var serchContent = obj.value;
	$("#treeDemo").find("a").each(function() {
		var atitle = this.title;
		if (serchContent != '') {
			if (atitle.search(serchContent) != -1) {
				$(this).css("color", "red");
				if (atitle.indexOf("[") > 0) {
					var arr = atitle.split("[");
					var userNo = arr[1].replace("]", "");
					var userName = arr[0];
					if (userNo == serchContent || userName == serchContent) {
						var id = $(this).parent("li").attr("id");
						var node = tobj.getNodeByTId(id);
						tobj.selectNode(node);
					}
				}
			} else {
				$(this).css("color", "black");
			}
		} else {
			$(this).css("color", "black");
		}
	});
}

/*
 * 组织结构挑选后的回调函数
 */
function selectUsersDialogSearchDept(deptId, deptNo, deptName) {
	$('#dept_search_id').val(deptId);
	$('#dept_search_strName').val(deptName);
	var tobj = $.fn.zTree.getZTreeObj("treeDemo");
	$("#treeDemo").find("a").each(function() {
		var atitle = this.title;
		if (deptName != '') {
			if (atitle.search(deptName) != -1) {
				$(this).css("color", "red");
				if (atitle.indexOf("[") < 0) {
					if (deptName == atitle) {
						var id = $(this).parent("li").attr("id");
						var node = tobj.getNodeByTId(id);
						tobj.selectNode(node);
					}
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
<div style="padding: 5px;">
	<div class="layui-form">
		<div class="layui-form-item">
	  		<div class="layui-inline" style="margin-right: 0px;">
	    		<label class="layui-form-label" style="width: 60px; padding: 9px;">组织定位</label>
	    		<div class="layui-input-inline" style="margin-right: 0px;">
	      			<input id="dept_search_id" type="hidden"/>
					<input id="dept_search_strName" class="layui-input" type="text" readonly="readonly" style="padding-right: 50px;" placeHolder="请点击挑选组织..." />
					<a class="layui-btn layui-btn-sm" onPickDept="selectUsersDialogSearchDept" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i class="layui-icon layui-icon-search"></i></a>
	    		</div>
	    	</div>
	    	<div class="layui-inline" style="margin-right: 0px;">
	    		<label class="layui-form-label" style="width: 60px; padding: 9px;">人员查询</label>
	    		<div class="layui-input-inline" style="margin-right: 0px;">
	      			<input type="text" class="layui-input" onkeyup="searchUser(this)" placeHolder="工号或者姓名..." alt="工号/姓名"/>
	    		</div>
	    	</div>
	  	</div>
	</div>
	<div id="dept-user-tree" style="position: absolute; top: 90px; right: 10px; left: 10px; bottom: 10px; border: 1px solid #ccc; overflow: auto;">
		<div style="text-align: center; margin: 0 auto; padding-top: 20px;"><img alt="" src="${ctx}/static/image/loading.gif"></div>
	</div>
</div>