<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<!--
@desc “此代码是自动生成，请继续优化注释”
@author 超级管理员 admin
@date 2019-04-30 13:34:43
@copyRight: 江苏金恒信息科技股份有限公司
-->
<form id="pagerForm" method="post" action="${ctx}/miBeginningM/saveDtl?id=${id}&strStatus=${strStatus}">
    <input type="hidden" name="pageNum" value="${page.pageNum}"/>
    <input type="hidden" name="numPerPage" value="${page.numPerPage}"/>
    <input type="hidden" name="orderField" value="${page.orderField}"/>
    <input type="hidden" name="strStatus" value="${strStatus}"/>
    <input type="hidden" name="keywords" value="${keywords}"/>
    <input type="hidden" name="strInspNo" id="strInspNo" value="${strInspNo}"/>
</form>
<div id="allPageContent">
    <div class="tab-bars">
        <c:if test="${strStatus == 'N'}">
            <%--<shiro:hasPermission name="MiAcceptanceD:create">--%>
                <a class="add" width="1100" height="500" target="dialog" dialogId="createMiAcceptanceDDialog"
                   href="${ctx}/miAcceptanceD/preCreate?strInspNo=${strInspNo}">添加</a>
            <%--</shiro:hasPermission>--%>
            <%--<shiro:hasPermission name="MiAcceptanceD:edit">--%>
                <a class="edit" width="1100" height="500" target="dialog" dialogId="upadteMiAcceptanceDDialog"
                   href="${ctx}/miAcceptanceD/preUpdate/{slt_uid}">编辑</a>
            <%--</shiro:hasPermission>--%>
            <a class="delete" onclick="deleteList()">删除</a>
        </c:if>
    </div>
    <table class="frog-table layui-form">
        <thead>
        <tr>
            <th style="width: 20px;"><input type="checkbox" lay-skin="primary" group="checkitemDtl"
                                            class="checkboxAllSaveDtl" lay-filter="checkboxSaveDtl"/></th>
            <th>序号</th>
            <%--<th>修改人工号</th>--%>
            <th>入库单号</th>
            <th>入库项次号</th>
            <th>仓库</th>
            <th>储位</th>
            <th>存货编号</th>
            <th>品名</th>
            <th>品牌</th>
            <th>型号规格</th>
            <th>计数单位</th>
            <th>入库单价</th>
            <th>入库数量</th>
            <th>采购总金额</th>
            <th>供应商</th>
            <th>备注</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="miAcceptanceD" varStatus="status">
            <tr target="slt_uid" rel="${miAcceptanceD.id}">
                <td><input type="checkbox" name="checkAcceptanceD" id="${miAcceptanceD.id}"
                           data-value="${miAcceptanceD.id}"
                           lay-skin="primary" lay-filter="checkboxSaveDtl"/></td>
                <td>${page.pageBeginCount + status.index + 1}</td>
                    <%--<td>${miAcceptanceD.updateUserNo}</td>--%>
                <td>${miAcceptanceD.strInspNo}</td>
                <td>${miAcceptanceD.strInspItem}</td>
                <td>${miAcceptanceD.strA}</td>
                <td>${miAcceptanceD.strAreaId}</td>
                <td>${miAcceptanceD.strMatrlNo}</td>
                <td>${miAcceptanceD.strMatrlName}</td>
                <td>${miAcceptanceD.strBrand}</td>
                <td>${miAcceptanceD.strSpec}</td>
                <td>${miAcceptanceD.strUnit}</td>
                <td>${miAcceptanceD.bdBuyPrice}</td>
                <td>${miAcceptanceD.bdInStoreQty}</td>
                <td>${miAcceptanceD.bdTotalAmt}</td>
                <td>${miAcceptanceD.strB}</td>
                <td>${miAcceptanceD.strMemo}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <c:import url="/WEB-INF/views/pager/dialogPagerBar.jsp">
        <c:param name="container" value="#tab2"> </c:param>
    </c:import>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
<script>
    form.on('checkbox(checkboxSaveDtl)', function (data) {
        if ($(data.elem).hasClass("checkboxAllSaveDtl")) {
            if (data.elem.checked) {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
            } else {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
            }
            form.render('checkbox');
        }
    });

    //批量删除明细
    function deleteList() {
        var strInspNo = $("#strInspNo").val();
        var strStatus = $("#strStatus").val();
        var aa = document.getElementsByName("checkAcceptanceD");
        var num = 0;
        var ids = "";
        var bdQtyCount = "";
        for (var i = 0; i < aa.length; i++) {
            if (aa.item(i).checked) {
                num++;
                var id = aa.item(i).parentNode.parentNode.cells[0].children[0].id;
                if (ids == '') {
                    ids = id;
                } else
                    ids = ids + "," + id;   // id 拼接
            }
        }
        if (num == 0) {
            layer.alert("请至少选择一条信息!");
        } else {
            layer.confirm("确定删除吗？", function () {
                $.post("${ctx}/miAcceptanceD/delete", {id: ids}, function (msg) {
                    try {
                        var result = JSON.parse(msg);
                        Ajax.ajaxDone(result);
                        if (result.statusCode == 200) {
                           $("#allPageContent").load("${ctx}/miBeginningM/saveDtl?id=" + strInspNo + "&strStatus=" + strStatus, {}, function () {
                            });
                        }
                    } catch (e) {
                        console.log(msg);
                        Dialog.error(e.message);
                    }
                })
            })
        }
    }
</script>
