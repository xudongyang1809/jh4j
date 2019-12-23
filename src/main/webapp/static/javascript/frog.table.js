/**
 * 表格脚本
 * @author WangWeiWei_020463
 */
var Table = {
	initTable: function() {
		/*
		 * 给table的tr添加点击事件
		 */
		$('body').on('click', '.frog-table tr', function (event) {
			var $tr = $(this);
			if ($tr.parent()[0].tagName.toLocaleUpperCase() == 'TBODY') {
				$tr.parent().find('tr').removeClass("selected");
				$tr.addClass("selected");
				var sTarget = $tr.attr("target");
				if (sTarget) {
					var $table = $tr.parents('table');
					if ($("#" + sTarget, $table).size() == 0) {
						$table.prepend('<input id="' + sTarget + '" type="hidden" />');
					}
					$("#" + sTarget, $table).val($tr.attr("rel"));
				}
			}
		});
		
		/*
		 * 排序的点击操作
		 */
		$('body').on('click', '.layui-table-sort .layui-edge', function (event) {
			var orderField = $(this).parents('th:first').attr("orderField");
			if ($(this).parents(".layui-layer-content:first").length == 1) {
				var dialog = $(this).parents(".layui-layer-content:first");
				$('#pagerForm', $(dialog)).find('input[name="orderField"]').val(orderField);
				if ($(this).hasClass("layui-table-sort-asc")) {
					$('#pagerForm', $(dialog)).find('input[name="orderDirection"]').val("asc");
				} else if ($(this).hasClass("layui-table-sort-desc")) {
					$('#pagerForm', $(dialog)).find('input[name="orderDirection"]').val("desc");
				}
				$('#pagerForm', $(this).parents(".layui-layer-content:first")).submit();
			} else if ($(this).parents(".layui-single-tab:first").length == 1) {
				var tab = $(this).parents(".layui-single-tab:first");
				$('#pagerForm', $(tab)).find('input[name="orderField"]').val(orderField);
				if ($(this).hasClass("layui-table-sort-asc")) {
					$('#pagerForm', $(tab)).find('input[name="orderDirection"]').val("asc");
				} else if ($(this).hasClass("layui-table-sort-desc")) {
					$('#pagerForm', $(tab)).find('input[name="orderDirection"]').val("desc");
				}
				$('#pagerForm', $(tab)).submit();
			}
		});
		
		/*
		 * 每半秒扫描一次整个html，查看是否有需要渲染的带排序的table，然后给需要排序的th元素加上排序按钮
		 */
		setInterval(function() {
			$('.frog-table').each(function() {
				$(this).find('th[orderField]').each(function() {
					if (!$.trim($(this).attr("orderField")) == "") {
						if ($(this).find('.layui-table-sort').length == 0) {
							$(this).append('<span class="layui-table-sort layui-inline">' +
								'<i class="layui-edge layui-table-sort-asc" title="升序"></i>' +
								'<i class="layui-edge layui-table-sort-desc" title="降序"></i>' +
							'</span>');
						}
					}
				});
			});
		}, 500);
	}
}