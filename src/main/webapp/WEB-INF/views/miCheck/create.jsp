<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>

<form class="layui-form" method="post" action="${ctx}/miCheck/create" onsubmit="return dialogAjaxDone(this, 'create')">
    <div class="dialogContent" style="right: 20px;">
        <div class="layui-form-item">
            <label class="layui-form-label">盘点单号:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="strCheckno" placeHolder="请输入盘点单号"/>
            </div>
            <label class="layui-form-label">盘点仓库:</label>
            <div class="layui-input-inline">
                <select name="strAreaId" id="strAreaId">
                    <c:forEach items="${dictDtlList}" var="field">
                        <option value='${field.id}'>${field.strValue}</option>
                    </c:forEach>
                </select>
            </div>
            <label class="layui-form-label">状态:</label>
            <div class="layui-input-inline">
                <select name="strTradingStatus" disabled="disabled" class="layui-input">
                    <option value="1">新建</option>
                    <option value="2" }>已盘点</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">用途类别:</label>
            <div class="layui-input-inline">
                <%--	<input type="text" name="strSpecificUse" class="layui-input" value="${miCheck.strSpecificUse}"    />--%>
                <select name="strSpecificUse" lay-verify="required" class="layui-input">
                    <option value="" ${miCheck.strSpecificUse eq '' ? 'selected':''}>-请选择-</option>
                    <option value="1" ${miCheck.strSpecificUse eq '1' ? 'selected':''}>盘盈</option>
                    <option value="2" ${miCheck.strSpecificUse eq '2' ? 'selected':''}>盘亏</option>
                </select>
            </div>
            <label class="layui-form-label">计划盘点日期:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strData1" lay-verify="required"
                       autocomplete="off" name="strplannedInventoryDate"
                       placeHolder="请输入计划盘点日期"/>
            </div>
            <label class="layui-form-label">申请日期:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strData2" lay-verify="required" name="strApplyDate"
                       autocomplete="off" placeHolder="请输入申请日期"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">申请单号:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="strApplyNo" placeHolder="请输入申请单号"/>
            </div>
            <label class="layui-form-label">申请人:</label>
            <div class="layui-input-inline">
                <input type="hidden" id="PickNameUserID" name="strApplyUser"/>
                <input type="text" id="PickNameUser" placeholder="点击挑选人员..." readonly class="layui-input"
                       style="padding-right: 50px;"/>
                <i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
                <a class="layui-btn layui-btn-sm" onPickUser="selectSingleUserCallback"
                   style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i
                        class="layui-icon layui-icon-search"></i></a>
            </div>
            <label class="layui-form-label">申请部门:</label>
            <div class="layui-input-inline">
                <input type="hidden" id="deptId" name="strApplyDept"/>
                <input type="hidden" id="deptNo"/>
                <input type="text" id="deptName" placeholder="选择部门..." readonly class="layui-input"
                       style="background-position: 107% 0;"/>
                <i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
                <button type="button" class="layui-btn layui-btn-sm" style="position: absolute; top: 4px; right: 5px;"
                        onPickDept="deptId,deptNo,deptName">
                    <i class="layui-icon">&#xe615;</i>
                </button>
            </div>

        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">申请人联系方式:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" lay-verify="required" name="strApplyUserPhone"
                       placeHolder="请输入申请人联系方式"/>
            </div>
            <label class="layui-form-label">备注:</label>
            <div class="layui-input-inline">
                <textarea type="text" style="width: 500px" class="layui-textarea" name="strMemo"
                          placeHolder="请输入备注"></textarea>
            </div>
        </div>
    </div>
    <div class="dialogFooter">
        <button type="submit" class="layui-btn">提交</button>
    </div>
</form>
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
    });

    /*
    * 选择单个人员的回调方法
    */
    function selectSingleUserCallback(userId, userNo, username) {
        $('#PickNameUserID').val(userId);
        $('#PickNameUser').val(username);
    }
</script>