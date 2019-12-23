<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
     @desc “此代码是自动生成，请继续优化注释”
	 @author 毛敏 022325
	 @date 2019-05-29 13:54:19
	 @copyRight: 江苏金恒信息科技股份有限公司
 -->
<script>
    /*挑选*/
	function selectMsSettlementDetail(){
		debugger;
	    var strSettleNumber = $('#strSettleNumber').val();
	    var strVendorNo = $('#strVendorNo5005').val();
		$.post("${ctx}/msSettlementD/selectMiIssueD?strSettleNumber="+strSettleNumber+"&strVendorNo="+strVendorNo,"",function (content) {
			top.layer.open({
				id:'msSettlementDetail',
				type: 1,
				area:["80%","80%"],
				title:"挑选",
				shadeClose:true,
				offset:'48px',
				maxmin:true,
				anim:5,
				content:content
			});
		});
	}
	/*删除*/
	/*function deletemsSettlementD(){
	    var msSettlementD001 = $('#msSettlementD001').val();
	    $.ajax({
            type:"post",
            url:"${ctx}/msSettlementD/delete?id="+msSettlementD001,
            dataType:"json",
            success:function (rst) {
                debugger;
                if (rst.statusCode == 200){
                    $('#msSettlementDId080').load("${ctx}/msSettlementD/detailList",{},function () {});
                    Dialog.success(rst.message);
                } else{
                    Dialog.error(rst.message);
                }
            }
        });
    }*/
    /*批量选择*/
    form.on('checkbox(checkALLMsSettlementD)', function(data) {
        if ($(data.elem).hasClass("checkALLMsSettlementD")) {
            if (data.elem.checked) {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
            } else {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
            }
            form.render('checkbox');
        }
    });
    /*批量删除*/
    function deletemsSettlementD() {
    	debugger;
        var ids = "";
        var trId;
        var btbedit = document.getElementsByName("check_MsSettlementD");
        var j=0;
        for (var i = 0;i<btbedit.length;i++) {
        	if (btbedit.item(i).checked){
        		j=j+1;
        		var tr = btbedit.item(i).parentNode.parentNode;
        		trId = $(tr).attr("rel");
        		if(ids == ""){
        			ids = trId
				}else{
        			ids += ","+ trId;
				}
			}
		}
        if (ids == "") {
            Dialog.warn("未选中一条以上的数据");
            return;
        }
		var strSettleNumber = $('#strSettleNumber').val();
		var strVendorNo = $('#strVendorNo5005').val();
        layer.confirm("确定删除吗?", {
            btn: ['确定','取消'] //按钮
        },function() {
            $.post("${ctx}/msSettlementD/delete", {ids: ids},
                function(msg) {
                    try {
                        var result = JSON.parse(msg);
						$('#msSettlementDId080').load("${ctx}/msSettlementD/detailList?strSettleNumber="+strSettleNumber+"&strVendorNo="+strVendorNo,{},function () {});
                        Ajax.ajaxDone(result);
                        if (result.statusCode == 200) {
                            NavTab.reloadWithPagination(result.navTabId);
                        }
                    } catch (e) {
                        console.log(msg);
                        Dialog.error(e.message);
                    }
                });
        }, function()
        {
            layer.close();
        })
    }
</script>
<div id="msSettlementDId080">
<form id="pagerForm" method="post" action="${ctx}/msSettlementD/list" onsubmit="return navTabAjaxDone(this)">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/>
	<input type="hidden" id="strSettleNumber" value="${strSettleNumber}">
	<input type="hidden" id="strVendorNo5005" value="${strVendorNo}">
</form>
<div class="tab-bars">
	<shiro:hasPermission name="MsSettlementD:create">
		<a class="choose" onclick="selectMsSettlementDetail()">挑选</a>
	</shiro:hasPermission>
	<%--<shiro:hasPermission name="MsSettlementD:create">
   		<a class="add" width="500" height="500" target="dialog" dialogId="createMsSettlementDDialog" href="${ctx}/msSettlementD/preCreate">添加</a>
   	</shiro:hasPermission>
   	<shiro:hasPermission name="MsSettlementD:edit">
   		<a class="edit" width="500" height="500" target="dialog" dialogId="upadteMsSettlementDDialog" href="${ctx}/msSettlementD/preUpdate/{slt_uid}">编辑</a>
   	</shiro:hasPermission>--%>
   	<shiro:hasPermission name="MsSettlementD:delete">
   		<a class="delete" onclick="deletemsSettlementD()">批量删除</a>
   	</shiro:hasPermission>
</div>
<div class="">
	<table class="frog-table layui-form">
		<thead>
			<tr>
                <th><input type="checkbox" lay-skin="primary" class="checkALLMsSettlementD" lay-filter="checkALLMsSettlementD"></th>
				<th>序号</th>
				<th>销售结算单号</th>
				<th>销账单号</th>
				<%--<th>销售订单编号</th>
				<th>销售订单项次</th>--%>

				<th>需求计划编号</th>
				<th style="width: 200px">需求计划项次号</th>
				<th>销售存货编号</th>
				<th>品名</th>
				<th>品牌</th>
				<th>型号规格</th>
				<th>库存单位</th>
				<th>销售单价</th>
				<th>销售数量</th>
				<th>单项总金额</th>

				<th>税率</th>
				<th>含税单价金额</th>
				<th>含税总金额</th>
				<th>不含税单价金额</th>
				<th>不含税总金额</th>
				<th>税额</th>
				<th>状态</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="msSettlementD" varStatus="status">
				<tr target="slt_uid" rel="${msSettlementD.id}" id="${msSettlementD.id}">
                    <%--<td><input type="checkbox" data-value="${msSettlementD.id}" lay-filter="checkALLMsSettlementD"></td>--%>
                    <td><input type="checkbox" name="check_MsSettlementD" data-value="${msSettlementD.id}" lay-skin="primary" lay-filter="checkALLMsSettlementD"></td>
				    <td>${page.pageBeginCount + status.index + 1}</td>
					<td>${msSettlementD.strSettleNumber}</td>
					<td>${msSettlementD.strSaleNo}</td>
					<%--<td>${msSettlementD.strOrderNo}</td>
					<td>${msSettlementD.strOrderItem}</td>--%>

					<td>${msSettlementD.strApplyNo}</td>
					<td style="width: 200px">${msSettlementD.strApplyItem}</td>
					<td>${msSettlementD.strMatrlNo}</td><%--销售存货编号--%>
					<td style="width: 300px">${msSettlementD.strMatrlName}</td><%--品名--%>
					<td>${msSettlementD.strBrand}</td><%--品牌--%>
					<td>${msSettlementD.strSpec}</td><%--型号规格--%>
					<td>${msSettlementD.strUnit}</td><%--库存单位--%>
					<td>${msSettlementD.bdSalePrice}</td><%--销售单价--%>
					<td>${msSettlementD.bdSaleCount}</td><%--销售数量--%>
					<td>${msSettlementD.bdItemAmt}</td>

					<td>${msSettlementD.bdTaxRate}</td><%--税率--%>
					<td>${msSettlementD.bdAmt}</td><%--含税金额--%>
					<td>${msSettlementD.bdTotaAmt}</td><%--含税总金额--%>
					<td>${msSettlementD.bdExcludAmt}</td><%--不含税金额--%>
                    <td>${msSettlementD.bdExcludSumAmt}</td><%--不含税总金额--%>
					<td>${msSettlementD.bdTaxAmt}</td>
					<td>${msSettlementD.strStusZH}</td>
                    <td style="display: none"><input style="display: none" id="msSettlementD001" value="${msSettlementD.id}"></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
</div>