<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>

<form id="pagerForm" method="post" action="${ctx}/miIssueD/list" onsubmit="return navTabAjaxDone(this)">
    <input type="hidden" name="pageNum" value="${page.pageNum}"/>
    <input type="hidden" name="numPerPage" value="${page.numPerPage}"/>
    <input type="hidden" name="orderField" value="${page.orderField}"/>
    <input type="hidden" name="orderDirection" value="${page.orderDirection}"/>
    <input type="hidden" name="keywords" value="${keywords}"/>
    <input type="hidden" name="strSaleNo" value="${miIssueD.strSaleNo}"/>
    <input type="hidden" name="strApplyNo" value="${miIssueD.strApplyNo}"/>
    <input type="hidden" id="strStus" name="strStus" value="${miIssueD.strStus}"/>
    <input type="hidden" name="strReqNo" value="${miIssueD.strReqNo}"/>
</form>
<div class="tab-header">
    <form method="post" action="${ctx}/miIssueD/list" class="layui-form" onsubmit="return navTabSearch(this)">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">销账单号</label>
                <div class="layui-input-inline">
                    <input type="text" name="strSaleNo" class="layui-input" value="${miIssueD.strSaleNo}"
                    />
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">出库单号</label>
                <div class="layui-input-inline">
                    <input type="text" name="strApplyNo" class="layui-input" value="${miIssueD.strApplyNo}"
                    />
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label" style="padding-left:21px">状态：</label>
                <div class="layui-input-inline">
                    <select name="strStus" class="layui-input">
                        <option value="">-请选择-</option>
                        <option value="C">未销账</option>
                        <option value="D">已销账</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">需求计划编号</label>
                <div class="layui-input-inline">
                    <input type="text" name="strReqNo" class="layui-input" value="${miIssueD.strReqNo}"/>
                </div>
            </div>
            <div class="layui-inline">
                <button class="search">查询</button>
            </div>
        </div>
    </form>
</div>
<div class="tab-bars">
    <%--<shiro:hasPermission name="MiIssueD:create">
           <a class="add" width="1200" height="600" target="dialog" dialogId="createMiIssueDDialog" href="${ctx}/miIssueD/preCreate">添加</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="MiIssueD:edit">
           <a class="edit" width="500" height="500" target="dialog" dialogId="upadteMiIssueDDialog" href="${ctx}/miIssueD/preUpdate/{slt_uid}">编辑</a>
       </shiro:hasPermission>
       <shiro:hasPermission name="MiIssueD:delete">
           <a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/miIssueD/delete/{slt_uid}">删除</a>
       </shiro:hasPermission>
       <a class="approve" href="#" onclick="ihShipListEx('confirm',this)">审核(部门领导)</a>
        <a class="sendback" href="#" onclick="ihShipListEx('unconfirm',this)">取消审核(部门领导)</a>
           <a class="edit" target="dialog"  rel="miIssueMSave" dialogID="miIssueMSaveId"
       width="1200" height="600" href="${ctx}/miIssueM/preUpdate/{slt_uid}"><span>编辑</span></a>--%>
    <a class="confirm" href="#" onclick="ihShipListEx('seles',this)">销账</a>
    <a class="cancelConfirm" href="#" onclick="ihShipListEx('unseles',this)">取消销账</a>
</div>
<div class="tab-content layui-form">
    <table class="frog-table sticky"
           style="width: 300%;z-index:5; max-width: 300%;table-layout: fixed; word-break: break-all; word-wrap: break-word">
        <thead>
        <tr>
            <th style="width: 30px;"><input type="checkbox" lay-skin="primary" class="checkAllInviter"
                                            lay-filter="checkboxInviter"></th>
            <th style="width:2%">序号</th>
            <th>销账单号</th>
            <th>出库单号</th>
            <th>出库项次</th>
            <th>状态</th>
            <th>验收入库单</th>
            <th>验收入库项次号</th>
            <th>存货编号</th>
            <th>储位</th>
            <th>品名</th>
            <th>型号规格</th>
            <th>计量单位</th>
            <th>品牌</th>
            <th>出库数量</th>
            <th>单价</th>
            <%--<th>销售数量</th>--%>
            <th>金额</th>
<%--            <th>销账人</th>
            <th>销账日期</th>--%>
            <th>出库人</th>
            <th>出库时间</th>
            <th>出库类型</th>
<%--            <th>使用单位</th>
            <th>审核人</th>--%>
            <th>备注</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="miIssueD" varStatus="status">
            <tr target="slt_uid" rel="${miIssueD.id}" title="${miIssueD.strStus}" id="${miIssueD.id}">
                <td><input type="checkbox" data-value="${miIssueD.id}" lay-skin="primary" lay-filter="checkboxInviter"/>
                </td>
                <td>${page.pageBeginCount + status.index + 1}</td>
                <td>${miIssueD.strSaleNo}</td>
                <td>${miIssueD.strApplyNo}</td>
                <td>${miIssueD.strShipItem}</td>
                <td>${miIssueD.strStus eq 'A'?"未出库":(miIssueD.strStus eq 'B'?"已出库":
                        (miIssueD.strStus eq 'C'?"未销账":(miIssueD.strStus eq 'D'?"已销账":"")))}</td>
                <td>${miIssueD.strInspNo}</td>
                <td>${miIssueD.strInspItemCon}</td>
                <td>${miIssueD.strMatrlNo}</td>
                <td>${miIssueD.strAreaId}</td>
                <td>${miIssueD.strMatrlName}</td>
                <td>${miIssueD.strSpec}</td>
                <td>${miIssueD.strUnit}</td>
                <td>${miIssueD.strBrand}</td>
                <td>${miIssueD.bdQty}</td>
                <td>${miIssueD.bdRealPrice}</td>
                <%--<td>${miIssueD.bdSaleQty}</td>--%>
                <td>${miIssueD.bdAmt}</td>
<%--                <td>${miIssueD.strCfmEmpNo}</td>
                <td>${miIssueD.strCfmDateTime}</td>--%>
                <td>${miIssueD.strOutUserId}</td>
                <td>${miIssueD.strOutTime}</td>
                <td>${miIssueD.strA}</td>
<%--                <td>${miIssueD.strUserCust}</td>
                <td>${miIssueD.strVerifyUser}</td>--%>
                <td>${miIssueD.strMemo}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
<script>
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
    function ihShipListEx(flag, obj){
        var _this = $(obj);
        var strStatus = "";
        var ids = "";
        $('.frog-table', NavTab.getCurrentPanel()).find('tbody input[type="checkbox"]').each(function () {
            if ($(this).prop("checked")) {
                var id = $(this).parents('tr:first').attr("rel");
                strStatus = $(this).parents('tr:first').attr("title");
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
        if (flag == 'seles' && strStatus == 'C') {
            layer.confirm('确定销账吗？', function (index) {
                var loadingIndex = Dialog.load();
                $.post("${ctx}/miIssueD/unseles?id=" + ids + "&flag=" + strStatus, function (msg) {
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
        } else if(flag == 'seles' && strStatus == 'D'){
            Dialog.warn("只能操作未销账的数据");
            return;
        }else if(flag == 'unseles' && strStatus == 'C'){
            Dialog.warn("只能操作已销账的数据");
            return;
        }else if (flag == 'unseles' && strStatus == 'D') {
            layer.confirm('确定取消销账吗？', function (index) {
                var loadingIndex = Dialog.load();
                $.post("${ctx}/miIssueD/unseles?id=" + ids + "&flag=" + strStatus, function (msg) {
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