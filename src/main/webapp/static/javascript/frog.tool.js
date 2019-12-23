/**
 * js脚本工具集
 * @author WangWeiWei_020463
 */
var Tool = {
	UUID: function () {
		var s = [];
		var hexDigits = "0123456789abcdef";
		for (var i = 0; i < 36; i++) {
			s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
		}
		s[14] = "4";
		s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);
		s[8] = s[13] = s[18] = s[23] = "-";
		var uuid = s.join("");
		return uuid;
	},
	
	/*
	 * 数字千位符格式化方法
	 * number是需要千位符格式化的数字
	 * n是保留的小数点位数，如果不传则默认传所有的小数位
	 * 比如：Tool.parseFormatNum('13400.2456', 2) 结果为：13,400.25
	 * 	    Tool.parseFormatNum('13400.2456') 结果为：13,400.2456
	 */
	parseFormatNum: function(number, n) { 
		if (n) {
			if (n != 0) {   
				n = (n > 0 && n <= 20) ? n : 2;  
			}
			number = parseFloat((number + "").replace(/[^\d\.-]/g,  "")).toFixed(n) + "";
		} else {
			number = parseFloat((number + "").replace(/[^\d\.-]/g,  "")) + "";
		}
		var sub_val  =  number.split(".")[0].split("").reverse();
		var sub_xs  =  number.split(".")[1];
		var show_html = "";
		for (i = 0; i < sub_val.length; i++) {
			show_html += sub_val[i] + ((i  +  1) % 3 == 0 && (i + 1) != sub_val.length ? "," : "");      
		}
		if (n == 0) {        
			return show_html.split("").reverse().join("");      
		} else {
			return show_html.split("").reverse().join("") + "." + sub_xs;      
		}
	}
}
