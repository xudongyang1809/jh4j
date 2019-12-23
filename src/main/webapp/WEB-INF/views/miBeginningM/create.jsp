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
        });
        laydate.render({
            elem: '#strData3'
        });
    });
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

    /*
 * 选择单个人员的回调方法
 */
    function selectSingleUserCallback(userId, userNo, username) {
        $('#PickNameUserID').val(userId);
        $('#PickNameUser').val(username);
    }
</script>
<form class="layui-form" method="post" action="${ctx}/miBeginningM/create"
      onsubmit="return dialogAjaxDone(this, 'create')">
    <div class="dialogContent" style="right: 60px;">
        <div class="layui-form-item">
            <label class="layui-form-label">入库单号:</label>
            <div class="layui-input-inline">
                <input type="text" name="strInspNo" value="${strOrdNo}" autocomplete="on" class="layui-input"
                       style="padding-right: 50px;background-color: WhiteSmoke;">
            </div>
            <label class="layui-form-label">入库时间:</label>
            <div class="layui-input-inline">
                <input type="text" lay-verify="required" class="layui-input" id="strData1"
                       autocomplete=“off” name="strApplyDateTime" placeholder="入库时间">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">入库单状态:</label>
            <div class="layui-input-inline">
                <select name="strStatus">
                    <option value="N" ${miAcceptanceM.strStatus eq 'N' ? 'selected':''}>新增</option>
                    <option value="C" ${miAcceptanceM.strStatus eq 'C' ? 'selected':''}>确认</option>
                    <option value="X" ${miAcceptanceM.strStatus eq 'X' ? 'selected':''}>结案</option>
                </select>
            </div>
            <label class="layui-form-label">入库类型：</label>
            <div class="layui-input-inline">
                <select name="strInspType">
                    <option value='D'
                    ${miAcceptanceM.strInspType eq 'D' ? "selected":""}>期初入库
                    </option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">入库人:</label>
            <div class="layui-input-inline">
                <input type="hidden" id="PickNameUserID" name="strInUserId"/>
                <input type="text" id="PickNameUser" placeholder="点击挑选人员..." readonly class="layui-input"
                       style="padding-right: 50px;"/>
                <i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
                <a class="layui-btn layui-btn-sm" onPickUser="selectSingleUserCallback"
                   style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i
                        autocomplete=“off” class="layui-icon layui-icon-search"></i></a>
            </div>
            <label class="layui-form-label">入库单金额:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="strInspNoPrice"
                       readonly value="0" placeHolder="请输入入库单金额"/>
            </div>
        </div>
        <%--        <div class="layui-form-item">
                    <div class="layui-col-md6">
                        <label class="layui-form-label">订单编号:</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" name="strOrderNo" placeHolder="请选择销售订单编号"/>
                        </div>
                    </div>
                    <div class="layui-col-md6">
                        <label class="layui-form-label">红冲单号:</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" name="strRedRush" placeHolder="请输入红冲单号"/>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-col-md6">
                        <label class="layui-form-label">仓库:</label>
                        <div class="layui-input-inline">
                            <select name="strLocNo" id="strLocNo" lay-filter="selectLocNo">
                                <c:forEach items="${dictDtlList}" var="field">
                                    <option value='${field.id}'>${field.strValue}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="layui-col-md6">
                        <label class="layui-form-label">供应商:</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" name="strSaleVendor" placeHolder="请挑选供应商"/>
                        </div>
                    </div>
                </div>--%>

        <%--<div class="layui-form-item">
            <label class="layui-form-label">生效人员:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="strCfmEmpNo" placeHolder="请选择生效人员"/>
            </div>
            <label class="layui-form-label">生效日期:</label>
            <div class="layui-input-inline">
                <input type="text" lay-verify="required" class="layui-input" id="strData2"
                       name="strCfmDateTime" placeholder="生效日期">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-col-md6">
                <label class="layui-form-label">实际到货日期:</label>
                <div class="layui-input-inline">
                    <input type="text" lay-verify="required" class="layui-input" id="strData3"
                           name="strActualDate" placeholder="实际到货日期">
                </div>
            </div>
            <div class="layui-col-md6">
                <label class="layui-form-label">储位:</label>
                <div class="layui-input-inline">
                    <select name="strAreaId" id="strAreaId">
                    </select>
                    &lt;%&ndash;<input type="text" class="layui-input" name="strAreaId" placeHolder="请挑选储位"/>&ndash;%&gt;
                </div>
            </div>
        </div>--%>
    </div>
    <div class="dialogFooter">
        <button type="submit" class="layui-btn">提交</button>
    </div>
</form>
