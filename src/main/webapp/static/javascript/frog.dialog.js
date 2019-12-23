/**
 * 弹窗封装方法
 * @author WangWeiWei_020463
 * @date 2018-03-01 19:41:41
 */
var Dialog = {
	defaultOptions: {
		height: "500",
		width: "500",
		minHeight: 40,
		minWidth: 50,
		title: "[弹窗名称未定义]",
		offset: 'auto',
		dialogId: '',
		max: 0,
		shade: 0.3,
		maxmin: true,
		resize: true,
		type: 1
	},
	
	/* 当前打开的窗口的Index值 */
	currentDialogIndex: null,
	
	/*
	 * 初始化按钮点击事件，开发人员只需要在a标签上设置相关属性就能实现点击弹窗事件 
	 */
	initUI:	function () {
		$('body').on("click", "a[target=dialog]", function (event) {
			var loadingIndex = Dialog.load();
			var $this = $(this);
			var title = $this.attr("title") || $this.text();
			var dialogId = $this.attr("dialogId") || '';
			var zIndex = $this.attr("zIndex");
			var options = {};
			var w = $this.attr("width");
			var h = $this.attr("height");
			if (w) options.width = w;
			if (h) options.height = h;
			options.title = title;
			options.dialogId = dialogId;
			options.offset = $this.attr("offset");
			options.max = eval($this.attr("max") || "false") ? 1 : 0;
			options.shade = $this.attr("shade");
			options.maxmin = eval($this.attr("maxmin") || "true");
			options.resize = eval($this.attr("resize") || "true");
			if ($this.attr("closeCallback")) {
				options.closeCallback = eval($this.attr("closeCallback"));
			}
			if (zIndex != null && zIndex.isInteger()) {
				options.zIndex = zIndex;
			}
			var url =  "";
			if ($(event.target).parents(".layui-single-tab:first").length > 0) {
				url = unescape($this.attr("href")).replaceTmById($(event.target).parents(".layui-single-tab:first"));
			} else {
				url = unescape($this.attr("href")).replaceTmById($(event.target).parents(".layui-layer-page:first"));
			}
			if (!url.isFinishedTm()) {
				Dialog.warn("未选择一条数据，无法操作！");
				layer.close(loadingIndex);
				return false;
			}
			if ($this.attr("onBeforeOpen") && $this.attr("onBeforeOpen") != "") {
				var methodName = eval($this.attr("onBeforeOpen"));
				try {
					if (methodName != null && $.trim(methodName) != "") {
						if (typeof(eval(methodName)) == "function") {
							var onBeforeOpen = eval(methodName);
							var $parent = $(event.target).parents(".layui-single-tab:first");
							var href = $this.attr("href");
							if (href.match(RegExp("({[A-Za-z_]+[A-Za-z0-9_]*})", "g")) == null) {
								if (!onBeforeOpen()) {
									layer.close(loadingIndex);
									return false;
								}
							} else {
								var beforeOpenExecuteResult = true;
								href.replace(RegExp("({[A-Za-z_]+[A-Za-z0-9_]*})", "g"),
								function($1) {
									var $input = $parent.find("#" + $1.replace(/[{}]+/g, ""));
									if (!onBeforeOpen($input.parents('.frog-table').find("tbody tr.selected"))) {
										beforeOpenExecuteResult = false;
									}
								});
								if (!beforeOpenExecuteResult) {
									layer.close(loadingIndex);
									return false;
								}
							}
						} else {
							layer.closeAll('loading');
							Dialog.warn("提交后的执行方法不存在");
							return false;
						}
					}
				} catch (e) {
					layer.closeAll('loading');
					Dialog.warn("提交后的回调方法名不存在");
					return false;
				}
			}
			Dialog.open(url, {}, options);
			return false;
		});
		$('body').on("click", "a[target=iframeDialog]", function (event) {
			var loadingIndex = Dialog.load();
			var $this = $(this);
			var title = $this.attr("title") || $this.text();
			var dialogId = $this.attr("dialogId") || '';
			var options = {};
			var w = $this.attr("width");
			var h = $this.attr("height");
			if (w) options.width = w;
			if (h) options.height = h;
			options.title = title;
			options.dialogId = dialogId;
			options.offset = $this.attr("offset");
			options.max = eval($this.attr("max") || "false") ? 1 : 0;
			options.shade = $this.attr("shade");
			options.maxmin = eval($this.attr("maxmin") || "true");
			options.resize = eval($this.attr("resize") || "true");
			options.type = 2;
			var url = unescape($this.attr("href")).replaceTmById($(event.target).parents(".layui-single-tab:first"));
			if (!url.isFinishedTm()) {
				Dialog.warn("未选择一条数据，无法操作！");
				layer.close(loadingIndex);
				return false;
			}
			Dialog.open(url, {}, options);
			return false;
		});
	},
	
	/* 打开页面层弹窗(div弹窗，非iframe)方法 */
	open: function (url, data, options) {
		var dialogOptions = $.extend({}, Dialog.defaultOptions, options);
		if (dialogOptions.width.endsWith("px")) {
			if (!dialogOptions.width.substring(0, dialogOptions.width.indexOf("px")).isInteger()) {
				Dialog.warn("弹窗宽度值不合法");
				return;
			}
		} else {
			if (!dialogOptions.width.isInteger()) {
				Dialog.warn("弹窗宽度值不合法");
				return;
			}
		}
		if (dialogOptions.height.endsWith("px")) {
			if (!dialogOptions.height.substring(0, dialogOptions.height.indexOf("px")).isInteger()) {
				Dialog.warn("弹窗高度值不合法");
				return;
			}
		} else {
			if (!dialogOptions.height.isInteger()) {
				Dialog.warn("弹窗高度值不合法");
				return;
			}
		}
		dialogOptions.width = dialogOptions.width.endsWith("px") ? dialogOptions.width : (dialogOptions.width + 'px');
		dialogOptions.height = dialogOptions.height.endsWith("px") ? dialogOptions.height : (dialogOptions.height + 'px');
		if (dialogOptions.type == 1) {
			$.post(url, data, function (content) {
				var layerOptions = {
					type: 1,
					id: dialogOptions.dialogId,
					title: dialogOptions.title,
					area: [dialogOptions.width, dialogOptions.height],
					offset: dialogOptions.offset.indexOf(",") > -1 ? [dialogOptions.offset.split(",")[0], dialogOptions.offset.split(",")[1]] : dialogOptions.offset,
					shade: dialogOptions.shade,
					maxmin: dialogOptions.maxmin,
					resize: dialogOptions.resize,
					content: content,
					success: function(layero, index) {
						form.render();
						layer.closeAll('loading');
					},
					cancel: function() {
						if (typeof(dialogOptions.closeCallback) == "function") {
							var method = dialogOptions.closeCallback;
							method();
						}
					}
				}
				if (dialogOptions.zIndex != null) {
					layerOptions.zIndex = dialogOptions.zIndex;
				}
				var index = layer.open(layerOptions);
				if (options.max == 1) {
					layer.full(index);
				}
			});
		} else if (dialogOptions.type == 2) {
			var index = layer.open({
				type: dialogOptions.type,
				id: dialogOptions.dialogId,
				title: dialogOptions.title,
				area: [dialogOptions.width, dialogOptions.height],
				offset: dialogOptions.offset.indexOf(",") > -1 ? [dialogOptions.offset.split(",")[0], dialogOptions.offset.split(",")[1]] : dialogOptions.offset,
				shade: dialogOptions.shade,
				maxmin: dialogOptions.maxmin,
				resize: dialogOptions.resize,
				content: url
			});
			if (options.max == 1) {
				layer.full(index);
			}
		}
	},
	
	getCurrentDialog: function() {
		var lastestDialogIndex = 0;
		$('.layui-layer-page').each(function(){
			if ($(this).attr("times") > lastestDialogIndex) {
				lastestDialogIndex = $(this).attr("times");
			}
		});
		return $('#layui-layer' + lastestDialogIndex);
	},
	
	/* 普通信息弹窗 */
	info: function (message) {
		layer.msg(message);     
	},
	
	/* 静态弹窗 */
	warn: function (message) {
		layer.alert(message, {icon: 7, title: false, btn: ["知道了"], btnAlign: 'c', closeBtn: 0});
	},
	
	/* 错误信息弹窗 */
	error: function (message, func) {
		layer.alert(message, {
			icon: 2, 
			title: false, 
			btn: ["知道了"], 
			btnAlign: 'c', 
			closeBtn: 0, 
			yes: function(index, layero) {
				layer.close(index);
				if (func) {
					func();
				}
			}
		});
	},
	
	/* 失败信息弹窗 */
	fail: function (message) {
		layer.alert(message, {icon: 5, title: false, btn: ["知道了"], btnAlign: 'c', closeBtn: 0});
	},
	
	/* 成功信息弹窗 */
	success: function (message) {
		layer.msg(message, {icon: 6});
	},
	
	/* 关闭弹窗 */
	close: function (dialogId) {
		var layerIndex = $('#' + dialogId).parents('.layui-layer').attr("times");
		layer.close(layerIndex);
	},
	
	/**
	 * 加载动画
	 * seconds单位是“秒”
	 */
	load: function (seconds) {
		if (seconds != null) {
			if (seconds.isInteger()) {
				if (seconds <= 0) {
					seconds = 3600;
				}
			} else {
				seconds = 3600;
			}
		} else {
			seconds = 3600;
		}
		var index = layer.load(2, {time: seconds * 1000});
		return index;
	},
	
	//支持post传参的window.open
	openPostWindow: function(url, data, name, features) {
		var tempForm = $("<form></form>");
		var formId = Tool.UUID();
		tempForm.attr("id", formId);
		tempForm.attr("style", "display: none");
		tempForm.attr("target", name);
		tempForm.attr("method", "post");
		tempForm.attr("action", url);
		for (var key in data) {
			var input1 = $("<input>");
			input1.attr("type", "hidden");
			input1.attr("name", key);
			input1.attr("value", data[key]);
			tempForm.append(input1);
		}
		tempForm.on("submit",
		function() {
			Dialog.openWindow(url, name, features);
		});
		tempForm.trigger("submit");
		$("body").append(tempForm); //将表单放置在web中
		tempForm.submit();
		$("#" + formId).remove();
	},

	openWindow: function(url, name, features)  {  
		window.open(url, name, features);  
	}
}