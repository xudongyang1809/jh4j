<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>

<form id="pagerForm" method="post" action="${ctx}/miBeginningM/list" onsubmit="return navTabAjaxDone(this)">
    <input type="hidden" name="pageNum" value="${page.pageNum}"/>
    <input type="hidden" name="numPerPage" value="${page.numPerPage}"/>
    <input type="hidden" name="orderField" value="${page.orderField}"/>
    <input type="hidden" name="orderDirection" value="${page.orderDirection}"/>
    <input type="hidden" name="keywords" value="${keywords}"/>
    <input type="hidden" name="strInspNo" value="${miAcceptanceM.strInspNo}"/>
    <input type="hidden" name="strInspType" value="${miAcceptanceM.strInspType}"/>
    <input type="hidden" name="strLocNo" value="${miAcceptanceM.strLocNo}"/>
    <input type="hidden" name="strInUserId" value="${miAcceptanceM.strInUserId}"/>
    <input type="hidden" name="strOrderNo" value="${miAcceptanceM.strOrderNo}"/>
    <input type="hidden" name="strStatus" value="${miAcceptanceM.strStatus}"/>
</form>
<div class="tab-header">
    <form method="post" action="${ctx}/miBeginningM/list" class="layui-form" onsubmit="return navTabSearch(this)">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">入库单号</label>
                <div class="layui-input-inline">
                    <input type="text" name="strInspNo" class="layui-input" value="${miAcceptanceM.strInspNo}"
                           />
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">入库人</label>
                <div class="layui-input-inline">
                    <input type="hidden" id="PickNameId" name="strInUserId"/>
                    <input type="text" id="PickName" placeholder="点击挑选人员..." readonly class="layui-input"
                           style="padding-right: 50px;"/>
                    <i class="layui-icon layui-icon-close" onclick="$(this).parent().find('input').val('');"></i>
                    <a class="layui-btn layui-btn-sm" onPickUser="selectSingleUserCallback"
                       style="position: absolute; top: 4px; right: 4px; bottom: 0px;"><i
                            class="layui-icon layui-icon-search"></i></a>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label" style="padding-left:21px">入库单状态：</label>
                <div class="layui-input-inline">
                    <select name="strStatus" class="layui-input">
                        <option value="" ${miAcceptanceM.strStatus eq '' ? 'selected':''}>-请选择-</option>
                        <option value="N" ${miAcceptanceM.strStatus eq 'N' ? 'selected':''}>新增</option>
                        <option value="C" ${miAcceptanceM.strStatus eq 'C' ? 'selected':''}>确认</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <button class="search">查询</button>
            </div>
        </div>
    </form>
</div>
<div class="tab-bars">
    <shiro:hasPermission name="MiAcceptanceM:create">
        <a class="add" width="750" height="300" target="dialog" dialogId="createMiAcceptanceMDialog"
           href="${ctx}/miBeginningM/preCreate">添加</a>
    </shiro:hasPermission>
    <shiro:hasPermission name="MiAcceptanceM:edit">
        <a class="edit" target="dialog" max="true" mask="true" dialogId="upadteMiAcceptanceMDialog"
           href="${ctx}/miBeginningM/preUpdate/{slt_uid}">编辑</a>
    </shiro:hasPermission>
    <a class="delete" onclick="deleteList()">删除</a>
    <a class="confirm" target="ajaxTodo" href="${ctx}/miBeginningM/updatestatue/{slt_uid}?flg=C"><span>确认</span></a>
    <a class="cancelConfirm" target="ajaxTodo" href="${ctx}/miBeginningM/updatestatue/{slt_uid}?flg=N"><span>取消确认</span></a>
</div>
<div class="tab-content layui-form">
    <table class="frog-table">
        <thead>
        <tr>
            <td style="width: 20px;"><input type="checkbox" lay-skin="primary" class="checkAllInviter"
                                            lay-filter="checkboxInviter"></td>
            <th>序号</th>
            <th>入库单号</th>
            <th>入库类型</th>
<%--            <th>仓库</th>
            <th>储位</th>
            <th>供应商</th>--%>
            <th>入库人</th>
            <th>入库时间</th>
            <%--<th>订单编号</th>--%>
            <th>入库单金额</th>
            <th>生效人员</th>
            <th>生效日期</th>
            <%--<th>实际到货日期</th>--%>
            <th>入库单状态</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="miAcceptanceM" varStatus="status">
            <tr target="slt_uid" rel="${miAcceptanceM.id}" title="${miAcceptanceM.strStatus}" th:each="miAcceptanceM,status : ${list}">
                <td><input type="checkbox" data-value="${miAcceptanceM.id}" lay-skin="primary"
                           lay-filter="checkboxInviter"/></td>
                <td title="序号">${page.pageBeginCount + status.index + 1}</td>
                <td>${miAcceptanceM.strInspNo}</td>
                <td>${miAcceptanceM.strInspType eq 'A'?"采购入库":(miAcceptanceM.strInspType
                        eq 'B'?"产品入库":(miAcceptanceM.strInspType eq 'C'?"贸易入库":miAcceptanceM.strInspType eq 'D'?"期初入库":""))}</td>
<%--                <td>${miAcceptanceM.strLocNo}</td>
                <td>${miAcceptanceM.strAreaId}</td>
                <td>${miAcceptanceM.strSaleVendor}</td>--%>
                <td>${miAcceptanceM.strInUserId}</td>
                <td>${miAcceptanceM.strApplyDateTime}</td>
                <%--<td>${miAcceptanceM.strOrderNo}</td>--%>
                <td>${miAcceptanceM.strInspNoPrice}</td>
                <td>${miAcceptanceM.strCfmEmpNo}</td>
                <td>${miAcceptanceM.strCfmDateTime}</td>
                <%--<td>${miAcceptanceM.strActualDate}</td>--%>
                <td style="width: 10%">${miAcceptanceM.strStatus eq 'N'?"新增":(miAcceptanceM.strStatus eq 'C'?"确认":(miAcceptanceM.strStatus eq 'D'?"删除":""))}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
<script type="text/javascript">
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
        $('#PickNameId').val(userId);
        $('#PickName').val(username);
    }
    function deleteList() {
        var ids = "";
        var flag = false;
        $('.frog-table', NavTab.getCurrentPanel()).find('tbody input[type="checkbox"]').each(function () {
            if ($(this).prop("checked")) {
                var id = $(this).parents('tr:first').attr("rel");
                var status = $(this).parents('tr:first').attr("title");
                if(status != "N"){
                    flag = true;
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
        if(flag){
            Dialog.warn("不能删除已确认的数据！");
            return;
        }

        layer.confirm('确定删除？', function (index) {
            var loadingIndex = Dialog.load();
            $.post("${ctx}/miBeginningM/delete", {id: ids}, function (msg) {
                layer.close(index);
                try {
                    var result = JSON.parse(msg);
                    Ajax.ajaxDone(result);
                    if (result.statusCode == 200) {
                        NavTab.reloadWithPagination(result.navTabId);
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
</script>