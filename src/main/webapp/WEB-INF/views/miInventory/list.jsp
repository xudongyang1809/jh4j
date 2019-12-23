<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<!--
@desc “此代码是自动生成，请继续优化注释”
@author 超级管理员 admin
@date 2019-05-27 10:13:33
@copyRight: 江苏金恒信息科技股份有限公司
-->
<form id="pagerForm" method="post" action="${ctx}/miInventory/list" onsubmit="return navTabAjaxDone(this)">
    <input type="hidden" name="pageNum" value="${page.pageNum}"/>
    <input type="hidden" name="numPerPage" value="${page.numPerPage}"/>
    <input type="hidden" name="orderField" value="${page.orderField}"/>
    <input type="hidden" name="orderDirection" value="${page.orderDirection}"/>
    <input type="hidden" name="keywords" value="${keywords}"/>
</form>
<%--<div class="tab-bars">--%>
<%--<shiro:hasPermission name="MiInventory:create">--%>
<%--<a class="add" width="500" height="500" target="dialog" dialogId="createMiInventoryDialog" href="${ctx}/miInventory/preCreate">添加</a>--%>
<%--</shiro:hasPermission>--%>
<%--<shiro:hasPermission name="MiInventory:edit">--%>
<%--<a class="edit" width="500" height="500" target="dialog" dialogId="upadteMiInventoryDialog" href="${ctx}/miInventory/preUpdate/{slt_uid}">编辑</a>--%>
<%--</shiro:hasPermission>--%>
<%--<shiro:hasPermission name="MiInventory:delete">--%>
<%--<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/miInventory/delete/{slt_uid}">删除</a>--%>
<%--</shiro:hasPermission>--%>
<%--</div>--%>
<div class="tab-header">
    <form method="post" action="${ctx}/miInventory/list" class="layui-form" onsubmit="return navTabSearch(this)">
        <div class="layui-form-item">
            <div class="layui-inline layui-col-md3">
                <label class="layui-form-label">业务类型</label>
                <div class="layui-input-inline">
                    <select name="viewtype" class="layui-input">
                        <option value="" >-请选择-</option>
                        <option value="期初入库"}>期初入库</option>
                        <option value="采购入库"}>采购入库</option>
                        <option value="产品入库"}>产品入库</option>
                        <option value="贸易入库"}>贸易入库</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline layui-col-md3">
                <label class="layui-form-label">业务单号</label>
                <div class="layui-input-inline">
                    <input type="text" name="viewnum" id="viewnum" class="layui-input" value="${miInventory.viewnum}"/>
                </div>
            </div>
            <div class="layui-inline layui-col-md3">
                <label class="layui-form-label">储位</label>
                <div class="layui-input-inline">
                    <select name="strAreaId" id="strAreaId" >
                        <option value=''>请选择</option>
                        <c:forEach items="${dictDtlList}" var="field">
                            <option value='${field.id}'>${field.strName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-inline layui-col-md3">
                <label class="layui-form-label">存货编号</label>
                <div class="layui-input-inline">
                    <input type="text" name="strMatrlNo" id="strMatrlNo" class="layui-input" value="${miInventory.strMatrlNo}"/>
                </div>
            </div>
            <div class="layui-inline">
                <button class="search">查询</button>
            </div>
        </div>
    </form>
</div>
<div class="tab-content">
    <table class="frog-table">
        <thead>
        <tr>
            <th>序号</th>
            <th>业务单号</th>
            <th>批次号</th>
            <th>业务类型</th>
            <th>储位</th>
            <th>供应商</th>
            <th>存货编号</th>
            <th>品名</th>
            <th>品牌</th>
            <th>型号规格</th>
            <th>单价</th>
            <th>数量</th>
            <th>计量单位</th>
            <th>总金额(单位:元)</th>
            <th>库存状态</th>
            <%--<th>业务ID</th>--%>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="miInventory" varStatus="status">
            <tr target="slt_uid" rel="${miInventory.id}" id="${miInventory.id}">
                <td>${page.pageBeginCount + status.index + 1}</td>
                <td>${miInventory.viewnum}</td>
                <td>${miInventory.strPoNo}</td>
                <td>${miInventory.viewtype}</td>
                <td>${miInventory.strAreaId}</td>
                <td>${miInventory.supplier}</td>
                <td>${miInventory.strMatrlNo}</td>
                <td>${miInventory.strMatrlName}</td>
                <td>${miInventory.strBrand}</td>
                <td>${miInventory.strSpec}</td>
                <td>${miInventory.bdBuyPrice}</td>
                <td>${miInventory.bdQty}</td>
                <td>${miInventory.strUnit}</td>
                <td>${miInventory.bdAmt}</td>
                <td>${miInventory.status}</td>
                <%--<td>${miInventory.viewid}</td>--%>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
