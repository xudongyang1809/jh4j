<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
@desc “此代码是自动生成，请继续优化注释”
@author 毛敏 022325
@date 2019-05-29 13:54:19
@copyRight: 江苏金恒信息科技股份有限公司
-->
<script>
    /*批量选择*/
    form.on('checkbox(checkAllMsSettleD)', function(data) {
        if ($(data.elem).hasClass("checkAllMsSettleD")) {
            if (data.elem.checked) {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
            } else {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
            }
            form.render('checkbox');
        }
    });
    function selectMsSettlementDetail(){
        debugger;
        var settleNumberId = $('#settleNumberId').val();
        var btbedit = document.getElementsByName("check_HW");
        layer.confirm("确认挑选?",{
            btn:['确定','取消']
        },function (index) {
            layer.close(index);
            var j = 0;
            for (var i = 0;i < btbedit.length;i++){
                //alert(btbedit.length);
                if (btbedit.item(i).checked){
                    j=j+1;
                    //alert("111");
                    debugger;
                    var tr = btbedit.item(i).parentNode.parentNode;
                    var strSettleNumber = $((tr.cells[2])).text();/*结算单号*/
                    var strSaleNo = $(tr.cells[3]).text();/*销账单号*/
                    //var strOrderNo = $(tr.cells[4]).text();/*销售订单编号*/
                    //var strOrderItem = $(tr.cells[5]).text();/*销售订单项次*/
                    var strReqNo = $(tr.cells[4]).text();/*需求计划编号*/
                    var strReqItem = $(tr.cells[5]).text();/*需求明细项次*/
                    var strMatrlNo = $(tr.cells[6]).text();/*存货编号*/
                    var strMatrlName = $(tr.cells[7]).text();/*品名*/
                    var strSpec = $(tr.cells[8]).text();/*型号规格*/
                    var strUnit = $(tr.cells[9]).text();/*计量单位*/
                    var strBrand = $(tr.cells[10]).text();/*品牌*/
                    var bdRealPrice = $(tr.cells[11]).text();/*销售单价*/
                    var bdSaleQty = $(tr.cells[12]).text();/*销售数量*/
                    var bdAmt = $(tr.cells[13]).text();/*销售单项总金额*/
                    var strB = $(tr.cells[14]).text();/*供应商*/
                    //alert(strB);
                    var strRate = $(tr.cells[15]).text();/*税率*/
                    //alert(strRate);
                    $.post("${ctx}/msSettlementD/saveMsSettlementDetail?strSettleNumber="+strSettleNumber+"&strSaleNo="+strSaleNo
                   +"&strReqNo="+strReqNo+"&strReqItem="+strReqItem+"&strMatrlNo="+strMatrlNo+"&strMatrlName="+strMatrlName
                    +"&strSpec="+strSpec+"&strUnit="+strUnit+"&strBrand="+strBrand+"&bdRealPrice="+bdRealPrice+"&bdSaleQty="+bdSaleQty+"&bdAmt="+bdAmt+"&strRate="+strRate,
                        function (rst) {
                            try{
                                var data = JSON.parse(rst);
                                if (data.statusCode == 200){
                                    Dialog.success("挑选成功");
                                    var dialogIndex = Dialog.getCurrentDialog().attr("times");
                                    if (dialogIndex){
                                        layer.close(dialogIndex);
                                    }
                                    <%--$('#MsSettlementMUpdateId06').load("${ctx}/msSettlementM/preUpdate?id="+settleNumberId,{},function () {});--%>
                                    $('#tab2').load("${ctx}/msSettlementD/detailList?strSettleNumber="+strSettleNumber+"&strVendorNo="+strB,{},function () {});
                                    $('#msSettlementMListId').load("${ctx}/msSettlementM/list",{},function () {});
                                    Dialog.success(data.message);
                                }else{
                                    Dialog.error(data.message);
                                }
                            }catch(e){
                                console.log(msg);
                                Dialog.error(e.message);
                            }
                        });
                }
            }
        });
    }
</script>
<form id="pagerForm" method="post" action="${ctx}/msSettlementD/list" onsubmit="return navTabAjaxDone(this)">
    <input type="hidden" name="pageNum" value="${page.pageNum}" />
    <input type="hidden" name="numPerPage" value="${page.numPerPage}" />
    <input type="hidden" name="orderField" value="${page.orderField}" />
    <input type="hidden" name="orderDirection" value="${page.orderDirection}" />
    <input type="hidden" name="keywords" value="${keywords}"/>
    <input type="hidden" id="strSettleNumber" value="${strSettleNumber}">
    <input type="hidden" id="strVendorNo" value="${strVendorNo}">
    <input type="hidden" id="settleNumberId" value="${settleNumberId}">
</form>
<div class="tab-bars">
    <shiro:hasPermission name="MsSettlementD:create">
        <a class="add" onclick="selectMsSettlementDetail()">确定</a>
    </shiro:hasPermission>
</div>
<table class="frog-table layui-form">
    <thead>
    <tr>
        <th><input type="checkbox" lay-skin="primary" lay-filter="checkAllMsSettleD" class="checkAllMsSettleD"></th>
        <th style="width:2%">序号</th>
        <th>销售结算单号</th>
        <th>销账单号</th>
        <%--<th>销售订单号</th>
        <th>销售订单项次</th>--%>
        <th>需求计划编号</th>
        <th>需求明细项次</th>
        <th>存货编号</th>
        <th>品名</th>
        <th>型号规格</th>
        <th>计量单位</th>
        <th>品牌</th>
        <th>销售单价</th>
        <th>销售数量</th>
        <th>单项总金额</th>
        <th>供应商</th>
        <th>税率</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="miIssueD" varStatus="status">
        <tr target="slt_uid" rel="${miIssueD.id}" id="${miIssueD.id}">
            <td><input type="checkbox" name="check_HW" lay-skin="primary" lay-filter="checkAllMsSettleD"></td>
            <td>${page.pageBeginCount + status.index + 1}</td>
            <td>${strSettleNumber}</td>
            <td>${miIssueD.strSaleNo}</td><%--销账单号--%>
            <%--<td>${miIssueD.strOrderNo}</td>
            <td>${miIssueD.strOrderItem}</td>--%>
            <td>${miIssueD.strReqNo}</td>
            <td>${miIssueD.strReqItem}</td>
            <td>${miIssueD.strMatrlNo}</td>
            <td>${miIssueD.strMatrlName}</td>
            <td>${miIssueD.strSpec}</td>
            <td>${miIssueD.strUnit}</td>
            <td>${miIssueD.strBrand}</td>
            <td>${miIssueD.bdRealPrice}</td>
            <td>${miIssueD.bdSaleQty}</td>
            <td>${miIssueD.bdAmt}</td>
            <td>${miIssueD.strB}</td>
            <td>${miIssueD.strRateZH}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<%--<table class="frog-table">
    <thead>
    <tr>
        <th>序号</th>
        <th>销售结算单号</th>
        <th>销售订单编号</th>
        <th>销售订单项次</th>
        <th>销账单号</th>
        <th>需求计划编号</th>
        <th>需求计划项次号</th>
        <th>销售存货编号</th>
        <th>库存单位</th>
        <th>品名</th>
        <th>品牌</th>
        <th>型号规格</th>
        <th>销售单价</th>
        <th>销售数量</th>
        <th>税率</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="msSettlementD" varStatus="status">
        <tr target="slt_uid" rel="${msSettlementD.id}" id="${msSettlementD.id}">
            <td>${page.pageBeginCount + status.index + 1}</td>
            <td>${msSettlementD.strSettleNumber}</td>&lt;%&ndash;结算单号&ndash;%&gt;
            <td>${msSettlementD.strOrderNo}</td>&lt;%&ndash;销售订单编号&ndash;%&gt;
            <td>${msSettlementD.strOrderItem}</td>&lt;%&ndash;销售订单项次&ndash;%&gt;
            <td>${msSettlementD.strSaleNo}</td>&lt;%&ndash;销账单号&ndash;%&gt;
            <td>${msSettlementD.strApplyNo}</td>
            <td>${msSettlementD.strApplyItem}</td>
            <td>${msSettlementD.strMatrlNo}</td>
            <td>${msSettlementD.strMatrlName}</td>
            <td>${msSettlementD.strBrand}</td>
            <td>${msSettlementD.strUnit}</td>
            <td>${msSettlementD.strSpec}</td>
            <td>${msSettlementD.bdSalePrice}</td>
            <td>${msSettlementD.bdSaleCount}</td>
            <td>${msSettlementD.bdTaxRate}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>--%>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>

