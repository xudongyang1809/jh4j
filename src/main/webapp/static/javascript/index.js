/**
 * 首页的js脚本
 * @author WangWeiWei_020463
 */
layui.use(['layer', 'element', 'form', 'laypage', 'laydate', 'rate', 'layedit', 'table'], function(){
	element = layui.element;
	layer = layui.layer;
	form = layui.form;
	laypage = layui.laypage;
	laydate = layui.laydate;
	layrate = layui.rate;
	layedit = layui.layedit;
	table = layui.table;
	element.on('tabDelete(layadmin-layout-tabs)', function(data) {
		var tabId = $(this).parent().prop("id");
		$('div[tabId="' + tabId + '"]').remove();
	});
	element.on('tab(layadmin-layout-tabs)', function(data){
		var tabId = $(this).prop("id");
		var currentPanel = $('.layui-body').find('>div[tabId="' + tabId + '"]');
		if (!currentPanel.hasClass("show")) {
			currentPanel.show();
			currentPanel.addClass("show");
			$('.layui-body').find('>div[tabId!="' + tabId + '"]').removeClass("show");
			$('.layui-body').find('>div[tabId!="' + tabId + '"]').hide();
		}
	});
	element.on('tab(layadmin-layout-navigation)', function(data) {
		NavTab.closeAllTab();
		$('.layui-single-tab').each(function() {
			if ($(this).attr("tabId") != 'homePage') {
				$(this).remove();
			}
		});
		$('#homePage').click();
		//加载左侧菜单栏
		$('.side-menu').load("menu/switchProject/" + $(this).prop("id"), function() {
			element.render('nav');
		});
	});
	/* 渲染全局的元素操作事件 */
	Table.initTable();
	Dialog.initUI();
	Ajax.initUI();
	Attribute.initUI();
	UI.repaint();
	FormObject.init();
	/* 加载主页 */
	$('.layui-body').append('<div class="layui-single-tab" tabId="homePage"></div>');
	$('.layui-body').find('div[tabId="homePage"]').load($('#homePage').attr("url"));
	/*默认点击导航条里第一个菜单*/
	$('#navigationBar').find('li.layui-this').click();
});

/* 取消ajax缓存机制 */
$.ajaxSetup ({
	cache: false,
	error: Ajax.ajaxError
});

$(document).ajaxStart(function(){
	Dialog.load();
});

$(document).ajaxStop(function(msg) {
	form.render();
	layer.closeAll('loading');
});

/*
 * 左侧菜单栏的点击事件
 */
$('.side-menu').on('click', '.layui-nav-child a', function (event) {
	var href = $(this).attr("href");
	var tabName = $(this).text();
	if (href == null || href == "#" || href == '') {
		event.preventDefault();
		Dialog.warn("菜单路径有误，无法打开！");
		return;
	}
	var index = Dialog.load();
	var _this = $(this);
	var tabId = $(this).attr("strSn");
	if ($('#' + tabId, $('#LAY_app_tabsheader')).length == 0) {
		$('#lay_app_tabs').find('.layui-tab>ul').find('li').removeClass("layui-this");
		$('.layui-body').find('>div[tabId!="' + tabId + '"]').removeClass("show");
		$('.layui-body').find('>div[tabId!="' + tabId + '"]').hide();
		$('#lay_app_tabs').find('.layui-tab>ul').append('<li class="layui-this" id="' + tabId + '" url="' + href + '">' + tabName + '</li>');
		$('.layui-body').append('<div class="layui-single-tab show" tabId="' + tabId + '"></div>');
		$('.layui-body').find('>div[tabId="' + tabId + '"]').load(href,
		function() {
			form.render();
			layer.close(index);
		});
	} else {
		if (!$('#' + tabId, $('#LAY_app_tabsheader')).hasClass("layui-this")) {
			$('#lay_app_tabs').find('.layui-tab>ul').find('li').removeClass("layui-this");
			$('.layui-body').find('>div[tabId!="' + tabId + '"]').hide();
			$('.layui-body').find('>div[tabId!="' + tabId + '"]').removeClass("show");
			$('#' + tabId, $('#LAY_app_tabsheader')).addClass("layui-this");
			$('.layui-body').find('>div[tabId="' + tabId + '"]').show();
			$('.layui-body').find('>div[tabId="' + tabId + '"]').addClass("show");
			$('.layui-body').find('>div[tabId="' + tabId + '"]').load(href, function() {
				layer.close(index);
				form.render();
			});
		} else {
			$('.layui-body').find('>div[tabId="' + tabId + '"]').load(href, function() {
				layer.close(index);
				form.render();
			});
		}
	}
	element.init();
	event.preventDefault();
});

/*
 * 标签页的右键菜单信息
 */
var items = {
	"refresh": {
		name: "刷新当前标签页",
		icon: "fa-refresh"
	},
	sep1: "-----------",
	"closeCurrent": {
		name: "关闭当前标签页",
		icon: "fa-map-marker"
	},
	"closeOthers": {
		name: "关闭其他标签页",
		icon: "fa-arrows-h"
	},
	"closeLeft": {
		name: "关闭左侧标签页",
		icon: "fa-arrow-left"
	},
	"closeRight": {
		name: "关闭右侧标签页",
		icon: "fa-arrow-right"
	},
	"closeAll": {
		name: "关闭全部标签页",
		icon: "fa-arrows"
	}
};

/*
 * 标签页的右击事件
 */
$('#lay_app_tabs').on('contextmenu', 'li', function() {
	items.closeCurrent.disabled = false;
	items.closeOthers.disabled = false;
	items.closeLeft.disabled = false;
	items.closeRight.disabled = false;
	items.closeAll.disabled = false;
	if ($(this).prop("id") == "homePage") {
		items.closeLeft.disabled = true;
		items.closeCurrent.disabled = true;
		if ($(this).parent().find('>li').length == 1) {
			items.closeRight.disabled = true;
			items.closeAll.disabled = true;
			items.closeOthers.disabled = true;
		}
	} else {
		if ($(this).prev().prop("id") == "homePage") {
			items.closeLeft.disabled = true;
		}
		if ($(this).next().length == 0) {
			items.closeRight.disabled = true;
		}
		if ($(this).next().length == 0 && $(this).prev().prop("id") == "homePage") {
			items.closeOthers.disabled = true;
		}
	}
});

/*
 * 标签页的右击事件注册（依赖于jquery.contextmenu.js）
 */
$.contextMenu({
	selector: '#lay_app_tabs li',
	className: 'css-contextMenu',
	callback: function(key, options) {
		var tabId = $(this).prop("id");
        if (key == "refresh") {
        	//刷新当前标签页
        	Dialog.load();
    		var url = $(this).attr("url");
        	$('.layui-body').find('>div[tabId="' + tabId + '"]').load(url, function() {
        		layer.closeAll('loading');
				form.render();
			});
        } else if (key == "closeCurrent") {
        	$(this).find("i.layui-tab-close").click();
        } else if (key == "closeOthers") {
        	$(this).click();
        	$(this).parent().find('li[id!=' + tabId + '][id!=homePage]').remove();
        	$('.layui-body').find('>div[tabId!="' + tabId + '"][tabId!=homePage]').remove();
        } else if (key == "closeLeft") {
        	$(this).click();
        	$(this).prevAll("[id!=homePage]").remove();
        	$('.layui-body').find('>div[tabId="' + tabId + '"]').prevAll('[tabId!=homePage]').remove();
        } else if (key == "closeRight") {
        	$(this).click();
        	$(this).nextAll().remove();
        	$('.layui-body').find('>div[tabId="' + tabId + '"]').nextAll().remove();
        } else if (key == "closeAll") {
        	$(this).parent().find('#homePage').click();
        	$(this).parent().find('li[id!=homePage]').remove();
        	$('.layui-body').find('>div[tabId!="homePage"]').remove();
        }
    },
	build: function($trigger, e) {
		return {
			items: items
		};
	}
});

$('#lay_app_tabs div.layui-icon-prev').click(function() {
	var left = $(this).parent().find('#LAY_app_tabsheader').find('li:first-child').position().left;
	$(this).parent().find('#LAY_app_tabsheader').scrollLeft(-(left + 200));
	
});

$('#lay_app_tabs div.layui-icon-next').click(function() {
	var left = $(this).parent().find('#LAY_app_tabsheader').find('li:first-child').position().left;
	$(this).parent().find('#LAY_app_tabsheader').scrollLeft(Math.abs(left) + 200);
});

/*
 * 天气显示插件
 */
(function(T,h,i,n,k,P,a,g,e){g=function(){P=h.createElement(i);a=h.getElementsByTagName(i)[0];P.src=k;P.charset="utf-8";P.async=1;a.parentNode.insertBefore(P,a)};T["ThinkPageWeatherWidgetObject"]=n;T[n]||(T[n]=function(){(T[n].q=T[n].q||[]).push(arguments)});T[n].l=+new Date();if(T.attachEvent){T.attachEvent("onload",g)}else{T.addEventListener("load",g,false)}}(window,document,"script","tpwidget","//widget.seniverse.com/widget/chameleon.js"))	
tpwidget("init", {
    "flavor": "slim",
    "location": "WX4FBXXFKE4F",
    "geolocation": "enabled",
    "language": "zh-chs",
    "unit": "c",
    "theme": "chameleon",
    "container": "tp-weather-widget",
    "bubble": "enabled",
    "alarmType": "badge",
    "uid": "UEA46723FA",
    "hash": "9a37462ea3021daf84cfe1a005dd1231"
});
tpwidget("show");

function flexible(a) {
	if ($('.container').hasClass("container-shrink")) {
		$('.container').removeClass("container-shrink");
	} else {
		$('.container').addClass("container-shrink");
	}
}

function switchProject() {
	$('#projectListDialog-shadow').show();
	$('#projectListDialog').show();
}

function closeProjectListDialog() {
	$('#projectListDialog-shadow').hide();
	$('#projectListDialog').hide();
}

/*
 * 修改密码
 */
function modifyPwd() {
	layer.prompt({title: '请输入新密码', formType: 1}, function(pass, index) {
    	if (pass.length < 6) {
      		Dialog.warn('新密码长度不能小于6');
      		return;
    	}
    	if (!/[A-Z]/.test(pass)) {
      		Dialog.warn('新密码必须包含大写字母');
      		return;
    	}
	    if (!/[a-z]/.test(pass)) {
			Dialog.warn('新密码必须包含小写字母');
			return;
	    }
	    if (!/[0-9]/.test(pass)) {
			Dialog.warn('新密码必须包含数字');
			return;
	    }
	    $.post('user/modifyPwd?pwd=' + pass, {}, function(res) {
			rst = $.parseJSON(res);
			if (rst.statusCode == '200') {
				Dialog.success(rst.message);
			} else {
				Dialog.error(rst.message);
			}
			layer.close(index);
	    });
	});
}

