/**
 * 元素自定义属性
 */
var Attribute = {
		initUI: function() {
			/*
			 * 给单选挑选部门组件统一添加点击方法
			 */
			$('body').on("click", "*[onPickDept]", function (event) {
				Dialog.load();
				var functionName = $(this).attr("onPickDept");
				var tags = functionName.split(",");
				var urlParams = "";
				if (tags.length == 3) {
					urlParams = "singleFlag=true";
					if (tags[0] != '') {
						if ($('[id=' + tags[0] + ']').length == 0) {
							Dialog.warn("挑选部门Id回填值的dom对象不存在!");
							layer.closeAll("loading");
							return;
						} else if ($('[id=' + tags[0] + ']').length > 1) {
							Dialog.warn("挑选部门Id回填值的dom对象存在多个，请修改回填的dom的id值，保证唯一性!");
							layer.closeAll("loading");
							return;
						} else {
							urlParams += "&deptIdFilter=" + tags[0];
						}
					}
					if (tags[1] != '') {
						if ($('[id=' + tags[1] + ']').length == 0) {
							Dialog.warn("挑选部门编码回填值的dom对象不存在!");
							layer.closeAll("loading");
							return;
						} else if ($('[id=' + tags[1] + ']').length > 1) {
							Dialog.warn("挑选部门编码回填值的dom对象存在多个，请修改回填的dom的id值，保证唯一性!");
							layer.closeAll("loading");
							return;
						} else {
							urlParams += "&deptNoFilter=" + tags[1];
						}
					}
					if (tags[2] != '') {
						if ($('[id=' + tags[2] + ']').length == 0) {
							Dialog.warn("挑选部门名称回填值的dom对象不存在!");
							layer.closeAll("loading");
							return;
						} else if ($('[id=' + tags[2] + ']').length > 1) {
							Dialog.warn("挑选部门名称回填值的dom对象存在多个，请修改回填的dom的id值，保证唯一性!");
							layer.closeAll("loading");
							return;
						} else {
							urlParams += "&deptNameFilter=" + tags[2];
						}
					}
					$.post("department/selectDept?" + urlParams, function(msg) {
						layer.open({
							type: 1,
							area: ['300px', '500px'],
							title: "挑选单个组织机构",
							content: msg,
							success: function() {
								layer.closeAll("loading");
							}
						});
					});
				} else if (tags.length > 1 && tags.length != 3) {
					Dialog.warn("挑选部门数据回填值的参数数量必须是3个!");
					layer.closeAll("loading");
					return;
				} else {
					if ($.trim(functionName) == "" || typeof(eval(functionName)) != "function") {
						Dialog.warn("提供的回调方法不存在，请修改！");
						layer.closeAll("loading");
						return;
					} else {
						$.post("department/selectDept?singleFlag=true&callbackMethod=" + functionName, function(msg) {
							layer.open({
								type: 1,
								area: ['300px', '500px'],
								title: "挑选单个组织机构",
								content: msg,
								success: function() {
									layer.closeAll("loading");
								}
							});
						});
					}
				}
			});
			
			/*
			 * 给多选挑选部门组件统一添加点击方法
			 */
			$('body').on("click", "*[onPickDepts]", function (event) {
				Dialog.load();
				var functionName = $(this).attr("onPickDepts");
				var tags = functionName.split(",");
				var urlParams = "";
				if (tags.length == 3) {
					urlParams = "singleFlag=false";
					if (tags[0] != '') {
						if ($('[id=' + tags[0] + ']').length == 0) {
							Dialog.warn("挑选部门Id回填值的dom对象不存在!");
							layer.closeAll("loading");
							return;
						} else if ($('[id=' + tags[0] + ']').length > 1) {
							Dialog.warn("挑选部门Id回填值的dom对象存在多个，请修改回填的dom的id值，保证唯一性!");
							layer.closeAll("loading");
							return;
						} else {
							urlParams += "&deptIdFilter=" + tags[0];
						}
					}
					if (tags[1] != '') {
						if ($('[id=' + tags[1] + ']').length == 0) {
							Dialog.warn("挑选部门编码回填值的dom对象不存在!");
							layer.closeAll("loading");
							return;
						} else if ($('[id=' + tags[1] + ']').length > 1) {
							Dialog.warn("挑选部门编码回填值的dom对象存在多个，请修改回填的dom的id值，保证唯一性!");
							layer.closeAll("loading");
							return;
						} else {
							urlParams += "&deptNoFilter=" + tags[1];
						}
					}
					if (tags[2] != '') {
						if ($('[id=' + tags[2] + ']').length == 0) {
							Dialog.warn("挑选部门名称回填值的dom对象不存在!");
							layer.closeAll("loading");
							return;
						} else if ($('[id=' + tags[2] + ']').length > 1) {
							Dialog.warn("挑选部门名称回填值的dom对象存在多个，请修改回填的dom的id值，保证唯一性!");
							layer.closeAll("loading");
							return;
						} else {
							urlParams += "&deptNameFilter=" + tags[2];
						}
					}
					$.post("department/selectDept?" + urlParams, function(msg) {
						layer.open({
							type: 1,
							area: ["500px", "500px"],
							title: "挑选多个组织机构",
							content: msg,
							success: function() {
								layer.closeAll("loading");
							}
						});
					});
				} else if (tags.length > 1 && tags.length != 3) {
					Dialog.warn("挑选部门数据回填值的参数数量必须是3个!");
					layer.closeAll("loading");
					return;
				} else {
					if ($.trim(functionName) == "" || typeof(eval(functionName)) != "function") {
						Dialog.warn("提供的回调方法不存在，请修改！");
						layer.closeAll("loading");
						return;
					} else {
						$.post("department/selectDept?singleFlag=false&callbackMethod=" + functionName, function(msg) {
							layer.open({
								type: 1,
								area: ['500px', '500px'],
								title: "挑选多个组织机构",
								content: msg,
								success: function() {
									layer.closeAll("loading");
								}
							});
						});
					}
				}
			});
			
			/*
			 * 给单选挑选人员组件统一添加点击方法
			 */
			$('body').on("click", "*[onPickUser]", function (event) {
				Dialog.load();
				var functionName = $(this).attr("onPickUser");
				var tags = functionName.split(",");
				var urlParams = "";
				if (tags.length == 3) {
					urlParams = "singleFlag=true";
					if (tags[0] != '') {
						if ($('[id=' + tags[0] + ']').length == 0) {
							Dialog.warn("挑选人员Id回填值的dom对象不存在!");
							layer.closeAll("loading");
							return;
						} else if ($('[id=' + tags[0] + ']').length > 1) {
							Dialog.warn("挑选人员Id回填值的dom对象存在多个，请修改回填的dom的id值，保证唯一性!");
							layer.closeAll("loading");
							return;
						} else {
							urlParams += "&userIdFilter=" + tags[0];
						}
					}
					if (tags[1] != '') {
						if ($('[id=' + tags[1] + ']').length == 0) {
							Dialog.warn("挑选人员工号回填值的dom对象不存在!");
							layer.closeAll("loading");
							return;
						} else if ($('[id=' + tags[1] + ']').length > 1) {
							Dialog.warn("挑选人员工号回填值的dom对象存在多个，请修改回填的dom的id值，保证唯一性!");
							layer.closeAll("loading");
							return;
						} else {
							urlParams += "&userNoFilter=" + tags[1];
						}
					}
					if (tags[2] != '') {
						if ($('[id=' + tags[2] + ']').length == 0) {
							Dialog.warn("挑选人员姓名回填值的dom对象不存在!");
							layer.closeAll("loading");
							return;
						} else if ($('[id=' + tags[2] + ']').length > 1) {
							Dialog.warn("挑选人员姓名回填值的dom对象存在多个，请修改回填的dom的id值，保证唯一性!");
							layer.closeAll("loading");
							return;
						} else {
							urlParams += "&usernameFilter=" + tags[2];
						}
					}
					$.post("user/selectUser?" + urlParams, function(msg) {
						layer.open({
							id: 'selectUserDialog',
							type: 1,
							area: ['300px', '550px'],
							title: "挑选单个人员",
							content: msg,
							success: function() {
								layer.closeAll("loading");
							}
						});
					});
				} else if (tags.length > 1 && tags.length != 3) {
					Dialog.warn("挑选人员数据回填值的dom对象数量必须是3个!");
					layer.closeAll("loading");
					return;
				} else {
					if ($.trim(functionName) == "" || typeof(eval(functionName)) != "function") {
						Dialog.warn("提供的回调方法不存在，请修改！");
						layer.closeAll("loading");
					} else {
						$.post("user/selectUser?singleFlag=true&callbackMethod=" + functionName, function(msg) {
							layer.open({
								id: 'selectUserDialog',
								type: 1,
								area: ['300px', '550px'],
								title: "挑选单个人员",
								content: msg,
								success: function() {
									layer.closeAll("loading");
								}
							});
						});
					}
				}
			});
			
			/*
			 * 给多选挑选人员组件统一添加点击方法
			 */
			$('body').on("click", "*[onPickUsers]", function (event) {
				Dialog.load();
				var functionName = $(this).attr("onPickUsers");
				var tags = functionName.split(",");
				var urlParams = "";
				if (tags.length == 3) {
					urlParams = "singleFlag=false";
					if (tags[0] != '') {
						if ($('[id=' + tags[0] + ']').length == 0) {
							Dialog.warn("挑选人员Id回填值的dom对象不存在!");
							layer.closeAll("loading");
							return;
						} else if ($('[id=' + tags[0] + ']').length > 1) {
							Dialog.warn("挑选人员Id回填值的dom对象存在多个，请修改回填的dom的id值，保证唯一性!");
							layer.closeAll("loading");
							return;
						} else {
							urlParams += "&userIdFilter=" + tags[0];
						}
					}
					if (tags[1] != '') {
						if ($('[id=' + tags[1] + ']').length == 0) {
							Dialog.warn("挑选人员工号回填值的dom对象不存在!");
							layer.closeAll("loading");
							return;
						} else if ($('[id=' + tags[1] + ']').length > 1) {
							Dialog.warn("挑选人员工号回填值的dom对象存在多个，请修改回填的dom的id值，保证唯一性!");
							layer.closeAll("loading");
							return;
						} else {
							urlParams += "&userNoFilter=" + tags[1];
						}
					}
					if (tags[2] != '') {
						if ($('[id=' + tags[2] + ']').length == 0) {
							Dialog.warn("挑选人员姓名回填值的dom对象不存在!");
							layer.closeAll("loading");
							return;
						} else if ($('[id=' + tags[2] + ']').length > 1) {
							Dialog.warn("挑选人员姓名回填值的dom对象存在多个，请修改回填的dom的id值，保证唯一性!");
							layer.closeAll("loading");
							return;
						} else {
							urlParams += "&usernameFilter=" + tags[2];
						}
					}
					$.post("user/selectUser?" + urlParams, function(msg) {
						layer.open({
							id: 'selectUserDialog',
							type: 1,
							area: ['530px', '550px'],
							title: "挑选多个人员",
							content: msg,
							success: function() {
								layer.closeAll("loading");
							}
						});
					});
				} else if (tags.length > 1 && tags.length != 3) {
					Dialog.warn("挑选人员数据回填值的dom对象数量必须是3个!");
					layer.closeAll("loading");
					return;
				} else {
					if ($.trim(functionName) == "" || typeof(eval(functionName)) != "function") {
						Dialog.warn("提供的回调方法不存在，请修改！");
						layer.closeAll("loading");
					} else {
						$.post("user/selectUser?singleFlag=false&callbackMethod=" + functionName, function(msg) {
							layer.open({
								id: 'selectUserDialog',
								type: 1,
								area: ['530px', '550px'],
								title: "挑选多个人员",
								content: msg,
								success: function() {
									layer.closeAll("loading");
								}
							});
						});
					}
				}
			});
		}
}