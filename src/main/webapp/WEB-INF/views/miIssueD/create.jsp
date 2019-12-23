<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<!--
@desc 创建画面
@author 超级管理员 admin
@date 2019-05-07 09:16:29
@Copyright: 江苏金恒信息科技股份有限公司
-->
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
</script>
<form class="layui-form" method="post" action="${ctx}/miIssueD/create"
      onsubmit="return validateCallback(this, dialogInsertPlanDone);">
    <div class="dialogContent" style="right: 60px;">
        <div class="layui-form-item">
            <label class="layui-form-label">销账单号:</label>
            <div class="layui-input-inline">
                <input type="text" readonly class="layui-input" name="strSaleNo" value="${strSaleNo}" placeHolder="请输入销账单号"/>
            </div>
            <label class="layui-form-label">出库单号:</label>
            <div class="layui-input-inline">
                <input type="text" readonly class="layui-input" id="strApplyNo" name="strApplyNo" value="${strApplyNo}"
                       placeHolder="请输入出库单号"/>
            </div>
            <label class="layui-form-label">出库项次:</label>
            <div class="layui-input-inline">
                <input type="text" readonly class="layui-input" value="${strShipItem}" name="strShipItem" placeHolder="请输入出库项次"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">验收入库单:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strInspNo" name="strInspNo"
                       readonly lay-verify="required" autocomplete="off"
                       placeHolder="请挑选入库单"/>
                <a class="layui-btn layui-btn-sm" href="${ctx}/miIssueD/selectInventory" title="请挑选入库单"
                   target="dialog" width="1000" height="500" dialogId="selectInventory"
                   style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i
                        class="layui-icon layui-icon-search"></i></a>
            </div>
            <label class="layui-form-label">验收入库项次号:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strInspItemCon" name="strInspItemCon" placeHolder="请输入验收入库项次号"/>
            </div>
            <label class="layui-form-label">存货编号:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strMatrlNo" name="strMatrlNo" placeHolder="请输入存货编号"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">型号规格:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strSpec" name="strSpec" placeHolder="请输入型号规格"/>
            </div>
            <label class="layui-form-label">品名:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strMatrlName" name="strMatrlName" placeHolder="请输入品名"/>
            </div>
            <label class="layui-form-label">计量单位:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strUnit" name="strUnit" placeHolder="请输入计量单位"/>
            </div>
        </div>
            <div class="layui-form-item">
                <label class="layui-form-label">品牌:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="strBrand" name="strBrand" placeHolder="请输入品牌"/>
                </div>
                <label class="layui-form-label">单价:</label>
                <div class="layui-input-inline">
                    <input type="text" lay-verify="required|number" class="layui-input" id="bdRealPrice" name="bdRealPrice"
                           placeHolder="请输入单价"/>
                </div>
                <label class="layui-form-label">销售数量:</label>
                <div class="layui-input-inline">
                    <input type="text" lay-verify="required|number" class="layui-input" name="bdSaleQty"
                           placeHolder="请输入销售数量"/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">储位:</label>
                <div class="layui-input-inline">
                    <select lay-filter="strAreaId" name="strAreaId" id="strAreaId">
                        <c:forEach items="${strAreaIdList}" var="field">
                            <option value='${field.id}'>${field.strName}</option>
                        </c:forEach>
                    </select>
                </div>
                <label class="layui-form-label">金额:</label>
                <div class="layui-input-inline">
                    <input type="text" lay-verify="required|number" class="layui-input" id="bdAmt" name="bdAmt"
                           placeHolder="请输入金额"/>
                </div>
                <label class="layui-form-label">销账人:</label>
                <div class="layui-input-inline">
                    <input type="text" lay-verify="required" class="layui-input" name="strCfmEmpNo"
                           placeHolder="请输入销账人"/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">销账日期:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="strCfmDateTime" name="strCfmDateTime"
                           placeHolder="请输入销账日期"/>
                </div>
                <label class="layui-form-label">出库人:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="strOutUserId" placeHolder="请输入出库人"/>
                </div>
                <label class="layui-form-label">出库时间:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="strOutTime" name="strOutTime" placeHolder="请输入出库时间"/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">出库数量:</label>
                <div class="layui-input-inline">
                    <input type="text" lay-verify="required|number" class="layui-input" id="bdQty" name="bdQty"
                           placeHolder="请输入出库数量"/>
                </div>
                <label class="layui-form-label">使用单位:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="strUserCust" placeHolder="请输入使用单位"/>
                </div>
                <label class="layui-form-label">状态:</label>
                <div class="layui-input-inline">
                    <select name="strStus" class="layui-input">
                        <option value="A">未出库</option>
                        <option value="B">已出库</option>
                        <option value="C">未销账</option>
                        <option value="D">已销账</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">出库类型:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="strA" placeHolder="请输入出库类型"/>
                </div>
                <label class="layui-form-label">备注:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="strMemo" placeHolder="请输入备注"/>
                </div>
                <label class="layui-form-label">审核人:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="strVerifyUser" placeHolder="请输入审核人"/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">供应商:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="strB" placeHolder="请输入供应商"/>
                </div>
            </div>
        </div>
        <div class="dialogFooter">
            <button type="submit" class="layui-btn">提交</button>
        </div>
</form>
<script>
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

<%--
<label class="layui-form-label">销售订单号:</label>
<div class="layui-input-inline">
    <input type="text" class="layui-input" name="strOrderNo" placeHolder="请输入销售订单号"/>
</div>
<label class="layui-form-label">销售订单项次:</label>
<div class="layui-input-inline">
    <input type="text" class="layui-input" name="strOrderItem" placeHolder="请输入销售订单项次"/>
</div>
<label class="layui-form-label">需求明细项次:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="strReqItem" placeHolder="请输入需求明细项次"/>
            </div>
             <label class="layui-form-label">需求计划编号:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="strReqNo" placeHolder="请输入需求计划编号"/>
            </div>
            <div class="layui-form-item">
            <label class="layui-form-label">采购合同项次:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="strPoItemNo" placeHolder="请输入采购合同项次"/>
            </div>
            <label class="layui-form-label">采购合同号:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="strPoNo" placeHolder="请输入采购合同号"/>
            </div>
        </div>
         <label class="layui-form-label">红冲单号:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="strRedRush" placeHolder="请输入红冲单号"/>
                </div>
--%>
