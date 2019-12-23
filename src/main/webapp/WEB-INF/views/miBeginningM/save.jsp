<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<html>
<head>
    <script>
        function loadTab(num) {
            var id = $("#strInspNo").val();
            var strStatus = $("#strStatus").val();
            if (num == '2') {
                $("#tab" + num).load("${ctx}/miBeginningM/saveDtl?id=" + id + "&strStatus=" + strStatus, {},
                    function () {
                    });
            }
        }

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
        //日期控件
        layui.use('laydate', function () {
            var laydate = layui.laydate;
            //常规用法
            laydate.render({
                elem: '#strData1'
            });
            laydate.render({
                elem: '#strActualDate'
            });
            laydate.render({
                elem: '#strCfmDateTime'
            });
        });
    </script>
</head>
<div id="all">
    <div class="layui-tab" id="layui-tab">
        <ul class="layui-tab-title">
            <li class="layui-this">入库主档信息</li>
            <li onclick="loadTab('2')">入库明细</li>
        </ul>
        <div class="layui-tab-content">
            <div id="tab1" class="layui-tab-item layui-show">
                <div class="tab-bars">
                    <c:if test="${miAcceptanceM.strStatus == 'N'}">
                        <button type="button" onclick="saveM()" class="confirm">保存</button>
                    </c:if>
                    <%--  <a class="add" href="#" onclick="saveM()"><span>保存</span></a>
                      <a class="delete btn-small" href="#" onclick="ihTrade('dele')"><span>删除</span></a>
                      <a class="confirm btn-small" href="#" onclick="ihTrade('effect')"><span>确认</span></a>
                      <a class="cancelConfirm btn-small" href="#" onclick="ihTrade('uneffect')"><span>取消确认</span></a>--%>
                </div>
                <form method="post" action="${ctx}/miBeginningM/save" class="layui-form" id="savedata"
                      onsubmit="return validateCallback(this, dialogInsertPlanDone);">
                    <div class="layui-form-item"></div>
                    <input type="hidden" id="id" name="id" value="${id}"/>
                    <div class="layui-form-item">
                        <label class="layui-form-label">入库单号:</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input layui-bg-gray" name="strInspNo" id="strInspNo"
                                   value="${miAcceptanceM.strInspNo}" readonly="true"/>
                        </div>
                        <label class="layui-form-label">入库单状态:</label>
                        <div class="layui-input-inline">
                            <select id="strStatus" name="strStatus" disabled="disabled">
                                <option value="N" ${miAcceptanceM.strStatus eq 'N' ? 'selected':''}>新增</option>
                                <option value="C" ${miAcceptanceM.strStatus eq 'C' ? 'selected':''}>确认</option>
                            </select>
                        </div>
                        <label class="layui-form-label">入库类型:</label>
                        <div class="layui-input-inline">
                            <select name="strInspType">
                                <option value='D'
                                ${miAcceptanceM.strInspType eq 'D' ? "selected":""}>期初入库
                                </option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">入库单金额:</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" name="strInspNoPrice" readonly
                                   value="${miAcceptanceM.strInspNoPrice}"/>
                        </div>
                        <label class="layui-form-label">入库人</label>
                        <div class="layui-input-inline">
                            <input type="hidden" id="EditPickNameID" name="strInUserId"/>
                            <input type="text" id="EditPickName" value="${pickusername}" placeholder="点击挑选人员..."
                                   class="layui-input" style="padding-right: 50px;"/>
                            <i class="layui-icon layui-icon-close"
                               onclick="$(this).parent().find('input').val('');"></i>
                            <a class="layui-btn layui-btn-sm" onPickUser="selectSingleUserCallback"
                               style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i
                                    class="layui-icon layui-icon-search"></i></a>
                        </div>
                        <label class="layui-form-label">入库时间:</label>
                        <div class="layui-input-inline">
                            <input type="text" class="layui-input" name="strApplyDateTime"
                                   id="strData1" value="${miAcceptanceM.strApplyDateTime}"/>
                        </div>
                    </div>
                    <%-- <div class="layui-form-item">
                         <label class="layui-form-label">生效人员:</label>
                         <div class="layui-input-inline">
                             &lt;%&ndash;<input type="hidden" name="strCfmEmpNo" value="${miAcceptanceM.strCfmEmpNo}"/>&ndash;%&gt;
                             <input type="text" class="layui-input" name="strCfmEmpNo"
                                    value="${miAcceptanceM.strCfmEmpNo}"/>
                         </div>
                         <label class="layui-form-label">生效日期:</label>
                         <div class="layui-input-inline">
                             <input type="text" class="layui-input" id="strCfmDateTime"
                                    id="strData2" name="strCfmDateTime"
                                    value="${miAcceptanceM.strCfmDateTime}"/>
                         </div>
                     </div>--%>
                    <div>
                        <label class="layui-form-label">备注:</label>
                        <div class="layui-input-inline">
                            <textarea type="textarea" name="strMemo"
                                      class="layui-textarea" placeholder="请填写入库描述信息，不超过100个字"
                                      lay-verify="strMemo" rowspan="5"
                                      style="width: 500px;">${miAcceptanceM.strMemo}</textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div id="tab2" class="layui-tab-item"></div>
        </div>
    </div>
</div>
<%-- <div class="layui-form-item">
                               <label class="layui-form-label">仓库:</label>
                               <div class="layui-input-inline">
                                   <select name="strLocNo" id="strLocNo" lay-filter="selectLocNo">
                                       <c:forEach items="${dictDtlList}" var="field">
                                           <option value='${field.id}'${field.id eq  miAcceptanceM.strLocNo ?'selected':field.id}>${field.strValue}</option>
                                       </c:forEach>
                                   </select>
                               </div>
                           </div>

                               <label class="layui-form-label">供应商:</label>
                               <div class="layui-input-inline">
                                   &lt;%&ndash;<input type="hidden"  id="strSaleVendor" name="strSaleVendor" value="${miAcceptanceM.strSaleVendor}" />&ndash;%&gt;
                                   <input type="text" class="layui-input" id="strSaleVendorName"
                                          name="strSaleVendor"
                                          value="${miAcceptanceM.strSaleVendor}"/>
                               </div>
                           </div>

                               <label class="layui-form-label">实际到货日期:</label>
                               <div class="layui-input-inline">
                                   <input type="text" class="layui-input" id="strActualDate"
                                          name="strActualDate"
                                          size="16%" value="${miAcceptanceM.strActualDate}"/>
                               </div>
                           </div>

                               <label class="layui-form-label">
                                   储位:</label>
                               <div class="layui-input-inline">
                                   <select name="strAreaId" id="strAreaId">
                                       <c:forEach items="${strAreaIdList}" var="field">
                                           <option value='${field.id}'${field.id eq  miAcceptanceM.strAreaId ?'selected':field.id}>${field.strName}</option>
                                       </c:forEach>
                                   </select>
                               </div>
                           </div>
                       </div>--%>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
<script type="text/javascript">
    function dialogInsertPlanDone(result) {
        try {
            var id = $("#strInspNo").val()
            var loadingIndex = Dialog.load();
            var messages = result.message;
            ss = messages.split(",");
            Dialog.success(ss[1]);
            if (result.statusCode == 200) {
                $("#tab2").load("${ctx}/miBeginningM/saveDtl?id=" + id, {},
                    function () {
                    });
                NavTab.reloadWithPagination(result.navTabId);
            }
        } catch (e) {
            // console.log(msg);
            Dialog.error(e.message);
        } finally {
            layer.close(loadingIndex);
        }
    }

    /* 提交方法 */
    function saveM(rst) {
        $.ajax({
            url: "${ctx}/miBeginningM/save",
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

    layui.use('form', function () {
        var form = layui.form;
        form.verify({
            strMemo: function (value, item) {
                if (value.length > 100) {
                    return '最大评价字数量不能超过100字？！';
                }
            }
        });
    });

    /*
        * 选择单个人员的回调方法
    */
    function selectSingleUserCallback(userId, userNo, username) {
        $('#EditPickNameID').val(userId);
        $('#EditPickName').val(username);
    }
</script>

</html>

