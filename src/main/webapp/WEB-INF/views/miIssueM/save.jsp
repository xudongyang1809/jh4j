<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<style type="text/css">
    .layui-icon-about:before {
        content: "";
    }

    table a:LINK {
        color: blue;
    }

    table a:HOVER {
        position: absolute;
    }

    #tabinfo {
        width: 90%;
        border-collapse: separate;
        border-spacing: 20px;
    }

    #tabinfo .td1 {
        text-align: right;
    }

    #tabinfo td {
        text-align: left;
    }

    .cutomtable td {
        margin-left: 15px;
        padding: 10px;
    }
</style>
<div id="alls">
    <div class="layui-tab" id="layui-tab">
        <ul class="layui-tab-title">
            <li class="layui-this">基本资料</li>
            <li onclick="loadTab('2')">出库明细</li>
        </ul>
        <div class="layui-tab-content">
            <div id="tab1" class="layui-tab-item layui-show">
                <div class="tab-bars">
                    <button type="button" onclick="saveM()" class="confirm">保存</button>
                </div>
                <form method="post" class="layui-form" action="${ctx}/miIssueM/save" id="savedata">
                    <div class="layui-form-item"></div>
                    <input type="hidden" name="id" value="${miIssueM.id}"/>
                    <div class="layui-form-item">
                        <label class="layui-form-label">出库单号：</label>
                        <div class="layui-input-inline">
                            <input type="text" id="idShip" name="strApplyNo" value="${miIssueM.strApplyNo}"
                                   class="layui-input" autocomplete="off" readonly="readonly"
                                   placeholder="出库单号自动生成"/>
                        </div>
                        <label class="layui-form-label">出库类型：</label>
                        <div class="layui-input-inline">
                            <select name="strOutType">
                                <option value=''>---请选择---</option>
                                <option value='A' ${miIssueM.strOutType eq 'A'? 'selected':'' }>领料出库</option>
                                <option value='S' ${miIssueM.strOutType eq 'S'? 'selected':'' }>销售出库</option>
                            </select>
                        </div>
                        <label class="layui-form-label">状态:</label>
                        <div class="layui-input-inline">
                            <select id="strStus" name="strStus" class="layui-input" disabled="disabled">
                                <option value="N" ${miIssueM.strStus eq 'N' ? 'selected':''}>新增</option>
                                <option value="S" ${miIssueM.strStus eq 'S' ? 'selected':''}>生效</option>
                                <option value="D" ${miIssueM.strStus eq 'D' ? 'selected':''}>删除</option>
                            </select>
                        </div>
                    </div>
                    <%--<div class="layui-form-item">
                        <label class="layui-form-label">入库单号：</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" name="strInspNo" value="${miIssueM.strInspNo}"
                                   placeHolder="请输入入库单号"/>
                        </div>
                        <label class="layui-form-label">出货仓库:</label>
                        <div class="layui-input-inline">
                            <select name="strLocNo" id="strLocNo" lay-filter="selectLocNo">
                                <c:forEach items="${dictDtlList}" var="field">
                                    <option value='${field.id}'${field.id eq  miIssueM.strLocNo ?'selected':field.id}>${field.strValue}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <label class="layui-form-label">采购合同号:</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" name="strPoNo" value="${miIssueM.strPoNo}"
                                   placeHolder="请输入采购合同号"/>
                        </div>
                         <label class="layui-form-label">销售订单号：</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" name="strOrderNo" value="${miIssueM.strOrderNo}"
                                   placeHolder="请输入销售订单号"/>
                        </div>
                         <label class="layui-form-label">出库人:</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" name="strOutUserId"
                                   value="${miIssueM.strOutUserId}" placeHolder="请输入出库人"/>
                        </div>
                         <label class="layui-form-label">出库时间:</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" name="strOutData" value="${miIssueM.strOutData}"
                                   id="strData2" placeHolder="请选择出库时间"/>
                        </div>
                    </div>--%>
                    <div class="layui-form-item">
                        <label class="layui-form-label">申请人:</label>
                        <div class="layui-input-inline">
                            <input type="hidden" id="PickEditNameID" name="strApplyUserId"/>
                            <input type="text" id="PickEditName" value="${pickusername}" placeholder="点击挑选人员..."
                                   readonly
                                   class="layui-input" style="padding-right: 50px;"/>
                            <i class="layui-icon layui-icon-close"
                               onclick="$(this).parent().find('input').val('');"></i>
                            <a class="layui-btn layui-btn-sm" onPickUser="selectSingleUserCallback"
                               style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i
                                    class="layui-icon layui-icon-search"></i></a>
                        </div>
                        <label class="layui-form-label">申请时间:</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" name="strApplyTime" id="strData1"
                                   value="${miIssueM.strApplyTime}" placeHolder="请选择申请时间"/>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">备注：</label>
                        <div class="layui-input-inline">
                            <textarea type="text" class="layui-input" name="strMemo"
                                      rowspan="5" style="width: 500px;height: 100px" placeHolder="请输入备注"
                                      style="">${miIssueM.strMemo}</textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div id="tab2" class="layui-tab-item"></div>
        </div>
    </div>
</div>
<script type="text/javascript">
    /* 提交方法 */
    function saveM(rst) {
        $.ajax({
            url: "${ctx}/miIssueM/save",
            data: $('#savedata').serialize(),
            dataType: 'json',
            success: function (rst) {
                if (rst.statusCode == '200') {
                    top.layer.msg(rst.message, {icon: 1});
                    loadTab(1);
                } else {
                    top.layer.msg(rst.message, {icon: 2});
                }
            }
        });
    }

    form.render();

    function loadTab(num) {
        var id = $("#idShip").val();
        var strStus = $("#strStus").val();
        if (num == '2') {
            $("#tab" + num).load("${ctx}/miIssueM/saveDtl?id=" + id + "&strStus=" + strStus, {},
                function () {
                });
        }
    }

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
    form.on('select(selectLocNo)', function (data) {
        var strLocNo = data.value;
        $('#strLocNo').val(strLocNo);
    });

    /*
    * 选择单个人员的回调方法
    */
    function selectSingleUserCallback(userId, userNo, username) {
        $('#PickEditNameID').val(userId);
        $('#PickEditName').val(username);
    }
</script>