<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<head>
    <style type="text/css">
    </style>
</head>
<form id="pagerForm" method="post" action="${ctx}/miIssueM/list" onsubmit="return navTabAjaxDone(this)">
    <input type="hidden" name="pageNum" value="${page.pageNum}"/>
    <input type="hidden" name="numPerPage" value="${page.numPerPage}"/>
    <input type="hidden" name="orderField" value="${page.orderField}"/>
    <input type="hidden" name="orderDirection" value="${page.orderDirection}"/>
    <input type="hidden" name="keywords" value="${keywords}"/>
    <input type="hidden" name="strApplyNo" value="${miIssueM.strApplyNo}"/>
    <input type="hidden" name="strOutType" value="${miIssueM.strOutType}"/>
    <input type="hidden" name="strInspNo" value="${miIssueM.strInspNo}"/>
    <input type="hidden" name="strPoNo" value="${miIssueM.strPoNo}"/>
    <input type="hidden" name="strOrderNo" value="${miIssueM.strOrderNo}"/>
    <input type="hidden" name="strLocNo" value="${miIssueM.strLocNo}"/>
    <input type="hidden" name="strApplyUserId" value="${miIssueM.strApplyUserId}"/>
    <input type="hidden" name="strOutUserId" value="${miIssueM.strOutUserId}"/>
    <input type="hidden" name="strStus" value="${miIssueM.strStus}"/>
</form>
<div class="tab-header">
    <form method="post" action="${ctx}/miIssueM/list" class="layui-form" onsubmit="return navTabSearch(this)">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">出库单号</label>
                <div class="layui-input-inline">
                    <input type="text" name="strApplyNo" class="layui-input" value="${miIssueM.strApplyNo}" />
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">出库类型</label>
                <div class="layui-input-inline">
                    <select name="strOutType" value="${miIssueM.strOutType }" class="layui-input">
                        <option value="" ${miIssueM.strOutType eq '' ? 'selected':''}>请选择</option>
                        <option value="A" ${miIssueM.strOutType eq 'N' ? 'selected':''}>领料出库</option>
                        <option value="S" ${miIssueM.strOutType eq 'S' ? 'selected':''}>销售出库</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">申请人</label>
                <div class="layui-input-inline">
                    <input type="hidden" id="PickNameID" name="strApplyUserId"/>
                    <input type="text" id="PickName"  placeholder="点击挑选人员..." readonly class="layui-input"
                           style="padding-right: 50px;"/>
                    <i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
                    <a class="layui-btn layui-btn-sm" onPickUser="selectSingleUserCallback"
                       style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i
                            class="layui-icon layui-icon-search"></i></a>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">采购合同号</label>
                <div class="layui-input-inline">
                    <input type="text" name="strPoNo" class="layui-input" value="${miIssueM.strPoNo}"
                           />
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">状态</label>
                <div class="layui-input-inline">
                    <select name="strStus" value="${miIssueM.strStus }" class="layui-input">
                        <option value="" ${miIssueM.strStus eq '' ? 'selected':''}>请选择</option>
                        <option value="N" ${miIssueM.strStus eq 'N' ? 'selected':''}>新增</option>
                        <option value="S" ${miIssueM.strStus eq 'S' ? 'selected':''}>生效</option>
                        <option value="D" ${miIssueM.strStus eq 'D' ? 'selected':''}>删除</option>
                    </select>
                </div>
            </div>
            <%--<div class="layui-inline">
                <label class="layui-form-label">出货仓库</label>
                <div class="layui-input-inline">
                    <input type="text" name="strLocNo" class="layui-input" value="${miIssueM.strLocNo}"
                           />
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">入库单号</label>
                <div class="layui-input-inline">
                    <input type="text" name="strInspNo" class="layui-input" value="${miIssueM.strInspNo}"
                    />
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">出库人</label>
                <div class="layui-input-inline">
                    <input type="text" name="strOutUserId" class="layui-input" value="${miIssueM.strOutUserId}"
                           />
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">销售订单号</label>
                <div class="layui-input-inline">
                    <input type="text" name="strOrderNo" class="layui-input" value="${miIssueM.strOrderNo}"
                    />
                </div>
            </div>--%>
            <div class="layui-inline">
                <button class="search">查询</button>
            </div>
        </div>
    </form>
</div>
<div class="tab-bars">
    <a class="add" width="750" height="400" target="dialog" rel="miIssueMSave"
       dialogID="miIssueMSaveId" href="${ctx}/miIssueM/preCreate"><span>添加</span></a>
    <a class="edit" target="dialog"  rel="miIssueMSave" dialogID="miIssueMSaveId"
       width="1000" height="500" href="${ctx}/miIssueM/preUpdate/{slt_uid}"><span>编辑</span></a>
    <a class="delete" href="#" onclick="ihList('dele',this)"><span>删除</span></a>
    <%--<a class="confirm btn-small" href="#" onclick="ihList('effect',this)"><span>生效</span></a>
    <a class="cancelConfirm btn-small" href="#" onclick="ihList('uneffect',this)"><span>取消生效</span></a>
    <a class="add" width="500" height="500" target="dialog" dialogId="createMiIssueMDialog" href="${ctx}/miIssueM/preCreate">添加</a>
    <a class="edit" width="500" height="500" target="dialog" dialogId="upadteMiIssueMDialog" href="${ctx}/miIssueM/preUpdate/{slt_uid}">编辑</a>
    <a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/miIssueM/delete/{slt_uid}">删除</a>--%>
</div>
<div class="tab-content layui-form">
    <table class="frog-table">
        <thead>
        <tr>
            <th style="width: 30px;"><input type="checkbox" lay-skin="primary" class="checkAllInviter"
                                            lay-filter="checkboxInviter"></th>
            <th>序号</th>
            <th>出库单号</th>
            <th>出库类型</th>
           <%-- <th>入库单号</th>
            <th>采购合同号</th>
            <th>销售订单号</th>
            <th>出货仓库</th>--%>
            <th>申请人</th>
            <th>申请时间</th>
          <%--  <th>出库人</th>
            <th>出库时间</th>--%>
            <th>备注</th>
            <th>状态</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="miIssueM" varStatus="status">
            <tr target="slt_uid" rel="${miIssueM.id}" title="${miIssueM.strStus}" id="${miIssueM.id}">
                <td><input type="checkbox" data-value="${miIssueM.id}" lay-skin="primary" lay-filter="checkboxInviter"/>
                </td>
                <td>${page.pageBeginCount + status.index + 1}</td>
                <td>${miIssueM.strApplyNo}</td>
                <td style="width: 10%">${miIssueM.strOutType eq 'A'?"领料出库":(miIssueM.strOutType eq 'S'?"销售出库":"")}</td>
              <%--  <td>${miIssueM.strInspNo}</td>
                <td>${miIssueM.strPoNo}</td>
                <td>${miIssueM.strOrderNo}</td>
                <td>${miIssueM.strLocNo}</td>--%>
                <td>${miIssueM.strApplyUserId}</td>
                <td>${miIssueM.strApplyTime}</td>
                <%--<td>${miIssueM.strOutUserId}</td>
                <td>${miIssueM.strOutData}</td>--%>
                <td>${miIssueM.strMemo}</td>
                <td style="width: 5%">${miIssueM.strStus eq 'N'?"新增":(miIssueM.strStus eq 'S'?"生效":(miIssueM.strStus eq 'D'?"删除":""))}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
<script type="text/javascript">
    form.render();
    form.on('checkbox(checkboxInviter)', function (data) {
        if ($(data.elem).hasClass("checkAllInviter")) {
            if (data.elem.checked) {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
            } else {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
            }
            form.render('checkbox');
        }
    });

    /*
    * 选择单个人员的回调方法
    */
    function selectSingleUserCallback(userId, userNo, username) {
        $('#PickNameID').val(userId);
        $('#PickName').val(username);
    }
    function ihList(flag, obj) {
        var _this = $(obj);
        var strStatus = "";
        var ids = "";
        $('.frog-table', NavTab.getCurrentPanel()).find('tbody input[type="checkbox"]').each(function () {
            if ($(this).prop("checked")) {
                var id = $(this).parents('tr:first').attr("rel");
                strStatus = $(this).parents('tr:first').attr("title");
                if (strStatus == null || strStatus == '' || strStatus != 'N') {
                    Dialog.warn("选中的数据中，存在已经生效的数据。请重新选择");
                    return;
                }
                if (ids == "") {
                    ids = id;
                } else {
                    ids += "," + id;
                }
            }
        });
        if (ids == "") {
            Dialog.warn("未选中程序");
            return;
        }

        var info = "";
        if (strStatus == 'N')
            info = "新增";
        else if (strStatus == 'D')
            info = "删除";
        else if (strStatus == 'S')
            info = "生效";
        else
            info = "空";
        if (flag == 'edit' || flag == 'open') {
            $.post("${ctx}/miIssueM/preUpdate/" + rel, {}, function (content) {
                    top.layer.open({
                        id: 'miIssueMSaveId',
                        type: 1,
                        area: ["100%", "100%"],
                        title: "编辑",
                        shadeClose: true,
                        maxmin: true,
                        anim: 5,
                        yes: function (index) {
                            parent.layer.close(index);
                        },
                        btn2: function (index, layero) {
                            parent.layer.close(index);
                        },
                        content: content
                    });
                }
            )
        } else if (flag == 'dele' && strStatus == 'N') {
            layer.confirm('确定删除吗？', function (index) {
                var loadingIndex = Dialog.load();
                $.post("miIssueM/delete/" + ids, function (msg) {
                    try {
                        var result = JSON.parse(msg);
                        var messages = result.message;
                        if (result.statusCode == 200 || result.statusCode == '200') {
                            Dialog.success(messages);
                            NavTab.reloadWithPagination(result.navTabId);
                        } else {
                            Dialog.error(messages);
                        }
                    } catch (e) {
                        console.log(msg);
                        Dialog.error(e.message);
                    } finally {
                        layer.close(loadingIndex);
                    }
                });
            });
        } else if (flag == 'effect' && strStatus == 'N') {
            layer.confirm('确定生效吗？', function (index) {
                var loadingIndex = Dialog.load();
                $.post("${ctx}/miIssueM/effect/" + rel, function (msg) {
                    try {
                        var result = JSON.parse(msg);
                        var messages = result.message;
                        if (result.statusCode == 200 || msg.statusCode == '200') {
                            Dialog.success(messages);
                            NavTab.reloadWithPagination(result.navTabId);
                        } else {
                            Dialog.error(messages);
                        }
                    } catch (e) {
                        console.log(msg);
                        Dialog.error(e.message);
                    } finally {
                        layer.close(loadingIndex);
                    }
                });
            });
        } else if (flag == 'uneffect' && strStatus == 'S') {
            var re = rel;
            layer.confirm('确定取消生效吗？', function (index) {
                var loadingIndex = Dialog.load();
                $.post("${ctx}/miIssueM/uneffect/" + rel, function (msg) {
                    try {
                        var result = JSON.parse(msg);
                        var messages = result.message;
                        if (result.statusCode == 200 || result.statusCode == '200') {
                            Dialog.success(messages);
                            NavTab.reloadWithPagination(result.navTabId);
                        } else {

                            Dialog.error(messages);
                        }
                    } catch (e) {
                        console.log(msg);
                        Dialog.error(e.message);
                    } finally {
                        layer.close(loadingIndex);
                    }
                });
            });

        }
    }
</script>