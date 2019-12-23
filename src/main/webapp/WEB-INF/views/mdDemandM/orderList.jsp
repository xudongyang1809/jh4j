<%--
  Created by IntelliJ IDEA.
  User: maomin
  Date: 2019/5/9
  Time: 11:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<head>   
    <script type="text/javascript">
        function selectStrOrdNoList(obj){
            $("#strOrderNoName001").val(obj["strOrderNo"]);
            $("#strVendorNo").val(obj["strVendorNo"]);
            $("div").each(function(){
                if($(this).attr("times") == $("#selectStrOrdNoDialogId1").parent().attr("times")){
                    $(this).fadeOut(500,function(){$(this).remove();});
                }
            })
        }
    </script>
</head>
<form id="pagerForm01" method="post" action="${ctx}/pmOrderPay/listOrder">
    <input type="hidden" name="pageNum" value="${page.pageNum}" />
    <input type="hidden" name="numPerPage" value="${page.numPerPage}" />
    <input type="hidden" name="orderField" value="${page.orderField}" />
    <input type="hidden" name="orderDirection" value="${page.orderDirection}" />
    <input type="hidden" name="keywords" value="${keywords}" />
    <input type="hidden" name="flg" value="${flg}"/>
</form>
<div class="tab-header">
    <form method="post" action="${ctx}/mdDemandM/orderList" class="layui-form" onsubmit="return navTabSearch(this,'#selectStrOrdNoDialogId1')">
        <div class="layui-form-item">
            <input type="hidden" name="strProjectName" value="${strProjectName}"/>
            <div class="layui-inline">
                <label class="layui-form-label">销售订单编号：</label>
                <div class="layui-input-inline">
                    <input type="text" name="strOrderNo" value="${msOrderM.strOrderNo}" placeholder="输入合同编号..." autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">销售订单名称：</label>
                <div class="layui-input-inline">
                    <input type="text" name="strOrderName" value="${msOrderM.strOrderName}" placeholder="输入合同名称..." autocomplete="off" class="layui-input">
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
            <th width="30">序号</th>
            <th>销售订单编号</th>
            <th>销售订单名称</th>
            <th>销售订单类型</th>
            <th>客商编号</th>
            <th>查找带回</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="msOrderList" varStatus="status">
            <tr target="slt_uid" rel="${msOrderList.id}" id="${msOrderList.id}" ><!-- ondblclick="selectOrder01(this)" -->
                <td>${page.pageBeginCount+status.index+1}</td>
                <td>${msOrderList.strOrderNo}</td>
                <td>${msOrderList.strOrderName}</td>
                <th>${msOrderList.strOrderStyle1}</th>
                <td>${msOrderList.strVendorNo}</td>
                <td><a class="layui-btn layui-btn-xs" onclick="selectStrOrdNoList({strOrderNo:'${msOrderList.strOrderNo}',strVendorNo:'${msOrderList.strVendorNo}'})" title="查找带回">选择</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
