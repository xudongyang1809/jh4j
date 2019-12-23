<%--
  Created by IntelliJ IDEA.
  User: maomin
  Date: 2019/5/9
  Time: 11:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/views/include.inc.jsp" %>
<head>
    <script type="text/javascript">
        function selectMp() {
            var strApplyNo = document.getElementById('strApplyNo').value;//出库单号
            var strStus = document.getElementById('strStus').value;//出库单号
            var Items = document.getElementsByName("checkitemDtl");
            var num = 0;
            var result = '';
            for (var i = 0; i < Items.length; i++) {
                if (Items.item(i).checked) {
                    num++;
                    var tr = Items.item(i).parentNode.parentNode;
                    var ihId = tr.cells[0].children[0].id;
                    if (result == '') {
                        result = ihId;
                    } else {
                        result = result + "," + ihId;
                    }
                }
            }
            if (num == 0)
                Dialog.warn("请至少选择一条信息！");
            else {
                $.ajax({
                    url: '${ctx}/miIssueD/selectInsert',
                    data: {id: result, strApplyNo: strApplyNo},
                    dataType: 'text',
                    success: function (msg) {
                        try {
                            var result = JSON.parse(msg);
                            var messages = result.message;
                            if (result.statusCode == 200) {
                                Dialog.success("挑选成功!");  //${ctx}/miIssueM/saveDtl?id=${id}&strStus=${strStus}
                                $("#allPageContent").load("${ctx}/miIssueM/saveDtl?id=" + strApplyNo + "&strStus=" + strStus , function () {
                                    var dialogIndex = Dialog.getCurrentDialog().attr("times");
                                    if (dialogIndex) {
                                        layer.close(dialogIndex);
                                    }
                                })
                            } else {
                                Dialog.error(messages);
                            }
                        } catch (e) {
                            console.log(msg);
                            Dialog.error(e.message);
                        }
                    }
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
        form.render();

        function selectStrMatrlNoList(obj) {
            $("#strMatrlNo").val(obj["strMatrlNo"]);//存货编号
            $("#strMatrlName").val(obj["strMatrlName"]);//品名
            $("#strBrand").val(obj["strBrand"]);//品牌
            $("#strInspNo").val(obj["viewnum"]);//入库单号
            $("#strInspItem").val(obj["strPoNo"]);//入库项次号
            $("#strSpec").val(obj["strSpec"]);//型号规格
            $("#strUnit").val(obj["strUnit"]);//单位
            $("#bdRealPrice").val(obj["bdBuyPrice"]);//单价
            $("#bdQty").val(obj["bdQty"]);//数量
            $("#bdAmt").val(obj["bdAmt"]);//总金额
            $("div").each(function () {
                if ($(this).attr("times") == $("#selectInventory").parent().attr("times")) {
                    $(this).fadeOut(500, function () {
                        $(this).remove();
                    });
                }
            })
        }
    </script>

</head>
<div id="allPageContent">
    <div class="tab-header">
        <form method="post" action="${ctx}/miInventory/list" class="layui-form" onsubmit="return navTabSearch(this)">
            <div class="layui-form-item">
                <div class="layui-inline layui-col-md3">
                    <label class="layui-form-label">业务单号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="viewnum" id="viewnum" class="layui-input"
                               value="${miInventory.viewnum}"/>
                    </div>
                </div>
                <div class="layui-inline layui-col-md3">
                    <label class="layui-form-label">存货编号</label>
                    <div class="layui-input-inline">
                        <input type="text" name="strMatrlNo" id="strMatrlNo" class="layui-input"
                               value="${miInventory.strMatrlNo}"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="search">查询</button>
                </div>
            </div>
        </form>
    </div>
    <div class="tab-bars">
        <a class="add" href="#" onclick="selectMp()"><span>确定</span></a>
    </div>
    <form id="pagerForm" method="post" class="layui-form"  action="${ctx}/miInventory/list" onsubmit="return navTabAjaxDone(this)">
        <input type="hidden" name="pageNum" value="${page.pageNum}"/>
        <input type="hidden" name="numPerPage" value="${page.numPerPage}"/>
        <input type="hidden" name="orderField" value="${page.orderField}"/>
        <input type="hidden" id="strShipItem" name="strShipItem" value="${strShipItem}"/>
        <input type="hidden" id="strSaleNo" name="strSaleNo" value="${strSaleNo}"/>
        <input type="hidden" id="strApplyNo" name="strApplyNo" value="${strApplyNo}"/>
        <input type="hidden" id="strStus" name="strStus" value="${strStus}"/>
        <input type="hidden" name="orderDirection" value="${page.orderDirection}"/>
        <input type="hidden" name="keywords" value="${keywords}"/>
        <table class="frog-table" style="width: 300%; max-width: 400%;">
            <thead>
            <tr>
                <th style="width: 20px;"><input type="checkbox" lay-skin="primary" group="checkitemDtl"
                                                class="checkboxSaveDtl" lay-filter="checkboxcheckboxSaveDtl"/></th>
                <th>序号</th>
                <th>业务单号</th>
                <th>批次号</th>
                <th>业务类型</th>
                <th>储位</th>
                <th>存货编号</th>
                <th>品名</th>
                <th>品牌</th>
                <th>型号规格</th>
                <th>单价</th>
                <th>数量</th>
                <th>单位</th>
                <th>总金额</th>
                <%--<th>操作</th>--%>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${list}" var="miInventory" varStatus="status">
                <tr target="slt_uid" rel="${miInventory.id}" id="${miInventory.id}">
                    <td><input type="checkbox" lay-skin="primary" name="checkitemDtl" id="${miInventory.id}"
                               lay-filter="checkboxcheckboxSaveDtl"></td>
                    <td>${page.pageBeginCount + status.index + 1}</td>
                    <td>${miInventory.viewnum}</td>
                    <td>${miInventory.strPoNo}</td>
                    <td>${miInventory.viewtype}</td>
                    <td>${miInventory.strAreaId}</td>
                    <td>${miInventory.strMatrlNo}</td>
                    <td>${miInventory.strMatrlName}</td>
                    <td>${miInventory.strBrand}</td>
                    <td>${miInventory.strSpec}</td>
                    <td>${miInventory.bdBuyPrice}</td>
                    <td>${miInventory.bdQty}</td>
                    <td>${miInventory.strUnit}</td>
                    <td>${miInventory.bdAmt}</td>
                        <%--<td><a class="layui-btn layui-btn-sm"
                               onclick="selectStrMatrlNoList({strMatrlNo:'${miInventory.strMatrlNo}',strMatrlName:'${miInventory.strMatrlName}',strUnit:'${miInventory.strUnit}',
                                       bdBuyPrice:'${miInventory.bdBuyPrice}',bdQty:'${miInventory.bdQty}',bdAmt:'${miInventory.bdAmt}',strBrand:'${miInventory.strBrand}',
                                       viewnum:'${miInventory.viewnum}',strPoNo:'${miInventory.strPoNo}',strSpec:'${miInventory.strSpec}'})"
                               title="查找带回" style="position:relative">选择</a></td>--%>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form>
</div>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
