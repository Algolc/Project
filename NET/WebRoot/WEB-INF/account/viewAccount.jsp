<%@page pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" />
    </head>
    <body>
        <!--Logo区域开始-->
        <div id="header">
            <img src="../images/logo.png" alt="logo" class="left" />
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
            <form action="" method="" class="main_form">
                <!--必填项-->
                <div class="text_info clearfix"><span>账务账号ID：</span></div>
                <div class="input_info"><s:textfield name="account.id" readonly="true" cssClass="readonly"/></div>
                <div class="text_info clearfix"><span>姓名：</span></div>
                <div class="input_info"><s:textfield name="account.realName" readonly="true" cssClass="readonly"/></div>
                <div class="text_info clearfix"><span>身份证：</span></div>
                <div class="input_info">
                	<s:textfield name="account.idcardNo" readonly="true" cssClass="readonly"/>
                </div>
                <div class="text_info clearfix"><span>登录账号：</span></div>
                <div class="input_info">
                   <s:textfield name="account.loginName" readonly="true" cssClass="readonly"/>
                </div>                   
                <div class="text_info clearfix"><span>电话：</span></div>
                <div class="input_info">
                	<s:textfield name="account.telephone" readonly="true" cssClass="width200 readonly"/>
                </div>
                <div class="text_info clearfix"><span>推荐人账务账号ID：</span></div>
                <div class="input_info"><s:textfield name="account.recommenderId" readonly="true" cssClass="readonly"/></div>
                <div class="text_info clearfix"><span>推荐人身份证号码：</span></div>
                <div class="input_info"><s:textfield name="account.recommenderIdCardNo" readonly="true" cssClass="readonly"/></div>
                <div class="text_info clearfix"><span>状态：</span></div>
                <div class="input_info">
                	<s:select name="account.status" list="#{'0':'开通','1':'暂停','2':'删除' }" disabled="true"></s:select>
                </div>                    
                <div class="text_info clearfix"><span>开通/暂停/删除时间：</span></div>
                <div class="input_info">
                	<s:if test="account.status==0">
                		<s:textfield name="account.createDate" readonly="true" cssClass="readonly"/>
                	</s:if>
                	<s:if test="account.status==1">
                		<s:textfield name="account.pauseDate" readonly="true" cssClass="readonly"/>
                	</s:if>
                	<s:if test="account.status==2">
                		<s:textfield name="account.closeDate" readonly="true" cssClass="readonly"/>
                	</s:if>
                </div>

                <div class="text_info clearfix"><span>上次登录时间：</span></div>
                <div class="input_info"><s:textfield name="account.lastLoginTime" readonly="true" cssClass="readonly"/></div>
                <div class="text_info clearfix"><span>上次登录IP：</span></div>
                <div class="input_info"><s:textfield name="account.lastLoginIp" readonly="true" cssClass="readonly"/></div>
                <!--可选项数据-->
                <div class="text_info clearfix"><span>生日：</span></div>
                <div class="input_info">
                    <s:textfield name="account.birthdate" readonly="true" cssClass="readonly"/>
                </div>
                <div class="text_info clearfix"><span>Email：</span></div>
                <div class="input_info">
                	<s:textfield name="account.email" readonly="true" cssClass="width350 readonly"/>
                </div> 
                <div class="text_info clearfix"><span>职业：</span></div>
                <div class="input_info">
                	<s:select name="account.occupation" list="#{'0':'干部','1':'学生','2':'技术人员','3':'其他' }" disabled="true"></s:select>
                </div>
                <div class="text_info clearfix"><span>性别：</span></div>
                <div class="input_info fee_type">
                    <s:radio name="account.gender" list="#{'0':'男','1':'女' }" disabled="true"></s:radio>
                </div> 
                <div class="text_info clearfix"><span>通信地址：</span></div>
                <div class="input_info"><s:textfield name="account.mailaddress" readonly="true" cssClass="width350 readonly"/></div> 
                <div class="text_info clearfix"><span>邮编：</span></div>
                <div class="input_info"><s:textfield name="account.zipcode" readonly="true" cssClass="readonly"/></div> 
                <div class="text_info clearfix"><span>QQ：</span></div>
                <div class="input_info"><s:textfield name="account.qq" readonly="true" cssClass="readonly"/></div>                
                <!--操作按钮-->
                <div class="button_info clearfix">
                    <input type="button" value="返回" class="btn_save" onclick="window.history.go(-1);" />
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
