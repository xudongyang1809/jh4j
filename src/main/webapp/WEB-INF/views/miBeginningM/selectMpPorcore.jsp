<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<html>
<!--
    采购入库挑选页面
 -->
<head>
    <script type="text/javascript">

        function selectMp() {
            var rel = document.getElementById('id').value;
            var aa = document.getElementsByName("checkitemDtl");
            var num = 0;
            var result = '';
            var qty = '';
            for (var i = 0; i < aa.length; i++) {
                if (aa.item(i).checked) {
                    num++;
                    var ihId = getCbxTdContent(aa.item(i), "ihId").val();
                    var updQty = getCbxTdContent(aa.item(i), "updQty").val();
                    if (result == '')
                        result = ihId;
                    else
                        result = result + "," + ihId;
                    if (qty == '')
                        qty = updQty;
                    else
                        qty = qty + "," + updQty;
                }
            }
            if (num == 0)
                Dialog.warn("请至少选择一条信息！");
            else {
                $.ajax({
                    url: '${ctx}/ihInventoryTrade/selectMp',
                    data: {id: rel, ihId: result, qty: qty},
                    dataType: 'text',
                    success: function (msg) {
                        try {
                            var result = JSON.parse(msg);
                            var messages = result.message;
                            if (result.statusCode == 200) {
                                Dialog.success("挑选成功!");
                                $("#preSelectCommonLabel2").load("${ctx}/ihInventoryTrade/preSelect/" + rel, function () {
                                    var dialogIndex = Dialog.getCurrentDialog().attr("times");
                                    if (dialogIndex) {
                                        layer.close(dialogIndex);
                                    }
                                    $("#ihInventoryTradeSaveId").load("${ctx}/ihInventoryTrade/preUpdate/" + rel, {}, function () {
                                        layer.close(loadingIndex);
                                    })
                                })
                            } else {
                                Dialog.error(messages);
                            }
                        } catch (e) {
                            console.log(msg);
                            Dialog.error(e.message);
                        }
                    }
                });
            }
        }
        form.on('checkbox(checkboxSelet)', function (data) {
            if ($(data.elem).hasClass("checkAllSelect")) {
                if (data.elem.checked) {
                    $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
                } else {
                    $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
                }
                form.render('checkbox');
            }
        });
        form.render();
    </script>
</head>
<form id="pagerForm" method="post" action="${ctx}/ihInventoryTrade/preSelect/${id}">
    <input type="hidden" name="pageNum" value="${page.pageNum}"/>
    <input type="hidden" name="numPerPage" value="${page.numPerPage}"/>
    <input type="hidden" name="orderField" value="${page.orderField}"/>
    <input type="hidden" name="orderDirection" value="${page.orderDirection}"/>
    <input type="hidden" name="keywords" value="${keywords}"/>
</form>
<div class="tab-bars">
    <a class="add" href="#" onclick="selectMp()"><span>确定</span></a>
</div>
<div class="tab_header"></div>
<div class="tab_content">
    <form method="post" action="${ctx}/ihInventoryTrade/preSelect/${id}" class="layui-form"
          onsubmit="return dialogSearch(this,'#preSelectCommonLabel2')">
        <table class="frog-table" id="selectTable">
            <input type="hidden" id="id" name="id" value="${id}"/>
            <thead>
            <tr>
                <th><input type="checkbox" lay-skin="primary" class="checkAllSelect" lay-filter="checkboxSelet"/></th>
                <th>序号</th>
                <th>采购合同号</th>
                <th>采购合同项次</th>
                <th>需求计划编号</th>
                <th>需求明细号</th>
                <th>储位</th>
                <th>存货编号</th>
                <th>品名</th>
                <th>型号规格</th>
                <th>品牌</th>
                <th>采购单价</th>
                <th>剩余数量</th>
                <th>采购总金额</th>
                <th>挑选数量</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${mplist}" var="MpDtl" varStatus="status">
                <tr target="slt_uid" rel="${MpDtl.id}" id="${MpDtl.id}">
                    <td><input type="checkbox" name="checkitemDtl" lay-skin="primary" value="${MpDtl.id}"
                               lay-filter="checkboxSelet"/></td>
                    <td>${page.pageBeginCount+status.index+1}</td>
                    <td>${MpDtl.strPoNo}<input type="hidden" name="ihId" value="${MpDtl.id}"/></td>
                    <td>${MpDtl.strPoItemNo}</td>
                    <td>${MpDtl.strReqNo}</td>
                    <td>${MpDtl.strReqItem}</td>
                    <td>${MpDtl.strMatrlNo}</td>
                    <td>${MpDtl.strName}</td>
                    <td>${fn:escapeXml(MpDtl.strSpec)}</td>
                    <td>${MpDtl.strBrand}</td>
                    <td>${MpDtl.strPrickle}</td>
                    <td displayType='currency' pattern='###,###.####'>${MpDtl.bdUnitPrice}</td>
                    <td displayType='currency' pattern='###,###.###'>${MpDtl.bdRemainQty}</td>
                    <td displayType='currency' pattern='###,###.##'>${MpDtl.bdAmt}</td>
                    <td><input type="text" id="updQty" name="updQty" value="${MpDtl.bdRemainQty}" size="10"
                               class="number" style="border:0px" required="true"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <!-- 分页 -->
    </form>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>

</html>

