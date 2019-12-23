<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<div class="layui-tab">
    <ul class="layui-tab-title">
        <li class="layui-this" onclick="openTabPage(1)">基础资料</li>
        <li onclick="openTabPage(2)">合同明细</li>
    </ul>
    <div class="layui-tab-content">
        <div id="tabPage1" class="layui-tab-item layui-show"></div>
        <div id="tabPage2" class="layui-tab-item"></div>
    </div>
</div>
<script>
    var tabPageMap=[0,0,],
        pageCreateEle={
            proId: '${proId}'
        },
        tabUrlMap=['${ctx}/msOrderM/preCreate/${proId}',
            '${ctx}/msOrderD/preCreate/${proId}'];
    openTabPage(1);
    function openTabPage(index){
        if(tabPageMap[index-1]==0){
            tabPageMap[index-1]=1;
            loadTabPage(index);
        }else{
            if(index==2){
                eval("render"+index+"()");
            }
        }
    }
    function loadTabPage(index){
        $('#tabPage'+index).load(tabUrlMap[index-1],{},function(){
            if(index==2){
                eval("render"+index+"()");
            }
        });
    }
</script>