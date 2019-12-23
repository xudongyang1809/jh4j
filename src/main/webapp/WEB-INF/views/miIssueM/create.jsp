<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<script>
    //日期控件
    layui.use('laydate', function () {
        var laydate = layui.laydate;
        //常规用法
        laydate.render({
            elem: '#strData1'
        });
        laydate.render({
            elem: '#strData2'
        })
        ;laydate.render({
            elem: '#strSendTime'
        });
    });

    /*
    * 选择单个人员的回调方法
    */
    function selectSingleUserCallback(userId, userNo, username) {
        $('#PickCreateNameID').val(userId);
        $('#PickCreateName').val(username);
    }
</script>
<form class="layui-form" method="post" action="${ctx}/miIssueM/create" onsubmit="return dialogAjaxDone(this, 'create')">
    <div class="dialogContent" style="right: 60px;">
        <div class="layui-form-item">
            <label class="layui-form-label">出库单号:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" value="${strApplyNo}" name="strApplyNo"
                       style="padding-right: 50px;background-color: WhiteSmoke;" placeHolder="请输入出库单号"/>
            </div>
            <label class="layui-form-label">出库类型:</label>
            <div class="layui-input-inline">
                <select name="strOutType">
                    <option value=''>---请选择---</option>
                    <option value='A' ${miIssueM.strOutType eq 'A'? 'selected':'' }>领料出库</option>
                    <option value='S' ${miIssueM.strOutType eq 'S'? 'selected':'' }>销售出库</option>
                </select>
            </div>
        </div>
        <%--        <div class="layui-form-item">
                    <label class="layui-form-label">入库单号:</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="strInspNo" placeHolder="请输入入库单号"/>
                    </div>
                    <label class="layui-form-label">出货仓库:</label>
                    <div class="layui-input-inline">
                        <select lay-filter="selectLocNo" name="strLocNo" id="strLocNo">
                            <c:forEach items="${dictDtlList}" var="field">
                                <option value='${field.id}'>${field.strValue}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <label class="layui-form-label">采购合同号:</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="strPoNo" placeHolder="请输入采购合同号"/>
                    </div>
                    <label class="layui-form-label">销售订单号:</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="strOrderNo" placeHolder="请输入销售订单号"/>
                    </div>
                     <label class="layui-form-label">出库人:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="strOutUserId" placeHolder="请输入出库人"/>
            </div>
              <label class="layui-form-label">出库时间:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strData2" name="strOutData" placeHolder="请选择出库时间"/>
            </div>
                </div>--%>
        <div class="layui-form-item">
            <label class="layui-form-label">状态:</label>
            <div class="layui-input-inline">
                <select name="strStus" class="layui-input" disabled="disabled">
                    <option value="N" ${miIssueM.strStus eq 'N' ? 'selected':''}>新增</option>
                </select>
            </div>
            <label class="layui-form-label">申请人:</label>
            <div class="layui-input-inline">
                <input type="hidden" id="PickCreateNameID" name="strApplyUserId"/>
                <input type="text" id="PickCreateName" placeholder="点击挑选人员..." class="layui-input"
                       readonly style="padding-right: 50px;"/>
                <i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
                <a class="layui-btn layui-btn-sm" onPickUser="selectSingleUserCallback"
                   style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i
                        class="layui-icon layui-icon-search"></i></a>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">申请时间:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strData1" name="strApplyTime" placeHolder="请选择申请时间"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">备注:</label>
            <div class="layui-input-inline">
                <textarea type="text" class="layui-input" id="strMemo" name="strSendTime"
                          rowspan="5" style="width: 500px;height: 100px"  placeHolder="请输入备注"></textarea>
            </div>
        </div>
    </div>
    <div class="dialogFooter">
        <button type="submit" class="layui-btn">提交</button>
    </div>
</form>
