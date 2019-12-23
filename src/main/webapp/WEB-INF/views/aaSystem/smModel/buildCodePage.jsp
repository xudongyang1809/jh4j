<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<html>
<head>
<style type="text/css">
.divflag {
	display: none;
	font-size: 15px;
	padding-left: 10px;
}

.divflag span {
	color: green;
	font-weight: bolder;
}
</style>
<script type="text/javascript">
/*
 * 开始一键生成实体类、mapper文件、dao类、service类、controller类、jsp代码和添加菜单
 */
function startGenCode() {
	startGenEntityCode();
	startGenMapperCode();
	startGenDaoCode();
	startGenServiceCode();
	startGenControllerCode();
	startGenJspCode();
	startInitModule();
	Dialog.success("代码已全部生成,请刷新工程目录");
}

/*
 * 开始生成实体类代码
 */
function startGenEntityCode() {
	$("#entitypendding").show();
	$.post("${ctx}/smModel/genEntityCode/${id}",
	function(msg) {
		try {
			var result = JSON.parse(msg);
			if (result.statusCode != 200) {
				$("#entitycompleted").html("生成失败：" + result.message);
				$("#entitycompleted").css("color", "red");
			} else {
				$("#entityName").html(result.rel);
				Dialog.success("实体类代码已生成,请刷新工程目录");
			}
			$("#entitycompleted").show();
		} catch (e) {
			console.log(msg);
		}
	});
}

/*
 * 开始生成mapper文件代码
 */
function startGenMapperCode() {
	$("#mybatispendding").show();
	$.post("${ctx}/smModel/genMybatisMapper/${id}",
	function(msg) {
		try {
			var result = JSON.parse(msg);
			if (result.statusCode != 200) {
				$("#mybatiscompleted").html("生成失败：" + result.message);
				$("#mybatiscompleted").css("color", "red");
			} else {
				$("#mybatisName").html(result.rel);
				Dialog.success("mapper文件代码已生成,请刷新工程目录");
			}
			$("#mybatiscompleted").show();
		} catch (e) {
			console.log(msg);
		}
	});
}

/*
 * 开始生成dao类代码
 */
function startGenDaoCode() {
	$("#daopendding").show();
	$.post("${ctx}/smModel/genDaoCode/${id}",
	function(msg) {
		try {
			var result = JSON.parse(msg);
			if (result.statusCode != 200) {
				$("#daocompleted").html("生成失败：" + result.message);
				$("#daocompleted").css("color", "red");
			} else {
				$("#DaoName").html(result.rel);
				Dialog.success("Dao类已生成,请刷新工程目录");
			}
			$("#daocompleted").show();
		} catch (e) {
			console.log(msg);
		}
	});
}

/*
 * 生成service类代码
 */
function startGenServiceCode() {
	$("#Servicependding").show();
	$.post("${ctx}/smModel/genServiceCode/${id}",
	function(msg) {
		try {
			var result = JSON.parse(msg);
			if (result.statusCode != 200) {
				$("#Servicecompleted").html("生成失败：" + result.message);
				$("#Servicecompleted").css("color", "red");
			} else {
				$("#ServiceName").html(result.rel);
				Dialog.success("Service类已生成,请刷新工程目录");
			}
			$("#Servicecompleted").show();
		} catch (e) {
			console.log(msg);
		}
	});
}

/*
 * 生成控制类代码
 */
function startGenControllerCode() {
	$("#Controllerpendding").show();
	$.post("${ctx}/smModel/genControllerCode/${id}",
	function(msg) {
		try {
			var result = JSON.parse(msg);
			if (result.statusCode != 200) {
				$("#Controllercompleted").html("生成失败：" + result.message);
				$("#Controllercompleted").css("color", "red");
			} else {
				$("#ControllerName").html(result.rel);
				Dialog.success("Controller类已生成,请刷新工程目录");
			}
			$("#Controllercompleted").show();
		} catch (e) {
			console.log(msg);
		}
	});
}

/*
 * 生成jsp代码
 */
function startGenJspCode() {
	$("#Pagependding").show();
	$.post("${ctx}/smModel/genPageCode/${id}",
	function(msg) {
		try {
			var result = JSON.parse(msg);
			if (result.statusCode != 200) {
				$("#Pagecompleted").html("生成失败：" + result.message);
				$("#Pagecompleted").css("color", "red");
			} else {
				$("#PageName").html(result.rel);
				Dialog.success("Jsp页面已生成,请刷新工程目录");
			}
			$("#Pagecompleted").show();
		} catch (e) {
			console.log(msg);
		}
	});
}

/*
 * 初始化菜单并赋权
 */
function startInitModule() {
	$("#Modulependding").show();
	$.post("${ctx}/smModel/initModule/${id}",
	function(msg) {
		try {
			var result = JSON.parse(msg);
			if (result.statusCode != 200) {
				$("#Modulecompleted").html("生成失败-" + result.message);
				$("#Modulecompleted").css("color", "red");
				Dialog.error(result.message);
			} else {
				$("#Modulecompleted").html(result.message);
				Dialog.success("菜单已新建并赋予权限");
			}
			$("#Modulecompleted").show();
		} catch (e) {
			console.log(msg);
		}
	});
}
</script>
</head>
<body>
<div class="dialogContent" style="right: 20px;">
	<div class="row">
		<button type="button" class="build" onclick="startGenCode()">一键自动生成代码</button><br/>
		<button type="button" class="build" onclick="startGenEntityCode()">生成实体类</button>
		<button type="button" class="build" onclick="startGenMapperCode()">生成mapper文件</button>
		<button type="button" class="build" onclick="startGenDaoCode()">生成dao类</button>
		<button type="button" class="build" onclick="startGenServiceCode()">生成service类</button>
		<button type="button" class="build" onclick="startGenControllerCode()">生成controller类</button>
		<button type="button" class="build" onclick="startGenJspCode()">生成jsp页面</button>
		<button type="button" class="build" onclick="startInitModule()">生成并赋权菜单</button>
	</div>
	
	<br/>
	<div id="entitypendding" class="divflag" align="left">正在生成实体类......</div>
	<br/>
	<div id="entitycompleted" class="divflag" align="left">实体类<span id="entityName"></span>已生成</div>
	<br/>
	<div id="mybatispendding" class="divflag" align="left">正在生成Mybatis配置文件......</div>
	<br/>
	<div id="mybatiscompleted" class="divflag" align="left">mybatis配置文件<span id="mybatisName"></span>已生成</div>
	<br/>
	<div id="daopendding" class="divflag" align="left">正在生成Dao......</div>
	<br/>
	<div id="daocompleted" class="divflag" align="left">Dao类<span id="DaoName"></span>已生成</div>
	<br/>
	<div id="Servicependding" class="divflag" align="left">正在生成Service......</div>
	<br/>
	<div id="Servicecompleted" class="divflag" align="left">Service类<span id="ServiceName"></span>已生成</div>
	<br/>
	<div id="Controllerpendding" class="divflag" align="left">正在生成Controller......</div>
	<br/>
	<div id="Controllercompleted" class="divflag" align="left">Controller类<span id="ControllerName"></span>已生成</div>
	<br/>
	<div id="Pagependding" class="divflag" align="left">正在生成页面......</div>
	<br/>
	<div id="Pagecompleted" class="divflag" align="left"><div style="font-size: 15px;">页面</div><span id="PageName"></span>已生成</div>
	<br/>
	<div id="Modulependding" class="divflag" align="left">正在初始化组件......</div>
	<br/>
	<div id="Modulecompleted" class="divflag" align="left"><div style="font-size: 15px;">组件初始化成功，并已授予超级管理员以操作权限</div></div>
</div>
</body>
</html>