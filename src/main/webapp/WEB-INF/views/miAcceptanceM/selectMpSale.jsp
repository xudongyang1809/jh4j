<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<script>
    form.on('checkbox(checkboxInArrival)', function (data) {
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
    <a class="add" href="#" onclick="selectMp()"><span>确定</span></a>
</div>
<div class="tab-content" style="overflow:auto;">
    <form method="post" action="${ctx}/miAcceptanceM/preSelect?type=${type}&strInspNo=${strInspNo}"
          class="layui-form" autocomplete="off" onsubmit="return validateCallback(this, dialogAjaxDone);">
        <input type="hidden" id="strInspNo" value="${strInspNo}">
        <input type="hidden" id="type" value="${type}">
        <table class="frog-table" id="ihArrivalDtlTable">
            <thead>
            <tr>
                <th style="width:3%;">
                    <input type="checkbox" lay-skin="primary" class="checkAllInArrival" lay-filter="checkboxInArrival"/>
                </th>
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
                <th type="text">采购金额</th>
                <th type="text">采购承办人</th>
                <!-- <th style="width:6%">编辑</th> -->
            </tr>
            </thead>
            <tbody name="ih_arrival_dtl">
            <c:forEach items="${mpArrivalD}" var="mpArrivalD" varStatus="status">
                <tr target="slt_uid">
                    <td style="width: 3%;">
                        <input type="checkbox" id="${mpArrivalD.id}" lay-skin="primary" name="checkitemArrivalDel"
                               lay-filter="checkboxInArrival"/>
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
<script>
    function selectMp() {
        var rel = document.getElementById('id').value;
        var strInspNo = document.getElementById('strInspNo').value;
        var type = document.getElementById('type').value;
        var aa = document.getElementsByName("checkitemArrivalDel");
        var num = 0;
        var result = '';
        for (var i = 0; i < aa.length; i++) {
            if (aa.item(i).checked) {
                debugger
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
</script>