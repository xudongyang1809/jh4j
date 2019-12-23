/**
 * navTab类
 * @author WangWeiWei_020463
 */
var NavTab = {
		getCurrentTab: function() {
			return $('#LAY_app_tabsheader').find('li.layui-this');
		},
		getCurrentPanel: function() {
			var tabId = $('#LAY_app_tabsheader').find('li.layui-this').prop("id");
			return $('div[tabId="' + tabId + '"]');
		},
		closeAllTab: function() {
			$('#LAY_app_tabsheader').find('li[id!="homePage"]').remove();
		},
		/* 刷新tab页面（有TabId：刷新指定tabId的tab，无tabId，刷新当前页面） */
		reload: function(tabId) {
			var url = "";
			if (tabId) {
				url = $('#' + tabId).attr("url");
				if (!url) {
					url = NavTab.getCurrentTab().attr("url");
				}
				$('div[tabId="' + tabId + '"]').load(url, function() {
					form.render();
				});
			} else {
				url = NavTab.getCurrentTab().attr("url");
				NavTab.getCurrentPanel().load(url, function() {
					form.render();
				});
			}
		},
		/* 刷新保持当前分页状态的tab页面（有TabId：刷新指定tabId的tab，无tabId，刷新当前页面） */
		reloadWithPagination: function(tabId) {
			var url = "";
			if (tabId) {
				url = $('#' + tabId).attr("url");
				if (!url) {
					url = NavTab.getCurrentTab().attr("url");
				}
				/* 判断标签是否有分页信息，做不同处理，下面无tabId的刷新同样如此 */
				if ($('#pagerForm', NavTab.getCurrentPanel()).length == 1) {
					$('div[tabId="' + tabId + '"]').load(url, $('#pagerForm', NavTab.getCurrentPanel()).serializeArray(), function() {
						form.render();
					});
				} else if ($('#pagerForm', NavTab.getCurrentPanel()).length > 1) {
					Dialog.warn("指定的标签页包含多个分页信息，无法刷新！");
				} else {
					$('div[tabId="' + tabId + '"]').load(url, function() {
						form.render();
					});
				}
			} else {
				url = NavTab.getCurrentTab().attr("url");
				if ($('#pagerForm', NavTab.getCurrentPanel()).length == 1) {
					NavTab.getCurrentPanel().load(url, $('#pagerForm', NavTab.getCurrentPanel()).serializeArray(), function() {
						form.render();
					});
				} else if ($('#pagerForm', NavTab.getCurrentPanel()).length > 1) {
					Dialog.warn("当前的标签页包含多个分页信息，无法刷新！");
				} else {
					NavTab.getCurrentPanel().load(url, function() {
						form.render();
					});
				}
			}
		},
		close: function(tabId) {
			$('#LAY_app_tabsheader').find('li[id="' + tabId + '"]').remove();
		}
}