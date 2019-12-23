<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<style>
#user-list>div {
	height: 30px;
    border-bottom: 1px solid #ccc;
    line-height: 30px;
    padding-left: 10px;
    padding-right: 10px;
    clear: both;
}

#user-list .btn-remove-selected-user {
	float: right; 
	cursor: pointer;
}

#dept-user-tree li.selected>a cite {
	background-color: #5FB878;
    color: white;
}
</style>
<script type="text/javascript">
/* 初始化树结构 */
var singleflag = eval("${singleFlag}");
//整个树结构的对象
var zTreeObj;
//树结构的配置信息
var setting = {
	check: {
		enable: eval(singleflag) ? false : true,
		autoCheckTrigger: false
	},
	callback: {
		onCheck: checkSelectUser,
		onClick: directSelectUser
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
 * 多选的挑选
 */
function checkSelectUser(event, treeId, treeNode) {
	var dialogIndex = Dialog.load();
	if (treeNode.isUser == 1) {
		if (treeNode.checked) {
			if (eval(singleflag)) {
				$('#user-list').html("");
			}
			$('#user-list').append('<div>' + 
					'<input type="hidden" name="strAccount" value="' + treeNode.strSn + '" />' +
					'<input type="hidden" name="id" value="' + treeNode.id + '" />' +
					'<input type="hidden" name="strName" value="' + treeNode.strName + '" />' +
					'<span style="font-weight: bolder; color: #2F4056;">' + treeNode.name + '</span>' + 
					'<span class="btn-remove-selected-user" onclick="removeSelectedUser(this)"><i class="layui-icon layui-icon-delete" style="color: red; font-size: 25px;"></i></span></div>');
		} else {
			$('#user-list>div').each(function() {
				if (treeNode.strSn == $(this).find('input[name="strAccount"]').val()) {
					$(this).remove();
				}
			});
		}
	} else {
		if (treeNode.checked) {
			addUserListByDept(treeNode);
		} else {
			removeUserListByDept(treeNode);
		}
	}
	layer.close(dialogIndex);
}

/*
 * 单选的挑选
 */
function selectUser(event, treeId, treeNode, clickFlag) {
	if (treeNode.isUser == 1) {
		var dialogIndex = Dialog.load();
		if (eval(singleflag)) {
			$('#user-list').html("");
		}
		$('#user-list').append('<div>' + 
				'<input type="hidden" name="strAccount" value="' + treeNode.strSn + '" />' +
				'<input type="hidden" name="id" value="' + treeNode.id + '" />' +
				'<input type="hidden" name="strName" value="' + treeNode.strName + '" />' +
				'<span style="font-weight: bolder; color: #2F4056;">' + treeNode.name + '</span>' + 
				'<span class="btn-remove-selected-user" onclick="removeSelectedUser(this)"><i class="layui-icon layui-icon-delete" style="color: red; font-size: 25px;"></i></span></div>');
		layer.close(dialogIndex);
	}
}

/*
 * 双击直接挑选人员
 */
function directSelectUser(event, treeId, treeNode) {
	if (treeNode.isUser == 1) {
		var strAccount = treeNode.strSn;
		var userId = treeNode.id;
		var strName = treeNode.strName;
		if ('${userIdFilter}' != '') {
			$('#${userIdFilter}').val(userId);
		}
		if ('${userNoFilter}' != '') {
			$('#${userNoFilter}').val(strAccount);
		}
		if ('${usernameFilter}' != '') {
			$('#${usernameFilter}').val(strName);
		}
		if ('${userIdFilter}' == '' && '${userNoFilter}' == '' && '${usernameFilter}' == '') {
			Dialo.warn("未定义人员赋值标签");		
		} else {
			layer.close($(event.target).parents('.layui-layer:first').attr("times"));
		}
	}
}

/*
 * 根据部门节点批量选中部门下的无限层次的人员
 */
function addUserListByDept(rootNode) {
	if (rootNode.children != null && rootNode.children.length > 0) {
		for (var i = 0; i < rootNode.children.length; i++) {
			var node = rootNode.children[i];
			if (node.isUser == 1) {
				$('#user-list').append('<div>' + 
						'<input type="hidden" name="strAccount" value="' + node.strSn + '" />' +
						'<input type="hidden" name="id" value="' + node.id + '" />' +
						'<input type="hidden" name="strName" value="' + node.strName + '" />' +
						'<span style="font-weight: bolder; color: #2F4056;">' + node.name + '</span>' + 
						'<span class="btn-remove-selected-user" onclick="removeSelectedUser(this)"><i class="layui-icon layui-icon-delete" style="color: red; font-size: 25px;"></i></span></div>');
			} else {
				addUserListByDept(node);
			}
		}
	}
}

/*
 * 根据部门节点批量剔除部门下的无限层次的人员
 */
function removeUserListByDept(rootNode) {
	if (rootNode.children != null && rootNode.children.length > 0) {
		for (var i = 0; i < rootNode.children.length; i++) {
			var node = rootNode.children[i];
			if (node.isUser == 1) {
				$('#user-list>div').each(function() {
					if (node.strSn == $(this).find('input[name="strAccount"]').val()) {
						$(this).remove();
					}
				});
			} else {
				removeUserListByDept(node);
			}
		}
	}
}

/*
 * 移除已选择的人员
 */
function removeSelectedUser(span) {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	//根据id取得对应树的节点
	var checkboxId = $(span).parent().find('input[name="id"]').val();
	var node = zTree.getNodeByParam("id", checkboxId, null);
	//取消勾选状态
	zTree.checkNode(node, false, false, true);
	$(span).parent().remove();
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
 * 提交已挑选的人员信息
 */
function submitSelectUsers(btn) {
	var userList = new Array();
	var userIds = "";
	var strAccounts = "";
	var strNames = "";
	$('#user-list>div').each(function() {
		var strAccount = $(this).find('input[name="strAccount"]').val();
		var strName = $(this).find('input[name="strName"]').val();
		var userId = $(this).find('input[name="id"]').val();
		userList.push({id: userId, strAccount: strAccount, strName: strName});
		if (userIds == "") {
			userIds = userId;
		} else {
			userIds += "," + userId;
		}
		if (strAccounts == "") {
			strAccounts = strAccount;
		} else {
			strAccounts += "," + strAccount;
		}
		if (strNames == "") {
			strNames = strName;
		} else {
			strNames += "," + strName;
		}
	});
	if ('${callbackMethod}' != '') {
		var callbackMethod = eval('${callbackMethod}');
		if (typeof(callbackMethod) == "function") {
			callbackMethod(userIds, strAccounts, strNames, userList);
		}
	} else {
		if ('${userIdFilter}' != '') {
			if ($('[id=${userIdFilter}]').length == 0) {
				Dialog.error("标签“${userIdFilter}”不存在");
				return false;
			} else if ($('[id=${userIdFilter}]').length > 1) {
				Dialog.error("标签“${userIdFilter}”存在多个,无法赋值");
				return false;
			} else {
				if ($('#${userIdFilter}').is('input')) {
					$('#${userIdFilter}').val(userIds);
				} else {
					$('#${userIdFilter}').text(userIds);
				}
			}
		}
		if ('${userNoFilter}' != '') {
			if ($('[id=${userNoFilter}]').length == 0) {
				Dialog.error("标签“${userNoFilter}”不存在");
				return false;
			} else if ($('[id=${userNoFilter}]').length > 1) {
				Dialog.error("标签“${userNoFilter}”存在多个,无法赋值");
				return false;
			} else {
				if ($('#${userNoFilter}').is('input')) {
					$('#${userNoFilter}').val(strAccounts);
				} else {
					$('#${userNoFilter}').text(strAccounts);
				}
			}
		}
		if ('${usernameFilter}' != '') {
			if ($('[id=${usernameFilter}]').length == 0) {
				Dialog.error("标签“${usernameFilter}”不存在");
				return false;
			} else if ($('[id=${usernameFilter}]').length > 1) {
				Dialog.error("标签“${usernameFilter}”存在多个,无法赋值");
				return false;
			} else {
				if ($('#${usernameFilter}').is('input')) {
					$('#${usernameFilter}').val(strNames);
				} else {
					$('#${usernameFilter}').text(strNames);
				}
			}
		}
	}
	if ('${callbackMethod}' == '' && '${userIdFilter}' == '' && '${userNoFilter}' == '' && '${usernameFilter}' == '') {
		Dialog.warn("未定义人员赋值标签");		
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
<div class="dialogContent" style="left: 15px; right: 15px;">
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
	    		<div class="layui-input-inline" style="width: 150px; margin-right: 0px;">
	      			<input type="text" class="layui-input" onkeyup="searchUser(this)" placeHolder="工号或者姓名..." alt="工号/姓名"/>
	    		</div>
	    	</div>
	  	</div>
	</div>
	<div style="position: absolute; top: 50px; left: 0px; right: 0px; bottom: 0px;">
		<div id="dept-user-tree" style="position: absolute; top: 0px; right: 208px; left: 0px; bottom: 10px; border: 1px solid #ccc; overflow: auto;">
			<div style="text-align: center; margin: 0 auto; padding-top: 20px;"><img alt="" src="${ctx}/static/image/loading.gif"></div>
		</div>
		<div id="user-list" style="position: absolute; top: 0px; right: 0px; bottom: 10px; width: 198px; border: 1px solid #ccc; overflow: auto;">
		</div>
	</div>
</div>
<div class="dialogFooter">
	<button type="submit" class="layui-btn" onclick="submitSelectUsers(this)">提交</button>
	<button type="button" class="layui-btn layui-btn-warm" onclick="closeCurrentDialog(this)">关闭</button>
</div>
