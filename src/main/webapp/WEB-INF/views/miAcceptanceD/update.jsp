<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<!--
@desc 编辑画面
@author 超级管理员 admin
@date 2019-04-30 13:34:43
@Copyright: 江苏金恒信息科技股份有限公司
-->
<head>
    <script type="text/javascript">
    </script>
</head>
<form class="layui-form" method="post" action="${ctx}/miAcceptanceD/update"
<%--onsubmit="return dialogAjaxDone(this, 'update')"--%>
      onsubmit="return validateCallback(this, dialogInsertPlanDone);">
    <div id="alls" class="dialogContent" style="right: 60px;">
        <input type="hidden" id="relativedId" name="id" value="${miAcceptanceD.id}">
        <div class="layui-form-item">
            <label class="layui-form-label">入库单号:</label>
            <div class="layui-input-inline">
                <input type="text" name="strInspNo" class="layui-input" placeHolder="请输入入库单号"
                       id="strInspNo" readonly="true" value="${miAcceptanceD.strInspNo}"/>
            </div>
            <label class="layui-form-label">入库项次号:</label>
            <div class="layui-input-inline">
                <input type="text" name="strInspItem" class="layui-input" placeHolder="请输入入库项次号"
                       readonly value="${miAcceptanceD.strInspItem}"/>
            </div>
            <label class="layui-form-label">供应商:</label>
            <div class="layui-input-inline">
                <input type="text" id="strVendorName" name="strB" value="${miAcceptanceD.strB}"
                       readonly style="width: 190px" class="layui-input"/>
                <a class="layui-btn layui-btn-sm select-btn"
                   href="${ctx}/mcInfomationM/listMerchant?strVendorNo1=strVendorNoMpPoNos&strVendorName1=strVendorName"
                   lookupGroup="org2t" target="dialog" dialogId="selectMerchantDialog" rel="selectCmMerchant"
                   title="供应商" width="800" height="480"><i class="layui-icon layui-icon-search"></i></a>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">仓库:</label>
            <div class="layui-input-inline">
                <select name="strA" id="strA" lay-filter="selectLocNo">
                    <option value=''>请选择</option>
                    <c:forEach items="${dictDtlList}" var="field">
                        <option value='${field.id}'${field.id eq  miAcceptanceD.strA ?'selected':field.id}>${field.strValue}</option>
                    </c:forEach>
                </select>
            </div>
            <label class="layui-form-label">储位:</label>
            <div class="layui-input-inline">
                <select name="strAreaId" id="strAreaId">
                    <c:forEach items="${strAreaIdList}" var="field">
                        <option value='${field.id}'${field.id eq  miAcceptanceD.strAreaId ?'selected':field.id}>${field.strName}</option>
                    </c:forEach>
                </select>
            </div>
            <label class="layui-form-label">存货编号:</label>
           <%-- <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strMatrlNo" name="strMatrlNo"
                       readonly  autocomplete="off"
                       placeHolder="请挑选存货编号"/>
                <a class="layui-btn layui-btn-sm" href="${ctx}/msOrderD/selectSaleMatrlNo" title="请挑选销售订单编号"
                   target="dialog" width="1000" height="500" dialogId="selectStrMatrlNoId001"
                   style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i
                        class="layui-icon layui-icon-search"></i></a>
            </div>--%>

            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strMatrlNo" name="strMatrlNo"
                       readonly lay-verify="required" autocomplete="off"
                       value="${miAcceptanceD.strMatrlNo}" placeHolder="请挑选存货编号"/>
                <a class="layui-btn layui-btn-sm" href="${ctx}/msOrderD/selectSaleMatrlNo" title="请挑选存货编号"
                   target="dialog" width="1000" height="500" dialogId="selectStrMatrlNoId001"
                   style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i
                        class="layui-icon layui-icon-search"></i></a>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">品名:</label>
            <div class="layui-input-inline">
                <input type="text" id="strMatrlName" name="strMatrlName" readonly class="layui-input" placeHolder="请输入品名"
                       value="${miAcceptanceD.strMatrlName}"/>
            </div>
            <label class="layui-form-label">品牌:</label>
            <div class="layui-input-inline">
                <input type="text" id="strBrand" name="strBrand" readonly class="layui-input" placeHolder="请输入品牌"
                       value="${miAcceptanceD.strBrand}"/>
            </div>
            <label class="layui-form-label">型号规格:</label>
            <div class="layui-input-inline">
                <input type="text" id="strSpec" name="strSpec" readonly class="layui-input" placeHolder="请输入型号规格"
                       value="${miAcceptanceD.strSpec}"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">单位:</label>
            <div class="layui-input-inline">
                <input type="text" readonly class="layui-input" id="strUnit" name="strUnit" value="${miAcceptanceD.strUnit}"/>
            </div>
            <label class="layui-form-label">入库单价:</label>
            <div class="layui-input-inline">
                <input type="text" id="bdBuyPrice" name="bdBuyPrice" class="layui-input" placeHolder="请输入入库单价"
                       onchange="setbdTotalAmt()" lay-verify="required|number" value="${miAcceptanceD.bdBuyPrice}"/>
            </div>
            <label class="layui-form-label">入库数量:</label>
            <div class="layui-input-inline">
                <input type="text" id="bdInStoreQty" name="bdInStoreQty" class="layui-input"
                       placeHolder="请输入入库量"
                       onchange="setbdTotalAmt()" lay-verify="required|number" value="${miAcceptanceD.bdInStoreQty}"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">备注:</label>
            <div class="layui-input-inline">
                     <textarea type="text" name="strMemo"
                               class="layui-textarea" rowspan="5"
                               style="width: 500px;">${miAcceptanceD.strMemo}</textarea>
            </div>
        </div>
    </div>
    <div class="dialogFooter">
        <button type="submit" class="layui-btn">提交</button>
    </div>
</form>
<script>
    //构建储位下拉框方法
    form.on('select(selectLocNo)', function (data) {
        var id = data.value;
        $.ajax({
            type: 'POST',
            url: '${ctx}/miAcceptanceM/SelectstrAreaId',
            data: {strSn: id},
            dataType: 'json',
            success: function (data) {
                var optionstring = "<option value='' >请选择</option>";
                $.each(data, function (i, item) {
                    optionstring += "<option value=\"" + item.id + "\" >" + item.strName + "</option>";
                });
                $("#strAreaId").html(optionstring);
                form.render('select'); //这个很重要
            }
        });
    });

    //自动计算
    function setbdTotalAmt() {
        var bdBuyPrice = $("#bdBuyPrice").val();
        var bdInStoreQty = $("#bdInStoreQty").val();
        if (bdBuyPrice == "" || bdBuyPrice == null) {
            Dialog.warn("请输入入库单价！");
            return;
        }
        if (bdInStoreQty == "" || bdInStoreQty == null) {
            Dialog.warn("请输入入库数量！");
            return;
        }
        $("#bdTotalAmt").val(bdBuyPrice * bdInStoreQty);
    }

    function dialogInsertPlanDone(result) {
        try {
            var strInspNo = document.getElementById("strInspNo").value;
            var messages = result.message;
            if (result.statusCode == 200) {
                layer.close(layer.index);
                $("#allPageContent").load("${ctx}/miBeginningM/saveDtl?id=" + strInspNo + "&strStatus=N", {}, function () {
                    var dialogIndex = Dialog.getCurrentDialog().attr("times");
                    if (dialogIndex) {
                        layer.close(dialogIndex);
                    }
                });
                Dialog.success(messages);
            } else {
                Dialog.error(messages);
            }
        } catch (e) {
            console.log(msg);
            Dialog.error(e.message);
        }
    }
</script>
