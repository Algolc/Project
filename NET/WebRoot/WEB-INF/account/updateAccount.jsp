<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" />
        <script language="javascript" type="text/javascript" src="../js/jquery-1.4.3.js"></script>
        <script language="javascript" type="text/javascript">
            //保存成功的提示信息
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

            //显示修改密码的信息项
            function showPwd(chkObj) {
                if (chkObj.checked) {
                    document.getElementById("divPwds").style.display = "block";
                } else{
                    document.getElementById("divPwds").style.display = "none";
                    //如果不修改密码，则将密码字段值清空
                    $("#loginPassword").val("");
                }
            }
            
           //根据推荐人身份证查询推荐人
            function searchRecommender(recommenderIdCardNo){
            	if(recommenderIdCardNo == null || recommenderIdCardNo == "")
            		return;
            	$.post(
            		"searchRecommender.action",
            		{"recommenderIdCardNo":recommenderIdCardNo},
            		function(data){
            			var account = data;
            			if(account != null) {
            				$("#recommenderId").val(account.id);
            			} else {
            				alert("找不到匹配的推荐人");
            			}
            		}
            	);
            }
            
            var pwdFlag = false; //密码校验成功标识
            var loginPassword; //原始密码
            $(function(){
            	//页面加载时记录原始密码
            	loginPassword = $("#loginPassword").val();
            });
            
            //校验旧密码
            function checkOldPassword(oldPwd){
            	//重置相关信息
            	$("#oldPwdMsg").text("30长度以内的字母、数字和下划线的组合");
            	pwdFlag = false;
            	
            	if(oldPwd == null || oldPwd == "") {
            		$("#oldPwdMsg").text("请输入旧密码");
            		return;
            	}
            	
            	if(oldPwd != loginPassword) {
            		$("#oldPwdMsg").text("旧密码输入有误");
            	}
            }
            
            //校验新密码
            function checkNewPassword(newPwd){
            	//重置相关信息
            	$("#newPasswordMsg").text("30长度以内的字母、数字和下划线的组合");
            	pwdFlag = false;
            	
            	if(newPwd == null || newPwd == "") {
            		$("#newPasswordMsg").text("请输入新密码");
            	}
            }
            
            //校验重复新密码
            function checkNewPassword2(newPwd2){
            	//重置相关信息
            	$("#newPasswordMsg2").text("30长度以内的字母、数字和下划线的组合");
            	pwdFlag = false;
            	
            	if(newPwd2 == null || newPwd2 == "") {
            		$("#newPasswordMsg2").text("请重新输入密码");
            		return;
            	}
            	
            	var newPwd = $("#newPassword").val();
            	if(newPwd != newPwd2){
            		$("#newPasswordMsg2").text("二次新密码输入不一致");
            		return;
            	}
            	
            	pwdFlag = true;
            	$("#loginPassword").val(newPwd);
            }
            
            //保存前校验
            function validate(){
            	var checked = $("#chkModiPwd").attr("checked");
            	if(checked && !pwdFlag){
            		alert("密码输入有误");
            		return false;
            	}
            	return true;
            }
            function save() {
            	if(validate()) {
            		document.forms[0].submit();
            	}
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
        	<s:include value="/WEB-INF/main/menu.jsp"/>
            <!-- <ul id="menu">
                <li><a href="../index.html" class="index_off"></a></li>
                <li><a href="../role/role_list.html" class="role_off"></a></li>
                <li><a href="../admin/admin_list.html" class="admin_off"></a></li>
                <li><a href="../fee/fee_list.html" class="fee_off"></a></li>
                <li><a href="../account/account_list.html" class="account_on"></a></li>
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
            <!--保存成功或者失败的提示消息-->          
            <div id="save_result_info" class="save_fail">保存失败，旧密码错误！</div>
            <form action="updateAccount" method="post" class="main_form">
            		<!-- 使用token来避免表单重复提交 -->
            		<s:token/>
                    <!--必填项-->
                    <div class="text_info clearfix"><span>账务账号ID：</span></div>
                    <div class="input_info">
                    	<s:textfield name="account.id" readonly="true" cssClass="readonly"></s:textfield>
                    	<!-- 不要丢掉一些不允许修改的字段 -->
                    </div>
                    <div class="text_info clearfix"><span>姓名：</span></div>
                    <div class="input_info">
                       	<s:textfield name="account.realName"></s:textfield>
                        <span class="required">*</span>
                        <div class="validate_msg_long error_msg">20长度以内的汉字、字母和数字的组合</div>
                    </div>
                    <div class="text_info clearfix"><span>身份证：</span></div>
                    <div class="input_info">
                    	<s:textfield name="account.idcardNo" readonly="true" cssClass="readonly"></s:textfield>
                    </div>
                    <div class="text_info clearfix"><span>登录账号：</span></div>
                    <div class="input_info">
                    	<s:textfield name="account.loginName" readonly="true" cssClass="readonly"></s:textfield>
                    	<!-- 
                        <div class="change_pwd">
                            <input type="checkbox" id="chkModiPwd" name="chkModiPwd" onclick="showPwd(this);" />
                            <label for="chkModiPwd">修改密码</label>
                        </div>
                       	-->
                    </div>
                    <!--修改密码部分-->
                    <!-- 
                    <div id="divPwds">
                        <div class="text_info clearfix"><span>旧密码：</span></div>
                        <div class="input_info">
                        	<s:hidden name="account.loginPassword" id="loginPassword"></s:hidden>
                            <input type="password" id="oldPassword" onblur="checkOldPassword(this.value);" />
                            <span class="required">*</span>
                            <div class="validate_msg_long" id="oldPwdMsg">30长度以内的字母、数字和下划线的组合</div>
                        </div>
                        <div class="text_info clearfix"><span>新密码：</span></div>
                        <div class="input_info">
                            <input type="password" id="newPassword" onblur="checkNewPassword(this.value);"/>
                            <span class="required">*</span>
                            <div class="validate_msg_long" id="newPasswordMsg">30长度以内的字母、数字和下划线的组合</div>
                        </div>
                        <div class="text_info clearfix"><span>重复新密码：</span></div>
                        <div class="input_info">
                            <input type="password" id="newPassword2" onblur="checkNewPassword2(this.value);"/>
                            <span class="required">*</span>
                            <div class="validate_msg_long" id="newPasswordMsg2">30长度以内的字母、数字和下划线的组合</div>
                        </div>  
                    </div>    
                     -->               
                    <div class="text_info clearfix"><span>电话：</span></div>
                    <div class="input_info">
                    	<s:textfield name="account.telephone" cssClass="width200"></s:textfield>
                        <span class="required">*</span>
                        <div class="validate_msg_medium error_msg">正确的电话号码格式：手机或固话</div>
                    </div>
                    <div class="text_info clearfix"><span>推荐人身份证号码：</span></div>
                    <div class="input_info">
                    	<s:hidden name="account.recommenderId" id="recommenderId"></s:hidden>
                    	<s:textfield name="account.recommenderIdCardNo" onblur="searchRecommender(this.value);" cssClass="width200"></s:textfield>
                        <div class="validate_msg_long error_msgs">正确的身份证号码格式</div>
                    </div>
                    <div class="text_info clearfix"><span>生日：</span></div>
                    <div class="input_info">
                    	<s:textfield name="account.birthdate" readonly="true" cssClass="readonly">
                    		<s:param name="value"><s:date name="account.birthdate" format="yyyy-MM-dd"/></s:param> 
                    	</s:textfield>
                    </div>
                    <div class="text_info clearfix"><span>Email：</span></div>
                    <div class="input_info">
                    	<s:textfield name="account.email" cssClass="width200"></s:textfield>
                        <div class="validate_msg_medium">50长度以内，合法的 Email 格式</div>
                    </div> 
                    <div class="text_info clearfix"><span>职业：</span></div>
                    <div class="input_info">
                    	<s:select name="account.occupation" list="#{'0':'干部','1':'学生','2':'技术人员','3':'其他' }" headerKey="" headerValue="请选择"></s:select>
                    </div>
                    <div class="text_info clearfix"><span>性别：</span></div>
                    <div class="input_info fee_type">
                    	<s:radio name="account.gender" list="#{'0':'男','1':'女' }" onclick="feeTypeChange(this.value);"></s:radio>
                    </div> 
                    <div class="text_info clearfix"><span>通信地址：</span></div>
                    <div class="input_info">
                    	<s:textfield name="account.mailaddress" cssClass="width350"></s:textfield>
                        <div class="validate_msg_tiny">50长度以内</div>
                    </div> 
                    <div class="text_info clearfix"><span>邮编：</span></div>
                    <div class="input_info">
                    	<s:textfield name="account.zipcode" ></s:textfield>
                        <div class="validate_msg_long">6位数字</div>
                    </div> 
                    <div class="text_info clearfix"><span>QQ：</span></div>
                    <div class="input_info">
                    	<s:textfield name="account.qq" ></s:textfield>
                        <div class="validate_msg_long">5到13位数字</div>
                    </div>                
                    <!--操作按钮-->
                    <div class="button_info clearfix">
                        <input type="submit" value="保存" class="btn_save" />
                        <input type="button" value="取消" class="btn_save" onclick="history.go(-1);"/>
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
