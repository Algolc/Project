<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" />
        <script language="javascript" type="text/javascript" src="../js/jquery-1.4.3.js"></script>
        <script language="javascript" type="text/javascript">
        	//校验账号非空及格式
        	function is_code_legal() {
       			var code = $("#admin_code").val();
       			
       			//校验是否为空
            	if(code == "") {
            		$("#code_msg").text("请输入账号！").addClass("error_msg");
            		return false;
            	}
            	
            	//校验格式
            	var reg = /^\w{3,30}$/;//3~30长度的字母、数字和下划线的组合
            	if(!reg.test(code)) {
            		$("#code_msg").text("请输入3~30长度的字母、数字和下划线的组合！").addClass("error_msg");
            		return false;
            	}
            	
            	$("#code_msg").text("有效的输入").removeClass("error_msg");
            	return true;
        	}
        	
        	//输入完账号光标切换时，校验账号
        	$(function(){
        		$("#admin_code").blur(function(){
					//先校验是否输入正确的格式
	        		if(!is_code_legal()) {
	        			return;
	        		}
	        		//校验是否重复
	        		var code = $("#admin_code").val();
	            	$.post(
	            		"validateCode",
	            		{"adminCode":code},
	            		function(data){
	            			if(data.success) {
	            				if(data.isRepeat) {
	            					//重复时提示重复信息
		            				$("#code_msg").text("该账号已存在，请重新输入！").addClass("error_msg");
	            				} else {
	            					//输入有效，给予正能量的提示
			            			$("#code_msg").text("有效的管理员账号").removeClass("error_msg");
	            				}
	            			} else {
	            				//发生异常时提示错误信息
	            				$("#code_msg").text(data.message).addClass("error_msg");
	            			}
	            		}
	            	);        			
        		});
        	});
        	
        	//保存前校验账号
        	$(function(){
        		$("#btn_save").click(function(){
        			if(is_code_legal()) {
	        			//校验是否重复
	        			var code = $("#admin_code").val();
		            	$.post(
		            		"validateCode",
		            		{"adminCode":code},
		            		function(data){
		            			if(data.success) {
		            				if(data.isRepeat) {
		            					//重复时提示重复信息
			            				$("#code_msg").text("该账号已存在，请重新输入！").addClass("error_msg");
		            				} else {
		            					//输入有效，给予正能量的提示
				            			$("#code_msg").text("有效的管理员账号").removeClass("error_msg");
		            				}
		            			} else {
		            				//发生异常时提示错误信息
		            				$("#code_msg").text(data.message).addClass("error_msg");
		            			}
		            		}
		            	);
        			}
        		});
        	});
        </script>
    </head>
    <body>
        <!--Logo区域开始-->
        <div id="header">
            <img src="../images/logo.png" alt="logo" class="left"/>
            <a href="#">[退出]</a>            
        </div>
        <!--Logo区域结束-->
        <!--导航区域开始-->
        <div id="navi">
        	<s:include value="/WEB-INF/main/menu.jsp"/>
            <!-- <ul id="menu">
                <li><a href="../index.html" class="index_off"></a></li>
                <li><a href="../role/role_list.html" class="role_off"></a></li>
                <li><a href="../admin/admin_list.html" class="admin_on"></a></li>
                <li><a href="../fee/fee_list.html" class="fee_off"></a></li>
                <li><a href="../account/account_list.html" class="account_off"></a></li>
                <li><a href="../service/service_list.html" class="service_off"></a></li>
                <li><a href="../bill/bill_list.html" class="bill_off"></a></li>
                <li><a href="../report/report_list.html" class="report_off"></a></li>
                <li><a href="../user/user_info.html" class="information_off"></a></li>
                <li><a href="../user/user_modi_pwd.html" class="password_off"></a></li>
            </ul> -->
        </div>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">            
            <div id="save_result_info" class="save_success">保存成功！</div>
            <form action="addAdmin" method="post" class="main_form" id="main_form">
                    <div class="text_info clearfix"><span>姓名：</span></div>
                    <div class="input_info">
                        <input type="text" name="admin.name"/>
                        <span class="required">*</span>
                        <div class="validate_msg_long">20长度以内的汉字、字母、数字的组合</div>
                    </div>
                    <div class="text_info clearfix"><span>管理员账号：</span></div>
                    <div class="input_info">
                        <input type="text" name="admin.adminCode" id="admin_code"/>
                        <span class="required">*</span>
                        <div class="validate_msg_long" id="code_msg">3~30长度的字母、数字和下划线的组合</div>
                    </div>
                    <div class="text_info clearfix"><span>密码：</span></div>
                    <div class="input_info">
                        <input type="password" name="admin.password" id="password"/>
                        <span class="required">*</span>
                        <div class="validate_msg_long">30长度以内的字母、数字和下划线的组合</div>
                    </div>
                    <div class="text_info clearfix"><span>重复密码：</span></div>
                    <div class="input_info">
                        <input type="password" id="password2"/>
                        <span class="required">*</span>
                        <div class="validate_msg_long">两次密码必须相同</div>
                    </div>      
                    <div class="text_info clearfix"><span>电话：</span></div>
                    <div class="input_info">
                        <input type="text" class="width200" name="admin.telephone"/>
                        <span class="required">*</span>
                        <div class="validate_msg_medium">正确的电话号码格式：手机或固话</div>
                    </div>
                    <div class="text_info clearfix"><span>Email：</span></div>
                    <div class="input_info">
                        <input type="text" class="width200" name="admin.email"/>
                        <span class="required">*</span>
                        <div class="validate_msg_medium">50长度以内，正确的 email 格式</div>
                    </div>
                    <div class="text_info clearfix"><span>角色：</span></div>
                    <div class="input_info_high">
                        <div class="input_info_scroll">
                            <s:checkboxlist name="admin.roleIds" list="roleList" listKey="id" listValue="name"/>
                             <!-- <ul>
                                <li><input type="checkbox"  />超级管理员</li>
                                <li><input type="checkbox" />账务账号管理员</li>
                                <li><input type="checkbox" />业务账号管理员</li>
                                <li><input type="checkbox" />账务账号管理员</li>
                                <li><input type="checkbox" />业务账号管理员</li>
                                <li><input type="checkbox" />账务账号管理员</li>
                                <li><input type="checkbox" />业务账号管理员</li>
                            </ul> -->
                        </div>
                        <span class="required">*</span>
                        <div class="validate_msg_tiny">至少选择一个</div>
                    </div>
                    <div class="button_info clearfix">
                        <input type="button" value="保存" class="btn_save" id="btn_save"/>
                        <input type="button" value="取消" class="btn_save" />
                    </div>
                </form>  
        </div>
        <!--主要区域结束-->
        <div id="footer">
            <span>[源自北美的技术，最优秀的师资，最真实的企业环境，最适用的实战项目]</span>
            <br />
            <span>版权所有(C)加拿大达内IT培训集团公司 </span>
        </div>
    </body>
</html>
