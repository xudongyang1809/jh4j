<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<style type="text/css">
</style>
<script type="text/javascript">
    // 标签折页切换方法
    function loadTab(num) {
        var id = $("#maArrivalM").val();    // id
        var strPoNo = $("#mpArrivalMstrPoNo").val();  // 合同号
        var strVendorNo = $("#strVendorNoArrival").val();  //
        var mStatus = $("#strStus").val();  //
        var loadingIndex = Dialog.load();
            $("#tab" + num).load("${ctx}/mpArrivalD/preCreate",{id:id,strPoNo:strPoNo,strVendorNo:strVendorNo,mStatus:mStatus}, function () {
                layer.close(loadingIndex);
            })
    }

    // 加载当前页面方法
    function loadIndex(rel) {
        var loadIndex = Dialog.load();
        var rel = $("#maArrivalM").val();
        $("#alls").load("${ctx}/mpArrivalM/preUpdate/?id=" + rel, function () {
            Dialog.close(loadIndex);
        });
    }

    /**
     * 业务方法
     * 保存回调方法
     * @param result
     */
    function dialogInsertPlanDone(result) {
        try {
            var message = result.message;
            var rel = result.rel;
            $("#maArrivalM").val(rel);
            if (result.statusCode == 200) {
                Dialog.success(message);
                if (rel != null || rel != "") {
                    loadIndex(rel);       // 刷新界面 **
                    NavTab.reloadWithPagination(result.navTabId);
                }
            } else {
                Dialog.error(message);
            }
        } catch (e) {
            console.log(msg);
            Dialog.error(e.message);
        }
    }


    <!--  业务方法 -->
    function mpArrivalM(flag) {
        debugger;
        var rel = $("#maArrivalM").val();
        var strStatus = $("#strStus").val();
        var strInspNo = $("#strInspNo").val();
        var info = '';
        if (strStatus == 'N') {
            info = "新增";
        } else if (strStatus == "D") {
            info = "删除";
        } else if (strStatus == 'S') {
            info = '确认';
        } else
            info = "空";


        function CheckSure() {
            var strPoNoname33 = $("#mpArrivalMstrPoNo").val();
            if (strPoNoname33 == '' ){
                layer.msg("请填写采购合同号", {icon: 5});
                return false;
            }
            return true;
        }

        <!--  保存提交 -->
        if (flag == 'save' && (strStatus == 'N' || rel == '')) {

            if(CheckSure() == false){
                return null;
            }

            $.ajax({
                type: "post",
                url: "${ctx}/mpArrivalM/create",
                data: $("#ihform").serialize(),
                datatype: "json",
                success: function (rst) {
                    var data = JSON.parse(rst);
                    var rel = data.rel;
                    if (data.statusCode == 200) {
                        $('#alls').load("${ctx}/mpArrivalM/preUpdate?id=" + rel, function () {
                        });
                        NavTab.reloadWithPagination(data.navTabId);

                        Dialog.success(data.message);
                    } else {
                        Dialog.error(data.message);
                    }
                },
                error: function (msg) {
                    Dialog.warn(msg.message);
                }
            });
            //$('#ihform').submit();
        } else if (flag == 'save' && (strStatus == 'S')) {
            layer.msg("状态已生效,不可修改");
            return ;

        } else if (flag == 'effect') {
            if (strStatus == 'S'){
                layer.msg("已生效,不能重复生效");
                return ;
            }

            layer.confirm("确认生效吗", function () {
                $.post("${ctx}/mpArrivalM/effect", {id: rel}, function (msg) {
                    try {
                        var result = JSON.parse(msg)
                        var message = result.message;
                        Ajax.ajaxDone(result);
                        if (result.statusCode == '200') {
                            Dialog.success(message);
                            loadIndex();
                            NavTab.reloadWithPagination(result.navTabId);
                        } else {
                            Dialog.error(message);
                        }
                    } catch (e) {
                        Dialog.error(message);
                    }
                })
            })
        } else if (flag == 'uneffect') {
            if (strStatus != 'S'){
                layer.msg("非生效状态,取消生效无效");
                return ;
            }

            layer.confirm("确认取消生效吗", function () {
                $.post("${ctx}/mpArrivalM/uneffect", {id: rel}, function (msg) {
                    try {
                        var result = JSON.parse(msg)
                        var message = result.message;
                        Ajax.ajaxDone(result);
                        if (result.statusCode == '200') {
                            Dialog.success(message);
                            NavTab.reloadWithPagination(result.navTabId);
                        } else {
                            Dialog.error(message);
                        }
                    } catch (e) {
                        Dialog.error(message);
                    }
                })
            })
        }

    }


</script>


<div id="alls">
    <div class="layui-tab" id="layui-tab">
        <ul class="layui-tab-title">
            <li class="layui-this">到货申请</li>
            <li onclick="loadTab('2')">到货明细</li>
        </ul>
        <div class="layui-tab-content">
            <div id="tab1" class="layui-tab-item layui-show">
                <div class="tab-bars">
                    <shiro:hasPermission name="MpPonoM:create">
                        <a class="add" href="#" onclick="mpArrivalM('save')"><span>保存</span></a>
                    </shiro:hasPermission>
                    <%--<shiro:hasPermission name="MpPonoM:delete">
                        <a class="delete" href="#" onclick="mpArrivalM('delete')"><span>删除</span></a>
                    </shiro:hasPermission>--%>
                    <a class="confirm" href="#" onclick="mpArrivalM('effect')"><span>生效</span></a>
                    <a class="cancelConfirm" href="#" onclick="mpArrivalM('uneffect')"><span>取消生效</span></a>
                </div>
                <form class="layui-form" method="post" id="ihform" class="layui-form" action="${ctx}/mpArrivalM/create"
                      onsubmit="return validateCallback(this,dialogInsertPlanDone);">
                    <input type="hidden" id="maArrivalM" name="id" value="${mpArrivalM.id}"/>
                    <div class="layui-form-item">
                        <div class="layui-col-xs6">
                            <label class="layui-form-label">到货单号:</label>
                            <div class="layui-input-block">
                                <input type="text" class="layui-input" id="strInspNo" name="strInspNo"
                                       value="${mpArrivalM.strInspNo}" autocomplete="off" readonly="readonly"
                                       placeHolder="请输入到货单号"/>
                            </div>
                        </div>
                        <div class="layui-col-xs6">
                            <label class="layui-form-label required-input ">采购合同:</label>
                            <div class="layui-input-block">
                                <input type="hidden" id="strPoNoname33" class="layui-input"/>
                                <input name="strPoNo" lay-verify="required" value="${mpArrivalM.strPoNo}" type="text"
                                       id="mpArrivalMstrPoNo" class="layui-input"/>
                                <i class="layui-icon layui-icon-close"
                                   onclick="clearSelected('mpArrivalMstrPoNo','strPoNoname33')"></i>
                                <a class="layui-btn layui-btn-sm select-btn"
                                   href="${ctx}/mpPonoM/preFindPoNo?strMpPoNo1=mpArrivalMstrPoNo&strMpPoName1=strPoNoname33&strVendorNo1=strVendorNoArrival"
                                   title="挑选采购合同"
                                   target="dialog" width="900" height="550" dialogId="selectmppono"><i
                                        class="layui-icon layui-icon-search"></i></a>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-col-xs6">
                            <label class="layui-form-label">供应商编号:</label>
                            <div class="layui-input-block">
                                <input type="text" lay-verify="required" id="strVendorNoArrival" name="strVendorNo"
                                       value="${mpArrivalM.strVendorNo}" readonly="readonly" class="layui-input"/>
                            </div>
                        </div>
                        <div class="layui-col-xs6">
                            <label class="layui-form-label">状态:</label>
                            <div class="layui-input-block">
                                <input type="hidden" id="strStus" class="layui-input" name="strStus"
                                       value="${mpArrivalM.strStus}">
                                <input type="text" id="strStus1" class="layui-input" readonly="readonly"
                                       value="${mpArrivalM.strStus eq 'N' ?'新增':(mpArrivalM.strStus eq 'S'  ? '生效' : (mpArrivalM.strStus eq 'D'?'删除' :'' ))}"/>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-col-xs6">
                            <label class="layui-form-label">生效人员:</label>
                            <div class="layui-input-block">
                                <input type="hidden" class="layui-input" name="strCfmEmpNo"
                                       value="${mpArrivalM.strCfmEmpNo}" autocomplete="off" placeHolder="请输入生效人员"/>
                                <input type="text" class="layui-input" value="${mpArrivalM.strCfmEmpName}"
                                       readonly="readonly" autocomplete="off" placeHolder="请输入生效人员"/>
                            </div>
                        </div>
                        <div class="layui-col-xs6">
                            <label class="layui-form-label">生效日期:</label>
                            <div class="layui-input-block">
                                <input type="text" class="layui-input" name="strCfmDateTime"
                                       value="${mpArrivalM.strCfmDateTime}" readonly="readonly" autocomplete="off"
                                       placeHolder="请输入生效日期"/>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-items">
                        <div class="layui-col-xs6">
                            <label class="layui-form-label">备注:</label>
                            <div class="layui-input-block">
                                <input type="text" class="layui-input" name="strMemova" value="${mpArrivalM.strMemova}"
                                       placeHolder="请输入备注"/>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div id="tab2" class="layui-tab-item">
            </div>
        </div>
    </div>
</div>



