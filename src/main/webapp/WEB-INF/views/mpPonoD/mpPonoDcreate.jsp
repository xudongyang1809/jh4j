<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc 采购合同明细折页
	 @author 王梦奇 022347
	 @date 2019-04-29 16:17:49
	 @Copyright: 江苏金恒信息科技股份有限公司
 -->
<script>
	// 刷新当前页
	function  refreshindex () {
		var loadingIndex = Dialog.load();
		var id = $("#ihid").val();
		var strVendorNo	= $("#strVendorNo").val();
		$("#tab2").load("${ctx}/mpPonoD/preCreate?ihid="+id+'&strVendorNo='+strVendorNo , function () {
			layer.close(loadingIndex);
		})
    }

	function mpPonoDSelect() {
		var ihid = $("#ihid").val();
		if (ihid =='' || ihid == null){
			layer.msg("请保存主档信息");
			return ;
		}
		var strVendorNo	= $("#strVendorNo").val();
		$.post("${ctx}/mpPonoD/mpPonoDSelect?strVendorNo="+strVendorNo+"&ihid="+ihid, function(content) {
			top.layer.open({
				id : 'preSelectmpPono',
				type : 1,
				area : [ "80%", "85%" ],
				title : "挑选",
				shadeClose : true,
				offset : "48px",
				maxmin : true,
				anim : 5,
				content : content
			});
		})
	}
	//checkbox 全选
	//全选操作
	form.on('checkbox(checkboxmpMpPayM)', function(data) {
		if ($(data.elem).hasClass("checkboxMpPayM")) {
			if (data.elem.checked) {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
			} else {
				$(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
			}
			form.render('checkbox');
		}
	});

	//批量删除明细
	function deleteSelectmpPonoD() {
		var aa = document.getElementsByName("checkitemMpnoDel");
		var num =0;
		var ids = "";
		for (var i = 0; i < aa.length; i++) {
			if(aa.item(i).checked){
				num++ ;
				var tr = aa.item(i).parentNode.parentNode;
				var id = $(tr.cells[0]).children("#labelId").val();   // id

				if(ids == ''){
					ids = id;
				}else
					ids = ids+","+id;   // id 拼接
			}
		}
		if (num == 0) {
			layer.alert("请至少选择一条信息!");
		}else{
			layer.confirm("确定删除吗？" ,function () {
				$.post("${ctx}/mpPonoD/deleteDtl?ids="+ids  , function (msg) {
					try {
						var result = JSON.parse(msg);
						var messages=result.message;
						Ajax.ajaxDone(result);
						if (result.statusCode == 200) {
							Dialog.success(messages);
							refreshindex();
						}
						else {
							Dialog.error(result.message);
						}
					}catch (e) {
						console.log(msg);
						Dialog.error(e.message);
					}
				})
			})
		}
	}

	// 方法结束
	<!--上 删除合同明细-->

	<!--指定合同明细交货期-->
	function mpPonoDSaveTime() {
		debugger;
		var  updateTime = $("#strSureDateTime").val();
		if (updateTime == null || updateTime == "") {
			layer.msg("请确认交货日期");
			return;
		}
		var aa = document.getElementsByName("checkitemMpnoDel");
		var num =0;
		var ids = "";
		var bdQtyCount= "";
		for (var i = 0; i < aa.length; i++) {
			if(aa.item(i).checked){
				num++ ;
				var tr = aa.item(i).parentNode.parentNode;
				var id = $(tr.cells[0]).children("#labelId").val();   // id
				if(ids == ''){
					ids = id;
				}else
					ids = ids+","+id;   // id 拼接
			}
		}
		if(num ==0){
			layer.alert("至少选择一条信息！")
		}else {
			layer.confirm("确定期望交货日期吗？",function () {
				$.ajax({
					url : '${ctx}/mpPonoD/mpPonoDSaveTime?labelId='+ids+'&updateTime='+updateTime,
					dataType : 'text' ,
					success : function(msg) {
						try {
							var result = JSON.parse(msg);
							Ajax.ajaxDone(result);
							if (result.statusCode == 200) {
								refreshindex();
							}
						} catch (e) {
							console.log(msg);
							Dialog.error(e.message);
						} finally {
							layer.close(loadingIndex);
						}
					}
				})

			})
		}
	}

	layui.use('laydate', function(){
		var laydate = layui.laydate;
		laydate.render({
			elem: '#strSureDateTime'     //结案日期

		});
	})
	form.render();

</script>
<form id="pagerForm" method="post" action="${ctx}/mpPonoD/preCreate" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
	<input type="hidden" name="ihid" value="${ihid}" />
	<input type="hidden" name="strVendorNo"  value="${strVendorNo}" />
	<input type="hidden" name="strRevision" value="${strRevision}" />
</form>

<form method="post" action="${ctx}/mpPonoD/create" class="layui-form"  onsubmit="return validateCallback(this, dialogAjaxDone);">
	<div class="tab-header" >
		<div class="tab-bars" style="position:relative;">
			<a class="choose"  onclick="mpPonoDSelect()"><span>挑选采购计划项次</span></a>
			<%--<a class="edit" onclick="mpPonoDSave()"><span>保存</span></a>--%>
			<a class="delete"  href="#" onclick="deleteSelectmpPonoD()"><span>删除</span></a>
		</div>
		<div class="tab-bars" style="position: relative">
			<div class="layui-form-item">
				<label class="layui-form-label">期望交货日期:</label>
				<div class="layui-input-inline">
					<input type="text " autocomplete="off"   class="layui-input" id="strSureDateTime" placeholder="请输入交货日期" style="width: 120px;" />
				</div>
					<a class="import" onclick="mpPonoDSaveTime()"  style="float: left;margin-left :2px "><span>交期确认</span></a>
				<label class="layui-form-label">合同总金额:</label>
				<div class="layui-input-inline">
					<div class="layui-inline">
						<input type="text " style="width:120px; margin-left: 3px;" class="layui-input" value="${bdMpPonoAmt}"/>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="tab-content layui-form"  style="overflow: auto;">
		<table class="frog-table " id="mpPonoDTable" style="width: 145%;z-index:5; max-width: 145%;table-layout: fixed; word-break: break-all; word-wrap: break-word">
			<thead>
				<input type="hidden" name="ihid" id="ihid" value="${ihid}" />
			 	<input type="hidden" name="strVendorNo" id="strVendorNo" value="${strVendorNo}" />
			<tr id="firstRow">
				<th style="width: 20px">
					<input type="checkbox" lay-skin="primary" class="checkboxMpPayM" lay-filter="checkboxmpMpPayM" />
				</th>
				<th type="text">合同项次</th>
				<th type="text">存货编号</th>
				<th type="text">订购数量</th>
				<%--<th type="text">建议采购单价</th>--%>
				<th type="text">采购单价</th>
				<th type="text">金额</th>
				<th type="text">期望交货日期</th>
				<th type="text">采购要求</th>
				<th type="text">需求计划编号</th>
				<th type="text">需求计划编项次</th>
				<th type="text">需求申报单位</th>
				<th type="text">销售订单号</th>
				<th type="text">销售订项次号</th>
				<th type="text">采购计划号</th>
				<th type="text">剩余未挑选数量</th>
			</tr>
			</thead>
			<tbody name="mp_pono_detail" id="mp_pono_detail_id">
			<c:forEach items="${ponoDetailList}"  var="mpPonoD" varStatus="status">
				<tr>
					<td style="width: 20px">
						<input type="checkbox" lay-skin="primary"  name="checkitemMpnoDel" lay-filter="checkboxmpMpPayM"/>
						<input type="hidden" id="labelId" name="labelId" value="${mpPonoD.id}">
					</td>
					<td>${mpPonoD.strPoItemNo}</td>
					<td>${mpPonoD.strMatrlNo}</td>
					<td>${mpPonoD.bdQty}</td>
					<%--<td>${mpPonoD.bdPlanPrice}</td>--%>
					<td>${mpPonoD.bdRealPrice}</td>
					<td>${mpPonoD.bdAmt}</td>
					<td>${mpPonoD.strPlanUseDate}</td>
					<td>${mpPonoD.strMemo}</td>
					<td>${mpPonoD.strApplyNo}</td>
					<td>${mpPonoD.strApplyItem}</td>
					<td>${mpPonoD.strReqDept}</td>
					<td>${mpPonoD.strOrderNo}</td>
					<td>${mpPonoD.strOrderItem}</td>
					<td>${mpPonoD.strPlanNo}</td>
					<td>${mpPonoD.strUnSelectQty}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</form>

<c:import url="/WEB-INF/views/aaSystem/pager/dialogPagerBar.jsp">
	<c:param name="container" value="#tab2"/>
</c:import>









