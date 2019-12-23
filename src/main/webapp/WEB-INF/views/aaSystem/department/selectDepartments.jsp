<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<style>
#department-list>div {
	height: 30px;
    border-bottom: 1px solid #ccc;
    line-height: 30px;
    padding-left: 5px;
    padding-right: 5px;
    clear: both;
}

#department-list .btn-remove-selected-user {
	float: right; 
	cursor: pointer;
}

#dept-tree li.selected>a cite {
	background-color: #5FB878;
    color: white;
}
</style>
<div class="dialogContent" style="left: 15px; right: 15px;">
	<div class="layui-form">
		<div class="layui-form-item">
	    	<div class="layui-inline" style="margin-right: 0px;">
	    		<label class="layui-form-label" style="width: 60px; padding: 9px;">部门查询</label>
	    		<div class="layui-input-inline" style="width: 150px; margin-right: 0px;">
	      			<input type="text" class="layui-input" onkeyup="searchDepartment(this)" placeHolder="部门名称..." alt="部门名称" />
	    		</div>
	    	</div>
	  	</div>
  	</div>
  	<div style="position: absolute; top: 50px; left: 0px; right: 0px; bottom: 0px;">
		<div id="dept-tree" style="position: absolute; top: 0px; right: 190px; left: 0px; bottom: 10px; border: 1px solid #ccc; overflow: auto;">
			<ul id="pick-organization-tree" class="ztree"></ul>
		</div>
		<div id="department-list" style="position: absolute; top: 0px; right: 0px; bottom: 10px; width: 180px; border: 1px solid #ccc; overflow: auto;">
			
		</div>
	</div>
</div>
<div class="dialogFooter">
	<button type="submit" class="layui-btn" onclick="submitSelectDepartments(this)">提交</button>
	<button type="button" class="layui-btn layui-btn-warm" onclick="closeCurrentDialog(this)">关闭</button>
</div>
<script type="text/javascript">
var dialogIndex = $('#pick-organization-tree').parents(".layui-layer:first").attr("times");
var singleflag = "${singleFlag}";
var setting = {
	check: {
		enable: true,
		chkboxType: { "Y" : "", "N" : "" }
	},
	callback: {
		onClick: clickPickOrganization,
		onCheck: checkSelectDepartment
	}
};
var json = '${ztreeData}';
var treeMapList = JSON.parse(json);
$.fn.zTree.init($("#pick-organization-tree"), setting, treeMapList);

function clickPickOrganization(event, treeId, node, clickFlag) {
	if ('${callbackMethod}' != '') {
		if (typeof(eval('${callbackMethod}')) == "function") {
			var func = eval('${callbackMethod}');
			func(node.id, node.strSn, node.name);
			layer.close(dialogIndex);
		} else {
			Dialog.warn("提供的回调方法不存在，请修改！");
		}
	} else {
		var deptIdFilter = '${deptIdFilter}';
		var deptNoFilter = '${deptNoFilter}';
		var deptNameFilter = '${deptNameFilter}';
		if (deptIdFilter == '' && deptNoFilter == '' && deptNameFilter == '') {
			Dialog.warn("提供的数据回填的dom元素不存在，请修改！");
		} else {
			if (deptIdFilter != '') {
				if ($('#' + deptIdFilter).is('input')) {
					$('#' + deptIdFilter).val(node.id);
				} else {
					$('#' + deptIdFilter).text(node.id);
				}
			}
			if (deptNoFilter != '') {
				if ($('#' + deptNoFilter).is('input')) {
					$('#' + deptNoFilter).val(node.strSn);
				} else {
					$('#' + deptNoFilter).text(node.strSn);
				}
			}
			if (deptNameFilter != '') {
				if ($('#' + deptNameFilter).is('input')) {
					$('#' + deptNameFilter).val(node.strName);
				} else {
					$('#' + deptNameFilter).text(node.strName);
				}
			}
			layer.close(dialogIndex);
		}
	}
}

/*
 * 勾选部门的触发事件
 */
function checkSelectDepartment(event, treeId, treeNode) {
	var dialogIndex = Dialog.load();
	if (treeNode.checked) {
		if (eval(singleflag)) {
			$('#department-list').html("");
		}
		$('#department-list').append('<div>' + 
				'<input type="hidden" name="strSn" value="' + treeNode.strSn + '" />' +
				'<input type="hidden" name="id" value="' + treeNode.id + '" />' +
				'<input type="hidden" name="strName" value="' + treeNode.strName + '" />' +
				'<span style="font-weight: bolder; color: #2F4056; display: inline-block; width: 130px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">' + treeNode.name + '</span>' + 
				'<span class="btn-remove-selected-user" onclick="removeSelectedDepartment(this)"><i class="layui-icon layui-icon-delete" style="color: red; font-size: 25px;"></i></span></div>');
	} else {
		$('#department-list>div').each(function() {
			if (treeNode.id == $(this).find('input[name="id"]').val()) {
				$(this).remove();
			}
		});
	}
	layer.close(dialogIndex);
}

function searchDepartment(obj) {
	var tobj = $.fn.zTree.getZTreeObj("pick-organization-tree");
	var serchContent = obj.value;
	$("#pick-organization-tree").find("a").each(function() {
		var atitle = this.title;
		if (serchContent != '') {
			if (atitle.search(serchContent) != -1) {
				$(this).css("color", "red");
				if (atitle == serchContent) {
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

function removeSelectedDepartment(span) {
	var zTree = $.fn.zTree.getZTreeObj("pick-organization-tree");
	//根据id取得对应树的节点
	var checkboxId = $(span).parent().find('input[name="id"]').val();
	var node = zTree.getNodeByParam("id", checkboxId, null);
	//取消勾选状态
	zTree.checkNode(node, false, false, true);
	$(span).parent().remove();
}

/*
 * 提交已挑选的人员信息
 */
function submitSelectDepartments(btn) {
	var departmentList = new Array();
	var departmentIds = "";
	var departmentNos = "";
	var departmentNames = "";
	$('#department-list>div').each(function() {
		var strSn = $(this).find('input[name="strSn"]').val();
		var strName = $(this).find('input[name="strName"]').val();
		var id = $(this).find('input[name="id"]').val();
		departmentList.push({id: id, strSn: strSn, strName: strName});
		if (departmentIds == "") {
			departmentIds = id;
		} else {
			departmentIds += "," + id;
		}
		if (departmentNos == "") {
			departmentNos = strSn;
		} else {
			departmentNos += "," + strSn;
		}
		if (departmentNames == "") {
			departmentNames = strName;
		} else {
			departmentNames += "," + strName;
		}
	});
	if ('${callbackMethod}' != '') {
		var callbackMethod = eval('${callbackMethod}');
		if (typeof(callbackMethod) == "function") {
			callbackMethod(departmentIds, departmentNos, departmentNames, departmentList);
		}
	} else {
		if ('${deptIdFilter}' != '') {
			if ($('[id=${deptIdFilter}]').length == 0) {
				Dialog.error("标签“${deptIdFilter}”不存在");
				return false;
			} else if ($('[id=${deptIdFilter}]').length > 1) {
				Dialog.error("标签“${deptIdFilter}”存在多个,无法赋值");
				return false;
			} else {
				if ($('#${deptIdFilter}').is('input')) {
					$('#${deptIdFilter}').val(departmentIds);
				} else {
					$('#${deptIdFilter}').text(departmentIds);
				}
			}
		}
		if ('${deptNoFilter}' != '') {
			if ($('[id=${deptNoFilter}]').length == 0) {
				Dialog.error("标签“${deptNoFilter}”不存在");
				return false;
			} else if ($('[id=${deptNoFilter}]').length > 1) {
				Dialog.error("标签“${deptNoFilter}”存在多个,无法赋值");
				return false;
			} else {
				if ($('#${deptNoFilter}').is('input')) {
					$('#${deptNoFilter}').val(departmentNos);
				} else {
					$('#${deptNoFilter}').text(departmentNos);
				}
			}
		}
		if ('${deptNameFilter}' != '') {
			if ($('[id=${deptNameFilter}]').length == 0) {
				Dialog.error("标签“${v}”不存在");
				return false;
			} else if ($('[id=${deptNameFilter}]').length > 1) {
				Dialog.error("标签“${deptNameFilter}”存在多个,无法赋值");
				return false;
			} else {
				if ($('#${deptNameFilter}').is('input')) {
					$('#${deptNameFilter}').val(departmentNames);
				} else {
					$('#${deptNameFilter}').text(departmentNames);
				}
			}
		}
	}
	if ('${callbackMethod}' == '' && '${deptIdFilter}' == '' && '${deptNoFilter}' == '' && '${deptNameFilter}' == '') {
		Dialog.warn("未定义部门赋值标签");		
	} else {
		layer.close($(btn).parents('.layui-layer:first').attr("times"));
	}
}

/*
 * 关闭当前窗口
 */
function closeCurrentDialog(btn) {
	layer.close($(btn).parents('.layui-layer:first').attr("times"));
}
</script>