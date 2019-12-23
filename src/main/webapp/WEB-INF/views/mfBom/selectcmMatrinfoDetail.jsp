<%--
  Created by IntelliJ IDEA.
  User: maomin
  Date: 2019/5/9
  Time: 11:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<head>
    <script type="text/javascript">
        function selectMatrlDetail(obj) {
            debugger;
            $('#strMatrlNo').val(obj["strSn"]);
            $('#strMatrlName01').val(obj["strName"]);
            $('#strBrand').val(obj["strBrand"]);
            $('#strUnit').val(obj["strPrickleZH"]);
            $('#strSpec').val(obj["strSpec"]);
            $("div").each(function(){
                if($(this).attr("times") == $("#selectMfBomMatrinfoDetailId001").parent().attr("times")){
                    $(this).fadeOut(500,function(){
                        $(this).remove();
                    });
                }
            });
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
    <form method="post" action="${ctx}/mfBom/selectcmMatrinfoDetail" class="layui-form"  onsubmit="return navTabSearch(this,'#selectMfBomMatrinfoDetailId001')">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">存货编号</label>
                <div class="layui-input-inline">
                    <input type="text" id="selectSaleMatrlNo_strSn90" name="strSn" value="${cmMatrinfoDetail.strSn}" autocomplete="off" class="layui-input"/>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">存货名称</label>
                <div class="layui-input-inline">
                    <input type="text" id="strName90" name="strName" value="${cmMatrinfoDetail.strName}" autocomplete="off" class="layui-input"/>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">存货品牌</label>
                <div class="layui-input-inline">
                    <input type="text" id="strBrand90" name="strBrand" value="${cmMatrinfoDetail.strBrand}" autocomplete="off" class="layui-input"/>
                </div>
            </div>
            <div class="layui-inline">
                <button class="search btn-big">查询</button>
            </div>
        </div>
    </form>
</div>
<div class="tab-content">
    <div class="frog-table layui-form">
        <table>
            <thead>
                <tr>
                    <th>序号</th>
                    <%--<th>存货大类</th>--%>
                    <th>存货名称</th>
                    <th>存货编号</th>
                    <th>品名</th>
                    <th>品牌</th>
                    <th>库存单位</th>
                    <th>型号规格</th>
                    <th>请选择</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${list}" var="item" varStatus="status">
                <tr target="slt_uid" rel="${item.id}" id="${item.id}">
                    <td>${page.pageBeginCount+status.index+1}</td>
                   <%-- <td>${item.strClass}</td>--%>
                    <td>${item.strName}</td>
                    <td>${item.strSn}</td>
                    <td>${item.strName}</td>
                    <td>${item.strBrand}</td>
                    <td>${item.strPrickleZH}</td>
                    <td style="width: 230px">${item.strSpec}</td>
                    <td><a class="layui-btn layui-btn-xs" onclick="selectMatrlDetail({strSn:'${item.strSn}',strName:'${item.strName}',strBrand:'${item.strBrand}',strPrickleZH:'${item.strPrickleZH}',strSpec:'${item.strSpec}'})" title="查找带回">选择</a></td>
                </tr>
            </tbody>
            </c:forEach>
        </table>
    </div>
</div>
<%--
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>--%>
<c:import url="/WEB-INF/views/pager/dialogPagerBar.jsp">
    <c:param name="container" value="#selectMfBomMatrinfoDetailId001"/>
</c:import>