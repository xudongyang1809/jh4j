<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>

<input type="hidden" name="pageNum" value="${page.pageNum}" />
<input type="hidden" name="numPerPage" value="${page.numPerPage}" />
<input type="hidden" name="orderField" value="${page.orderField}" />
<input type="hidden" id="ihId"  value="${ihId}" />
<div class="tab-header">
    <div class="layui-form-item" style="padding-left: 0px">
        <label class="layui-form-label">企业编码:</label>
        <label class="layui-form-label">${mEntityById.strVendorNo}</label>
    </div>
    <div class="layui-form-item" style="padding-left: 0px">
        <label class="layui-form-label">企业简称:</label>
        <label class="layui-form-label">${mEntityById.strAbbrevName}</label>
    </div>
</div>
<div class="tab-bars">
    <a class="add" title="新增证书" target="dialog" width="800" height="500" dialogId="mcCertCreate" href="${ctx}/mcInfomationM/preCertCreate?ihId=${mEntityById.id}"><span>添加</span></a>
    <a class="edit" title="修改" target="dialog" dialogId="mcUpdateCert" width="800" height="500"  href="${ctx}/mcInfomationM/preCertUpdate?id={slt_uid}&ihId=${mEntityById.id}"><span>编辑</span></a>
  <%--  <a class="delete" target="ajaxTodo" title="确定要删除吗?" onclick="deletesure()">删除</a>--%>
</div>
<div class="tab-content">

    <table class="frog-table layui-table layui-table-cell" lay-size="sm">
        <thead>
        <tr>
            <th>序号</th><!-- 1 -->
            <th>证书编号</th><!-- 2 -->
            <th>证书名称</th><!-- 3 -->
            <th>发证单位</th><!-- 4 -->
            <th>证书内容</th><!-- 5 -->
            <th>发证日期</th><!-- 6 -->
            <th>有效日期</th><!-- 7 -->
            <th>备注</th><!-- 8 -->
            <th>证书资料</th><!-- 9 -->
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${certByihIdList}" var="mcCertInfo" varStatus="status">
            <tr target="slt_uid" rel="${mcCertInfo.id}" id="${mcCertInfo.id}">
                <td>${page.pageBeginCount+status.index+1}</td><!-- 1 -->
                <td>${mcCertInfo.strCertNo}</td><!--2  -->
                <td>${mcCertInfo.strCertificateName}</td><!--3  -->
                <td>${mcCertInfo.strIssueUnit}</td><!-- 4 -->
                <td>${mcCertInfo.strCertificateContent}</td><!-- 5 -->
                <td>${mcCertInfo.strIssueDate}</td><!-- 6 -->
                <td>${mcCertInfo.strIssueEndDate}</td><!--  7-->
                <td>${mcCertInfo.strRemarkCert}</td><!-- 8 -->
                <td><!-- 9 -->
                    <a class="add" title="更新证书" target="dialog" width="700" height="400" dialogId="mcCertCreate" href="${ctx}/mcInfomationM/certFile?ihId=${mcCertInfo.id}"><span>查看</span></a>
                    <a class="delete" onclick="deletethis(this)"><span>删除</span></a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- 分页 -->
<%@ include file="/WEB-INF/views/aaSystem/pager/layuiPagerBar.jsp" %>

<script>

    function deletethis(obj) {
        var id = obj.parentNode.parentNode.id;
        var ihId=$("#ihId").val();
             $.ajax({
                 type: "post",
                 url: "${ctx}/mcInfomationM/certDelete/"+id,
                 datatype: "json",
                 success: function (rst) {
                     var data = JSON.parse(rst);
                     var rel = data.rel;
                     if (data.statusCode == 200) {
                         $('#editMcInformation').load("${ctx}/mcInfomationM/preUpdateCertInfo/"+ihId , function () {
                         });
                         Dialog.success(data.message);
                     } else {
                         Dialog.error(data.message);
                     }
                 },
                 error: function (msg) {
                     Dialog.warn(msg.message);
                 }
             });
      }

</script>