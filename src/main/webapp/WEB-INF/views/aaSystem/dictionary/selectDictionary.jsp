<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<head>
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
	var ztreeNodes = JSON.parse('${ztreeData}');
	$.fn.zTree.init($("#dictionaryTree"), setting, ztreeNodes);
});

function zTreeOnClick(event, treeId, treeNode) {
	if ("${callbackMethod}" != "") {
		var callbackMethod = eval('${callbackMethod}');
		if (typeof(callbackMethod) == "function") {
			callbackMethod(treeNode.id,treeNode.name);
			layer.close($(event.target).parents('.layui-layer:first').attr("times"));
		}
	} else {
		if ('${dictionaryId}' != '') {
			if ($('[id=${dictionaryId}]').length == 0) {
				Dialog.error("标签“${dictionaryId}”不存在");
				return false;
			} else if ($('[id=${dictionaryId}]').length > 1) {
				Dialog.error("标签“${dictionaryId}”存在多个,无法赋值");
				return false;
			} else {
				if(treeNode.id == ''){
					Dialog.error("请挑选具体的词典类型");
					return false;
				}else{
					$('[id=${dictionaryId}]').val(treeNode.id);
				}
			}
		}
		if ('${dictionaryName}' != '') {
			if ($('[id=${dictionaryName}]').length == 0) {
				Dialog.error("标签“${dictionaryName}”不存在");
				return false;
			} else if ($('[id=${dictionaryName}]').length > 1) {
				Dialog.error("标签“${dictionaryName}”存在多个,无法赋值");
				return false;
			} else {
				$('[id=${dictionaryName}]').val(treeNode.name);
			}
		}
	}
	if ('${callbackMethod}' == '' && '${dictionaryId}' == '' && '${dictionaryName}' == '') {
		Dialo.warn("未定义部门赋值标签");		
	} else {
		layer.close($(event.target).parents('.layui-layer:first').attr("times"));
	}
}

function searchDic(obj) {
	var tobj = $.fn.zTree.getZTreeObj("dictionaryTree");
	var serchContent = obj.value;
	$("#dictionaryTree").find("a").each(function() {
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
</head>
<div class="dialogContent" style="left: 15px; right: 15px;">
	<div class="layui-form-item">
    	<div class="layui-inline" style="margin-right: 0px;">
    		<label class="layui-form-label" style="width: 60px; padding: 9px;">词典类型</label>
    		<div class="layui-input-inline" style="width: 180px; margin-right: 0px;">
      			<input type="text" class="layui-input" onkeyup="searchDic(this)" placeHolder="输入词典类型..." alt="类型名"/>
    		</div>
    	</div>
  	</div>
	<div style="position: absolute; top: 50px; left: 0px; right: 0px; bottom: 0px;">
		<div id="dictree" style="position: absolute; top: 0px; right: 0px; left: 0px; bottom: 0px; border: 1px solid #ccc; overflow: auto;">
			<ul id="dictionaryTree" class="ztree"></ul>
		</div>
	</div>
</div>