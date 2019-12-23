<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<!--
@desc “此代码是自动生成，请继续优化注释”
@author 超级管理员 admin
@date 2019-05-10 11:32:22
@copyRight: 江苏金恒信息科技股份有限公司
-->
<div id="mdDemandDId">
<form id="pagerForm" method="post" action="${ctx}/mdDemandD/list" onsubmit="return navTabAjaxDone(this)">
    <input type="hidden" name="pageNum" value="${page.pageNum}" />
    <input type="hidden" name="numPerPage" value="${page.numPerPage}" />
    <input type="hidden" name="orderField" value="${page.orderField}" />
    <input type="hidden" name="orderDirection" value="${page.orderDirection}" />
    <input type="hidden" name="keywords" value="${keywords}"/>
    <input type="hidden" id="strApplyNo" value="${strApplyNo}">
    <input type="hidden" id="strTypeId" value="${strTypeId}">
    <input type="hidden" id="strOrderNo005" value="${strOrderNo}">
</form>
<div class="tab-bars">
    <c:if test="${strStus != 'S'}">
        <c:if test="${strTypeId == '3'}">
            <shiro:hasPermission name="MdDemandD:create">
                <a class="add" width="800" height="500" target="dialog" dialogId="createMdDemandDDialog" href="${ctx}/mdDemandD/preCreate?strApplyNo=${strApplyNo}">添加</a>
            </shiro:hasPermission>
            <shiro:hasPermission name="MdDemandD:edit">
                <a class="edit" width="800" height="500" target="dialog" dialogId="createMdDemandDDialog" href="${ctx}/mdDemandD/preUpdate/{slt_uid}">编辑</a>
            </shiro:hasPermission>
            <%--<shiro:hasPermission name="MdDemandM:view">
                <a class="confirm" onclick="updateMdDemandDStatueToS03()">生效</a>
            </shiro:hasPermission>
            <shiro:hasPermission name="MdDemandM:view">
                <a class="confirm" onclick="updateMdDemandDStatueToN03()">取消生效</a>
            </shiro:hasPermission>--%>
        </c:if>

        <c:if test="${strTypeId == '1'}">
            <shiro:hasPermission name="MdDemandD:create">
                <a class="choose" onclick="selectDemandDetail()">挑选</a>
            </shiro:hasPermission>
            <shiro:hasPermission name="MdDemandD:create">
                <a class="confirm" onclick="saveDemandDetail()">保存</a>
            </shiro:hasPermission>
           <%-- <shiro:hasPermission name="MdDemandM:view">
                <a class="confirm" onclick="updateMdDemandDStatueToS()">生效</a>
            </shiro:hasPermission>
            <shiro:hasPermission name="MdDemandM:view">
                <a class="confirm" onclick="updateMdDemandDStatueToN()">取消生效</a>
            </shiro:hasPermission>--%>
        </c:if>

        <c:if test="${strTypeId == '2'}">
            <shiro:hasPermission name="MdDemandD:create">
                <a class="choose" onclick="selectDemandDetail()">挑选</a>
            </shiro:hasPermission>
            <shiro:hasPermission name="MdDemandD:create">
                <a class="confirm" onclick="saveDemandDetail()">保存</a>
            </shiro:hasPermission>
           <%-- <shiro:hasPermission name="MdDemandM:view">
                <a class="confirm" onclick="updateMdDemandDStatueToS()">生效</a>
            </shiro:hasPermission>
            <shiro:hasPermission name="MdDemandM:view">
                <a class="confirm" onclick="updateMdDemandDStatueToN()">取消生效</a>
            </shiro:hasPermission>--%>
        </c:if>

        <shiro:hasPermission name="MdDemandD:delete">
            <%--<a class="delete" target="ajaxTodo" title="确定要删除吗?" href="${ctx}/mdDemandD/delete/{slt_uid}">删除</a>--%>
            <a class="delete" onclick="deleteDemandDetail()">删除</a>
        </shiro:hasPermission>
    </c:if>
    <c:if test="${strStus == 'S'}">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px">
            <legend>非新增状态不可修改</legend>
        </fieldset>
        <c:if test="${strTypeId == '3'}">
            <shiro:hasPermission name="MdDemandD:create">
                <a class="confirm" onclick="saveDemandDetail()">保存</a>
            </shiro:hasPermission>
            <shiro:hasPermission name="MdDemandM:view">
                <a class="confirm" onclick="updateMdDemandDStatueToS03()">生效</a>
            </shiro:hasPermission>
            <shiro:hasPermission name="MdDemandM:view">
                <a class="confirm" onclick="updateMdDemandDStatueToN03()">取消生效</a>
            </shiro:hasPermission>
        </c:if>
        <c:if test="${strTypeId == '1' || strTypeId == '2'}">
            <shiro:hasPermission name="MdDemandD:create">
                <a class="confirm" onclick="saveDemandDetail()">保存</a>
            </shiro:hasPermission>
            <shiro:hasPermission name="MdDemandM:view">
                <a class="confirm" onclick="updateMdDemandDStatueToS()">生效</a>
            </shiro:hasPermission>
            <shiro:hasPermission name="MdDemandM:view">
                <a class="confirm" onclick="updateMdDemandDStatueToN()">取消生效</a>
            </shiro:hasPermission>
        </c:if>
    </c:if>

</div>
<%--<div class="layui-form">--%>
    <table class="frog-table layui-form">
        <thead>
        <tr>
            <th><input type="checkbox" lay-skin="primary" class="checkAllDemandDetail" lay-filter="checkAllDemandDetail"></th>
            <th>序号</th>
            <th>需求计划编号</th>
            <th>需求计划项次号</th>
            <c:if test="${strTypeId != '3'}">
                <th>销售订单编号</th>
                <th>销售订单项次</th>
            </c:if>
            <th>存货编号</th>
            <th>存货名称</th>
            <th>品牌</th>
            <th>库存单位</th>
            <th>型号规格</th>
            <c:if test="${strTypeId != '3'}">
                <th>销售单价</th>
                <th>销售数量</th>
            </c:if>
            <th>计划申报数量</th>
            <th>建议单价</th>
            <th>备注</th>
            <th>状态</th>
        </tr>
        </thead>
        <tbody id="table_list">
            <c:forEach items="${demandDetailList}" var="mdDemandD" varStatus="status">
                <tr target="slt_uid" rel="${mdDemandD.id}" id="${mdDemandD.id}">
                    <td><input type="checkbox" name="check_HW02" data-value="${mdDemandD.id}" lay-skin="primary" lay-filter="checkAllDemandDetail"/></td>
                    <td>${page.pageBeginCount + status.index + 1}</td>
                    <td>${mdDemandD.strApplyNo}</td><%--需求申报单号--%>
                    <td>${mdDemandD.strApplyItem}</td><%--需求申报项次--%>
                    <c:if test="${strTypeId != '3'}">
                        <td>${mdDemandD.strOrderNo}</td><%--销售订单编号--%>
                        <td>${mdDemandD.strOrderItem}</td><%--销售订单项次--%>
                    </c:if>
                    <td>${mdDemandD.strMatrlNo}</td><%--存货编号--%>
                    <td>${mdDemandD.strMatrlName}</td><%--存货名称--%>
                    <td>${mdDemandD.strBrand}</td><%--品牌--%>
                    <td>${mdDemandD.strUnit}</td><%--库存单位--%>
                    <td>${mdDemandD.strSpec}</td><%--型号规格--%>
                    <c:if test="${strTypeId != '3'}">
                        <td>${mdDemandD.bdSalePrice}</td><%--销售单价--%>
                        <td>${mdDemandD.bdPlanQty}</td><%--销售数量--%>
                    </c:if>
                    <c:if test="${strTypeId == '1' || strTypeId == '2'}"><%--贸易--%><%--${mdDemandD.bdMatrlQty}${mdDemandD.bdPlanPrice}"--%>
                        <td><input id="bdApplyNumber" autocomplete="off" name="bdApplyNumber" value="${mdDemandD.bdApplyNumber}" style="width:80px"/></td>
                        <td><input id="bdPlanPrice" autocomplete="off" name="bdPlanPrice" value="${mdDemandD.bdPlanPrice}" style="width:50px"/></td>
                        <td><input id="strRemark" autocomplete="off" name="strRemark" value="${mdDemandD.strRemark}" style="width:150px"/></td>
                    </c:if>
                    <c:if test="${strTypeId == '3'}">
                        <td>${mdDemandD.bdApplyNumber}</td>
                        <td>${mdDemandD.bdPlanPrice}</td>
                        <td>${mdDemandD.strRemark}</td>
                    </c:if>
                    <td>${mdDemandD.strStatuZH}</td>
                    <%--<td style="display: none;"><input type="hidden" id="mdDemandDId001" value="${mdDemandD.id}"/></td>--%>
                    <td style="display: none;"><input type="hidden" id="strApplyItem" value="${mdDemandD.strApplyItem}"/></td>
                    <td style="display: none"><input type="hidden" id="strMatrlNo020" value="${mdDemandD.strMatrlNo}"></td>
                    <td style="display: none">${mdDemandD.strStus}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
<%--</div>--%>
<!-- 分页 -->
    <%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>
</div>
<script>
    /*需求申报明细状态变为生效*/
   function updateMdDemandDStatueToS(){
        debugger;
        var flg = "R";
        var strOrderNo = $("#strOrderNo005").val();
        var strApplyNo = $("#strApplyNo").val();
        var btbedit = document.getElementsByName("check_HW02");
        var trId;
        var j=0;
        for ( var i = 0; i < btbedit.length; i++) {
            if (btbedit.item(i).checked) {
                j=j+1;
                debugger;
                var tr = btbedit.item(i).parentNode.parentNode;
                trId = $(tr).attr("rel");
                var strStatu = btbedit.item(i).parentNode.parentNode.cells[19].textContent;

                //计划申报数量
                var bdApplyNumber = btbedit.item(i).parentNode.parentNode.cells[13].children[0].value;
                if (!bdApplyNumber){
                    top.layer.msg("请先保存计划申报数量",{icon:2});
                    return false;
                }
                //建议单价
                var bdPlanPrice = btbedit.item(i).parentNode.parentNode.cells[14].children[0].value;
                if (!bdPlanPrice){
                    top.layer.msg("请先保存建议单价",{icon:2});
                    return false;
                }
            }
        }
        var updateStrStatu = "S";
        //alert(updateStrStatu);
        if (trId == "" || trId == undefined) {
            Dialog.warn("未选中一条以上数据");
            return;
        }
        $.ajax({
            type:"post",
            url:"${ctx}/mdDemandD/updateMdDemandDStatue?id="+trId+"&flg="+strStatu+"&updateStrStatu="+updateStrStatu,
            dataType:"json",
            success:function (data) {
                debugger;
                if(data.statusCode == 200){
                    Dialog.success(data.message);
                    $("#mdDemandDId").load("${ctx}/mdDemandM/demandDetail?strApplyNo="+strApplyNo+"&strOrderNo="+"",{},function(){});
                }else {
                    // Dialog.error(data.message);
                }
            },
        });
    }
    /*取消生效*/
    function updateMdDemandDStatueToN(){
        debugger;
        var flg = "R";
        var strOrderNo = $("#strOrderNo005").val();
        var strApplyNo = $("#strApplyNo").val();
        var btbedit = document.getElementsByName("check_HW02");
        var trId;
        var j = 0;
        for (var i = 0;i<btbedit.length;i++){
            if (btbedit.item(i).checked) {
                j = j + 1;
                debugger;
                var tr = btbedit.item(i).parentNode.parentNode;
                trId = $(tr).attr("rel");
                var strStatu = btbedit.item(i).parentNode.parentNode.cells[19].textContent;
            }
        }
        if (trId == "" || trId == undefined) {
            Dialog.warn("未选中一条以上数据");
            return;
        }
        var updateStrStatu = "N";
        $.ajax({
            type:"post",
            url:"${ctx}/mdDemandD/updateMdDemandDStatue?id="+trId+"&flg="+strStatu+"&updateStrStatu="+updateStrStatu,
            dataType:"json",
            success:function (data) {
                debugger;
                if(data.statusCode == 200){
                    Dialog.success(data.message);
                    $("#mdDemandDId").load("${ctx}/mdDemandM/demandDetail?strApplyNo="+strApplyNo+"&strOrderNo="+"",{},function(){});
                }else {
                    Dialog.error(data.message);
                }
            }
        });
    }

    function updateMdDemandDStatueToS03(){
        debugger;
        var flg = "R";
        var strOrderNo = $("#strOrderNo005").val();
        var strApplyNo = $("#strApplyNo").val();
        var btbedit = document.getElementsByName("check_HW02");
        var trId;
        var j=0;
        for ( var i = 0; i < btbedit.length; i++) {
            if (btbedit.item(i).checked) {
                j=j+1;
                debugger;
                var tr = btbedit.item(i).parentNode.parentNode;
                trId = $(tr).attr("rel");
                var strStatu = btbedit.item(i).parentNode.parentNode.cells[15].textContent;
            }
        }
        var updateStrStatu = "S";
        //alert(updateStrStatu);
        if (trId == "" || trId == undefined) {
            Dialog.warn("未选中一条以上数据");
            return;
        }
        $.ajax({
            type:"post",
            url:"${ctx}/mdDemandD/updateMdDemandDStatue?id="+trId+"&flg="+strStatu+"&updateStrStatu="+updateStrStatu,
            dataType:"json",
            success:function (data) {
                debugger;
                if(data.statusCode == 200){
                    Dialog.success(data.message);
                    $("#mdDemandDId").load("${ctx}/mdDemandM/demandDetail?strApplyNo="+strApplyNo+"&strOrderNo="+"",{},function(){});
                }else {
                    // Dialog.error(data.message);
                }
            },
        });
    }
    /*取消生效*/
    function updateMdDemandDStatueToN03(){
        debugger;
        var flg = "R";
        var strOrderNo = $("#strOrderNo005").val();
        var strApplyNo = $("#strApplyNo").val();
        var btbedit = document.getElementsByName("check_HW02");
        var trId;
        var j = 0;
        for (var i = 0;i<btbedit.length;i++){
            if (btbedit.item(i).checked) {
                j = j + 1;
                debugger;
                var tr = btbedit.item(i).parentNode.parentNode;
                trId = $(tr).attr("rel");
                var strStatu = btbedit.item(i).parentNode.parentNode.cells[15].textContent;
            }
        }
        if (trId == "" || trId == undefined) {
            Dialog.warn("未选中一条以上数据");
            return;
        }
        var updateStrStatu = "N";
        $.ajax({
            type:"post",
            url:"${ctx}/mdDemandD/updateMdDemandDStatue?id="+trId+"&flg="+strStatu+"&updateStrStatu="+updateStrStatu,
            dataType:"json",
            success:function (data) {
                debugger;
                if(data.statusCode == 200){
                    Dialog.success(data.message);
                    $("#mdDemandDId").load("${ctx}/mdDemandM/demandDetail?strApplyNo="+strApplyNo+"&strOrderNo="+"",{},function(){});
                }else {
                    Dialog.error(data.message);
                }
            }
        });
    }

   /* 弹出挑选框*/
    function selectDemandDetail() {
        debugger;
        var strOrderNo = $("#strOrderNo005").val();
        var strApplyNo = $("#strApplyNo").val();
        var strApplyItem = $("#strApplyItem").val();
        $.post("${ctx}/mdDemandM/selectDetail?strOrderNo="+strOrderNo+"&strApplyNo="+strApplyNo+"&strApplyItem="+strApplyItem,"",function(content){
            top.layer.open({
                id: 'mdDemandDetail',
                type : 1,
                area : [ "80%", "80%" ],
                title : "挑选",
                shadeClose : true,
                offset : "48px",
                maxmin : true,
                anim : 5,
                content : content
            });
        });
    }

    /*批量删除*/
    function deleteDemandDetail() {
        debugger;
        var ids = "";
        var trId;
        var btbedit = document.getElementsByName("check_HW02");
        var j=0;
        for ( var i = 0; i < btbedit.length; i++) {
            if (btbedit.item(i).checked) {
                j=j+1;
                debugger;
                var tr = btbedit.item(i).parentNode.parentNode;
                trId = $(tr).attr("rel");
                if (ids == "") {
                    ids = trId;
                } else {
                    ids += "," + trId;
                }
            }
        }
        var strApplyNo = $("#strApplyNo").val();
        var strOrderNo = $('#strOrderNo005').val();
        if (trId == "") {
            Dialog.warn("未选中一条以上的数据");
            return;
        }
        layer.confirm("确定删除吗?", {
            btn: ['确定','取消'] //按钮
        }, function()
        {
            $.post("${ctx}/mdDemandD/delete", {ids: ids},
                function(msg) {
                    try {
                        debugger;
                        var result = JSON.parse(msg);
                        Ajax.ajaxDone(result);
                        if (result.statusCode == 200) {
                            debugger;
                            $("#mdDemandDId").load("${ctx}/mdDemandM/demandDetail?strApplyNo="+strApplyNo+"&strOrderNo="+strOrderNo,{},function(){});
                        }
                    } catch (e) {
                        console.log(msg);
                        Dialog.error(e.message);
                    }
                });
        }, function()
        {
            layer.close();
        })
    }
    /*保存明细*/
    function saveDemandDetail(){
        debugger;
        var ids = '';
        var btbedit = document.getElementsByName("check_HW02");
        var j=0;
        for ( var i = 0; i < btbedit.length; i++) {
            if (btbedit.item(i).checked) {
                j=j+1;
                debugger;
                var tr = btbedit.item(i).parentNode.parentNode;
                var trId = $(tr).attr("rel");
                //计划申报数量
                var bdApplyNumber = btbedit.item(i).parentNode.parentNode.cells[13].children[0].value;
                if (!bdApplyNumber){
                    top.layer.msg("计划申报数量不能为空",{icon:2});
                    return false;
                }
                //建议单价
                var bdPlanPrice = btbedit.item(i).parentNode.parentNode.cells[14].children[0].value;
                if (!bdPlanPrice){
                    top.layer.msg("建议单价不能为空",{icon:2});
                    return false;
                }
                //备注
                var strRemark = btbedit.item(i).parentNode.parentNode.cells[15].children[0].value;
                if (trId == "" || trId == undefined){
                    Dialog.warn("未选中一条数据");
                    return;
                }
                $.ajax({
                    type:"post",
                    url:"${ctx}/mdDemandD/updateSelectDetail?id="+trId+"&bdApplyNumber="+bdApplyNumber+"&bdPlanPrice="+bdPlanPrice+"&strRemark="+strRemark,
                    data:$('#msOrderD_1').serialize(),
                    datatype:"json",
                    success:function(rst){
                        var data = JSON.parse(rst);
                        if(data.statusCode == 200) {
                            Dialog.success(data.message);
                        }else{
                            Dialog.error(data.message);
                        }
                    },
                    error:function(msg){
                        Dialog.warn(msg.message);
                    }
                });
            }
        }
    }
    /*批量选择*/
    form.on('checkbox(checkAllDemandDetail)', function(data) {
        if ($(data.elem).hasClass("checkAllDemandDetail")) {
            if (data.elem.checked) {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
            } else {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
            }
            form.render('checkbox');
        }
    });
    form.render();
</script>