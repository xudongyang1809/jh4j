/**
 * ajax相关封装
 * @author WangWeiWei_020463
 * @date 2018-03-05 20:46:00
 */
var Ajax = {
	keyCode: {
		ENTER: 13, ESC: 27, END: 35, HOME: 36,
		SHIFT: 16, TAB: 9,
		LEFT: 37, RIGHT: 39, UP: 38, DOWN: 40,
		DELETE: 46, BACKSPACE: 8
	},
	statusCode: {ok: 200, failure: 300, error: 500, timeout: 301, unauthorized: 403, badRequest: 400},
	ajaxDone: function(json) {
		try {
			if (json.statusCode == Ajax.statusCode.error) {
				if (json.message) {
					Dialog.error(json.message);
				} else {
					Dialog.error("系统错误");
				}
			} else if (json.statusCode == Ajax.statusCode.timeout) {
				Dialog.warn(json.message);
				setTimeout(function() {
					location.reload();
				}, 2000);
			} else if (json.statusCode == Ajax.statusCode.failure) {
				if (json.message) {
					Dialog.error(json.message);
				} else {
					Dialog.error("请求操作失败");
				}
			} else if (json.statusCode == Ajax.statusCode.unauthorized) {
				if (json.message) {
					Dialog.error(json.message);
				} else {
					Dialog.error("您没有权限执行该动作");
				}
			} else if (json.statusCode == Ajax.statusCode.badRequest) {
				if (json.message) {
					Dialog.error(json.message);
				} else {
					Dialog.error("错误的请求,系统无法匹配参数");
				}
			} else {
				if (json.message) {
					Dialog.success(json.message);
				}
			};
		} catch (e) {
			console.log(json);
			Dialog.error(e.message);
		}
	},
	ajaxError: function(xhr, ajaxOptions, thrownError) {
		layer.closeAll("loading");
		if (xhr.responseText.search("19850e79-2aa1-485b-8a1a-45d2c291a442") != -1) {
			Dialog.error("请求路径不存在");
		} else if (xhr.responseText.search("23de2202-109e-4a73-ab62-da06c61c559b") != -1) {
			Dialog.error("系统错误");
		} else if (xhr.responseText.search("2e5fe2bf-752f-4b16-b499-5f2c76b463bb") != -1) {
			Dialog.error("您没有权限操作该动作");
		} else if (xhr.responseText.search("71ec7579-71ba-4888-bcf4-b0cbec5f91df") != -1) {
			Dialog.error("错误的请求，系统无法匹配参数");
		} else if (xhr.responseText.search("9dea8cd1-30a5-4087-b54e-65e16abf3080") != -1) {
			Dialog.error("登录状态失效，请重新登录", function() {
				$.post("preDialogLogin", function (content) {
					var layerOptions = {
						type: 1,
						id: 'loginDialog',
						title: '登录',
						area: ['450px', '350px'],
						maxmin: false,
						resize: false,
						closeBtn: 0,
						content: content,
						success: function(layero, index) {
							form.render();
						},
						cancel: function() {
							location.reload();
						}
					}
					var index = layer.open(layerOptions);
				});
			});
		} else {
			Dialog.error("<div>Http status: " + xhr.status + " " + xhr.statusText + "</div>" 
					+ "<div>ajaxOptions: " + ajaxOptions + "</div>"
					+ "<div>thrownError: " + thrownError + "</div>"
					+ "<div>" + xhr.responseText + "</div>");
		}
	},
	initUI:	function () {
		$('body').on("click", "a[target=ajaxTodo]", function (event) {
			var $this = $(this);
			var url =  "";
			if ($(event.target).parents(".layui-single-tab:first").length > 0) {
				url = unescape($this.attr("href")).replaceTmById($(event.target).parents(".layui-single-tab:first"));
			} else {
				url = unescape($this.attr("href")).replaceTmById($(event.target).parents(".layui-layer-page:first"));
			}
			var refreshContainer = $this.attr("refreshContainer");
			if (!url.isFinishedTm()) {
				Dialog.error("未选择一条数据，无法操作！");
				return false;
			}
			if (refreshContainer) {
				if ($(refreshContainer).length == 0) {
					Dialog.warn("指定刷新的容器不存在！");
					return false;
				} else if ($(refreshContainer).length > 1) {
					Dialog.warn("指定刷新的容器存在多个！");
					return false;
				}
			}
			var onBeforeAjaxName = $(this).attr("onBeforeAjax");
			if (onBeforeAjaxName != null && $.trim(onBeforeAjaxName) != "") {
				try {
					if (typeof(eval(onBeforeAjaxName)) == "function") {
						var onBeforeAjax = eval(onBeforeAjaxName);
						onBeforeAjax($(this));
					} else {
						Dialog.warn("执行前的回调方法名不是一个方法");
						return false;
					}
				} catch (e) {
					Dialog.warn("执行前的回调方法名不存在");
					return false;
				}
			}
			if ($this.attr("title") != null && $.trim($this.attr("title")) != "") {
				layer.confirm($this.attr("title"), {
					cancel: function() {
						layer.closeAll("loading");
					}
				},
				function (index) {
					layer.close(index);
					$.ajax({
						type: 'POST',
						url: url,
						dataType: "json",
						cache: false,
						success: function (json) {
							if (json.statusCode == Ajax.statusCode.ok) {
								if ("closeCurrent" == json.callbackType) {
									var dialogIndex = $this.parents('.layui-layer:first').attr("times");
									if (dialogIndex) {
										layer.close(dialogIndex);
									}
									var tabId = $this.parents('.layui-single-tab:first').attr("tabId");
									if (tabId) {
										$this.parents('.layui-single-tab:first').remove();
										$('#' + tabId).remove();
									}
								} else {
									if (refreshContainer) {
										reloadContainer(refreshContainer, true);
									} else {
										NavTab.reloadWithPagination();
									}
								}
							}
						},
						complete: function(json) {
							var result = json.responseJSON;
							if (result.statusCode == Ajax.statusCode.ok) {
								var onAfterAjaxName = $($this).attr("onAfterAjax");
								if (onAfterAjaxName != null && $.trim(onAfterAjaxName) != "") {
									if (typeof(eval(onAfterAjaxName)) == "function") {
										var onAfterAjax = eval(onAfterAjaxName);
										onAfterAjax($this);
									} else {
										Dialog.warn("提交后的执行方法不存在");
									}
								}
							}
							Ajax.ajaxDone(result);
							form.render();
						}
					});
				},
				function(index) {
					layer.closeAll('loading');
				});
			} else {
				$.ajax({
					type: 'POST',
					url: url,
					dataType: "json",
					cache: false,
					success: function (json) {
						if (json.statusCode == Ajax.statusCode.ok) {
							if ("closeCurrent" == json.callbackType) {
								var dialogIndex = $this.parents('.layui-layer:first').attr("times");
								if (dialogIndex) {
									layer.close(dialogIndex);
								}
								var tabId = $this.parents('.layui-single-tab:first').attr("tabId");
								if (tabId) {
									$this.parents('.layui-single-tab:first').remove();
									$('#' + tabId).remove();
								}
							} else {
								if (refreshContainer) {
									reloadContainer(refreshContainer, true);
								} else {
									NavTab.reloadWithPagination();
								}
							}
						}
					},
					complete: function(json) {
						var result = json.responseJSON;
						if (result.statusCode == Ajax.statusCode.ok) {
							var onAfterAjaxName = $($this).attr("onAfterAjax");
							if (onAfterAjaxName != null && $.trim(onAfterAjaxName) != "") {
								if (typeof(eval(onAfterAjaxName)) == "function") {
									var onAfterAjax = eval(onAfterAjaxName);
									onAfterAjax($this);
								} else {
									Dialog.warn("提交后的执行方法不存在");
								}
							}
						}
						Ajax.ajaxDone(result);
						form.render();
					}
				});
			}
			return false;
		});
	}
}

/*
 * 标签页ajax提交回调方法
 */
function navTabAjaxDone(submitForm, loadContainer) {
	if (validateForm(submitForm)) {
		var url = $(submitForm).attr("action");
		if (!url) {
			url = NavTab.getCurrentTab().attr("url");
		}
		if (loadContainer) {
			if ($(loadContainer).length == 0) {
				layer.close(loadingIndex);
				Dialog.warn("指定刷新的容器不存在！");
				return false;
			} else if ($(loadContainer).length > 1) {
				layer.close(loadingIndex);
				Dialog.warn("指定刷新的容器存在多个！");
				return false;
			}
		}
		if (loadContainer) {
			$(loadContainer, NavTab.getCurrentPanel()).load(url, $(submitForm).serializeArray(), function() {
				form.render();
			});
		} else {
			$(submitForm).parents(".layui-single-tab:first").load(url, $(submitForm).serializeArray(), function() {
				form.render();
			});
		}
	}
	return false;
}

/*
 * 标签页内查询的表单回调函数
 * 1.提交数据在回调函数里完成
 * 2.查询完数据并重载当前的标签页
 * @author WangWeiWei_020463
 */
function navTabSearch(submitForm, loadContainer) {
	if (validateForm(submitForm)) {
		var url = $(submitForm).attr("action");
		//这里做是否空的判断，如果查询的表单没有填写提交路径的话，则从当前标签页里获取请求路径
		if (!url) {
			url = NavTab.getCurrentTab().attr("url");
		}
		if (loadContainer) {
			if ($(loadContainer).length == 0) {
				Dialog.error("指定刷新的容器“" + loadContainer + "”不存在");
				return false;
			} else if ($(loadContainer).length > 1) {
				Dialog.error("指定刷新的容器“" + loadContainer + "”筛选后存在多个，无法操作！");
				return false;
			} else {
				$(loadContainer).load(url, $(submitForm).serializeArray(), function() {
					form.render();
				});
			}
		} else {
			var tabId = NavTab.getCurrentTab().prop("id");
			$('div[tabId="' + tabId + '"]').load(url, $(submitForm).serializeArray(), function() {
				form.render();
			});
		}
	}
	return false;
}

function dialogSearch(submitForm, loadContainer) {
	if (validateForm(submitForm)) {
		var url = $(submitForm).attr("action");
		//这里做是否空的判断，如果查询的表单没有填写提交路径的话，则从当前标签页里获取请求路径
		if (!url || url == "") {
			Dialog.error("未指定请求路径，无法操作！");
			return false;
		}
		if (loadContainer) {
			if ($(loadContainer).length == 0) {
				Dialog.error("指定刷新的容器“" + loadContainer + "”不存在");
				return false;
			} else if ($(loadContainer).length > 1) {
				Dialog.error("指定刷新的容器“" + loadContainer + "”筛选后存在多个，无法操作！");
				return false;
			} else {
				$(loadContainer).load(url, $(submitForm).serializeArray(), function() {
					form.render();
				});
			}
		} else {
			Dialog.getCurrentDialog().find('>.layui-layer-content').load(url, $(submitForm).serializeArray(), function() {
				form.render();
			});
		}
	}
	return false;
}

/**
 * 带文件上传的ajax表单提交
 * @param {Object} form
 * @param {Object} callback
 */
function iframeCallback(form, method, loadContainer){
	var $form = $(form);
	var $iframe = $("#callbackframe");
	if (validateForm(form)) {
		if ($iframe.size() == 0) {
			$iframe = $("<iframe id='callbackframe' name='callbackframe' src='about:blank' style='display:none'></iframe>").appendTo("body");
		}
		if(!form.ajax) {
			$form.append('<input type="hidden" name="ajax" value="1" />');
		}
		form.target = "callbackframe";
		_iframeResponse($iframe[0], method, loadContainer);
	}else {
		return false;
	}
}

function _iframeResponse(iframe, method, loadContainer){
	var $iframe = $(iframe), $document = $(document);
	
	$document.trigger("ajaxStart");
	
	$iframe.bind("load", function(event){
		$iframe.unbind("load");
		$document.trigger("ajaxStop");
		if (iframe.src == "javascript:'%3Chtml%3E%3C/html%3E';" || // For Safari
			iframe.src == "javascript:'<html></html>';") { // For FF, IE
			return;
		}
		var doc = iframe.contentDocument || iframe.document;
		// fixing Opera 9.26,10.00
		if (doc.readyState && doc.readyState != 'complete') return; 
		// fixing Opera 9.64
		if (doc.body && doc.body.innerHTML == "false") return;
		var response;
		if (doc.XMLDocument) {
			// response is a xml document Internet Explorer property
			response = doc.XMLDocument;
		} else if (doc.body){
			try{
				response = $iframe.contents().find("body").text();
				response = jQuery.parseJSON(response);
			} catch (e){ // response is html document or plain text
				response = doc.body.innerHTML;
			}
		} else {
			response = doc;
		}
		Ajax.ajaxDone(response);
		if (response.statusCode == Ajax.statusCode.ok) {
			if ("closeCurrent" == response.callbackType) {
				var dialogIndex = Dialog.getCurrentDialog().attr("times");
				layer.close(dialogIndex);
				if (method) {
					if (method == "create" || method == "insert") {
						if (loadContainer) {
							reloadContainer(loadContainer);
						} else {
							NavTab.reload(response.navTabId);
						}
					} else {
						if (loadContainer) {
							reloadContainer(loadContainer, true);
						} else {
							NavTab.reloadWithPagination(response.navTabId);
						}
					}
				} else {
					if (loadContainer) {
						reloadContainer(loadContainer, true);
					} else {
						NavTab.reloadWithPagination(response.navTabId);
					}
				}
			}
		}
	});
}

/*
 * 标签页内打开窗口，并执行完添加或编辑等操作之后，进行刷新当前的标签页
 * 1.其中添加和编辑操作完之后的回调刷新应该是不一样的，添加操作完之后应该刷新不保持当前分页状态的标签页，编辑操作完之后应该刷新保持当前分页状态的标签页
 * 2.所以在形参里加了一个参数method，标注这个回调是创建还是编辑操作
 * 3.loadContainer参数是指定刷新的容器
 * @author WangWeiWei_020463
 */
function dialogAjaxDone(submitForm, method, loadContainer) {
	if (validateForm(submitForm)) {
		var onBeforeSubmitName = $(submitForm).attr("onBeforeSubmit");
		try {
			if (onBeforeSubmitName != null && $.trim(onBeforeSubmitName) != "") {
				if (typeof(eval(onBeforeSubmitName)) == "function") {
					var onBeforeSubmit = eval(onBeforeSubmitName);
					onBeforeSubmit(submitForm);
				} else {
					Dialog.warn("提交前的执行方法不是一个方法");
					return;
				}
			}
		} catch (e) {
			Dialog.warn("提交前的执行方法名不存在");
			return false;
		}
		$.ajax({
			type: submitForm.method || 'POST',
			url: $(submitForm).attr("action"),
			data: $(submitForm).serializeArray(),
			dataType: "json",
			cache: false,
			success: function (json) {
				if (json.statusCode == Ajax.statusCode.ok) {
					if ("closeCurrent" == json.callbackType) {
						var dialogIndex = $(submitForm).parents('.layui-layer:first').attr("times");
						layer.close(dialogIndex);
						if (method) {
							if (method == "create" || method == "insert") {
								if (loadContainer) {
									reloadContainer(loadContainer, false);
								} else {
									NavTab.reload(json.navTabId);
								}
							} else {
								if (loadContainer) {
									reloadContainer(loadContainer, true);
								} else {
									NavTab.reloadWithPagination(json.navTabId);
								}
							}
						} else {
							if (loadContainer) {
								reloadContainer(loadContainer, true);
							} else {
								NavTab.reloadWithPagination(json.navTabId);
							}
						}
					}
				}
			},
			complete: function(json) {
				var result = json.responseJSON;
				if (result.statusCode == Ajax.statusCode.ok) {
					var onAfterSubmitName = $(submitForm).attr("onAfterSubmit");
					try {
						if (onAfterSubmitName != null && $.trim(onAfterSubmitName) != "") {
							if (typeof(eval(onAfterSubmitName)) == "function") {
								var onAfterSubmit = eval(onAfterSubmitName);
								onAfterSubmit(submitForm);
							} else {
								Dialog.warn("提交后的执行方法不存在");
							}
						}
					} catch (e) {
						Dialog.warn("提交后的回调方法名不存在");
					}
				}
				Ajax.ajaxDone(result);
			}
		});
	}
	return false;
}

/*
 * @desc 局部加载或刷新容器
 * 		 参数filter：定位信息，可填#abc || .abc 等 jquery式的筛选格式
 * 			isPagination：是否带分页式的刷新
 * @author WangWeiWei_020463
 * */
function reloadContainer(filter, isPagination) {
	if (filter) {
		if (isPagination) {
			var url = $(filter).find('#pagerForm').attr("action");
			if (url != null && url != '') {
				$(filter).load(url, $(filter).find('#pagerForm').serializeArray());
			} else {
				Dialog.warn("没有用作刷新的请求路径信息");
			}
		} else {
			var url = $(filter).attr("url");
			if (url != null && url != '') {
				$(filter).load(url);
			} else {
				Dialog.warn("没有用作刷新的请求路径信息");
			}
		}
	} else {
		Dialog.warn("没有指定刷新的容器");
	}
}

/*
 * layui自带的被动表单验证改装过来，可以进行手动验证表单了
 * @author WangWeiWei_020463
 */
function validateForm(submitForm) {
	var verify = form.config.verify;
	var dangerClassName = "layui-form-danger";
	var elements = $(submitForm).find("*[lay-verify]");
	var n = layui.device();
	var s = null;
	if (layui.each(elements, function(e, l) {
		var element = $(this);
		var	verifyRules = element.attr("lay-verify").split("|");
		var	verType = element.attr("lay-verType");
		var	value = element.val();
		if (element.removeClass(dangerClassName), layui.each(verifyRules, function(e, t) {
				var verifyRules;
				var alertMsg = "";
				var isFunction = "function" == typeof verify[t];
				if (verify[t]) {
					if (t != "required") {
						if (value != "") {
							var verifyRules = isFunction ? alertMsg = verify[t](value, l) : !verify[t][0].test(value);
							if (alertMsg = alertMsg || verify[t][1], verifyRules) {
								return "tips" === verType ? layer.tips(alertMsg, function() {
									return "string" == typeof element.attr("lay-ignore") || "select" !== l.tagName.toLowerCase() && !/^checkbox|radio$/.test(l.type) ? element : element.next()
								}(), {
									tips: 1
								}) : "alert" === verType ? layer.alert(alertMsg, {
									title: "提示",
									shadeClose: !0
								}) : layer.msg(alertMsg, {
									icon: 5,
									shift: 6
								}), 
								n.android || n.ios || l.focus(), 
								element.addClass(dangerClassName), 
								s = !0
							}
						}
					} else {
						var verifyRules = isFunction ? alertMsg = verify[t](value, l) : !verify[t][0].test(value);
						if (alertMsg = alertMsg || verify[t][1], verifyRules) {
							return "tips" === verType ? layer.tips(alertMsg, function() {
								return "string" == typeof element.attr("lay-ignore") || "select" !== l.tagName.toLowerCase() && !/^checkbox|radio$/.test(l.type) ? element : element.next()
							}(), {
								tips: 1
							}) : "alert" === verType ? layer.alert(alertMsg, {
								title: "提示",
								shadeClose: !0
							}) : layer.msg(alertMsg, {
								icon: 5,
								shift: 6
							}), 
							n.android || n.ios || l.focus(), 
							element.addClass(dangerClassName), 
							s = !0
						}
					}
				}
			}), s) {
			return s
		}
	}), s) {
		return !1;
	} else {
		return true;
	}
}


/**
 * 普通ajax表单提交
 * @param submitForm
 * @param callback
 */
function validateCallback(submitForm, callback) {
	if (validateForm(submitForm)) {
		$.ajax({
			type: submitForm.method || 'POST',
			url: $(submitForm).attr("action"),
			data:$(submitForm).serializeArray(),
			dataType:"json",
			cache: false,
			success: callback,
			error: function(e){console.log(e);Dialog.warn("提交失败");}
		});
	}
	return false;
}
