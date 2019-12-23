<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<meta name="decorator" content="default"/>
<script type="text/javascript">

	function beforeSubmit()
	{
		var form=$("#formExcelImport");
		var v=form.find("input[type='file']").val();
		var lindex=v.lastIndexOf(".");
		var suffix=v.substring(lindex+1);
		if(suffix.search("xls")==-1)
			top.layer.msg("请选择Excel文件【扩展名为:xls、xlsx】", {icon: 2});
		else
		{
			form.submit();
		}
	}
	
	function successCallback(msg)
	{
		if(msg.statusCode==200)
		{
			var filepath=msg.message;
			var dataHandler="${param.dataHandler}";
			if(dataHandler.indexOf("?")>0&&"${param.refreshType}"!='dialog')
			{
			  ajaxTodo("${ctx}${param.dataHandler}&filepath="+filepath);
			}else{
				var url="${ctx}${param.dataHandler}?filepath="+filepath;
				if(dataHandler.indexOf("?")>0)
					url="${ctx}${param.dataHandler}&filepath="+filepath;
				alert("${param.refreshType}");
				customAjaxTodo(url,function(msg)
					  {
							msg = JSON.parse(msg);
				  			if("${param.refreshType}"=='dialog'&&msg.statusCode=='200')
				  			{
				  				var dialogId=msg.rel;
				  				$.pdialog.closeCurrent();
					  			var op={dialogId:""+dialogId+""};
					  			$.pdialog.reload("${param.refreshURL}",op);
					  			top.layer.msg(msg.message, {icon: 1});
				  			}else{
				  				top.layer.msg(msg.message, {icon: 2});
				  			}
					  });
				}
			 //ajaxTodo("${ctx}${param.dataHandler}?filepath="+filepath);
		}else{
			top.layer.msg(msg.message, {icon: 2});
		}
	}
	function iframeCallback(form,callback){
		var $form=$(form);
		var $iframe=$("#callbackframe");
		if($iframe.length==0){
		$iframe=$("<iframe id='callbackframe' name='callbackframe' src='about:blank' style='display:none'></iframe>").appendTo("body");}
		if(!form.ajax){
		$form.append('<input type="hidden" name="ajax" value="1" />');}
		form.target="callbackframe";
		_iframeResponse($iframe[0],callback||DWZ.ajaxDone);}
		function _iframeResponse(iframe,callback){
		var $iframe=$(iframe),$document=$(document);
		$document.trigger("ajaxStart");
		$iframe.bind("load",function(event){
		$iframe.unbind("load");
		$document.trigger("ajaxStop");
		if(iframe.src=="javascript:'%3Chtml%3E%3C/html%3E';"||
		iframe.src=="javascript:'<html></html>';"){
		return;}
		var doc=iframe.contentDocument||iframe.document;
		if(doc.readyState&&doc.readyState!='complete')return;
		if(doc.body&&doc.body.innerHTML=="false")return;
		var response;
		if(doc.XMLDocument){
			response=doc.XMLDocument;
		}
		else if(doc.body){
		try{
			var response = $iframe.contents().find("pre").html();
			if(response==null||response=="")
			{
				response=$iframe.contents().find("body").html();
			}
			response=JSON.parse(response);
			}catch(e){
				alert(error);
				response=doc.body.innerHTML;
			}
		}
		else{response=doc;}
		callback(response);});}
</script>
<form id="formExcelImport" method="post" action="${ctx}/common/importExcel"  class="form-horizontal" enctype="multipart/form-data"  onsubmit="return iframeCallback(this, successCallback);">
	  <div class="box-body">
		<div class="form-group">
			<label class="control-label col-xs-2">请选择文件:</label>
			<div class="col-xs-10">
				<input type="file" name="strFilePath" class=" "  />
			</div>
		</div>
		<div class="form-group ">
			<label class="control-label col-xs-2">是否显示导入结果:</label>
				<div class="col-xs-10">
				<input type="checkbox" name="isShowRslt"/>
			</div>
		</div>
		<div class="form-group ">
			<label class="control-label col-xs-2">是否覆盖导入结果:</label>
				<div class="col-xs-10">
				<input type="checkbox" name="isOverLapRslt"/>
			</div>
		</div>	
	</div>		
	<div class="row">
		<div class="col-xs-6">
					<button type="button" onclick="beforeSubmit()" class="btn btn-primary col-xs-6 col-xs-offset-4">确定</button>
		</div>
		<div class="col-xs-6">
			<button type="button" class="btn col-xs-6" onclick="parent.layer.closeAll();">关闭</button>
		</div>
		
	</div>
</form>
<script src="${ctx}/static/styles/AdminLTE-2.4.2/bower_components/jquery/dist/jquery.js"></script>
<%-- <form id="formExcelImport" method="post" action="${ctx}/common/importExcel"  class="required-validate pageForm" enctype="multipart/form-data"  onsubmit="return iframeCallback(this, successCallback);">
	<div class="pageFormContent" layoutH="50">
	<label>请选择文件：</label><input type="file" name="strFilePath" style="width: 400px;"/><input type="button" onclick="beforeSubmit()" value="导入数据" style="margin-left: 50px;"/>
	<!-- <div class="progressBar" id="progressBar11" style="display: none;">数据正在导入中...</div> -->
	</div>
	<div class="formBar">
		<ul>
				<!-- <li><div class="buttonActive"><div class="buttonContent"><button type="submit">确定</button></div></div></li> -->
			
			<li><div class="button"><div class="buttonContent"><button type="button" class="close">关闭</button></div></div></li>
		</ul>
	</div>
</form> --%>
