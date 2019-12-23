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

 
</script>
<style type="text/css">
 .cmMatrinfotd{
  height: 40px;
 }
</style>
</head>
<form  method="post" action="${ctx}/cmMatrinfoDetail/list?flg=dialog" onsubmit="return divSearch(this, 'Matrinfolis1')">
	<input type="hidden" name="parentId" value="${parentId}"   style="width: px;" />
	<input type="hidden" name="cmMatrinfocontrol" value="${cmMatrinfocontrol}"   style="width: px;" />
	<div  layoutH="35" >
		<table>
				<tr class="cmMatrinfotd">
					<td style="padding-left: 20px">存货编码区间：</td>
					<td  >
							<input type="text" name="strSnfro"    style="width: px;" />
					 <span>~</span>
							<input type="text" name="strSnto"   style="width: px;" />
					</td>
				</tr>
				<tr class="cmMatrinfotd">
					<td style="padding-left: 20px">存货名称：</td>
					<td>
							<input type="text" name="strName" style="width: px;" />
					</td>
				</tr>
				<tr>
					<td style="padding-left: 20px">型号：</td>
					<td>
							<input type="text" name="strSpec"  style="width: px;" />
					</td>
				</tr>
				<tr class="cmMatrinfotd">
					<td style="padding-left: 20px">品牌：</td>
					<td>
							<input type="text" name="strBrand"     style="width: px;" />
					</td>
				</tr>
				<tr class="cmMatrinfotd">
					<td style="padding-left: 20px">计量单位：</td>
					<td>	 
						<select name="strPrickle" style="width: 140px;" id="strPrickle">
							<option value=''>---请选择---</option>
							<c:forEach items="${dcMetrologylis}" var="dcMetrology" >
								<option value='${dcMetrology.id}'>${dcMetrology.strName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
		</table>
	</div>
	<div class="formBar">
			<ul>
				<li><div class="buttonActive">
						<div class="buttonContent">
							<button type="submit" >搜索</button>
						</div>
					</div></li>

				<li><div class="button">
						<div class="buttonContent">
							<button type="button" class="close">关闭</button>
						</div>
					</div></li>
			</ul>
		</div>
</form>

</html>

