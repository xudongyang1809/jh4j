<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<div>
    <div id="panelBar"></div>
    <script>
	    var container = "${param.container}";
	    var numPerPage = 15;
    	var limits = [numPerPage, numPerPage*2, numPerPage*3, numPerPage*4, numPerPage*5, numPerPage*6];
    	var isCanPage = true;
    	if (container && container != "") {
    		if ($(container).length == 0) {
    			Dialog.warn("指定要刷新的容器不存在");
    			isCanPage = false;
    		} else if ($(container).length > 1) {
    			Dialog.warn("指定要刷新的容器存在多个");
    			isCanPage = false;
    		}
    	}
    	if (isCanPage) {
    		laypage.render({
    			elem: $('#panelBar', $("${param.container}").length == 1 ? $("${param.container}") : NavTab.getCurrentPanel()),
    			limit: "${page.numPerPage}",
    			limits: limits,
    			layout: ['prev', 'page', 'next', 'limit', 'skip', 'count'],
    			count: '${page.totalCount}',
    			curr: '${page.pageNum}',
    			prev: '<i class="layui-icon">&#xe65a;</i>',
    			next: '<i class="layui-icon">&#xe65b;</i>',
    			jump: function (obj, first) {
    			 	if (!first) {
    			 		if ("${param.container}" != '') {
    			 			$('#pagerForm', $("${param.container}")).find('input[name="pageNum"]').val(obj.curr);
    						$('#pagerForm', $("${param.container}")).find('input[name="numPerPage"]').val(obj.limit);
    						navTabAjaxDone($('#pagerForm', $("${param.container}", NavTab.getCurrentPanel())), "${param.container}");
    			 		} else {
    			 			$('#pagerForm', NavTab.getCurrentPanel()).find('input[name="pageNum"]').val(obj.curr);
    						$('#pagerForm', NavTab.getCurrentPanel()).find('input[name="numPerPage"]').val(obj.limit);
    						navTabAjaxDone($('#pagerForm', NavTab.getCurrentPanel()));
    			 		}
    			 	}
    			}
    		});
    	}
	</script>
</div>