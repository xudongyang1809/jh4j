<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<html>
<!-- Hints:
     1. The code was automatic created;
     2. Any other questions can ask the software engineer for help.
	 @author sysadmin
	 @date 2014-03-24
 -->
<head>
<script type="text/javascript">
  function comformSelect(){
	  var lisMatr=new Array();
	  var j=0;
	  for(var i=0;i<$(".checkmatri").length;i++){
		  var cbx=$(".checkmatri")[i];
		  if(cbx.checked){
			  var tr = cbx.parentNode.parentNode.parentNode;
			  var strSn = $(tr.cells[2]).find("div").html();
			  var strName = $(tr.cells[3]).find("div").html();
			  var strSpec = $(tr.cells[5]).find("div").html();
			  var strPrickle = $(tr.cells[6]).find("div").html();
			  var strPrickleZH = $(tr.cells[7]).find("div").html();
			  var strBrand = $(tr.cells[8]).find("div").html();
			  var bdPlanPrice = $(tr.cells[9]).find("div").html();
			  var MatrinfoDetail={strSn:strSn, strName:strName, strSpec:strSpec,strPrickle:strPrickle,strPrickleZH:strPrickleZH,strBrand:strBrand,bdPlanPrice:bdPlanPrice};
			  lisMatr[j]=MatrinfoDetail;
			  j=j+1;
			}
	  }
	  var bringflg=$("#bringflg").val();
	  //eval("("+bringflg+")")(lisMatr);
	  if(bringflg =="matriBringback"){
		  matriBringback(lisMatr);
	  }
  }
</script>
</head>
<form id="pagerForm" method="post" action="${ctx}/cmMatrinfoDetail/list?flg=dialog" onsubmit="return divSearch(this, 'Matrinfolis1')">
	<input type="hidden" name="pageNum" value="${page.pageNum}" />
	<input type="hidden" name="numPerPage" value="${page.numPerPage}" /> 
	<input type="hidden" name="orderField" value="${page.orderField}" />
	<input type="hidden" name="orderDirection" value="${page.orderDirection}" />
	<input type="hidden" name="keywords" value="${keywords}"/> 
	<input type="hidden" name="parentId" value="${cmMatrinfoDetail.parentId}" />
	<input type="hidden" name="cmMatrinfocontrol" value="${cmMatrinfocontrol}"   style="width: px;" />
	<input type="hidden" name="strSn" value="${cmMatrinfoDetail.strSn}"   style="width: px;" />
	<input type="hidden" name="strName" value="${cmMatrinfoDetail.strName}"   style="width: px;" />
	<input type="hidden" name="strEnName" value="${cmMatrinfoDetail.strEnName}"   style="width: px;" />
	<input type="hidden" name="strSpec" value="${cmMatrinfoDetail.strSpec}"   style="width: px;" />
	<input type="hidden" name="strBrand" value="${cmMatrinfoDetail.strBrand}"   style="width: px;" />
	<input type="hidden" name="strPrickle" value="${cmMatrinfoDetail.strPrickle}"   style="width: px;" />
	<input type="hidden" name="strSnfro" value="${strSnfro}"   style="width: px;" />
	<input type="hidden" name="strSnto" value="${strSnto}"   style="width: px;" />
</form> 

<form  method="post" action="${ctx}/cmMatrinfoDetail/list?flg=dialog" onsubmit="return divSearch(this, 'Matrinfolis1')">
	
	<div class="pageHeader">
		<div class="searchBar">
		<input type="hidden" name="parentId" value="${cmMatrinfoDetail.parentId}"   style="width: px;" />
		<input type="hidden" name="cmMatrinfocontrol" value="${cmMatrinfocontrol}"   style="width: px;" />
		 
		<table>
				<tr>
					<td>存货编码：</td>
					<td>
							<input type="text" name="strSn" value="${cmMatrinfoDetail.strSn}"   style="width: 80px;" />
					</td>
					<td style="padding-left: 20px">存货名称：</td>
					<td>
							<input type="text" name="strName" value="${cmMatrinfoDetail.strName}"   style="width: 80px;" />
					</td>
					
				<tr>
		</table>
			<div class="subBar">
				<ul>	
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit">搜索</button></div></div></li>
				</ul>
				<ul>	
					<li><div class="buttonActive"><div class="buttonContent"><a href="${ctx}/cmMatrinfoDetail/highSearch?parentId=${cmMatrinfoDetail.parentId}&cmMatrinfocontrol=${cmMatrinfocontrol}&flg=dialog" target="dialog" width="450" height="300" mask=true title="进阶查询">进阶查询</a></div></div></li>
				</ul>
				<ul>	
					<li><div class="buttonActive"><div class="buttonContent"><button type="button" onclick="comformSelect()">确认</button></div></div></li>
				</ul>
				
			</div>
		</div>
	</div>
</form>
<div class="pageContent" >
		<table class="table" layoutH="110" width="100%" id="Matrinfolisdia" name="Matrinfolisdia">
		<thead>
			<tr>
			    <th><input type="checkbox" class="checkboxCtrl" group="group1" />全选</th>
				<th>序号</th>
				<th>存货编码</th>
				<th>存货名称</th>
				<!-- <th>英文名称</th> -->
				<th>存货分类</th>
				<!-- <th>助记码</th> -->
				<th>型号</th>
				<th style="display:none">计量单位隐藏</th>
				<th>计量单位</th>
				<!-- <th>最高库存</th>
				<th>最低库存</th>
				<th>安全库存</th> -->
				<th>品牌</th>
				<th>预计含税单价</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="cmMatrinfoDetail" varStatus="status">
				<tr target="slt_uid" rel="${cmMatrinfoDetail.id}" id="${cmMatrinfoDetail.id}">
				    <td><input type="checkbox"  class="checkmatri" value="${cmMatrinfoDetail.id}" name="group1"/></td>
				    <td>${page.pageBeginCount+status.index+1}</td>
							<td>${cmMatrinfoDetail.strSn}</td>
							<td>${cmMatrinfoDetail.strName}</td>
							<%-- <td>${cmMatrinfoDetail.strEnName}</td> --%>
							<td>${cmMatrinfoDetail.strClass}</td>
							<%-- <td>${cmMatrinfoDetail.strEasyCode}</td> --%>
							<td>${cmMatrinfoDetail.strSpec}</td>
							<td style="display:none">${cmMatrinfoDetail.strPrickle}</td>
							<td>${cmMatrinfoDetail.strPrickleZH}</td>
						<%-- 	<td>${cmMatrinfoDetail.intMaxStorage}</td>
							<td>${cmMatrinfoDetail.intMinStorage}</td>
							<td>${cmMatrinfoDetail.intSafeStorage}</td> --%>
							<td>${cmMatrinfoDetail.strBrand}</td>
							<td>${cmMatrinfoDetail.bdPlanPrice}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="panelBar">
		<div class="pages">
			<span>每页显示</span>
			<select name="numPerPage" onchange="dialogPageBreak({numPerPage:this.value},'Matrinfolis1')">
				<c:forEach begin="15" end="100" step="10" varStatus="s">
					<option value="${s.index}" ${page.numPerPage eq s.index ? 'selected="selected"' : ''}>${s.index}</option>
				</c:forEach>
			</select>
			<span>总条数: ${page.totalCount}</span>
		</div>
	
		<div class="pagination" targetType="dialog" rel="Matrinfolis1" totalCount="${page.totalCount}" numPerPage="${page.numPerPage}" pageNumShown="10" currentPage="${page.pageNum}"></div>
	</div>
	<!-- 分页 -->
</div>
</html>

