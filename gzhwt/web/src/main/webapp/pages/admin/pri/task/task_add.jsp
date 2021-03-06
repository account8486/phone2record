<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="/pages/common/taglibs.jsp" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>新增发言人</title>
	${admin_css}                                   
	${jquery_js}                          
	${jquery_form_js}                                 
	${validate_js}                                
	${WdatePicker_js}    
	${jmpopups_js}    
	${admin_js}  
	${util_js}      
	<link rel="stylesheet" type="text/css" href="${ctx}/js/easyui/themes/default/tabs.css">
	<script type="text/javascript" src="${ctx}/js/easyui/jquery.easyui.js"></script>
	
<script>
$().ready(function() {
	$("#addForm").validate({
		onkeyup: false,
		rules: {
			"mobile": {
				required :false,
				minlength: 11,
				maxlength: 11,
				digits: true,
				isMobile:true
			},
			"name": "required"
		},
		messages: {
			"mobile": "请输入以数字1开头的11位手机号码！",	
			"name": "请输入发言人姓名！"
		}
	});
	
});

jQuery.validator.addMethod("isMobile", function(value, element) {
    var mobileVal=$("#mobile").val();
    if(mobileVal!=''){
    	if(mobileVal.substr(0,1)!='1'){
    		  return false;
    	}
    }
	return true;
}, "手机号码首字母必须为数字1");

function add(){	   
	var url="${ctx}/admin/pri/task/addTask.action";
	
    function callback(data){
    	hideLoading();
    	alert(data.retMsg);
    	returnList(${meetingId});	
    }
    
	function returnList(meetingId){
		window.location.href = "${ctx}/admin/pri/task/getTaskListPager.action?meetingId="+meetingId;
	}
	
	
	var options ={ 
			beforeSubmit: validate,
	        url:	   url,
	        success:   callback, 
	        type:      'post',      
	        dataType:  'json'
	    };
	
	$('#addForm').ajaxSubmit(options);
	
}


$(document).ready(function() {
		$(".easyui-tabs").tabs({  
			onSelect:function(title){  
				var tab = $(this).tabs("getTab", title); 
				var href = tab.attr("link");
				if (href) {
					location.href = href;
					//showLoading(title);
					return false;
				}
			}  
		});	
});



function validate()
{    
     var isSuccess=$("#addForm").validate().form(); //.form(); 返回是否验证成功
	  if(isSuccess){
		  
		showLoading("正在保存，请稍候...");
		
	}
     return isSuccess;
}


</script>
</head>
<body>
	<div class="page_title">
		<h3>添加发言人  -- ${CURRENT_MEETING}</h3>
	</div>
	
	<div class="easyui-tabs" border="false" style="padding:10px;">	
	
	<div title="任务列表" link="${ctx}/admin/pri/task/getTaskListPager.action?meetingId=${meetingId}" style="padding:10px;"></div>
	<div title="我的任务" link="${ctx}/admin/pri/task/getDetailListPager.action?meetingId=${meetingId}&myTaskFlag=1" style="padding:10px;"></div>
	<div title="添加任务" selected="true" style="padding:10px;"></div>
	
	</div>
	
	<div class="page_form">
	<form id="addForm" action="${ctx}/admin/pri/task/addTask.action" method="post">
	<input type="hidden" id="meetingId" name="meetingId" value="${meetingId}"/>
	    <fieldset>
	        <legend>基本信息</legend>
	          <dl>
	        	<dt>
	            	<label for="title"><font color="red">*</font>名&nbsp;&nbsp;&nbsp;称：</label>
	            </dt>
	            <dd>
	            	<input type="text" class="half" id="taskName" name="taskName" value="" tabindex="2" maxlength="30"></input>	            	
	            </dd>
	        </dl>	
	        
	        <dl>
	        	<dt>
	            	<label for="title">描述：</label>
	            </dt>
	            <dd>
	            	<textarea id="taskDescription" name="taskDescription"  tabindex="1"  style="width:600px;height:38px"></textarea>
	                <small></small>
	            </dd>
	        </dl>	
	        
	
	    </fieldset>
	    <div class="neidi">&nbsp;</div>
	    <div class="page_form_sub">
	        <a href="#" onclick="add();" id="addUserBtn" class="btn_common btn_true">保 存</a>　
	    </div>
	   
	</form>
	</div>

</body>
</html>