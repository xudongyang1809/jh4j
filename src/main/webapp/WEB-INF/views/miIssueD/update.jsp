<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<!--
@desc 编辑画面
@author 超级管理员 admin
@date 2019-05-07 09:16:29
@Copyright: 江苏金恒信息科技股份有限公司
-->
<head>
    <script type="text/javascript">
        //日期控件
        layui.use('laydate', function () {
            var laydate = layui.laydate;
            //常规用法
            laydate.render({
                elem: '#strOutTime'
            });
            laydate.render({
                elem: '#strCfmDateTime'
            })
        });

        function dialogInsertPlanDone(result) {
            var strApplyNo = document.getElementById("strApplyNo").value;
            try {
                var loadingIndex = Dialog.load();
                var messages = result.message;
                ss = messages.split(",");
                Dialog.success("新增成功");
                if (result.statusCode == 200) {
                    $("#allPageContent").load("${ctx}/miIssueM/saveDtl/?id=" + strApplyNo + "&tab=2", {}, function () {
                    })
                }
            } catch (e) {
                console.log(msg);
                Dialog.error(e.message);
            } finally {
                layer.close(loadingIndex);
            }
        }
    </script>
</head>
<form class="layui-form" method="post" action="${ctx}/miIssueD/update" onsubmit="return dialogAjaxDone(this, 'update')">
    <div class="dialogContent" style="right: 60px;">
        <input type="hidden" name="id" value="${miIssueD.id}"/>
        <div class="layui-form-item">
            <label class="layui-form-label">销账单号:</label>
            <div class="layui-input-inline">
                <input type="text" readonly class="layui-input" name="strSaleNo" value="${miIssueD.strSaleNo}"
                       placeHolder="请输入销账单号"/>
            </div>
            <label class="layui-form-label">出库单号:</label>
            <div class="layui-input-inline">
                <input type="text" readonly class="layui-input" id="strApplyNo" name="strApplyNo"
                       value="${miIssueD.strApplyNo}"
                       placeHolder="请输入出库单号"/>
            </div>
            <label class="layui-form-label">出库项次:</label>
            <div class="layui-input-inline">
                <input type="text" readonly class="layui-input" value="${miIssueD.strShipItem}" name="strShipItem"
                       placeHolder="请输入出库项次"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">状态:</label>
            <div class="layui-input-inline">
                <select name="strStus" disabled="disabled" class="layui-input">
                    <option value="A">未出库</option>
                    <option value="B">已出库</option>
                    <option value="C">未销账</option>
                    <option value="D">已销账</option>
                </select>
            </div>
            <label class="layui-form-label">验收入库单:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strInspNo" name="strInspNo"
                       readonly lay-verify="required"  autocomplete="off" value="${miIssueD.strInspNo}"
                       placeHolder="请挑选入库单"/>
                <a class="layui-btn layui-btn-sm" href="${ctx}/miIssueD/selectInventory" title="请挑选入库单"
                   target="dialog" width="1000" height="500" dialogId="selectInventory"
                   style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i
                        class="layui-icon layui-icon-search"></i></a>
            </div>
            <label class="layui-form-label">验收入库项次号:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" readonly id="strInspItem" value="${miIssueD.strInspItemCon}"
                       name="strInspItemCon" placeHolder="请输入验收入库项次号"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">单价:</label>
            <div class="layui-input-inline">
                <input type="text" readonly class="layui-input" value="${miIssueD.bdRealPrice}"
                       id="bdRealPrice" name="bdRealPrice"
                       placeHolder="请输入单价"/>
            </div>
            <label class="layui-form-label">出库数量:</label>
            <div class="layui-input-inline">
                <input type="text" readonly value="${miIssueD.bdQty}" class="layui-input" id="bdQty"
                       name="bdQty"
                       placeHolder="请输入出库数量"/>
            </div>
            <label class="layui-form-label">金额:</label>
            <div class="layui-input-inline">
                <input type="text" readonly class="layui-input" id="bdAmt" name="bdAmt"
                       value="${miIssueD.bdAmt}"
                       placeHolder="请输入金额"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">存货编号:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strMatrlNo" readonly value="${miIssueD.strMatrlNo}" name="strMatrlNo"
                       placeHolder="请输入存货编号"/>
            </div>
            <label class="layui-form-label">储位:</label>
            <div class="layui-input-inline">
                <select lay-filter="strAreaId" disabled="disabled" name="strAreaId" id="strAreaId">
                    <c:forEach items="${strAreaIdList}" var="field">
                        <option value='${field.id}'${field.id eq  miIssueD.strAreaId ?'selected':field.id}>${field.strName}</option>
                    </c:forEach>
                </select>
            </div>
            <label class="layui-form-label">品名:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strMatrlName" readonly value="${miIssueD.strMatrlName}"
                       name="strMatrlName" placeHolder="请输入品名"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">型号规格:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strSpec" readonly value="${miIssueD.strSpec}" name="strSpec"
                       placeHolder="请输入型号规格"/>
            </div>

            <label class="layui-form-label">计量单位:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strUnit" readonly value="${miIssueD.strUnit}" name="strUnit"
                       placeHolder="请输入计量单位"/>
            </div>
            <label class="layui-form-label">品牌:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strBrand" readonly name="strBrand" value="${miIssueD.strBrand}"
                       placeHolder="请输入品牌"/>
            </div>
        </div>
        <div>
            <%--     <label class="layui-form-label">供应商:</label>
                 <div class="layui-input-inline">
                     <input type="text" class="layui-input" value="${miIssueD.strB}" name="strB" placeHolder="请输入供应商"/>
                 </div>--%>
            <label class="layui-form-label">备注:</label>
            <div class="layui-input-inline">
                <textarea type="textarea" class="layui-textarea" name="strMemo" style="width: 810px"
                          placeHolder="请输入备注">${miIssueD.strMemo}</textarea>
            </div>
        </div>
    </div>
    <div class="dialogFooter">
        <button type="submit" class="layui-btn">提交</button>
    </div>
</form>
