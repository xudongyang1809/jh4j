/**
 * 核心方法
 * @author WangWeiWei_020463
 * @date 2018-03-01 20:01:00
 */
(function($) {
	/* 扩展String的方法 */
	$.extend(String.prototype, {
		/*
		 * 判断是否正整数
		 */
		isPositiveInteger: function() {
			return (new RegExp(/^[1-9]\d*$/).test(this));
		},
		/*
		 * 判断是否整数
		 */
		isInteger: function() {
			return (new RegExp(/^\d+$/).test(this));
		},
		/*
		 * 判断是否是数字机
		 */
		isNumber: function(value, element) {
			return (new RegExp(/^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/).test(this));
		},
		/*
		 * 去掉前尾空格，可用$.trim替代
		 */
		trim: function() {
			return this.replace(/(^\s*)|(\s*$)|\r|\n/g, "");
		},
		startsWith: function(pattern) {
			return this.indexOf(pattern) === 0;
		},
		endsWith: function(pattern) {
			var d = this.length - pattern.length;
			return d >= 0 && this.lastIndexOf(pattern) === d;
		},
		replaceSuffix: function(index) {
			return this.replace(/\[[0-9]+\]/, '[' + index + ']').replace('#index#', index);
		},
		trans: function() {
			return this.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '"');
		},
		encodeTXT: function() {
			return (this).replaceAll('&', '&amp;').replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp;");
		},
		replaceAll: function(os, ns) {
			return this.replace(new RegExp(os, "gm"), ns);
		},
		replaceTm: function($data) {
			if (!$data) return this;
			return this.replace(RegExp("({[A-Za-z_]+[A-Za-z0-9_]*})", "g"),
			function($1) {
				return $data[$1.replace(/[{}]+/g, "")];
			});
		},
		replaceTmById: function(_box) {
			var $parent = _box || $(document);
			return this.replace(RegExp("({[A-Za-z_]+[A-Za-z0-9_]*})", "g"),
			function($1) {
				var $input = $parent.find("#" + $1.replace(/[{}]+/g, ""));
				return $input.val() ? $input.val() : $1;
			});
		},
		/* 判断字符串里是否符合只包含字母和数字的条件 */
		isFinishedTm: function() {
			return ! (new RegExp("{[A-Za-z_]+[A-Za-z0-9_]*}").test(this));
		},
		skipChar: function(ch) {
			if (!this || this.length === 0) {
				return '';
			}
			if (this.charAt(0) === ch) {
				return this.substring(1).skipChar(ch);
			}
			return this;
		},
		isValidPwd: function() {
			return (new RegExp(/^([_]|[a-zA-Z0-9]){6,32}$/).test(this));
		},
		isValidMail: function() {
			return (new RegExp(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/).test(this.trim()));
		},
		isSpaces: function() {
			for (var i = 0; i < this.length; i += 1) {
				var ch = this.charAt(i);
				if (ch != ' ' && ch != "\n" && ch != "\t" && ch != "\r") {
					return false;
				}
			}
			return true;
		},
		isPhone: function() {
			return (new RegExp(/(^([0-9]{3,4}[-])?\d{3,8}(-\d{1,6})?$)|(^\([0-9]{3,4}\)\d{3,8}(\(\d{1,6}\))?$)|(^\d{3,8}$)/).test(this));
		},
		isUrl: function() {
			return (new RegExp(/^[a-zA-z]+:\/\/([a-zA-Z0-9\-\.]+)([-\w .\/?%&=:]*)$/).test(this));
		},
		isExternalUrl: function() {
			return this.isUrl() && this.indexOf("://" + document.domain) == -1;
		}
	});
})(jQuery);