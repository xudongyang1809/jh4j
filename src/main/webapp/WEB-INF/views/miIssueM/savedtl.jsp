<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
         trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>

<div id="allPageContent">
    <div class="tab-bars">
        <a class="choose" onclick="ihTrade('dtlSelect')"><span>挑选</span></a>
        <%-- <a class="add" width="1100" height="600" target="dialog" dialogId="createMiIssueDDialog"
            href="${ctx}/miIssueD/preInventory?strApplyNo=${strApplyNo}&strLocNo=${strLocNo}">挑选</a>--%>
        <a class="edit" onclick="ihShipdata('preUpdate',this)">编辑</a>
        <a class="delete" id="deleteDtl" href="#" onclick="ihShipdata('deleteDtl',this)"><span>删除</span></a>
        <a class="delivery" id="chu" href="#" onclick="ihShipdata('chu',this)"><span>出库</span></a>
        <a class="cancelDelivery" id="unchu" href="#" onclick="ihShipdata('unchu',this)"><span>取消出库</span></a>
        <a class="confirm" id="run" href="#" onclick="ihShipdata('run',this)"><span>生效</span></a>
        <a class="cancelConfirm" id="unrun" href="#" onclick="ihShipdata('unrun',this)"><span>取消生效</span></a>
    </div>
    <form id="pagerForm" class="layui-form" method="post"
          action="${ctx}/miIssueM/saveDtl?id=${strApplyNo}&strStus=${MiIssueMstrStus}">
        <input type="hidden" name="MiIssueMstrStus" id="MiIssueMstrStus" value="${MiIssueMstrStus}"/>
        <input type="hidden" name="keywords" value="${keywords}"/>
        <input type="hidden" name="strApplyNo" id="strApplyNo" value="${strApplyNo}"/>
        <input type="hidden" name="id" id="id" value="${id}"/>
        <table class="frog-table" style="width: 150%; max-width: 400%;">
            <thead>
            <tr>
                <th style="width: 20px;"><input type="checkbox" lay-skin="primary" group="checkitemDtl"
                                                class="checkboxSaveDtl" lay-filter="checkboxcheckboxSaveDtl"/></th>
                <th>序号</th>
                <th>销账单号</th>
                <th>出库单号</th>
                <th>出库项次</th>
                <th>状态</th>
                <th>验收入库单</th>
                <th>验收入库项次号</th>
                <th>单价</th>
                <th>出库数量</th>
                <th>金额</th>
                <th>供应商</th>
                <th>存货编号</th>
                <th>储位</th>
                <th>品名</th>
                <th>型号规格</th>
                <th>计量单位</th>
                <th>品牌</th>
                <%-- <th>出库人</th>
                 <th>出库时间</th>--%>
            </tr>
            </thead>
            <c:forEach items="${iteam}" var="miIssueD" varStatus="status">
                <tr target="slt_uid" rel="${miIssueD.id}">
                    <td><input type="checkbox" lay-skin="primary" name="checkitemDtl" id="${miIssueD.id}"
                               value="${miIssueD.strStus}"
                               lay-filter="checkboxcheckboxSaveDtl"></td>
                    <td>${page.pageBeginCount + status.index + 1}</td>
                    <td>${miIssueD.strSaleNo}</td>
                    <td>${miIssueD.strApplyNo}</td>
                    <td>${miIssueD.strShipItem}</td>
                    <td>${miIssueD.strStus eq 'A'?"未出库":(miIssueD.strStus eq 'B'?"已出库":
                            (miIssueD.strStus eq 'C'?"未销账":(miIssueD.strStus eq 'D'?"已销账":"")))}</td>
                    <td>${miIssueD.strInspNo}</td>
                    <td>${miIssueD.strInspItemCon}</td>
                    <td>${miIssueD.bdRealPrice}</td>
                    <td>${miIssueD.bdQty}</td>
                    <td>${miIssueD.bdAmt}</td>
                    <td>${miIssueD.strB}</td>
                    <td>${miIssueD.strMatrlNo}</td>
                    <td>${miIssueD.strAreaId}</td>
                    <td>${miIssueD.strMatrlName}</td>
                    <td>${miIssueD.strSpec}</td>
                    <td>${miIssueD.strUnit}</td>
                    <td>${miIssueD.strBrand}</td>
                        <%--     <td>${miIssueD.strOutUserId}</td>
                             <td>${miIssueD.strOutTime}</td>--%>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form>
    <%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
    <%--<c:param name="container" value="#allPageContent"> </c:param>--%>
</div>


<script type="text/javascript">
    function ihTrade(flag) {
        //获取主档的id值
        var strStus = document.getElementById('MiIssueMstrStus').value;//出库单状态
        var strApplyNo = document.getElementById("strApplyNo").value;//出库单号
        var info = "";
        //挑选
        if (flag == 'dtlSelect') {
            $.post("${ctx}/miIssueD/preInventory?strApplyNo=" + strApplyNo + "&strStus=" + strStus, function (content) {
                top.layer.open({
                    id: 'preInventory',
                    type: 1,
                    area: ["80%", "80%"],
                    title: "挑选库存",
                    shadeClose: true,
                    offset: "48px",
                    maxmin: true,
                    anim: 5,
                    content: content
                });
            });
        }
    }

    form.on('checkbox(checkboxcheckboxSaveDtl)', function (data) {
        if ($(data.elem).hasClass("checkboxSaveDtl")) {
            if (data.elem.checked) {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
            } else {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
            }
            form.render('checkbox');
        }
    });

    function ihShipdata(flag, obj) {
        var rel = document.getElementById('strApplyNo').value;
        var status = "A";
        var ids = '';
        var aa = document.getElementsByName("checkitemDtl");
        var mm = 0;
        for (var i = 0; i < aa.length; i++) {
            if (aa.item(i).checked) {
                mm++;
                var id = aa.item(i).parentNode.parentNode.cells[0].children[0].id;
                var status = aa.item(i).parentNode.parentNode.cells[0].children[0].value;
                if (status != "A") {
                    status = "N";
                }
                // var status = getTrDefinedAttr(aa.item(i), "statu");
                if (ids == '')
                    ids = id;
                else
                    ids = ids + "," + id;   // id 拼接
            }

        }
        if (mm == 0) {
            layer.msg("请至少选择一条信息！");
            return;
        } else {
            //满足条件配送出库
            if (flag == 'chu') {
                layer.confirm("确定出库吗?", {
                        btn: ['确定', '取消'] //按钮
                    }, function () {
                        $.post("${ctx}/miIssueD/out", {id: ids, flg: "B"}, function (msg) {
                            try {
                                var result = JSON.parse(msg);
                                Ajax.ajaxDone(result);
                                if (result.statusCode == 200) {
                                    $("#allPageContent").load("${ctx}/miIssueM/saveDtl/?id=" + rel + "&tab=2", {}, function () {
                                    })
                                }
                            } catch (e) {
                                console.log(msg);
                                Dialog.error(e.message);
                            }
                        })
                    }
                    , function () {
                        layer.close();
                    })
            } else if (flag == 'unchu') {
                layer.confirm("确定取消出库吗?", {
                    btn: ['确定', '取消'] //按钮
                }, function () {
                    $.post("${ctx}/miIssueD/out", {id: ids, flg: "A"}, function (msg) {
                        try {
                            var result = JSON.parse(msg);
                            Ajax.ajaxDone(result);
                            if (result.statusCode == 200) {
                                $("#allPageContent").load("${ctx}/miIssueM/saveDtl/?id=" + rel + "&tab=2", {}, function () {
                                })
                            }
                        } catch (e) {
                            console.log(msg);
                            Dialog.error(e.message);
                        }
                    })
                }, function () {
                    layer.close();
                })
            } else if (flag == 'run') {
                layer.confirm("确定生效吗?", {
                    btn: ['确定', '取消'] //按钮
                }, function () {
                    $.post("${ctx}/miIssueD/out", {id: ids, flg: "C"}, function (msg) {
                        try {
                            var result = JSON.parse(msg);
                            Ajax.ajaxDone(result);
                            if (result.statusCode == 200) {
                                $("#allPageContent").load("${ctx}/miIssueM/saveDtl/?id=" + rel + "&tab=2", {}, function () {
                                })
                            }
                        } catch (e) {
                            console.log(msg);
                            Dialog.error(e.message);
                        }
                    })
                }, function () {
                    layer.close();
                })
            } else if (flag == 'unrun') {
                layer.confirm("确定取消生效吗?", {
                    btn: ['确定', '取消'] //按钮
                }, function () {
                    $.post("${ctx}/miIssueD/out", {id: ids, flg: "E"}, function (msg) {
                        try {
                            var result = JSON.parse(msg);
                            Ajax.ajaxDone(result);
                            if (result.statusCode == 200) {
                                $("#allPageContent").load("${ctx}/miIssueM/saveDtl/?id=" + rel + "&tab=2", {}, function () {
                                })
                            }
                        } catch (e) {
                            console.log(msg);
                            Dialog.error(e.message);
                        }
                    })
                }, function () {
                    layer.close();
                })
            } else if (flag == 'deleteDtl') {
                if (status == "N") {
                    layer.msg("只能删除未出库的数据！");
                    return;
                } else {
                    layer.confirm("确定删除吗?", {
                        btn: ['确定', '取消'] //按钮
                    }, function () {
                        $.post("${ctx}/miIssueD/delete", {id: ids}, function (msg) {
                            try {
                                var result = JSON.parse(msg);
                                Ajax.ajaxDone(result);
                                if (result.statusCode == 200) {
                                    $("#allPageContent").load("${ctx}/miIssueM/saveDtl/?id=" + rel + "&tab=2", {}, function () {
                                    })
                                }
                            } catch (e) {
                                console.log(msg);
                                Dialog.error(e.message);
                            }
                        })
                    }, function () {
                        layer.close();
                    })
                }
            } else if (flag == 'preUpdate') {
                if (mm != 1) {
                    Dialog.warn("请选择一条信息！");
                } else {
                    $.post("${ctx}/miIssueD/preUpdate/", {id: ids, strApplyNo: rel}, function (content) {
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
        }
    }
</script>


