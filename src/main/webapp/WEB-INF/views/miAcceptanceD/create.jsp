<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<!--
@desc 创建画面
@author 超级管理员 admin
@date 2019-04-30 13:34:43
@Copyright: 江苏金恒信息科技股份有限公司
-->
<div id="allPageContent">
    <form class="layui-form" method="post" action="${ctx}/miAcceptanceD/create"
          <%--onsubmit="return dialogAjaxDone(this, 'create')">--%>
        onsubmit="return validateCallback(this, dialogInsertPlanDone);">
        <div id="alls" class="dialogContent" style="right: 60px;">
            <div class="layui-form-item">
                <label class="layui-form-label">入库单号:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="strInspNo" value="${strInspNo}" readonly="true"
                           name="strInspNo"/>
                </div>
                <label class="layui-form-label">入库项次号:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" value="${strInspItem}" name="strInspItem" readonly/>
                </div>
                <label class="layui-form-label">供应商:</label>
                <div class="layui-input-inline">
                    <input type="text" id="strVendorName" name="strB"
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
                    <select name="strA" id="strA" lay-filter="selectLocNo" >
                        <option value=''>请选择</option>
                        <c:forEach items="${dictDtlList}" var="field">
                            <option value='${field.id}'>${field.strValue}</option>
                        </c:forEach>
                    </select>
                </div>
                <label class="layui-form-label">储位:</label>
                <div class="layui-input-inline">
                    <select name="strAreaId" id="strAreaId"  ><%--lay-verify="required"--%>
                        <option value="">请选择</option>
                    </select>
                </div>
                <label class="layui-form-label">存货编号:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="strMatrlNo" name="strMatrlNo"
                            readonly  autocomplete="off"
                           placeHolder="请挑选存货编号"/>
                    <a class="layui-btn layui-btn-sm" href="${ctx}/msOrderD/selectSaleMatrlNo" title="请挑选销售订单编号"
                       target="dialog" width="1000" height="500" dialogId="selectStrMatrlNoId001"
                       style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i
                            class="layui-icon layui-icon-search"></i></a>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">品名:</label>
                <div class="layui-input-inline">
                    <input type="text" readonly class="layui-input" id="strMatrlName" name="strMatrlName"/>
                </div>
                <label class="layui-form-label">品牌:</label>
                <div class="layui-input-inline">
                    <input type="text" readonly class="layui-input" id="strBrand" name="strBrand"/>
                </div>
                <label class="layui-form-label">型号规格:</label>
                <div class="layui-input-inline">
                    <input type="text" readonly class="layui-input"id="strSpec" name="strSpec"/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">单位:</label>
                <div class="layui-input-inline">
                    <input type="text" readonly class="layui-input" id="strUnit" name="strUnit"/>
                </div>
                <label class="layui-form-label">入库单价:</label>
                <div class="layui-input-inline">
                    <input type="text" lay-verify="required|number" class="layui-input" name="bdBuyPrice"
                           id="bdBuyPrice"
                           onchange="setbdTotalAmt()" placeHolder="请输入入库单价"/>
                </div>
                <label class="layui-form-label">入库量:</label>
                <div class="layui-input-inline">
                    <input type="text" lay-verify="required|number" class="layui-input" name="bdInStoreQty"
                           id="bdInStoreQty"
                           placeHolder="请输入入库量" onchange="setbdTotalAmt()"/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">总金额:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="bdTotalAmt" name="bdTotalAmt"
                           readonly placeHolder="单价和数量自动计算"/>
                </div>
                <label class="layui-form-label">备注:</label>
                <div class="layui-input-inline">
                      <textarea type="textarea" name="strMemo"
                                class="layui-textarea" placeholder="请填写入库描述信息"
                                lay-verify="strMemo" rowspan="5" style="width: 500px;"></textarea>
                </div>
            </div>
            <div class="dialogFooter">
                <button type="submit" class="layui-btn">提交</button>
            </div>
        </div>
    </form>
</div>
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
                Dialog.success(messages);
                <%--${ctx}/miAcceptanceD/preCreate--%>
                $("#allPageContent").load("${ctx}/miBeginningM/saveDtl?id=" + strInspNo + "&strStatus=N", {}, function () {
                    var dialogIndex = Dialog.getCurrentDialog().attr("times");
                    if (dialogIndex) {
                        layer.close(dialogIndex);
                    }
                });
            } else {
                Dialog.error(messages);
            }
        } catch (e) {
            console.log(messages);
            Dialog.error(e.message);
        }
    }
</script>
