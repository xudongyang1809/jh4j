<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<!--
@desc 编辑画面
@author 超级管理员 admin
@date 2019-05-16 10:46:58
@Copyright: 江苏金恒信息科技股份有限公司
-->
<head>
    <script type="text/javascript">
    </script>
</head>
<form class="layui-form" method="post" action="${ctx}/miCheck/update" onsubmit="return dialogAjaxDone(this, 'update')">
    <input type="hidden" name="id" value="${miCheck.id}"/>
    <div class="dialogContent" style="right: 20px;">
        <div class="layui-form-item">
            <label class="layui-form-label">盘点单号:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="strCheckno" value="${miCheck.strCheckno}"
                       placeHolder="请输入盘点单号"/>
            </div>
            <label class="layui-form-label">盘点仓库:</label>
            <div class="layui-input-inline">
                <select name="strAreaId" id="strAreaId">
                    <c:forEach items="${dictDtlList}" var="field">
                        <option value='${field.id}'${field.id eq  miCheck.strAreaId ?'selected':field.id}>${field.strValue}</option>
                    </c:forEach>
                </select>
            </div>
            <label class="layui-form-label">状态:</label>
            <div class="layui-input-inline">
                <select name="strTradingStatus" disabled="disabled" value="${miCheck.strTradingStatus}" class="layui-input">
                    <option value=""  ${miCheck.strTradingStatus eq '' ? 'selected':''}>-请选择-</option>
                    <option value="1" ${miCheck.strTradingStatus eq '1' ? 'selected':''}>新建</option>
                    <option value="2" ${miCheck.strTradingStatus eq '2' ? 'selected':''}>已盘点</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">用途类别:</label>
            <div class="layui-input-inline">
                <%--	<input type="text" name="strSpecificUse" class="layui-input" value="${miCheck.strSpecificUse}"    />--%>
                <select name="strSpecificUse" class="layui-input">
                    <option value="" ${miCheck.strSpecificUse eq '' ? 'selected':''}>-请选择-</option>
                    <option value="1" ${miCheck.strSpecificUse eq '1' ? 'selected':''}>盘盈</option>
                    <option value="2" ${miCheck.strSpecificUse eq '2' ? 'selected':''}>盘亏</option>
                </select>
            </div>
            <label class="layui-form-label">计划盘点日期:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strData1" lay-verify="required" name="strplannedInventoryDate"
                       value="${miCheck.strplannedInventoryDate}"
                       placeHolder="请输入计划盘点日期"/>
            </div>
            <label class="layui-form-label">申请单号:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="strApplyNo" value="${miCheck.strApplyNo}"
                       placeHolder="请输入申请单号"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">申请人:</label>
            <div class="layui-input-inline">
                <input type="hidden" id="PickNameUserID" name="strApplyUser"/>
                <input type="text" id="PickNameUser" value="${StrApplyUserName}" placeholder="点击挑选人员..." readonly
                       class="layui-input"
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
                <input type="text" id="deptName" value="${StrApplyDeptName}" placeholder="选择部门..." readonly
                       class="layui-input" style="background-position: 107% 0;"/>
                <i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
                <button type="button" class="layui-btn layui-btn-sm" style="position: absolute; top: 4px; right: 5px;"
                        onPickDept="deptId,deptNo,deptName">
                    <i class="layui-icon">&#xe615;</i>
                </button>
            </div>
            <label class="layui-form-label">申请人联系方式:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" lay-verify="required" name="strApplyUserPhone"
                       value="${miCheck.strApplyUserPhone}"
                       placeHolder="请输入申请人联系方式"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">申请日期:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strData2" lay-verify="required" name="strApplyDate"
                       value="${miCheck.strApplyDate}"
                       placeHolder="请输入申请日期"/>
            </div>
            <label class="layui-form-label">备注:</label>
            <div class="layui-input-inline">
                            <textarea type="textarea" name="strMemo"
                                      class="layui-textarea" placeholder="请填写入库描述信息"
                                      lay-verify="strMemo" rowspan="4" style="width: 500px;">${miCheck.strMemo}</textarea>
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