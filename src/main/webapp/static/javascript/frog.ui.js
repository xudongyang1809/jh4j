/**
 * 全局样式初始化
 * @author WangWeiWei_020463
 * @date 2018-03-02 07:14:00
 */
var UI = {
		repaint: function() {
			//表格位置定时调整
			setInterval(function() {
				if ($('div.tab-content').length > 0) {
					var tabContentList = $('div.tab-content');
					for (var i = 0; i < tabContentList.length; i++) {
						var tabHeaderHeight = 0;
						var tabBarsHeight = 0;
						if ($(tabContentList[i]).parent().find('div.tab-header').length != 0) {
							$(tabContentList[i]).parent().find('div.tab-header').each(function() {
								tabHeaderHeight += parseInt($(this).outerHeight());
							});
						}
						if ($(tabContentList[i]).parent().find('div.tab-bars').length != 0) {
							$(tabContentList[i]).parent().find('div.tab-bars').each(function() {
								tabBarsHeight += parseInt($(this).outerHeight());
							});
						}
						$(tabContentList[i]).css("top", (tabHeaderHeight + tabBarsHeight) + 'px');
					}
				}
			}, 500);
		}
}