<%--
  Created by IntelliJ IDEA.
  User: maomin
  Date: 2019/5/13
  Time: 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<script type="text/javascript">
    /*批量选择*/
    form.on('checkbox(checkAllSelectDemandDetail)', function(data) {
        if ($(data.elem).hasClass("checkAllSelectDemandDetail")) {
            if (data.elem.checked) {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", true);
            } else {
                $(data.elem).parents('table:first').find('tbody').find('input[type="checkbox"]').prop("checked", false);
            }
            form.render('checkbox');
        }
    });
    var checkit = true;
    function selectall(objname) {
        aa = document.getElementsByName(objname);
        if (checkit) {
            for ( var i = 0; i < aa.length; i++)
                aa.item(i).checked = true;
            checkit = false;
        } else {
            for (i = 0; i < aa.length; i++)
                aa.item(i).checked = false;
            checkit = true;
        }
    };
    function saveselect_HD(){
        debugger;
        var btbedit = document.getElementsByName("check_HW");
        var strApplyNo  = $("#strApplyNo").val();
        //alert(strApplyNo);
        //var strOrderNo = $("#strOrdNo202").val();
        //alert(strOrderNo);
        layer.confirm("确认挑选?！", {
            btn: ['确定', '取消']
        }, function(index) {
            layer.close(index);
            var j=0;
            for ( var i = 0; i < btbedit.length; i++) {
                if (btbedit.item(i).checked) {
                    j=j+1;
                    debugger;
                    var tr = btbedit.item(i).parentNode.parentNode;
                    var strOrderNo = $(tr.cells[2]).text();//销售订单编号
                    var strOrderItem =$(tr.cells[3]).text();//销售订单项次
                    console.log(strOrderItem);
                    var strMatrlNo =$((tr.cells[5])).text();//销售存货编号
                    console.log(strMatrlNo);
                    var strMatrlName = $((tr.cells[6])).text();//品名
                    console.log(strMatrlName);
                    var strBrand = $((tr.cells[7])).text();//品牌
                    console.log(strBrand);
                    var strUnit = $((tr.cells[8])).text();//库存单位
                    console.log(strUnit);
                    var strSpec = $((tr.cells[9])).text();//型号规格
                    console.log(strSpec);
                    var bdSalePrice = $((tr.cells[10])).text();//销售单价
                    console.log(bdSalePrice);
                    var bdSaleQty = $((tr.cells[11])).text();//销售数量
                    console.log(bdSaleQty);
                    var trId = $(tr).attr("rel");
                    var bdAmount=$("#ab_"+trId).val();
                    var bdUMoney=$("#ac_"+trId).val();
                    $.post("${ctx}/mdDemandD/createSelectDetail?strApplyNo="+strApplyNo+"&strOrderNo="+strOrderNo+"&strOrderItem="+strOrderItem+"&strMatrlNo="+strMatrlNo+"&strMatrlName="+strMatrlName
                        +"&strBrand="+strBrand+"&strUnit="+strUnit+"&strSpec="+strSpec+"&bdSalePrice="+bdSalePrice+"&bdSaleQty="+bdSaleQty
                        , function(rst){
                            try{
                                var result = JSON.parse(rst);
                                Ajax.ajaxDone(result);
                                if (result.statusCode == 200) {
                                    Dialog.success("挑选成功");
                                    var dialogIndex = Dialog.getCurrentDialog().attr("times");
                                    if (dialogIndex) {
                                        layer.close(dialogIndex);
                                    }
                                    <%--$("#mdDemandId1").load("${ctx}/mdDemandM/preCreate",{},function () {});--%>
                                    $("#mdDemandDId").load("${ctx}/mdDemandM/demandDetail?strApplyNo="+strApplyNo+"&strOrderNo="+strOrderNo,{},function(){});
                                    Dialog.success(result.message);
                                }else{
                                    Dialog.error(result.message);
                                }
                            }catch(e){
                                console.log(msg);
                                Dialog.error(e.message);
                            }
                        });
                }//if
            }//for
        });
    }
    form.render();
</script>
<form action="" onsubmit="return dialogAjaxDone(this, 'create', '#createPmOrderDialog')">
    <input type="hidden" id="strApplyNo" value="${strApplyNo}">
    <input type="hidden" id="strOrdNo202" value="${strOrderNo}">
</form>
<div class="tab-bars ">
    <shiro:hasPermission name="MdDemandM:edit">
        <a class="add" onclick="saveselect_HD()">确定</a>
    </shiro:hasPermission>
</div>
<table class="frog-table layui-form">
    <thead>
    <tr>
        <td style="width: 20px;"><input type="checkbox" lay-skin="primary" class="checkAllSelectDemandDetail" lay-filter="checkAllSelectDemandDetail" onclick="selectall('check_HW')"/></td>
        <th>序号</th>
        <th>销售订单编号 </th>
        <th>销售订单项次</th>
        <th>销售订单类型</th>
        <th>销售存货编号</th>
        <th>品名</th>
        <th>品牌</th>
        <th>库存单位</th>
        <th>型号规格</th>
        <th>销售单价</th>
        <th>销售数量</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${list}" var="item" varStatus="status">
        <tr target="slt_uid" rel="${item.id}" id="${item.id}">
            <td><input type="checkbox" name="check_HW" lay-skin="primary" lay-filter="checkAllSelectDemandDetail" /></td>
            <td>${page.pageBeginCount+status.index+1}</td>
            <td>${item.strOrderNo}</td>
            <td>${item.strOrderItem}</td>
            <td>${item.strOrderStyle1}</td>
            <td>${item.strMatrlNo}</td>
            <td>${item.strMatrlName}</td>
            <td>${item.strBrand}</td>
            <td>${item.strUnit}</td>
            <td>${item.strSpec}</td>
            <td>${item.bdSalePrice}</td>
            <td>${item.bdSaleQty}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>