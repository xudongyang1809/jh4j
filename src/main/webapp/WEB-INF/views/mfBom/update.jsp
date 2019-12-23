<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 编辑画面
	 @author 超级管理员 admin
	 @date 2019-04-29 11:10:45
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<div id="mfBomId">
<head>
<script type="text/javascript">
	/*批量选择*/
	form.on('checkbox(checkAllMfBom)', function(data) {
		if ($(data.elem).hasClass("checkAllMfBom")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});

	function createRows() {
		debugger;
		var index = $("tbody[name='mfBom_table_tbody']").find("tr").length;
		var num = $("#rowsValue").val() || 1;
		for (var n=0; n<num; n++){
			debugger;
			var html='<tr target="" rel="" id="">'
					/*+'<td><input type="checkbox" lay-skin="primary" class="checkAllMfBom" lay-filter="checkAllMfBom"></td>'*/
					+'<td><input type="checkbox" lay-skin="primary"><input style="display: none" id="mfBomId21212" value="${mfBom.id}"></td>'
					+'<td><input name="plist['+index+'].strProdMatrlNo" readonly class="layui-input" style="text-align:center" autocomplete="off" type="text" id="strProdMatrlNo"></td>'
					+'<td><input lay-verify="required" name="plist[\'+index+\'].strMatrlNo" id="strMatrlNo" type="text" style="text-align:center" class="layui-input" readonly />'
						+'<a class="layui-btn layui-btn-sm"  href="${ctx}/mfBom/selectcmMatrinfoDetail?strMatrlNo=strMatrlNo" title="编号挑选"  target="dialog" dialogId="selectMfBomMatrinfoDetailId001" width="800" height="550"  style="position: absolute; top: 4px; right: 4px; bottom: 0px;">'
						+'<i class="layui-icon layui-icon-search"></i></a></td>'
					+'<td><input name="plist['+index+'].strMatrlName" class="layui-input" style="text-align:center" autocomplete="off" type="text" id="strMatrlName01" name="strMatrlName" readonly ></td>'
					+'<td><input name="plist['+index+'].strBrand" class="layui-input" style="text-align:center" autocomplete="off" type="text" id="strBrand" name="strBrand" readonly ></td>'
					+'<td><input name="plist['+index+'].strUnit" class="layui-input" style="text-align:center" autocomplete="off" type="text" id="strUnit" name="strUnit" readonly></td>'
					+'<td><input name="plist['+index+'].strSpec" class="layui-input" style="text-align:center" autocomplete="off" type="text" id="strSpec" name="strSpec" readonly ></td>'
					+'<td><input name="plist['+index+'].bdMatrlQty" class="layui-input" style="text-align:center;width:100px" autocomplete="off" type="text" id="bdMatrlQty" name="bdMatrlQty" lay-verify="required"></td>'
					+'<td><input name="plist['+index+'].bdItemPurPrice" class="layui-input" style="text-align:center;width:100px" autocomplete="off" type="text" id="bdItemPurPrice" name="bdItemPurPrice" lay-verify="required"></td>'
					+'<td><a class="delete" style="text-align:center"  onclick="deleteMfBomRow(this)">删除</a></td>'
					'+</tr>';
			index++;
			$("tbody[name='mfBom_table_tbody']").append(html);
			form.render('checkbox');
		}
	}
	/*function openSaleMatrlNo(obj){
		var bb = document.getElementsByName("ids");
		var check=$(obj).parents("td").parents("tr").find('input[type="checkbox"]').prop('checked');//判断当前行有未被选中，未选中false
		for ( var j = 0; j < bb.length; j++) {
			var dname ='plist['+(j+1)+'].strOldSaleMatrlNo';
			$("input[name='"+dname+"']").parents("tr").find('input[type="checkbox"]').prop("checked", false);
			$("input[name='"+dname+"']").parents("tr").removeClass("selected");
		}
		console.log($(obj).parents("td").parents("tr").find('input[type="checkbox"]').prop('checked'));
		var aa = $(obj).parent("td").parent("tr.selected").length;
		if(aa==0){
			//alert("您没有勾选操作内容！");
			var a= $(obj).parents("td").parents("tr");
			$(obj).parents("td").parents("tr").find('input[type="checkbox"]').prop("checked", true);
			$(obj).parents("td").parents("tr").addClass("selected");
		}
	}*/

	//删除
	function deleteMfBomRow(id){
		debugger;
		//alert(id);
		if(id == null || id == ''){
			$(id).parent().parent().remove();
		}else{
			var cmMatrinfoDetailId = $('#cmMatrinfoDetailId').val();
			$.ajax({
				url:"${ctx}/mfBom/delete?id="+id,
				dataType:'json',
				success:function (rst) {
					if (rst.statusCode == '200') {
						top.layer.msg(rst.message,{icon:1});
						$('#mfBomId').load("${ctx}/mfBom/preUpdate?id="+cmMatrinfoDetailId,{},function () {});
					}else{
						top.layer.msg(rst.message,{icon:2});
					}
				}
			});
		}
	}//children.children(("tr:first").attr("rel"))
	function saveMfBom(){
		debugger;
		var btbedit = document.getElementsByName("check_HW090");
		var trId;
		var j=0;
		for ( var i = 0; i < btbedit.length; i++) {
			if (btbedit.item(i).checked) {
				j=j+1;
				debugger;
				var tr = btbedit.item(i).parentNode.parentNode;
				trId = $(tr).attr("rel");
				//var strStatu = btbedit.item(i).parentNode.parentNode.cells[19].textContent;
			}
		}

		var cmMatrinfoDetailId = $('#cmMatrinfoDetailId').val();
		var strProdMatrlNo = $('#strProdMatrlNo005').val();
		var strMatrlNo = $('#strMatrlNo').val();
		var strMatrlName = $('#strMatrlName01').val();
		var strBrand = $('#strBrand').val();
		var strUnit = $('#strUnit').val();
		var strSpec = $('#strSpec').val();
		var bdMatrlQty = $('#bdMatrlQty').val();
		if (!bdMatrlQty){
			Dialog.warn("原料数量不能为空",{icon:2});
			return;
		}
		var bdItemPurPrice = $('#bdItemPurPrice').val();
		if (!bdItemPurPrice){
			Dialog.warn("原料单价不能为空",{icon:2});
			return;
		}
		 // if (validateForm($('#bomForm001'))){
			$.ajax({
				url:"${ctx}/mfBom/save?strProdMatrlNo="+strProdMatrlNo+"&strMatrlNo="+strMatrlNo+"&strMatrlName="+strMatrlName+"&strBrand="+strBrand+"&strUnit="+strUnit+"&strSpec="+strSpec+"&mfBomId="+trId+"&bdMatrlQty="+bdMatrlQty+"&bdItemPurPrice="+bdItemPurPrice,
				dataType:'json',
				success:function (rst) {
					if (rst.statusCode == '200') {
						top.layer.msg(rst.message, {icon:1});
						$('#mfBomId').load("${ctx}/mfBom/preUpdate?id="+cmMatrinfoDetailId,{},function () {});
					}else{
						top.layer.msg(rst.message,{icon:2});
					}
				}
			});
		 // }
	}
	//编辑
	function editMfBomRow(obj){
		debugger;
		var btnedit = document.getElementsByName("btnedit");
		var tr = obj.parentNode.parentNode;
		var Id = $(tr).attr("rel");//获取id
		//alert(Id);
		var trid = tr.rowIndex;
		// btnedit[trid].disabled = true;
		var size = obj.parentNode.parentNode.cells.length;
		var hiddeninput = "<input type='hidden' value='"+Id+"' name = 'plist["+trid+"]' />";
		for (var i=2; i<size-1; i++) {
			var tempTd = tr.cells[i];
			var tdText = tempTd.innerText;
			var name = "";
			switch (i) {
				case 2 :
					name = "plist["+trid+"].strMatrlNo";
			}
			if(i==2){
				tempTd.innerHTML = "<input type='text' class=\"layui-input\" value='"+tdText+"' size='10' name=\"plist['+index+'].strMatrlNo\" id=\"strMatrlNo\"/>"
						+ "<a class=\"layui-btn layui-btn-sm\"  href=\"${ctx}/mfBom/selectcmMatrinfoDetail?strMatrlNo=strMatrlNo\" title=\"编号挑选\"  target=\"dialog\" dialogId=\"selectMfBomMatrinfoDetailId001\" width=\"800\" height=\"550\"  style=\"position: absolute; top: 4px; right: 4px; bottom: 0px;\">"
						+ "<i class=\"layui-icon layui-icon-search\"></i></a>"
						+ hiddeninput;//也可以使用empty()
			}else if(i==3){
				tempTd.innerHTML = "<input type='text' readonly style=\"text-align:center\" class=\"layui-input\" value='"+tdText+"' size='10' id=\"strMatrlName01\" name=\"strMatrlName\" />";
			}else if(i==4) {
				tempTd.innerHTML = "<input type='text' readonly style=\"text-align:center\" class=\"layui-input\" value='"+tdText+"' size='10' id=\"strBrand\" name=\"strBrand\" />";
			}else if(i==5){
				tempTd.innerHTML = "<input type='text' readonly style=\"text-align:center\" class=\"layui-input\" value='"+tdText+"' size='10' id=\"strUnit\" name=\"strUnit\" />";
			}else if(i==6){
				tempTd.innerHTML = "<input type='text' readonly style=\"text-align:center\" class=\"layui-input\" value='"+tdText+"' size='10' id=\"strSpec\" name=\"strSpec\"/>";
			}else if(i==7){
				tempTd.innerHTML = "<input type='text' style='text-align:center;width:100px' class=\"layui-input\" value='"+tdText+"' size='10' id=\"bdMatrlQty\" name=\"bdMatrlQty\"/>"
			}else{
				tempTd.innerHTML = "<input type='text' style='text-align:center;width:100px' class=\"layui-input\" value='"+tdText+"' size='10' id=\"bdItemPurPrice\" name=\"bdItemPurPrice\"/>"
			}
		}
	}
</script>
</head>
<form id="bomForm001" class="layui-form" method="post" action="${ctx}/mfBom/save" onsubmit="return dialogAjaxDone(this, 'update')">
	<input type="hidden" id="relativedId" name="id" value="${mfBom.id}">
	<input type="hidden" id="strProdMatrlNo005" value="${cmMatrinfoDetail.strSn}">
	<input type="hidden" id="cmMatrinfoDetailId" value="${cmMatrinfoDetailId}">
	<div class="layui-form-item"></div>
	<%--<div class="">
		<legend style="font-size: 20px;font-family: Consolas">存货编号:${cmMatrinfoDetail.strSn}</legend>
		<legend style="font-size: 20px;font-family: Consolas">存货名称:${cmMatrinfoDetail.strName}</legend>
	</div>--%>
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
		<legend>存货编号:${cmMatrinfoDetail.strSn}</legend>
		<legend>存货名称:${cmMatrinfoDetail.strName}</legend>
		<legend>品牌:${cmMatrinfoDetail.strBrand}</legend>
		<legend>型号:${cmMatrinfoDetail.strSpec}</legend>
		<legend>计量单位:${cmMatrinfoDetail.strPrickleZH}</legend>
	</fieldset>

	<div class="layui-form-item"></div>
	<div  class="tab-bars">
		<shiro:hasPermission name="MfBom:edit">
			<a class="add" onclick="createRows()">新增明细</a>
		</shiro:hasPermission>
		<div class="layui-input-inline">
			<input type="text" class="layui-input" style="width:50px;display: none" id="rowsValue" value="1"/>
		</div>
		<shiro:hasPermission name="MfBom:edit">
			<a class="edit" onclick="saveMfBom()">保存</a>
		</shiro:hasPermission>
	</div>
	<div class="layui-form">
		<table class="frog-table sticky">
			<thead>
			<tr id="firstRow">
				<th><input type="checkbox" lay-skin="primary" class="checkAllMfBom" lay-filter="checkAllMfBom" ></th>
				<th type="text" name="plist[#index#].strProdMatrlNo" style="width:150px;text-align:center">产品存货编号</th>
				<%--<th style="width:150px;text-align:center">产品存货名称</th>--%>
				<th type="text" name="plist[#index#].strMatrlNo" lookupGroup="plist[#index#]"
					href="${ctx}/mfBom/selectcmMatrinfoDetail?strMatrlNo=strMatrlNo"
					target="dialog" size="12" align="center" style="width:150px;text-align:center">原料</th>
				<th type="text" name="plist[#index#].strMatrlName" style="width:200px;text-align:center">品名</th>
				<th type="text" name="plist[#index#].strBrand" style="width:180px;text-align:center">品牌</th>
				<th type="text" name="plist[#index#].strUnit" style="width:180px;text-align:center">库存单位</th>
				<th type="text" name="plist[#index#].strSpec" style="width:180px;text-align:center">型号</th>
				<th type="text" name="plist[#index#].bdMatrlQty">原料数量</th>
				<th type="text" name="plist[#index#].bdItemPurPrice">原料单价</th>
				<th style="width:180px;text-align:center">操作</th>
			</tr>
			</thead>
			<tbody name="mfBom_table_tbody">
			<c:forEach items="${list}" var="mfBom" varStatus="status">
				<tr target="slt_uid" rel="${mfBom.id}" id="${mfBom.id}">
					<td><input type="checkbox" name="check_HW090" data-value="${mfBom.id}" lay-skin="primary"  lay-filter="checkAllMfBom"/></td>
					<td style="text-align:center">${mfBom.strProdMatrlNo}</td>
						<%--<td>${mfBom.strMaterialName}</td>--%>
					<td style="text-align:center">${mfBom.strMatrlNo}</td>
					<td style="text-align:center">${mfBom.strMatrlName}</td>
					<td style="text-align:center">${mfBom.strBrand}</td>
					<td style="text-align:center">${mfBom.strUnit}</td>
					<td style="text-align:center">${mfBom.strSpec}</td>
					<td style="text-align: center">${mfBom.bdMatrlQty}</td>
					<td style="text-align: center">${mfBom.bdItemPurPrice}</td>
					<td style="text-align:center">
						<a class="delete" style="text-align: center" onclick="deleteMfBomRow('${mfBom.id}')">删除</a>
						<a class="edit" style="text-align: center" onclick="editMfBomRow(this)" name="btnedit">编辑</a>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</form>
</div>