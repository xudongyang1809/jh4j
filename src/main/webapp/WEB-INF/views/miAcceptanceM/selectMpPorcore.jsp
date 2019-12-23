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
            var strInspNo = document.getElementById('strInspNo').value;
            var type = document.getElementById('type').value;
            var aa = document.getElementsByName("checkitemDtl");
            var num = 0;
            var result = '';
            for (var i = 0; i < aa.length; i++) {
                if (aa.item(i).checked) {
                    num++;
                    var tr = aa.item(i).parentNode.parentNode;
                    var ihId = tr.cells[0].children[0].id;
                    if (result == '') {
                        result = ihId;
                    } else {
                        result = result + "," + ihId;
                    }
                }
            }
            if (num == 0)
                Dialog.warn("请至少选择一条信息！");
            else {
                $.ajax({
                    url: '${ctx}/miAcceptanceD/selectInsert',
                    data: {id: rel, ihIds: result, strInspNo: strInspNo, type: type},
                    dataType: 'text',
                    success: function (msg) {
                        try {
                            var result = JSON.parse(msg);
                            var messages = result.message;
                            if (result.statusCode == 200) {
                                Dialog.success("挑选成功!");
                                $("#all").load("${ctx}/miAcceptanceM/preUpdate/" + rel, function () {
                                    var dialogIndex = Dialog.getCurrentDialog().attr("times");
                                    if (dialogIndex) {
                                        layer.close(dialogIndex);
                                    }
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
        form.on('checkbox(checkboxmsOrderD)', function (data) {
            if ($(data.elem).hasClass("checkboxmsAllOrderD")) {
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
<form id="pagerForm" method="post" action="${ctx}/miAcceptanceM/preSelect/${id}">
    <input type="hidden" id="type" value="${type}">
    <input type="hidden" id="id" name="id" value="${id}"/>
    <input type="hidden" id="strInspNo" value="${strInspNo}">
    <input type="hidden" name="pageNum" value="${page.pageNum}"/>
    <input type="hidden" name="keywords" value="${keywords}"/>
</form>
<div class="tab-bars">
    <a class="add" href="#" onclick="selectMp()"><span>确定</span></a>
</div>
<div class="tab_content">
    <form method="post" action="${ctx}/miAcceptanceM/preSelect/${id}" class="layui-form">
        <table class="frog-table">
            <thead>
            <tr>
                <th><input type="checkbox" lay-skin="primary" class="checkboxmsAllOrderD" lay-filter="checkboxmsOrderD"/></th>
                <th>序号</th>
                <th>销售订单编号</th>
                <th>销售订单项次</th>
                <th>存货编号</th>
                <th>品名</th>
                <th>品牌</th>
                <th>库存单位</th>
                <th>型号规格</th>
                <th>采购单价</th>
                <th>销售单价</th>
                <th>销售数量</th>
                <th>采购数量</th>
                <th>销售单项总金额</th>
                <th>交货期限</th>
                <th>状态</th>
                <th>备注</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${msOrderD}" var="msOrderD" varStatus="status">
                <tr target="slt_uid" rel="${msOrderD.id}" id="${msOrderD.id}">
                    <td><input type="checkbox" name="checkitemDtl" lay-skin="primary" id="${msOrderD.id}"
                               lay-filter="checkboxmsOrderD"/></td>
                    <td>${page.pageBeginCount+status.index+1}</td>
                    <td>${msOrderD.strOrderNo}</td>
                    <td>${msOrderD.strOrderItem}</td>
                    <td>${msOrderD.strMatrlNo}</td>
                    <td>${msOrderD.strMatrlName}</td>
                    <td>${msOrderD.strBrand}</td>
                    <td>${msOrderD.strUnit}</td>
                    <td>${msOrderD.strSpec}</td>
                    <td>${msOrderD.bdPurchasePrice}</td>
                    <td>${msOrderD.bdSalePrice}</td>
                    <td>${msOrderD.bdSaleQty}</td>
                    <td>${msOrderD.bdPurchaseQty}</td>
                    <td>${msOrderD.bdItemAmt}</td>
                    <td>${msOrderD.strDate}</td>
                    <td>${msOrderD.strStus}</td>
                    <td>${msOrderD.strRemark}</td>
                    <%--<td><input type="text" id="updQty" name="updQty" value="${MpDtl.bdRemainQty}" size="10"--%>
                               <%--class="number" style="border:0px" required="true"/></td>--%>
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

