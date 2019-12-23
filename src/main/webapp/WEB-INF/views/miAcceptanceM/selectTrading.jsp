<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>

<form id="pagerForm" lay method="post"  action="${ctx}/mpArrivalD/preCreate">
    <input type="hidden" name="pageNum" value="${page.pageNum}" />
    <input type="hidden" name="numPerPage" value="${page.numPerPage}" />
    <input type="hidden" name="orderField" value="${page.orderField}" />
    <input type="hidden" name="orderDirection" value="${page.orderDirection}" />
    <input type="hidden" name="keywords" value="${keywords}"/>
</form>

<script >
    form.on('checkbox(checkboxInArrival)', function(data) {
        if ($(data.elem).hasClass("checkAllInArrival")) {
            if (data.elem.checked) {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
            } else {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
            }
            form.render('checkbox');
        }
    });
</script>
<div class="tab-bars">
    <a class="choose" onclick="mpArrivalD()"><span>挑选</span></a>
    <a class="save" onclick="saveArriveDetail()"><span>保存</span></a>
    <a class="delete" onclick="deleteArrival()"><span>删除</span></a>
</div>
<div class="tab-header">
</div>
<div class="tab-content" style="overflow:auto;">
    <input id="ihid" type="text" value="${ihid}">
    <input id="strPoNo" type="text" value="${strPoNo}">
    <input  id="strVendorNo" type="text" value="${strVendorNo}"/>

    <form method="post" action="${ctx}/ihArrival/saveDtl" class="layui-form" autocomplete="off" onsubmit="return validateCallback(this, dialogAjaxDone);"  >
        <table class="frog-table" id="ihArrivalDtlTable">
            <thead>
            <tr>
                <th style="width:3%;">
                    <input type="checkbox" lay-skin="primary" class="checkAllInArrival" lay-filter="checkboxInArrival" /></th>
                <th type="text">到货明细号</th>
                <th type="text">采购合同号</th>
                <th type="text">采购合同项次</th>
                <th type="text">到货时间</th>
                <th type="text">存货编号</th>
                <th type="text">品名</th>
                <th type="text">品牌</th>
                <th type="text">规格型号</th>
                <th type="text">采购单价</th>
                <th type="text">采购数量</th>
                <th type="text">采购合同中数量</th>
                <th type="text">到货数量</th>
                <th type="text">采购承办人</th>
                <!-- <th style="width:6%">编辑</th> -->
            </tr>
            </thead>
            <tbody name="ih_arrival_dtl">
            <c:forEach items="${mpArrivalD}" var="mpArrivalD" varStatus="status">
                <tr target="slt_uid">
                    <td style="width: 3%;">
                        <input type="text" id="labelId" value="${mpArrivalD.id}"  />
                        <input type="checkbox" lay-skin="primary" name="checkitemArrivalDel"  lay-filter="checkboxInArrival" />
                    </td>
                    <td>${mpArrivalD.strArrItemNo}</td>
                    <td>${mpArrivalD.strPoNo}</td>
                    <td>${mpArrivalD.strPoItemNo}</td>
                    <td>${mpArrivalD.strApplyDateTime}</td>
                    <td>${mpArrivalD.strMatrlNo}</td>
                    <td>${mpArrivalD.strMatrlName}</td>
                    <td>${mpArrivalD.strBrand}</td>
                    <td>${mpArrivalD.strSpecMark}</td>
                    <td>${mpArrivalD.bdRealPrice}</td>
                    <td>${mpArrivalD.bdQty}</td>
                    <td>${mpArrivalD.bdPoNoQty}</td>
                    <td>${mpArrivalD.bdAmt}</td>
                    <td>${mpArrivalD.strRespEmpNo}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form>
</div>
<!-- 分页 -->
<c:import url="/WEB-INF/views/aaSystem/pager/dialogPagerBar.jsp">

</c:import>