<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" />
        <script language="javascript" type="text/javascript" src="../js/jquery-1.11.1.js"></script>
        <script language="javascript" type="text/javascript">
            //保存成功的提示消息
            function testPass(){
            	var oldPass=$("#oldPass").val();//旧密码
            	//采用异步的方式，检查旧密码是否正确
            	var admin_id=$("#admin_id2").val();//帐户id
            	var flag='aaa';
            	if(!oldPass){
            		$("#requiredOld").html("密码不能为空");
            		flag=false;
				}else{
					$.post(
	            		"testPassword.do",
	            		{"oldPass":oldPass,"admin_id":admin_id},
	            		function(data) {
	            			//设置提示信息
	            			$("#requiredOld").html(data.message);//alert(data.message==''||data.message==null||data.message==undefined);
	            			if(data.message==''||data.message==null||data.message==undefined){
	            				flag=true;
	            			}else{
	            				flag=false;
	            			}
	            		}
            		);
            	}
           		if(flag == false){
					return false;
				}else{
					return true;
				}
            	
            	
            }
            
             function testPass2(){alert(11);
             	/**var oldPass=$("#oldPass").val();//旧密码
             	var newPass=$("#newPass").val();//旧密码
             	var admin_id=$("#admin_id2").val();//帐户id
             	alert(testPass(oldPass)+"---");
             	if(testPass(oldPass)==true){
	             	$.post(
		            		"editPassword.do",
		            		{"newPass":newPass,"admin_id":admin_id},
		            		function(data) {alert(data);
		            			location.href = "../login/toLogin.do";
		            		}
	            	);
            	}*/
             }
            
            
            function showResult() {
                showResultDiv(true);
                window.setTimeout("showResultDiv(false);", 3000);
            }
            
            
            function showResultDiv(flag) {
                var divResult = document.getElementById("save_result_info");
                if (flag)
                    divResult.style.display = "block";
                else
                    divResult.style.display = "none";
            }
            
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
        	<jsp:include page="/WEB-INF/main/menu.jsp" />
        </div>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">            
            <div id="save_result_info" class="save_success">保存成功！</div>
            <form action=""  class="main_form" onsubmit="testPass2()"><!-- editPassword.do  method="post"  -->
            		<input id="admin_id2" type="hidden" name="admin_id" value="${admin.admin_id }"/>
                    <div class="text_info clearfix"><span>姓名：</span></div>
                    <div class="input_info">
                        <input type="text" name="name" value="${admin.name}" readonly="readonly" class="readonly" />
                        <span class="required">*</span>
                        <div class="validate_msg_long error_msg">20长度以内的汉字、字母、数字的组合</div>
                    </div>
                    <div class="text_info clearfix"><span>管理员账号：</span></div>
                    <div class="input_info"><input type="text" readonly="readonly" class="readonly" name="admin_code" value="${admin.admin_code }"  /></div>
                    <div class="text_info clearfix"><span>请输入旧密码：</span></div>
                    <div class="input_info">
                        <input type="password" id="oldPass" name="oldPass" value="" onblur="testPass();"/>
                        <span class="required" id="requiredOld">*</span>
                        <span class="operate_msg" id="operate_msg"></span>
                        <!-- <div class="operate_msg" id="operate_msg"></div> -->
                    </div>
                    <div class="text_info clearfix"><span>请输入新密码：</span></div>
                    <div class="input_info">
                        <input class="width200" id="newPass" type="password" name="password""/>
                        <span class="required">*</span>
                        <div class="validate_msg_medium error_msg">6-30位(不能包含空格)</div>
                    </div>
                    <div class="button_info clearfix">
                        <input type="submit" value="保存" class="btn_save" onclick="javascript:testPass2();"/>
                        <input type="button" value="取消" class="btn_save" onclick="history.back();"/>
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