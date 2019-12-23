<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include.inc.jsp"%>
<html>
<head>
<style type="text/css">
#web-uploader .queueList {
    /* margin: 20px; */
    border: 3px dashed #e6e6e6;
}

#web-uploader .queueList.filled {
    /* padding: 10px; */
    margin: 0;
    border: 3px dashed transparent;
}

#web-uploader .queueList.warn {
    margin: 0;
    border: 3px dashed #FF5722;
}

#web-uploader .queueList.webuploader-dnd-over {
    border: 3px dashed #999999;
}

#web-uploader p {
	margin: 0;
}

.element-invisible {
    position: absolute !important;
    clip: rect(1px 1px 1px 1px); /* IE6, IE7 */
    clip: rect(1px,1px,1px,1px);
}

#web-uploader .placeholder {
    min-height: 100px;
    padding-top: 100px;
    text-align: center;
    background: url(${ctx}/static/image/webuploader-image.png) center 15px no-repeat;
    color: #cccccc;
    font-size: 18px;
    position: relative;
}

#web-uploader .placeholder .webuploader-pick {
    font-size: 18px;
    background: #00b7ee;
    border-radius: 3px;
    line-height: 44px;
    padding: 0 30px;
    *width: 120px;
    color: #fff;
    display: inline-block;
    margin: 0 auto 0px auto;
    cursor: pointer;
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
}

#web-uploader .placeholder .webuploader-pick-hover {
    background: #00a2d4;
}

#web-uploader .placeholder .flashTip {
    color: #666666;
    font-size: 12px;
    position: absolute;
    width: 100%;
    text-align: center;
    bottom: 20px;
}

#web-uploader .placeholder .flashTip a {
    color: #0785d1;
    text-decoration: none;
}

#web-uploader .placeholder .flashTip a:hover {
    text-decoration: underline;
}

#web-uploader .filelist {
    list-style: none;
    margin: 0;
    padding: 0;
}

#web-uploader .filelist:after {
    content: '';
    display: block;
    width: 0;
    height: 0;
    overflow: hidden;
    clear: both;
}

#web-uploader .filelist li {
    width: 110px;
    height: 110px;
    background: url(${ctx}/static/image/webuploader-bg.png) no-repeat;
    text-align: center;
    margin: 0 8px 8px 0;
    position: relative;
    display: inline;
    float: left;
    overflow: hidden;
    font-size: 12px;
}

#web-uploader .filelist li p.log {
    position: relative;
    top: -45px;
}

#web-uploader .filelist li p.title {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    overflow: hidden;
    /* white-space: nowrap; */
    text-overflow : ellipsis;
    top: 5px;
    text-indent: 5px;
    text-align: left;
    z-index: 5;
}

#web-uploader .filelist li p.progress {
    position: absolute;
    width: 100%;
    bottom: 0;
    left: 0;
    height: 8px;
    overflow: hidden;
    z-index: 50;
    margin: 0;
    border-radius: 0;
    background: none;
    -webkit-box-shadow: 0 0 0;
}

#web-uploader .filelist li p.progress span {
    display: none;
    overflow: hidden;
    width: 0;
    height: 100%;
    background: #1483d8 url(${ctx}/static/image/webuploader-progress.png) repeat-x;

    -webit-transition: width 200ms linear;
    -moz-transition: width 200ms linear;
    -o-transition: width 200ms linear;
    -ms-transition: width 200ms linear;
    transition: width 200ms linear;

    -webkit-animation: progressmove 2s linear infinite;
    -moz-animation: progressmove 2s linear infinite;
    -o-animation: progressmove 2s linear infinite;
    -ms-animation: progressmove 2s linear infinite;
    animation: progressmove 2s linear infinite;

    -webkit-transform: translateZ(0);
}

@-webkit-keyframes progressmove {
    0% {
       background-position: 0 0;
    }
    100% {
       background-position: 17px 0;
    }
}

@-moz-keyframes progressmove {
    0% {
       background-position: 0 0;
    }
    100% {
       background-position: 17px 0;
    }
}

@keyframes progressmove {
    0% {
       background-position: 0 0;
    }
    100% {
       background-position: 17px 0;
    }
}

#web-uploader .filelist li p.imgWrap {
    position: relative;
    z-index: 2;
    line-height: 110px;
    vertical-align: middle;
    overflow: hidden;
    width: 110px;
    height: 110px;

    -webkit-transform-origin: 50% 50%;
    -moz-transform-origin: 50% 50%;
    -o-transform-origin: 50% 50%;
    -ms-transform-origin: 50% 50%;
    transform-origin: 50% 50%;

    -webit-transition: 200ms ease-out;
    -moz-transition: 200ms ease-out;
    -o-transition: 200ms ease-out;
    -ms-transition: 200ms ease-out;
    transition: 200ms ease-out;
}

#web-uploader .filelist li img {
    width: 100%;
    margin-top: -2px;
}

#web-uploader .filelist li p.error {
    background: #f43838;
    color: #fff;
    position: absolute;
    bottom: 0;
    left: 0;
    height: 28px;
    line-height: 28px;
    width: 100%;
    z-index: 100;
}

#web-uploader .filelist li .success {
    display: block;
    position: absolute;
    left: 0;
    bottom: 0;
    height: 40px;
    width: 100%;
    z-index: 200;
    background: url(${ctx}/static/image/webuploader-success.png) no-repeat right bottom;
}

#web-uploader .filelist div.file-panel {
    position: absolute;
    height: 0;
    filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr='#80000000', endColorstr='#80000000')\0;
    background: rgba(0, 0, 0, 0.5);
    width: 100%;
    top: 0;
    left: 0;
    overflow: hidden;
    z-index: 300;
}

#web-uploader .filelist div.file-panel span,
#web-uploader .filelist div.file-panel a.icon-download {
    width: 24px;
    height: 24px;
    display: inline;
    float: right;
    text-indent: -9999px;
    overflow: hidden;
    background: url(${ctx}/static/image/webuploader-icons.png) no-repeat;
    margin: 5px 1px 1px;
    cursor: pointer;
}

#web-uploader .filelist div.file-panel span.rotateLeft {
    background-position: 0 -24px;
}
#web-uploader .filelist div.file-panel span.rotateLeft:hover {
    background-position: 0 0;
}

#web-uploader .filelist div.file-panel span.rotateRight {
    background-position: -24px -24px;
}
#web-uploader .filelist div.file-panel span.rotateRight:hover {
    background-position: -24px 0;
}

#web-uploader .filelist div.file-panel span.cancel {
    background-position: -48px -24px;
}
#web-uploader .filelist div.file-panel span.cancel:hover {
    background-position: -48px 0;
}

#web-uploader .filelist div.file-panel a.icon-download {
    background-position: -72px -24px;
}
#web-uploader .filelist div.file-panel a.icon-download:hover {
    background-position: -72px 0;
}

#web-uploader .webuploader-pick+div {
	width: 100%!important;
	height: 100%!important;
	right: 0;
	bottom: 0;
}

#web-uploader .statusBar {
    height: 63px;
    border-top: 1px solid #dadada;
    padding: 0;
    line-height: 63px;
    vertical-align: middle;
    position: relative;
}

#web-uploader .statusBar .progress {
    border: 1px solid #1483d8;
    width: 198px;
    background: #fff;
    height: 18px;
    position: relative;
    display: inline-block;
    text-align: center;
    line-height: 20px;
    color: #6dbfff;
    position: relative;
    margin: 0 10px 0 0;
}
#web-uploader .statusBar .progress span.percentage {
    width: 0;
    height: 100%;
    left: 0;
    top: 0;
    background: #1483d8;
    position: absolute;
}
#web-uploader .statusBar .progress span.text {
    position: relative;
    z-index: 10;
}

#web-uploader .statusBar .info {
    display: inline-block;
    font-size: 14px;
    color: #666666;
}

#web-uploader .statusBar .btns {
    position: absolute;
    top: 10px;
    right: 0px;
    line-height: 40px;
}

#filePicker2 {
    display: inline-block;
    float: left;
}

#web-uploader .statusBar .btns .webuploader-pick,
#web-uploader .statusBar .btns .uploadBtn,
#web-uploader .statusBar .btns .uploadBtn.state-uploading,
#web-uploader .statusBar .btns .uploadBtn.state-paused {
    background: #ffffff;
    border: 1px solid #cfcfcf;
    color: #565656;
    padding: 0 10px;
    display: inline-block;
    border-radius: 3px;
    margin-left: 10px;
    cursor: pointer;
    font-size: 14px;
    float: left;
}

#web-uploader .statusBar .btns .webuploader-pick-hover,
#web-uploader .statusBar .btns .uploadBtn:hover,
#web-uploader .statusBar .btns .uploadBtn.state-uploading:hover,
#web-uploader .statusBar .btns .uploadBtn.state-paused:hover {
    background: #f0f0f0;
}

#web-uploader .statusBar .btns .uploadBtn {
    background: #00b7ee;
    color: #fff;
    border-color: transparent;
}
#web-uploader .statusBar .btns .uploadBtn:hover {
    background: #00a2d4;
}

#web-uploader .statusBar .btns .uploadBtn.disabled {
    pointer-events: none;
    opacity: 0.6;
    background-color: grey;
}
</style>
</head>
<body>
	<input type="hidden" id="web-uploader-required-input" ${param.isRequired eq '1' ? 'lay-verify="file"' : ''} />
	<div id="web-uploader" class="wu-example">
	    <div class="queueList">
	        <div id="dndArea" class="placeholder">
	            <div id="filePicker" style="display: inline-block;"></div>
	            <p style="padding: 5px;">支持文件拖拽，屏幕截图粘贴，最多可上传${param.fileNum eq null ? 1 : param.fileNum}个文件</p>
	        </div>
	    </div>
	    <div class="statusBar" style="display:none;">
	        <div class="progress">
	            <span class="text">0%</span>
	            <span class="percentage"></span>
	        </div>
	        <div class="info"></div>
	        <div class="btns">
	        	<c:if test="${param.action eq null or param.action eq '' or param.action eq 'edit'}">
	        		<div id="filePicker2"></div>
	        	</c:if>
	            <!-- <div class="uploadBtn">开始上传</div> -->
	        </div>
	    </div>
	</div>
</body>
<script type="text/javascript">
jQuery(function() {
    var $ = jQuery,
        $wrap = $('#web-uploader'),
        // 图片容器
        $queue = $('<ul class="filelist"></ul>').appendTo($wrap.find('.queueList')),

        // 状态栏，包括进度和控制按钮
        $statusBar = $wrap.find('.statusBar'),

        // 文件总体选择信息。
        $info = $statusBar.find('.info'),

        // 上传按钮
        $upload = $wrap.find('.uploadBtn'),

        // 没选择文件之前的内容。
        $placeHolder = $wrap.find('.placeholder'),

        // 总体进度条
        $progress = $statusBar.find('.progress').hide(),

        // 添加的文件数量
        fileCount = 0,

        // 添加的文件总大小
        fileSize = 0,

        // 优化retina, 在retina下这个值是2
        ratio = window.devicePixelRatio || 1,

        // 缩略图大小
        thumbnailWidth = 110 * ratio,
        thumbnailHeight = 110 * ratio,

        // 可能有pedding, ready, uploading, confirm, done.
        state = 'pedding',

        // 所有文件的进度信息，key为file id
        percentages = {},

        supportTransition = (function(){
            var s = document.createElement('p').style,
                r = 'transition' in s ||
                      'WebkitTransition' in s ||
                      'MozTransition' in s ||
                      'msTransition' in s ||
                      'OTransition' in s;
            s = null;
            return r;
        })(),
        uploader;
    if (!WebUploader.Uploader.support()) {
        Dialog.warn('Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
        throw new Error('WebUploader does not support the browser you are using.');
    }
    
    var acceptExt = '${param.ext}';
    var mimeTypes = "";
    if (acceptExt != '') {
    	var exts = acceptExt.split(",");
    	for (var i = 0; i < exts.length; i++) {
    		if (mimeTypes == "") {
    			mimeTypes = exts[i] + "/*";
    		} else {
    			mimeTypes += "," + exts[i] + "/*";
    		}
    	}
    }

    // 实例化
    uploader = WebUploader.create({
        pick: {
            id: '#filePicker',
            label: '点击选择文件',
            multiple: '${param.fileNum}' == '1' ? false : true
        },
        dnd: '#web-uploader .queueList',
        paste: document.body,
        swf: '${ctx}/static/plugin/webuploader/Uploader.swf',
        disableGlobalDnd: true,
        chunked: false,
        server: '${ctx}/attach/uploadListFile?relativedId=${param.relativedId}',
        fileNumLimit: '${param.fileNum}' == '' ? 100 : '${param.fileNum}',
        fileSizeLimit: '${param.fileSizeLimit}' == '' ? 100 * 1024 * 1024 : parseInt('${param.fileSizeLimit}') * 1024,    // 100 M
        fileSingleSizeLimit: '${param.fileSingleSizeLimit}' == '' ? 20 * 1024 * 1024 : parseInt('${param.fileSingleSizeLimit}') * 1024,    // 20 M
        accept: {
        	mimeTypes: mimeTypes
        },
        auto: true
    });

    // 添加“添加文件”的按钮
    if ('${param.fileNum}' != '1') {
    	uploader.addButton({
            id: '#filePicker2',
            label: '继续添加'
        });
    }
    
    var docColor = "#5087E5";
    var docIcon = "file-word-o";
    
    var xlsColor = "#47B347";
    var xlsIcon = "file-excel-o";
    
    var pptColor = "#F2733D";
    var pptIcon = "file-powerpoint-o";
    
    var pdfColor = "#EB5E5E";
    var pdfIcon = "file-pdf-o";
    
    var videoColor = "#EB5E5E";
    var videoIcon = "file-video-o";
    
    var soundColor = "#EB5E5E";
    var soundIcon = "file-sound-o";
    
    $.ajax({
    	type: "POST",
    	url: "${ctx}/attach/findByRelativedId",
    	data: {relativedId: '${param.relativedId}'},
    	async: false,
    	success: function(msg) {
    		try {
        		var result = JSON.parse(msg);
        		if (result.statusCode == 200) {
        			fileCount = result.data.length;
        			for (var i = 0; i < result.data.length; i++) {
        				state = "echo";
        				$('#web-uploader-required-input').val($('#web-uploader-required-input').val() == "" ? 1 : parseInt($('#web-uploader-required-input').val()) + 1);
        				fileSize += parseFloat(result.data[i].doubleSize);
            			var file = new Object();
            			file.ext = result.data[i].strDocType;
            			file.name = result.data[i].strName;
            			file.src = result.data[i].strPath;
            			file.doubleSize = result.data[i].doubleSize;
            			file.relativedId = result.data[i].relativedId;
            			file.type = result.data[i].strSn;
            			file.id = result.data[i].id;
            			addUploadedFile(file);
            		}
        			fileSize = fileSize * 1024;
        		} else {
        			Dialog.error(result.message);
        		}
        	} catch (e) {
        		Dialog.error(e.message);
        	}
    	}
    });
    
    function addUploadedFile(file) {
    	var $li;
    	if (file.type.startsWith("image")) {
    		$li = $('<li style="border: 1px solid #CCFF66;" size="' + file.doubleSize + '" rel="' + file.id + '" id="' + file.id + '">' +
            		'<p class="title">' + file.name + '</p>' +
                    '<p class="imgWrap"><img style="height: 100%;" src="${ctx}' + file.src + '" /></p>' +
                    (('${param.action}' == 'edit' || '${param.action}' == '') ? '<span class="success"></span>' : '') +
                    '</li>');
    	} else {
    		var icon = "";
    		var color = "";
    		if (file.type.startsWith("video")) {
    			icon = "file-video-o";
    			color = "#003366";
    		} else if (file.type.startsWith("audio")) {
    			icon = "file-sound-o";
    			color = "#CC99CC";
    		} else {
    			if ($.inArray(file.ext, ["doc", "docx", "rtf", "dot", "dotx", "docm", "dotm", "xps", "odt", "wtf"]) != -1) {
        			icon = "file-word-o";
        			color = "#5087E5";
        		} else if ($.inArray(file.ext, ["pdf"]) != -1) {
        			icon = "file-pdf-o";
        			color = "orange";
        		} else if ($.inArray(file.ext, ["xls", "xlsx", "xlsm", "xlt", "xltx", "xltm", "xlsb", "xlam"]) != -1) {
        			icon = "file-excel-o";
        			color = "#47B347";
        		} else if ($.inArray(file.ext, ["ppt", "pptx", "pptm", "ppsx", "pot", "potx", "thmx", "potm", "ppa", "ppam", "pps", "ppsx"]) != -1) {
        			icon = "file-powerpoint-o";
        			color = "#EB5E5E";
        		} else if ($.inArray(file.ext, ["txt", "log", "xml"]) != -1) {
        			icon = "file-text-o";
        			color = "grey";
        		} else if ($.inArray(file.ext, ["rar", "zip", "7z", "tar", "jar", "war", "iso"]) != -1) {
        			icon = "file-zip-o";
        			color = "#663300";
        		} else {
        			icon = "file";
        			color = "#CC0033";
        		}
    		}
    		$li = $('<li style="border: 1px solid ' + color + ';" rel="' + file.id + '" id="' + file.id + '">' +
            		'<p style="background-color: ' + color + '; color: white;"><i class="fa fa-' + icon + '"></i>&nbsp;&nbsp;' + file.ext + '</p>' +
            		'<p class="title" style="top: 15px;">' + file.name + '</p>' +
            		(('${param.action}' == 'edit' || '${param.action}' == '') ? '<span class="success"></span>' : '') +
                    '</li>');
    	}
		if ('${param.action}' == 'edit' || '${param.action}' == '') {
			var $btns;
	   		$btns = $('<div class="file-panel">' +
	                    '<span class="cancel">删除</span></div>').appendTo($li);
	    	
	    	$li.on('mouseenter', function() {
	            $btns.stop().animate({height: 30});
	        });

	        $li.on('mouseleave', function() {
	            $btns.stop().animate({height: 0});
	        });
	        
	        $btns.on('click', 'span', function() {
	            var index = $(this).index(),
	                deg;
	            switch (index) {
	                case 0:
	                	var fileAttachId = $('#' + file.id).attr("rel");
	                	if (fileAttachId && fileAttachId != "") {
	                		$.post("${ctx}/attach/delete", {id: fileAttachId}, function(msg) {
	                			var result = JSON.parse(msg);
	                			if (result.statusCode == 200) {
	                				fileSize -= parseFloat($('#' + file.id).attr("size")) * 1024;
	                				fileCount -= 1;
	                				state = "echo";
	                				updateStatus();
	                				$('#' + file.id).remove();
	                				$('#web-uploader-required-input').val((parseInt($('#web-uploader-required-input').val()) - 1) == 0 ? "" : (parseInt($('#web-uploader-required-input').val()) - 1));
	                				if (fileCount == 0) {
	                					setState('pedding');
	                					updateTotalProgress();
	                				}
	                			} else {
									Dialog.error(result.message);                				
	                			}
	                		});
	                	} else {
	                		$('#' + file.id).remove();
	                	}
	                    return;
	            }
	            if (supportTransition) {
	                deg = 'rotate(' + file.rotation + 'deg)';
	                $wrap.css({
	                    '-webkit-transform': deg,
	                    '-mos-transform': deg,
	                    '-o-transform': deg,
	                    'transform': deg
	                });
	            } else {
	                $wrap.css('filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation=' + (~~((file.rotation/90)%4 + 4)%4) + ')');
	            }
	        });
		}
				
		if ('${param.action}' == 'view') {
			var $btns;
	   		$btns = $('<div class="file-panel">' +
	                    '<a target="_blank" class="icon-download" download="' + file.name + '" href="${ctx}' + file.src + '">下载</a></div>').appendTo($li);
	    	
	    	$li.on('mouseenter', function() {
	            $btns.stop().animate({height: 30});
	        });

	        $li.on('mouseleave', function() {
	            $btns.stop().animate({height: 0});
	        });
	        
	        $btns.on('click', 'span', function() {
	            var index = $(this).index(),
	                deg;
	            switch (index) {
	                case 0:
	                	console.log($(this).next().attr("href"));
	                	$(this).next().trigger('click');
	                    return;
	            }
	            if (supportTransition) {
	                deg = 'rotate(' + file.rotation + 'deg)';
	                $wrap.css({
	                    '-webkit-transform': deg,
	                    '-mos-transform': deg,
	                    '-o-transform': deg,
	                    'transform': deg
	                });
	            } else {
	                $wrap.css('filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation=' + (~~((file.rotation/90)%4 + 4)%4) + ')');
	            }
	        });
		}
    	
        $li.appendTo($queue);
        $('#dndArea').addClass("element-invisible");
        $statusBar.show();
        $('#web-uploader .queueList').addClass("filled");
        $upload.hide();
    }

    // 当有文件添加进来时执行，负责view的创建
    function addFile(file) {
    	$upload.show();
    	$upload.removeClass("disabled");
    	var $li;
    	if (file.type.startsWith("image")) {
    		$li = $('<li style="border: 1px solid #CCFF66;" id="' + file.id + '">' +
            		'<p class="title">' + file.name + '</p>' +
                    '<p class="imgWrap"></p>' +
                    '<p class="progress"><span></span></p>' +
                    '</li>');
    	} else {
    		var icon = "";
    		var color = "";
    		if (file.type.startsWith("video")) {
    			icon = "file-video-o";
    			color = "#003366";
    		} else if (file.type.startsWith("audio")) {
    			icon = "file-sound-o";
    			color = "#CC99CC";
    		} else {
    			if ($.inArray(file.ext, ["doc", "docx", "rtf", "dot", "dotx", "docm", "dotm", "xps", "odt", "wtf"]) != -1) {
        			icon = "file-word-o";
        			color = "#5087E5";
        		} else if ($.inArray(file.ext, ["pdf"]) != -1) {
        			icon = "file-pdf-o";
        			color = "orange";
        		} else if ($.inArray(file.ext, ["xls", "xlsx", "xlsm", "xlt", "xltx", "xltm", "xlsb", "xlam"]) != -1) {
        			icon = "file-excel-o";
        			color = "#47B347";
        		} else if ($.inArray(file.ext, ["ppt", "pptx", "pptm", "ppsx", "pot", "potx", "thmx", "potm", "ppa", "ppam", "pps", "ppsx"]) != -1) {
        			icon = "file-powerpoint-o";
        			color = "#EB5E5E";
        		} else if ($.inArray(file.ext, ["txt", "log", "xml"]) != -1) {
        			icon = "file-text-o";
        			color = "grey";
        		} else if ($.inArray(file.ext, ["rar", "zip", "7z", "tar", "jar", "war", "iso"]) != -1) {
        			icon = "file-zip-o";
        			color = "#663300";
        		} else {
        			icon = "file";
        			color = "#CC0033";
        		}
    		}
    		$li = $('<li style="border: 1px solid ' + color + ';" id="' + file.id + '">' +
            		'<p style="background-color: ' + color + '; color: white;"><i class="fa fa-' + icon + '"></i>&nbsp;&nbsp;' + file.ext + '</p>' +
            		'<p class="title" style="top: 15px;">' + file.name + '</p>' +
                    '<p class="progress"><span></span></p>' +
                    '</li>');
    	}

    	var $btns;
    	if (file.type.startsWith("image")) {
    		$btns = $('<div class="file-panel">' +
                    '<span class="cancel">删除</span>' +
                    '<span class="rotateRight">向右旋转</span>' +
                    '<span class="rotateLeft">向左旋转</span></div>').appendTo($li);
    	} else {
    		$btns = $('<div class="file-panel">' +
                    '<span class="cancel">删除</span></div>').appendTo($li);
    	}
    	
        var $prgress = $li.find('p.progress span');
        var $wrap = $li.find('p.imgWrap');
        var $info = $('<p class="error"></p>');

        var showError = function (code) {
                switch (code) {
                    case 'exceed_size':
                        text = '文件大小超出';
                        break;
                    case 'interrupt':
                        text = '上传暂停';
                        break;
                    default:
                        text = '上传失败，请重试';
                        break;
                }
                $info.text(text).appendTo($li);
            };
        if (file.getStatus() === 'invalid') {
            showError(file.statusText);
        } else {
            $wrap.text('预览中');
            uploader.makeThumb(file, function(error, src) {
                if (error) {
                    $wrap.text('');
                    return;
                }
                var img = $('<img src="' + src + '">');
                $wrap.empty().append(img);
            }, thumbnailWidth, thumbnailHeight);
            percentages[file.id] = [file.size, 0];
            file.rotation = 0;
        }
		
        //文件状态变化的触发事件
        file.on('statuschange', function(cur, prev) {
            if (prev === 'progress') {
                $prgress.hide().width(0);
            } else if (prev === 'queued') {
                //$li.off('mouseenter mouseleave');
                //$btns.remove();
            }
            // 成功
            if (cur === 'error' || cur === 'invalid') {
                console.log(file.statusText);
                showError(file.statusText);
                percentages[file.id][1] = 1;
            } else if (cur === 'interrupt') {
                showError('interrupt');
            } else if (cur === 'queued') {
                percentages[file.id][1] = 0;
            } else if (cur === 'progress') {
                $info.remove();
                $prgress.css('display', 'block');
            } else if (cur === 'complete') {
                $li.append('<span class="success"></span>');
            }
            $li.removeClass('state-' + prev).addClass('state-' + cur);
        });

        $li.on('mouseenter', function() {
            $btns.stop().animate({height: 30});
        });

        $li.on('mouseleave', function() {
            $btns.stop().animate({height: 0});
        });

        $btns.on('click', 'span', function() {
            var index = $(this).index(),
                deg;
            switch (index) {
                case 0:
                	var fileAttachId = $('#' + file.id).attr("rel");
                	if (fileAttachId && fileAttachId != "") {
                		$.post("${ctx}/attach/delete", {id: fileAttachId}, function(msg) {
                			var result = JSON.parse(msg);
                			if (result.statusCode == 200) {
                				uploader.removeFile(file);
                				$('#web-uploader-required-input').val((parseInt($('#web-uploader-required-input').val()) - 1) == 0 ? "" : (parseInt($('#web-uploader-required-input').val()) - 1));
                			} else {
								Dialog.error(result.message);                				
                			}
                		});
                	} else {
                		uploader.removeFile(file);
                	}
                    return;
                case 1:
                    file.rotation += 90;
                    break;
                case 2:
                    file.rotation -= 90;
                    break;
            }
            if (supportTransition) {
                deg = 'rotate(' + file.rotation + 'deg)';
                $wrap.css({
                    '-webkit-transform': deg,
                    '-mos-transform': deg,
                    '-o-transform': deg,
                    'transform': deg
                });
            } else {
                $wrap.css('filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation='+ (~~((file.rotation/90)%4 + 4)%4) +')');
            }
        });
        $li.appendTo($queue);
    }

    // 负责view的销毁
    function removeFile(file) {
        var $li = $('#' + file.id);
        delete percentages[file.id];
        updateTotalProgress();
        $li.off().find('.file-panel').off().end().remove();
    }

    function updateTotalProgress() {
        var loaded = 0,
            total = 0,
            spans = $progress.children(),
            percent;
        $.each(percentages, function(k, v) {
            total += v[0];
            loaded += v[0] * v[1];
        });

        percent = total ? loaded / total : 0;
        spans.eq(0).text(Math.round(percent * 100) + '%');
        spans.eq(1).css('width', Math.round(percent * 100) + '%');
        updateStatus();
    }

    function updateStatus() {
        var text = '', stats;
        if (state === 'ready') {
            text = fileCount + '个文件，共' + WebUploader.formatSize(fileSize);
        } else if (state === 'confirm') {
            stats = uploader.getStats();
            if (stats.uploadFailNum) {
                text = '已成功上传' + stats.successNum+ '个文件至系统，'+
                    stats.uploadFailNum + '张文件上传失败，<a class="retry" href="#">重新上传</a>失败文件或<a class="ignore" href="#">忽略</a>'
            }
        } else if (state === 'echo') {
            text = '共' + fileCount + '个（' + WebUploader.formatSize(fileSize)  + '），已上传' + fileCount + '个';
        } else {
            stats = uploader.getStats();
            text = '共' + fileCount + '个（' + WebUploader.formatSize(fileSize)  + '），已上传' + stats.successNum + '个';
            if (stats.uploadFailNum) {
                text += '，失败' + stats.uploadFailNum + '张';
            }
        }
        $info.html(text);
    }

    function setState(val) {
        var file, stats;
        if (val === state) {
            return;
        }
        $upload.removeClass('state-' + state);
        $upload.addClass('state-' + val);
        state = val;
        switch (state) {
            case 'pedding':
                $placeHolder.removeClass('element-invisible');
                $queue.parent().removeClass('filled');
                $queue.hide();
                $statusBar.addClass('element-invisible');
                uploader.refresh();
                break;
            case 'ready':
                $placeHolder.addClass('element-invisible');
                $('#filePicker2').removeClass('element-invisible');
                $queue.parent().addClass('filled');
                $queue.show();
                $statusBar.removeClass('element-invisible');
                uploader.refresh();
                break;
            case 'uploading':
                //$('#filePicker2').addClass('element-invisible');
                $progress.show();
                $upload.text('暂停上传');
                break;
            case 'paused':
                $progress.show();
                $upload.text('继续上传');
                break;
            case 'confirm':
                $progress.hide();
                $upload.text('开始上传').addClass('disabled');
                $upload.hide();
                stats = uploader.getStats();
                if (stats.successNum && !stats.uploadFailNum) {
                    setState('finish');
                    return;
                }
                break;
            case 'finish':
                stats = uploader.getStats();
                if (stats.successNum) {
                    Dialog.success('上传成功');
                } else {
                    // 没有成功的图片，重设
                    state = 'done';
                    location.reload();
                }
                break;
        }
        updateStatus();
    }

    uploader.onUploadProgress = function(file, percentage) {
        var $li = $('#' + file.id),
            $percent = $li.find('.progress span');
        $percent.css('width', percentage * 100 + '%');
        percentages[file.id][1] = percentage;
        updateTotalProgress();
    };

    uploader.onFileQueued = function(file) {
        fileCount++;
        fileSize += file.size;
        if (fileCount === 1) {
            $placeHolder.addClass('element-invisible');
            $statusBar.show();
        }
        addFile(file);
        setState('ready');
        updateTotalProgress();
    };

    uploader.onFileDequeued = function(file) {
        fileCount--;
        fileSize -= file.size;
        if (!fileCount) {
            setState('pedding');
        }
        removeFile(file);
        updateTotalProgress();
    };

    uploader.on('all', function(type) {
        var stats;
        switch (type) {
            case 'uploadFinished':
                setState('confirm');
                break;
            case 'startUpload':
                setState('uploading');
                break;
            case 'stopUpload':
                setState('paused');
                break;
        }
    });

    uploader.onError = function (code) {
    	if (code == "Q_EXCEED_NUM_LIMIT") {
    		Dialog.error('错误: 超过文件上传数量限制');
    	} else if (code == "Q_EXCEED_SIZE_LIMIT") {
    		Dialog.error('错误: 超过文件上传大小限制');
    	} else if (code == "Q_TYPE_DENIED") {
    		Dialog.error('错误: 不支持的文件类型');
    	} else {
    		Dialog.error('错误: ' + code);
    	}
    };
    
    uploader.onUploadSuccess = function(file, result) {
    	if (result.statusCode == 200) {
    		$('#web-uploader-required-input').val($('#web-uploader-required-input').val() == "" ? 1 : parseInt($('#web-uploader-required-input').val()) + 1);
    		$('#' + file.id).attr("rel", result.rel);
    	}
    }

    $upload.on('click', function() {
        if ($(this).hasClass('disabled')) {
            return false;
        }
        if (state === 'ready') {
            uploader.upload();
        } else if (state === 'paused') {
            uploader.upload();
        } else if (state === 'uploading') {
            uploader.stop();
        }
    });

    $info.on('click', '.retry', function() {
        uploader.retry();
    });

    $info.on('click', '.ignore', function() {
        Dialog.warn('todo');
    });

    $upload.addClass('state-' + state);
    updateTotalProgress();
});
</script>
</html>