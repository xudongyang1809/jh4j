<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<form id="pagerForm" method="post" action="${ctx}/miIssueM/ihList">
    <input type="hidden" name="pageNum" value="${page.pageNum}" />
    <input type="hidden" id="numPerPage_old" name="numPerPage" value="${page.numPerPage}" />
    <input type="hidden" name="orderField" value="${page.orderField}" />
    <input type="hidden" name="orderDirection" value="${page.orderDirection}" />
    <input type="hidden" name="strApplyNo" value="${miIssueD.strApplyNo}" />
    <input type="hidden" name="strSaleNo" value="${miIssueD.strSaleNo}" />
    <input type="hidden" name="strAreaId" value="${miIssueD.strAreaId}" />
    <input type="hidden" name="strReqNo" value="${miIssueD.strReqNo}" />
    <input type="hidden" name="strOrderNo" value="${miIssueD.strOrderNo}" />
    <input type="hidden" name="strMatrlNo" value="${miIssueD.strMatrlNo}" />
    <input type="hidden" name="strCfmEmpNo" value="${miIssueD.strCfmEmpNo}" />
    <input type="hidden" name="srtCfmDateTime" value="${miIssueD.strCfmDateTime}" />
    <input type="hidden" name="strOutUserId" value="${miIssueD.strOutUserId}" />
    <input type="hidden" name="strOutTime" value="${miIssueD.strOutTime}" />
    <input type="hidden" name="strStus" value="${miIssueD.strStus}" />
    <input type="hidden" name="operateType" value="${operateType}" />
</form>
<style>
    .sticky {
        position: -webkit-sticky;
        position: sticky;
        top: 0;}
</style>

<div id="alls1">
    <div class="tab-header">
        <form class="layui-form" action="${ctx}/miIssueM/ihList" onsubmit="return navTabSearch(this)">
            <input type="hidden" name="operateType" value="${operateType}" />
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">出库单号：</label>
                    <div class="layui-input-inline" style="width: 180px">
                        <input type="text" name="strApplyNo" value="${miIssueD.strApplyNo}" placeholder="出库单号" autocomplete="off" class="layui-input" />
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">销账单号：</label>
                    <div class="layui-input-inline" style="width: 180px; margin-left: 20px">
                        <input type="text" name="strSaleNo" value="${miIssueD.strSaleNo}" placeholder="销账单号" autocomplete="off" class="layui-input" />
                    </div>
                </div>
                <div class="layui-inline" style="float: none">
                    <label class="layui-form-label" style="margin-left: 20px;">状态：</label>
                    <div class="layui-input-inline" style="width: 180px;">
                        <select name="strStus">
                            <option value=''>---请选择---</option>
                            <option value='C' ${miIssueD.strStus eq 'C' ? "selected":""}>未销账</option>
                            <option value='S' ${miIssueD.strStus eq 'S' ? "selected":""}>已销账</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">计划编号：</label>
                    <div class="layui-input-inline" style="width: 180px;">
                        <input id="strReqNo_01Ihlist" name="strReqNo" value="${miIssueM.strReqNo}" class="layui-input" type="text" value="" style="padding-right: 50px;" placeholder="请挑选计划编号" autocomplete="off" />
                        <i class="layui-icon layui-icon-close" onclick="clearSelected('strReqNo_01Ihlist')"></i>
                        <a class="layui-btn-sm" href="${ctx}/miIssueM/selectReqNo?strReqNo1=strReqNo_01Ihlist"
                           title="挑选计划编号" target="dialog" width="800" height="500" dialogId="selecteihShipReqNo" style="position: absolute; top: 4px; right: 4px; bottom: 0px;"> <i class="layui-icon layui-icon-search"></i></a>
                    </div>
                </div>
                <div class="layui-inline" style="float: right; margin-right: 20px">
                    <button class="search">查询</button>
                </div>
            </div>
        </form>
    </div>
    <div class="tab-bars">
            <a class="confirm" href="#" onclick="ihShipListEx('effect',this)">销账</a>
            <a class="cancelConfirm" href="#" onclick="ihShipListEx('uneffect',this)">取消销账</a>
    </div>
    <div class="tab-content layui-form" >
        <table class="frog-table sticky" style="width: 300%;z-index:5; max-width: 300%;table-layout: fixed; word-break: break-all; word-wrap: break-word">
            <thead>
            <input type="hidden" name="orderId" id="orderId" value="${orderId}" />
            <tr>
                <td style="width:30px"><input type="checkbox" lay-skin="primary" class="checkAllIhShipIhList" lay-filter="checkboxIhShipIhList" /></td>
                <th style="width:30px">序号</th>
                <th>配送单号</th>
                <th>配送项次号</th>
                <th >审核领导</th>
                <th>存货编号</th>
                <th>品名</th>
                <th>型号规格</th>
                <th>品牌</th>
                <th>单价</th>
                <th>计划数量</th>
                <th>配送数量</th>
                <th>金额</th>
                <th>状态</th>
                <th>使用单位</th>
                <th>项目编号</th>
                <th>储位</th>
                <th>验收入库单</th>
                <th>销售合同号</th>
                <th>销售合同项次</th>
                <th>需求计划编号</th>
                <th>需求明细号</th>
                <th>出库人</th>
                <th>出库时间</th>
                <th>销账人</th>
                <th>销账时间</th>
                <th>销账单号</th>
            </tr>
            </thead>
        </table>
        <table class="frog-table" id="tableIhlist" style="width: 300%; max-width: 300%;table-layout: fixed; word-break: break-all; word-wrap: break-word">
            <tbody style="overflow-y:auto; ">
            <c:forEach items="${ihLabel}" var="miIssueD" varStatus="status">
                <tr  target="slt_uid" rel="${miIssueD.id}" id="${miIssueD.id}" statu="${miIssueD.strStus}"
                     ondblclick="showTaskDetail(this)">
                    <td style="width:30px"><input type="checkbox" name="checkitemDtl" lay-skin="primary" lay-filter="checkboxIhShipIhList"/></td>
                    <td style="width:30px">${page.pageBeginCount+status.index+1}</td>
                    <td>${miIssueD.strApplyNo}</td>
                    <td>${miIssueD.strShipItem}</td>
                    <td>${miIssueD.strCheckNo}-${miIssueD.strCheckNoNAME}</td>
                    <td>${miIssueD.strMatrlNo}</td>
                    <td>${miIssueD.strProdName}</td>
                    <td style=" width :  60px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;" title="${fn:escapeXml(miIssueD.strSpecMark)}">${fn:escapeXml(miIssueD.strSpecMark)}</td>
                    <td>${miIssueD.strBrand}</td>
                    <td displayType='currency' pattern='###,###.####'>${miIssueD.bdRealPrice}</td>
                    <td displayType='currency' pattern='###,###.###'>${miIssueD.bdPlanQty}</td>
                    <td displayType='currency' pattern='###,###.###'>${miIssueD.bdSaleQty}</td>
                    <td displayType='currency' pattern='###,###.##'>${miIssueD.bdAmt}</td>
                    <td>${miIssueD.strStus eq 'C'?"未销账":(miIssueD.strStus eq 'S'?"已销账":"")}</td>
                    <td>${miIssueD.strUserCust}</td>
                    <td style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"  title="${fn:escapeXml(miIssueD.strSpecMark)}">${miIssueD.strproJectName}</td>
                    <td>${miIssueD.strAreaId}-${miIssueD.strAreaName}</td>
                    <td>${miIssueD.strInspNo}</td>
                    <td>${miIssueD.strRealOrderNo}</td>
                    <td>${miIssueD.strRealOrderItem}</td>
                    <td>${miIssueD.strOrderNo}</td>
                    <td>${miIssueD.strOrderItem}</td>
                    <td>${miIssueD.strReqNo}</td>
                    <td>${miIssueD.strReqItem}</td>
                    <td>${miIssueD.PeiUserName}</td>
                    <td>${miIssueD.PeiDateTime}</td>
                    <td>${miIssueD.strChuName}</td>
                    <td>${miIssueD.strChuTime}</td>
                    <td>${miIssueD.cfmEmpName}</td>
                    <td>${miIssueD.cfmDateTime}</td>
                    <td>${miIssueD.PrintPeiNum}</td>
                    <td>${miIssueD.PrintCfmNum}</td>
                    <td>${miIssueD.strSaleNo}</td>
                    <td>${miIssueD.isSmart eq 'Y'?"是":"否"}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <!-- 分页 -->
    <%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>

