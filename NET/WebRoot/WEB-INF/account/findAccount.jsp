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
        	//开通
        	function startAccount(id){
        		var r = window.confirm("确定要开通此账务账号吗？");
        		if(!r) return;
        		$.post(
        			"startAccount.action",
        			{"id":id},
        			function(data){
        				if(data){
        					$("#operMsg").text("开通成功！");
        				} else {
        					$("#operMsg").text("开通失败！");
        				}
        				$("#operate_result_info").show();
        				setTimeout(function(){
        					toPage(document.getElementById("currPage").value);
        				},1000);
        			}
        		);
        	}
        	//暂停
        	function pauseAccount(id){
        		var r = window.confirm("确定要暂停此账务账号吗？");
        		if(!r) return;
        		$.post(
        			"pauseAccount.action",
        			{"id":id},
        			function(data){
        				if(data){
        					$("#operMsg").text("暂停成功！");
        				} else {
        					$("#operMsg").text("暂停失败！");
        				}
        				$("#operate_result_info").show();
        				setTimeout(function(){
        					toPage(document.getElementById("currPage").value);
        				},1000);
        			}
        		);
        	}
            //删除
            function deleteAccount(id) {
				var r = window.confirm("确定要暂停此账务账号吗？");
        		if(!r) return;
        		$.post(
        			"deleteAccount.action",
        			{"id":id},
        			function(data){
        				if(data){
        					$("#operMsg").text("删除成功！");
        				} else {
        					$("#operMsg").text("删除失败！");
        				}
        				$("#operate_result_info").show();
        				setTimeout(function(){
        					toPage(document.getElementById("currPage").value);
        				},1000);
        			}
        		);
            }
            //分页查询
            function toPage(page){
            	document.getElementById("currPage").value=page;
            	//alert($("#findForm").serialize());
            	document.getElementById("findForm").submit();
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
            <form action="findAccount" method="post" id="findForm">
                <!--查询-->
                <div class="search_add">                        
                	<s:hidden name="page" id="currPage"/>
                    <div>身份证：<s:textfield name="idCardNo" cssClass="text_search"/></div>                            
                    <div>姓名：<s:textfield name="realName" cssClass="width70 text_search"/></div>
                    <div>登录名：<s:textfield name="loginName" cssClass="text_search"/></div>
                    <div>
                                                状态：
                        <s:select name="status" list="#{'-1':'全部','0':'开通','1':'暂停','2':'删除'}" cssClass="select_search"/>
                    </div>
                    <div><input type="button" value="搜索" class="btn_search" onclick="toPage(1);"/></div>
                    <input type="button" value="增加" class="btn_add" onclick="location.href='toAddAccount.action';" />
                </div>  
                <!--删除等的操作提示-->
                <div id="operate_result_info" class="operate_success">
                    <img src="../images/close.png" onclick="this.parentNode.style.display='none';" />
                  	 <span id="operMsg">删除成功，且已删除其下属的业务账号！</span>
                </div>   
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                    <tr>
                        <th>账号ID</th>
                        <th>姓名</th>
                        <th class="width150">身份证</th>
                        <th>登录名</th>
                        <th>状态</th>
                        <th class="width100">创建日期</th>
                        <th class="width150">上次登录时间</th>                                                        
                        <th class="width200"></th>
                    </tr>
                   
                   	<s:iterator value="accounts">
	                    <tr>
	                        <td><s:property value="id"/></td>
	                        <td><a href="viewAccount?id=<s:property value="id"/>"><s:property value="realName"/></a></td>
	                        <td><s:property value="idcardNo"/></td>
	                        <td><s:property value="loginName"/></td>
	                        <td>
	                        	<s:if test="status==0">开通</s:if>
	                        	<s:if test="status==1">暂停</s:if>
	                        	<s:if test="status==2">删除</s:if>
	                        </td>
	                        <td><s:date name="createDate" format="yyyy-MM-dd"/></td>
	                        <td><s:date name="lastLoginTime" format="yyyy-MM-dd hh:mm:ss"/></td>                            
	                        <td class="td_modi">
	                        	<s:if test="status==0">
		                            <input type="button" value="暂停" class="btn_pause" onclick="pauseAccount(<s:property value="id"/>);" />
		                            <input type="button" value="修改" class="btn_modify" onclick="location.href='toUpdateAccount?id=<s:property value="id"/>';" />
		                            <input type="button" value="删除" class="btn_delete" onclick="deleteAccount(<s:property value="id"/>);" />
	                        	</s:if>
	                        	<s:if test="status==1">
	                        		 <input type="button" value="开通" class="btn_start" onclick="startAccount(<s:property value="id"/>);" />
		                             <input type="button" value="修改" class="btn_modify" onclick="location.href='toUpdateAccount?id=<s:property value="id"/>';" />
		                             <input type="button" value="删除" class="btn_delete" onclick="deleteAccount(<s:property value="id"/>);" />
	                        	</s:if>
	                        	<s:if test="status==2">
	                        		
	                        	</s:if>
	                        </td>
	                    </tr>
                   	</s:iterator>             
                </table>
                <p>业务说明：<br />
                1、创建则开通，记载创建时间；<br />
                2、暂停后，记载暂停时间；<br />
                3、重新开通后，删除暂停时间；<br />
                4、删除后，记载删除时间，标示为删除，不能再开通、修改、删除；<br />
                5、暂停账务账号，同时暂停下属的所有业务账号；<br />                
                6、暂停后重新开通账务账号，并不同时开启下属的所有业务账号，需要在业务账号管理中单独开启；<br />
                7、删除账务账号，同时删除下属的所有业务账号。</p>
                </div>                   
                <!--分页-->
                <div id="pages">
                    <a href="javascript:toPage(1);">首页</a>
                    <s:if test="page==1">
	        	        <a href="#">上一页</a>
                    </s:if>
                    <s:else>
                    	<a href="javascript:toPage(<s:property value="page-1"/>);">上一页</a>
                    </s:else>
                    
                    <s:iterator begin="1" end="totalPages" var="p">
                    	<s:if test="#p==page">
                    		<a href="javascript:toPage(<s:property value="#p"/>);" class="current_page"><s:property value="#p"/></a>
                    	</s:if>
                    	<s:else>
                    		<a href="javascript:toPage(<s:property value="#p"/>);"><s:property value="#p"/></a>
                    	</s:else>
                    </s:iterator>
                    
                    <s:if test="page==totalPages">
	        	        <a href="#">下一页</a>
                    </s:if>
                    <s:else>
                    	<a href="javascript:toPage(<s:property value="page+1"/>);">下一页</a>
                    </s:else>
                    <a href="javascript:toPage(<s:property value="totalPages"/>);">末页</a>
                </div>                    
            </form>
        </div>
        <!--主要区域结束-->
        <div id="footer">
            <p>[源自北美的技术，最优秀的师资，最真实的企业环境，最适用的实战项目]</p>
            <p>版权所有(C)加拿大达内IT培训集团公司 </p>
        </div>
    </body>
</html>
