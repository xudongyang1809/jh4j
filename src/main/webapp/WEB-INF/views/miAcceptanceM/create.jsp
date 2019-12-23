<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<style type="text/css">
    .tab-contentnew {
        position: absolute;
        top: 250px;
        bottom: 50px;
        left: 0px;
        right: 0px;
        overflow-x: scroll;
    }
</style>
<div id="all">
    <form class="layui-form" method="post" action="${ctx}/miAcceptanceM/create"
          onsubmit="return dialogAjaxDone(this, 'create')" style="padding-top: 10px;padding-left: 30px;">
        <div class="layui-form-item">
            <input id="relid" name="id" hidden="hidden">
            <label class="layui-form-label">入库单号:</label>
            <div class="layui-input-inline">
                <input type="text" id="strInspNo" name="strInspNo" value="${strOrdNo}" autocomplete="off"
                       class="layui-input"
                       style="background-color: WhiteSmoke;">
            </div>
            <label class="layui-form-label">入库单状态:</label>
            <div class="layui-input-inline">
                <select name="strStatus" id="strStatus">
                    <option value="N" ${miAcceptanceM.strStatus eq 'N' ? 'selected':''}>新增</option>
                    <option value="C" ${miAcceptanceM.strStatus eq 'C' ? 'selected':''}>确认</option>
                    <option value="X" ${miAcceptanceM.strStatus eq 'X' ? 'selected':''}>结案</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">入库类型:</label>
            <div class="layui-input-inline">
                <select name="strInspType" lay-filter="showOrder">
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
                <input type="text" value="0" class="layui-input" name="strInspNoPrice"
                       readonly/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">入库人:</label>
            <div class="layui-input-inline">
                <input type="hidden" id="PickCreateNameID" name="strInUserId"/>
                <input type="text" id="PickCreateName" placeholder="点击挑选人员..." class="layui-input"
                       style="padding-right: 50px;"/>
                <i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
                <a class="layui-btn layui-btn-sm" onPickUser="selectSingleUserCallback"
                   style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i
                        class="layui-icon layui-icon-search"></i></a>
            </div>
            <label class="layui-form-label">入库时间:</label>
            <div class="layui-input-inline">
                <input type="text" lay-verify="required" class="layui-input" id="strData1"
                       name="strApplyDateTime" placeholder="入库时间">
            </div>
        </div>
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
        </div>--%>
        <div class="layui-form-item">
            <label class="layui-form-label">订单/合同编号:</label>
            <div class="layui-input-inline count1" style="width: 190px;display: none">
                <input id="strOrderNoName001" name="strOrderNo" class="layui-input" type="text" readonly
                       style="padding-right: 50px;background-color:white;"
                       placeHolder="请挑选销售订单编号"/>
                <a class="layui-btn layui-btn-sm" href="${ctx}/mdDemandM/orderList?strOrderNo1=strOrderNoName"
                   title="请挑选销售订单编号" target="dialog" width="1000" height="500" dialogId="selectStrOrdNoDialogId1"
                   style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i
                        class="layui-icon layui-icon-search"></i></a>
            </div>
            <div class="layui-input-inline count2" style="width: 190px">
                <input type="hidden" id="strPoNoname33" class="layui-input"/>
                <input name="strOrderNo"  type="text" id="mpArrivalMstrPoNo" class="layui-input"  placeHolder="请挑选采购合同编号"/>
                <i class="layui-icon layui-icon-close" onclick="clearSelected('mpArrivalMstrPoNo','strPoNoname33')"></i>
                <a class="layui-btn layui-btn-sm select-btn"
                   href="${ctx}/mpPonoM/preFindPoNo?strMpPoNo1=mpArrivalMstrPoNo&strMpPoName1=strPoNoname33&strVendorNo1=strVendorNoArrival"
                   title="挑选采购合同"
                   target="dialog" width="900" height="550" dialogId="selectmppono"><i
                        class="layui-icon layui-icon-search"></i></a>
            </div>
            <div class="dialogFooter">
                <button type="submit" class="layui-btn">提交</button>
            </div>
        </div>
    </form>
</div>
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
    //全选按钮
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
    //1为产品  2为采购贸易
    form.on('select(showOrder)', function (data) {
        if (data.value == "A" || data.value == "C") {//采购，贸易
            $("#strOrderNoName001").val("");
            $(".count1").hide();
            $(".count2").show();
        } else {//产品
            $("#strPoNo4").val("");
            $(".count1").show();
            $(".count2").hide();
        }

    });

    //创建成功之后的回调函数。
    function dialogInsertPlanDone(result) {
        var messages = result.message;
        ss = messages.split(",");
        Dialog.success(ss[0]);
        $('#relid').val(ss[0]);
        var id = $("#relid").val();
    }

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

    /*
     * 选择单个人员的回调方法
     */
    function selectSingleUserCallback(userId, userNo, username) {
        $('#PickCreateNameID').val(userId);
        $('#PickCreateName').val(username);
    }

    function ihTrade(flag) {
        if (document.getElementById('relid').value == "" || document.getElementById('relid').value == null) {
            Dialog.warn("请先保存主档信息！");
            return;
        } else {
            //获取主档的id值
            var rel = document.getElementById('relid').value;
            var strStatus = document.getElementById('strStatus').value;
            //根据入库类型不同挑选不同页面
            var strInspType = document.getElementById("strInspType").value;
            var strInspNo = document.getElementById("strInspNo").value;
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
                    $.post("${ctx}/miAcceptanceM/preSelect?type=" + strInspType + "&strInspNo=" + strInspNo, function (content) {
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
                    $.post("${ctx}/miAcceptanceM/preSelect?type=" + strInspType + "&strInspNo=" + strInspNo, function (content) {
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
                    $.post("${ctx}/miAcceptanceM/preSelect?type=" + strInspType + "&strInspNo=" + strInspNo, function (content) {
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
            if (flag == 'deleteDtl' && strStatus == 'N') {
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
</script>

<%--<h2>入库--详细信息</h2>
    <div class="tab-bars">
        <a class="choose" onclick="ihTrade('dtlSelect')"><span>挑选</span></a>
        <a class="delete" onclick="ihTrade('deleteDtl')"><span>删除</span></a>
        &lt;%&ndash; <c:if test="${miAcceptanceM.strStatus!='N'}">
             <h3 style="text-align:center">非新增状态不可编辑</h3>
         </c:if>&ndash;%&gt;
    </div>
    <div class="tab-contentnew">
        <form method="post" action="${ctx}/miAcceptanceM/saveDtl"
              class="layui-form"
              onsubmit="return validateCallback(this, dialogAjaxDone);"
              id="ihdtl">
            <input type="hidden" name="ihId" value="${miAcceptanceM.id}">
            <table class="frog-table" id="MiAcceptanceDtlTable"
                   style="width: 140%;z-index:5; max-width: 140%;table-layout: fixed; word-break: break-all; word-wrap: break-word">
                <thead>
                <tr>
                    <th style="width:2%">
                        <input type="checkbox" lay-skin="primary" class="checkAllMiAcceptanceD"
                               lay-filter="checkMiAcceptanceD"/></th>
                    <th style="width:4%">入库项次号</th>
                    <th style="width:8%">入库单号</th>
                    <th style="width:7%">存货编号</th>
                    <th style="width:5%">储位</th>
                    <th style="width:5%">品名</th>
                    <th style="width:5%">品牌</th>
                    <th style="width:4%">型号规格</th>
                    <th style="width:4%">入库数量</th>
                    <th style="width:4%">入库单价</th>
                    <th style="width:4%">到货数量</th>
                    <th style="width:4%">合格量</th>
                    <th style="width:6%">让步接收量</th>
                    <th style="width:4%">退货量</th>
                    <th style="width:4%">总金额</th>
                    <th style="width:6%">采购合同号</th>
                    <th style="width:6%">采购合同项次</th>
                    <th style="width:5%">需求计划号</th>
                    <th style="width:4%">计划项次</th>
                    <th style="width:6%">销售订单号</th>
                    <th style="width:6%">销售订单项次</th>
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
                        <td style="width:4%">${MiAcceptanceMDtl.strInspItem}
                        <td style="width:8%">${MiAcceptanceMDtl.strInspNo}</td>
                        <td style="width:7%">${MiAcceptanceMDtl.strMatrlNo}</td>
                        <td style="width:5%">${MiAcceptanceMDtl.strAreaId}</td>
                        <td style="width:5%">${MiAcceptanceMDtl.strMatrlName}</td>
                        <td style="width:5%">${MiAcceptanceMDtl.strBrand}</td>
                        <td style="width:5%">${MiAcceptanceMDtl.strSpec}</td>
                        <td style="width:5%">${MiAcceptanceMDtl.bdInStoreQty}</td>
                        <td style="width:5%">${MiAcceptanceMDtl.bdBuyPrice}</td>
                        <td style="width:6%">${MiAcceptanceMDtl.bdArrQty}</td>
                        <td style="width:5%">${MiAcceptanceMDtl.bdPassQty}</td>
                        <td style="width:4%">${MiAcceptanceMDtl.bdConcessionQty}</td>
                        <td style="width:6%">${MiAcceptanceMDtl.bdReturnQty}</td>
                        <td style="width:6%">${MiAcceptanceMDtl.bdTotalAmt}</td>
                        <td style="width:6%">${MiAcceptanceMDtl.strPoNo}</td>
                        <td style="width:6%">${MiAcceptanceMDtl.strPoItemNo}</td>
                        <td style="width:6%">${MiAcceptanceMDtl.strReqNo}</td>
                        <td style="width:6%">${MiAcceptanceMDtl.strReqItem}</td>
                        <td style="width:6%">${MiAcceptanceMDtl.strOrderNo}</td>
                        <td style="width:6%">${MiAcceptanceMDtl.strOrderItem}</td>
                        <td style="width:6%">${MiAcceptanceMDtl.strMemo}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </form>
    </div>--%>

<%-- <div class="layui-form-item">

         <label class="layui-form-label">订单编号:</label>
         <div class="layui-input-inline">
             <input type="text" class="layui-input" name="strOrderNo" placeHolder="请选择销售订单编号"/>
         </div>
     </div>

         <label class="layui-form-label">红冲单号:</label>
         <div class="layui-input-inline">
             <input type="text" class="layui-input" name="strRedRush" placeHolder="请输入红冲单号"/>
         </div>
     </div>
 </div>
 <div class="layui-form-item">

         <label class="layui-form-label">仓库:</label>
         <div class="layui-input-inline">
             <select lay-filter="selectLocNo" name="strLocNo" id="strLocNo">
                 <c:forEach items="${dictDtlList}" var="field" >
                     <option value='${field.id}'>${field.strValue}</option>
                 </c:forEach>
             </select>
         </div>
     </div>

         <label class="layui-form-label">供应商:</label>
         <div class="layui-input-inline">
             <input type="text" class="layui-input" name="strSaleVendor" placeHolder="请挑选供应商"/>
         </div>
     </div>
 </div>

         <label class="layui-form-label">储位:</label>
         <div class="layui-input-inline">
             <select name="strAreaId" id="strAreaId"  >
                 <option value="">请选择</option>
             </select>
         </div>
    </div>
       <label class="layui-form-label">实际到货日期:</label>
     <div class="layui-input-inline">
         <input type="text" lay-verify="required" class="layui-input" id="strData3"
                name="strActualDate" placeholder="实际到货日期">
     </div>--%>


