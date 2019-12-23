<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<html>
<head>
    <script>
        //日期控件
        layui.use('laydate', function () {
            var laydate = layui.laydate;
            //常规用法
            laydate.render({
                elem: '#strData1'
            });
            /*           laydate.render({
                           elem: '#strData2'
                       });*/
            laydate.render({
                elem: '#strData3'
            });
        });
        form.on('select(checkboxInviter)', function (data) {
            if ($(data.elem).hasClass("checkAllInviter")) {
                if (data.elem.checked) {
                    $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
                } else {
                    $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
                }
                form.render('checkbox');
            }
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
    </script>
    <style type="text/css">
        .tab-contentnew {
            position: absolute;
            top: 323px;
            bottom: 10px;
            left: 0px;
            right: 0px;
            overflow-x: scroll;
        }
        .layui-textarea {
            min-height: 80px;
            height: auto;
            line-height: 20px;
            padding: 6px 10px;
            resize: vertical;
        }
    </style>
</head>
<div id="all">
    <h2>入库--主档信息</h2>
    <div class="tab-bars">
        <c:if test="${miAcceptanceM.strStatus =='N' }">
            <button type="button" onclick="saveM()" class="confirm">保存</button>
        </c:if>
        <%--<a class="delete btn-small" href="#" onclick="ihTrade('dele')"><span>删除</span></a>--%>
        <%--<a class="confirm btn-small" href="#" onclick="ihTrade('effect')"><span>生效</span></a>--%>
        <%--<a class="cancelConfirm btn-small" href="#" onclick="ihTrade('uneffect')"><span>取消生效</span></a>--%>
    </div>
    <form id="pagerForm" method="post" action="${ctx}/miAcceptanceM/preUpdate/${id}">
        <input type="hidden" name="pageNum" value="${page.pageNum}"/>
        <input type="hidden" name="numPerPage" value="${page.numPerPage}"/>
        <input type="hidden" name="orderField" value="${page.orderField}"/>
        <input type="hidden" name="orderDirection" value="${page.orderDirection}"/>
        <input type="hidden" name="keywords" value="${keywords}"/>
    </form>
    <form method="post" action="${ctx}/miAcceptanceM/save"
          class="layui-form" id="savedata" onsubmit="return validateCallback(this, dialogInsertPlanDone);">
        <input type="hidden" id="id" name="id" value="${id}"/>
        <div class="layui-form-item">

            <label class="layui-form-label">入库单号:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input layui-bg-gray" name="strInspNo"
                       id="strInspNo" value="${miAcceptanceM.strInspNo}" readonly="true"/>
            </div>

            <label class="layui-form-label">入库单状态:</label>
            <div class="layui-input-inline">
                <select id="strStatus" name="strStatus" disabled="disabled">
                    <option value="N" ${miAcceptanceM.strStatus eq 'N' ? 'selected':''}>新增</option>
                    <option value="C" ${miAcceptanceM.strStatus eq 'C' ? 'selected':''}>确认</option>
                    <%--<option value="X" ${miAcceptanceM.strStatus eq 'X' ? 'selected':''}>结案</option>--%>
                </select>
            </div>

            <label class="layui-form-label">入库类型:</label>
            <div class="layui-input-inline">
                <select name="strInspType" id="strInspType" disabled="disabled">
                    <option value='A'
                    ${miAcceptanceM.strInspType eq 'A' ? "selected":""}>采购入库
                    </option>
                    <option value='B'
                    ${miAcceptanceM.strInspType eq 'B' ? "selected":""}>产品入库
                    </option>
                    <option value='C'
                    ${miAcceptanceM.strInspType eq 'C' ? "selected":""}>贸易入库
                    </option>
                </select>
            </div>
            <label class="layui-form-label">入库单金额:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strInspNoPrice" name="strInspNoPrice"
                       readonly value="${miAcceptanceM.strInspNoPrice}"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">入库人</label>
            <div class="layui-input-inline">
                <input type="hidden" id="PickEditNameID" name="strInUserId"/>
                <input type="text" id="PickEditName" value="${pickusername}" placeholder="点击挑选人员..."
                       class="layui-input" style="padding-right: 50px;"/>
                <i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
                <a class="layui-btn layui-btn-sm" onPickUser="selectSingleUserCallback"
                   style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i
                        class="layui-icon layui-icon-search"></i></a>
            </div>

            <label class="layui-form-label required-input">入库时间:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="strApplyDateTime" id="strData1"
                       value="${miAcceptanceM.strApplyDateTime}"/>
            </div>
            <label class="layui-form-label">&nbsp;&nbsp;&nbsp;&nbsp;生效人员:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" readonly name="strCfmEmpNo"
                       value="${miAcceptanceM.strCfmEmpNo}"/>
            </div>

            <label class="layui-form-label">生效日期:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strData2" readonly name="strCfmDateTime"
                       size="16%" value="${miAcceptanceM.strCfmDateTime}"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">订单/合同编号:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="strOrderNo" name="strOrderNo" readonly
                       value="${miAcceptanceM.strOrderNo}"/>
            </div>
            <label class="layui-form-label">备注:</label>
            <div class="layui-input-inline">
                            <textarea type="textarea" name="strMemo"
                                      class="layui-textarea" placeholder="请填写入库描述信息，不超过100个字"
                                      lay-verify="strMemo" rowspan="4"
                                      style="width: 500px;">${miAcceptanceM.strMemo}</textarea>
            </div>
        </div>
    </form>
    <h2>入库--详细信息</h2>
    <div class="tab-bars">
        <c:if test="${miAcceptanceM.strStatus =='N' }">
            <a class="choose" onclick="ihTrade('dtlSelect')"><span>挑选</span></a>
            <a class="edit"
                <%--href="${ctx}/miAcceptanceD/preUpdate/{slt_uid}"--%>
               onclick="ihTrade('preUpdate')">编辑</a>
            <a class="delete" onclick="ihTrade('deleteDtl')"><span>删除</span></a>
        </c:if>
        <%-- <c:if test="${miAcceptanceM.strStatus!='N'}">
             <h3 style="text-align:center">非新增状态不可编辑</h3>
         </c:if>--%>
    </div>
    <div class="tab-contentnew">
        <form method="post" action="${ctx}/miAcceptanceM/saveDtl"
              class="layui-form"
              onsubmit="return validateCallback(this, dialogAjaxDone);"
              id="ihdtl">
            <div class="layui-form-item"></div>
            <input type="hidden" name="ihId" value="${miAcceptanceM.id}">
            <table class="frog-table" id="MiAcceptanceDtlTable"
                   style="width: 140%;z-index:5; max-width: 140%;table-layout: fixed; word-break: break-all; word-wrap: break-word">
                <thead>
                <tr>
                    <th style="width:2%">
                        <input type="checkbox" lay-skin="primary" class="checkAllMiAcceptanceD"
                               lay-filter="checkMiAcceptanceD"/></th>
                    <%--<th style="width:4%">入库项次号</th>--%>
                    <th>入库单号</th>
                    <th>入库项次号</th>
                    <th>订单编号</th>
                    <th>订单项次号</th>
                    <th>仓库</th>
                    <th>储位</th>
                    <th>存货编号</th>
                    <th>品名</th>
                    <th>品牌</th>
                    <th>型号规格</th>
                    <th>单位</th>
                    <th>入库数量</th>
                    <th>入库单价</th>
                    <%--   <th>合格量</th>
                       <th>让步接收量</th>
                       <th>退货量</th>--%>
                    <th>总金额</th>
                    <th>到货数量</th>
                    <%--                    <th style="width:5%">需求计划号</th>
                                        <th style="width:4%">计划项次</th>
                                        <th style="width:6%">销售订单号</th>
                                        <th style="width:6%">销售订单项次</th>--%>
                    <th style="width:6%">备注说明</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${ihlist}" var="MiAcceptanceMDtl" varStatus="status">
                    <tr target="slt_uid" rel="${MiAcceptanceMDtl.id}" id="${MiAcceptanceMDtl.id}">
                        <td style="width:2%">
                            <input type="checkbox" name="checkAllMiAcceptanceD" lay-skin="primary"
                                   id="${MiAcceptanceMDtl.id}" lay-filter="checkMiAcceptanceD"/>
                        </td>
                            <%--<td style="width:4%">${MiAcceptanceMDtl.strInspItem}--%>
                        <td>${MiAcceptanceMDtl.strInspNo}</td>
                        <td>${MiAcceptanceMDtl.strInspItem}</td>
                        <td>${MiAcceptanceMDtl.strPoNo}</td>
                        <td>${MiAcceptanceMDtl.strPoItemNo}</td>
                        <td>${MiAcceptanceMDtl.strA}</td>
                        <td>${MiAcceptanceMDtl.strAreaId}</td>
                        <td>${MiAcceptanceMDtl.strMatrlNo}</td>
                        <td>${MiAcceptanceMDtl.strMatrlName}</td>
                        <td>${MiAcceptanceMDtl.strBrand}</td>
                        <td>${MiAcceptanceMDtl.strSpec}</td>
                        <td>${MiAcceptanceMDtl.strUnit}</td>
                        <td>${MiAcceptanceMDtl.bdInStoreQty}</td>
                        <td>${MiAcceptanceMDtl.bdBuyPrice}</td>
                            <%--  <td>${MiAcceptanceMDtl.bdPassQty}</td>
                              <td>${MiAcceptanceMDtl.bdConcessionQty}</td>
                              <td>${MiAcceptanceMDtl.bdReturnQty}</td>--%>
                        <td>${MiAcceptanceMDtl.bdTotalAmt}</td>
                        <td>${MiAcceptanceMDtl.bdArrQty}</td>
                            <%-- <td style="width:6%">${MiAcceptanceMDtl.strReqNo}</td>
                             <td style="width:6%">${MiAcceptanceMDtl.strReqItem}</td>
                             <td style="width:6%">${MiAcceptanceMDtl.strOrderNo}</td>
                             <td style="width:6%">${MiAcceptanceMDtl.strOrderItem}</td>--%>
                        <td>${MiAcceptanceMDtl.strMemo}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </form>
    </div>
    <!-- 分页 -->
</div>
</html>
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
<script type="text/javascript">
    form.on('checkbox(checkMiAcceptanceD)', function (data) {
        if ($(data.elem).hasClass("checkAllMiAcceptanceD")) {
            if (data.elem.checked) {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
            } else {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
            }
            form.render('checkbox');
        }
    });

    function dialogInsertPlanDone(result) {
        try {
            var messages = result.message;
            var rel = result.rel;
            if (result.statusCode == 200) {
                Dialog.success(messages);
                $('#miIssueMSaveId').load("${ctx}/miAcceptanceM/preUpdate/" + rel, {}, function () {
                });
                NavTab.reloadWithPagination(result.navTabId);
            } else {
                Dialog.error(messages);
            }
        } catch (e) {
            console.log(msg);
            Dialog.error(e.message);
        }
    }

    /* 提交方法 */
    function saveM(rst) {
        var rel = document.getElementById('id').value;
        $.ajax({
            url: "${ctx}/miAcceptanceM/save",
            data: $('#savedata').serialize(),
            dataType: 'json',
            success: function (rst) {
                if (rst.statusCode == '200') {
                    top.layer.msg(rst.message, {icon: 1});
                    $("#all").load("${ctx}/miAcceptanceM/preUpdate/" + rel, function () {
                    })
                } else {
                    top.layer.msg(rst.message, {icon: 2});
                }
            }
        });
    }

    function ihTrade(flag) {
        //获取主档的id值
        var rel = document.getElementById('id').value;
        var strStatus = document.getElementById('strStatus').value;
        //根据入库类型不同挑选不同页面
        var strInspType = document.getElementById("strInspType").value;//入库类型
        var strInspNo = document.getElementById("strInspNo").value;//入库单号
        var strOrderNo = document.getElementById("strOrderNo").value;//订单编号
        var info = "";
        if (strStatus == 'N')
            info = "新增";
        else if (strStatus == 'D')
            info = "删除";
        else if (strStatus == 'S')
            info = "生效";
        else
            info = "空";
        if (flag == 'save' && (strStatus == 'N' || rel == '')) {
            if (validateForm($('#ihform'))) {
                $('#ihform').submit();
            }
        }
        //挑选
        if (flag == 'dtlSelect' && strStatus == 'N') {
            //获取主档的id
            if (rel == null || rel == "") {
                Dialog.warn("请先保存主档信息！");
                return;
            }
            if (strInspType == "A") {
                $.post("${ctx}/miAcceptanceM/preSelect?type=" + strInspType + "&strInspNo=" + strInspNo + "&strOrderNo=" + strOrderNo, function (content) {
                    top.layer.open({
                        id: 'preselectMpSale',
                        type: 1,
                        area: ["80%", "80%"],
                        title: "挑选采购入库单",
                        shadeClose: true,
                        offset: "48px",
                        maxmin: true,
                        anim: 5,
                        content: content
                    });
                });
            } else if (strInspType == "B") {
                $.post("${ctx}/miAcceptanceM/preSelect?type=" + strInspType + "&strInspNo=" + strInspNo + "&strOrderNo=" + strOrderNo, function (content) {
                    top.layer.open({
                        id: 'preselectMpProcore',
                        type: 1,
                        area: ["80%", "80%"],
                        title: "挑选产品入库单",
                        shadeClose: true,
                        offset: "48px",
                        maxmin: true,
                        anim: 5,
                        content: content
                    });
                });
            } else if (strInspType == "C") {
                $.post("${ctx}/miAcceptanceM/preSelect?type=" + strInspType + "&strInspNo=" + strInspNo + "&strOrderNo=" + strOrderNo, function (content) {
                    top.layer.open({
                        id: 'preselectTrading',
                        type: 1,
                        area: ["80%", "80%"],
                        title: "挑选贸易入库单",
                        shadeClose: true,
                        offset: "48px",
                        maxmin: true,
                        anim: 5,
                        content: content
                    });
                });
            }
        }
        if (flag == 'dtlSelect' && strStatus == 'C') {
            Dialog.warn("已确认数据不能进行挑选操作！");
            return;
        }
        var result = '';
        var aa = document.getElementsByName("checkAllMiAcceptanceD");
        var mm = 0;
        for (var i = 0; i < aa.length; i++) {
            if (aa.item(i).checked) {
                mm++;
                var id = aa.item(i).parentNode.parentNode.cells[0].children[0].id;
                if (result == '')
                    result = id;
                else
                    result = result + "," + id;
            }
        }
        if (flag == 'preUpdate') {
            if (mm != 1) {
                Dialog.warn("请选择一条信息！");
            } else {
                var zbid = document.getElementById("id").value;
                $.post("${ctx}/miAcceptanceM/preDUpdate", {id: result, zbid: zbid}, function (content) {
                    top.layer.open({
                        id: 'preDUpdate',
                        type: 1,
                        area: ["80%", "80%"],
                        title: "编辑",
                        shadeClose: true,
                        offset: "48px",
                        maxmin: true,
                        anim: 5,
                        content: content
                    });
                })
            }

        }
        if (flag == 'deleteDtl' && strStatus == 'N') {
            if (mm == 0)
                Dialog.warn("请至少选择一条信息！");
            else {
                layer.confirm('确定删除吗？', function (index) {
                    $.post("${ctx}/miAcceptanceD/delete", {id: result}, function (msg) {
                        try {
                            var result = JSON.parse(msg);
                            var messages = result.message;
                            Ajax.ajaxDone(result);
                            if (result.statusCode == 200 || msg.statusCode == '200') {
                                $("#all").load("${ctx}/miAcceptanceM/preUpdate/" + rel, function () {
                                })
                            }
                        } catch (e) {
                            console.log(msg);
                            Dialog.error(e.message);
                        }
                    });
                });
            }
        }
        if (flag == 'deleteDtl' && strStatus == 'C') {
            Dialog.warn("已确认数据不能进行删除操作！");
            return;
        }
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
        $('#PickEditNameID').val(userId);
        $('#PickEditName').val(username);
    }
</script>
<%--<div class="layui-form-item">
                <label class="layui-form-label">订单编号:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" name="strOrderNo"
                           value="${miAcceptanceM.strOrderNo}"/>
                </div>
                <label class="layui-form-label">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;供应商:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="strSaleVendorName" name="strSaleVendor"
                           value="${miAcceptanceM.strSaleVendor}"/>
                </div>
                <label class="layui-form-label">实际到货日期:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="strData3" name="strActualDate"
                           size="16%" value="${miAcceptanceM.strActualDate}"/>
                </div>
                <label class="layui-form-label">储位:</label>
                <div class="layui-input-inline">
                    <select name="strAreaId" id="strAreaId">
                        <c:forEach items="${strAreaIdList}" var="field">
                            <option value='${field.id}'${field.id eq  miAcceptanceM.strAreaId ?'selected':field.id}>${field.strName}</option>
                        </c:forEach>
                    </select>
                </div>
                <label class="layui-form-label">红冲单号:</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="strRedRush" name="strRedRush"
                           size="16%" value="${miAcceptanceM.strRedRush}"/>
                </div>
                <label class="layui-form-label">仓库:</label>
                <div class="layui-input-inline">
                    <select name="strLocNo" id="strLocNo" lay-filter="selectLocNo">
                        <c:forEach items="${dictDtlList}" var="field">
                            <option value='${field.id}'${field.id eq  miAcceptanceM.strLocNo ?'selected':field.id}>${field.strValue}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>--%>

