/**
 * 表单脚本组件
 */
var FormObject = {
	init: function() {
		form.verify({
		  	/*
		  	 * 字母校验，要求输入字符串必须由字母组成
		  	 */
		  	letter: [/^[a-zA-Z]+$/, '输入内容必须是字母组成']
		});
		form.verify({
		  	/*
		  	 * 字母校验，要求输入字符串必须由字母组成
		  	 */
			file: function(value, item){ //value：表单的值、item：表单的DOM对象
			    if (value == "") {
			    	$(item).next().find('.queueList').addClass("warn");
			    	setTimeout(function() {
			    		$(item).next().find('.queueList').removeClass("warn");
			    	}, 3000);
			    	return '上传文件不能为空';
			    }
			}
		});
	}
}
