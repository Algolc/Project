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
            //显示角色详细信息
            function showDetail(flag, a) {
                var detailDiv = a.parentNode.getElementsByTagName("div")[0];
                if (flag) {
                    detailDiv.style.display = "block";
                }
                else
                    detailDiv.style.display = "none";
            }
            //重置密码
            function resetPwd() {
            	var checkObjs = document.getElementsByName("selectAdmin");
            	var ids = new Array();
            	for(var i=0;i<checkObjs.length;i++){
            		if(!checkObjs[i].checked)
            			continue;
            		var trObj = checkObjs[i].parentNode.parentNode;
            		var tdObjs = trObj.getElementsByTagName("td");
            		var id = tdObjs[1].innerHTML;
            		ids.push(id);
            	}
            	
            	if(ids.length == 0) {
            		alert("请至少选择一条数据！");
            		return;
            	}
            	
            	$.post(
            		"resetPassword.action",
            		{"ids":ids.toString()},
            		function(data){
            			var pass = data;
            			if(pass) {
            				alert("密码重置成功!");
            			} else {
            				alert("密码重置失败!");
            			}
            		}
            	);
            }
            function resetPwd_jquery(){
            	var trObjs = $("input[name='selectAdmin']:checked").parent().parent();
            	var ids = new Array();
            	for(var i=0;i<trObjs.length;i++){
            		ids.push($(trObjs[i]).children()[1].innerHTML);
            	}
            	
            	if(ids.length == 0) {
            		alert("请至少选择一条数据！");
            		return;
            	}
            	
            	$.post(
            		"resetPassword.action",
            		{"ids":ids.toString()},
            		function(data){
            			var pass = data;
            			if(pass) {
            				alert("密码重置成功!");
            			} else {
            				alert("密码重置失败!");
            			}
            		}
            	);
            }
            //删除
            function deleteAdmin() {
                var r = window.confirm("确定要删除此管理员吗？");
                document.getElementById("operate_result_info").style.display = "block";
            }
            //全选
            function selectAdmins(inputObj) {
                var inputArray = document.getElementById("datalist").getElementsByTagName("input");
                for (var i = 1; i < inputArray.length; i++) {
                    if (inputArray[i].type == "checkbox") {
                        inputArray[i].checked = inputObj.checked;
                    }
                }
            }
            //分页查询
            function toPage(page){
            	document.getElementById("currPage").value=page;
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
            <form action="findAdmin" method="post" id="findForm">
                <!--查询-->
                <div class="search_add">
                	<s:hidden name="page" id="currPage"></s:hidden>
                    <div>
                       	 模块：
                       	<s:select name="privilegeId" list="privileges" listKey="id" listValue="name" cssClass="select_search" emptyOption="-1"></s:select>
                    </div>
                    <div>
                    	角色：
                    	<s:select name="roleId" list="roles" listKey="id" listValue="name" cssClass="select_search" emptyOption="-1"></s:select>
                    </div>
                    <div><input type="button" value="搜索" class="btn_search" onclick="toPage(1);"/></div>
                    <input type="button" value="密码重置" class="btn_add" onclick="resetPwd();" />
                    <input type="button" value="增加" class="btn_add" onclick="location.href='toAddAdmin.action';" />
                </div>
                <!--删除和密码重置的操作提示-->
                <div id="operate_result_info" class="operate_fail">
                    <img src="../images/close.png" onclick="this.parentNode.style.display='none';" />
                    <span>删除失败！数据并发错误。</span><!--密码重置失败！数据并发错误。-->
                </div> 
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                        <tr>
                            <th class="th_select_all">
                                <input type="checkbox" onclick="selectAdmins(this);" id="selectAll"/>
                                <span><label for="selectAll">全选</label></span>
                            </th>
                            <th>管理员ID</th>
                            <th>姓名</th>
                            <th>登录名</th>
                            <th>电话</th>
                            <th>电子邮件</th>
                            <th>授权日期</th>
                            <th class="width100">拥有角色</th>
                            <th></th>
                        </tr>                      
                        
                        <s:iterator value="admins">
	                        <tr>
	                            <td><input type="checkbox" name="selectAdmin" /></td>
	                            <td><s:property value="id"/></td>
	                            <td><s:property value="name"/></td>
	                            <td><s:property value="adminCode"/></td>
	                            <td><s:property value="telephone"/></td>
	                            <td><s:property value="email"/></td>
	                            <td><s:property value="enrollDate"/></td>
	                            <td>
	                                <a class="summary" onmouseover="showDetail(true,this);" onmouseout="showDetail(false,this);">
	                                	<s:if test="roleNames.length()>5">
	                                		<s:property value="roleNames.substring(0,6)+'...'"/>
	                                	</s:if>
	                                	<s:else>
	                                		<s:property value="roleNames"/>
	                                	</s:else>
	                                </a>
	                                <!--浮动的详细信息-->
	                                <div class="detail_info">
	                                    	<s:property value="roleNames"/>
	                                </div>
	                            </td>
	                            <td class="td_modi">
	                                <input type="button" value="修改" class="btn_modify" onclick="location.href='admin_modi.html';" />
	                                <input type="button" value="删除" class="btn_delete" onclick="deleteAdmin();" />
	                            </td>
	                        </tr>
                        </s:iterator>
                        
                    </table>
                </div>
                <!--分页-->
                <div id="pages">
        	         <s:if test="page==1">
	        	        <a href="#">上一页</a>
                    </s:if>
                    <s:else>
                    	<a href="javascript:toPage(<s:property value="page-1"/>);">上一页</a>
                    </s:else>
                    
                    <s:iterator begin="1" end="totalPage" var="p">
                    	<s:if test="#p==page">
                    		<a href="javascript:toPage(<s:property value="#p"/>);" class="current_page"><s:property value="#p"/></a>
                    	</s:if>
                    	<s:else>
                    		<a href="javascript:toPage(<s:property value="#p"/>);"><s:property value="#p"/></a>
                    	</s:else>
                    </s:iterator>
                    
                    <s:if test="page==totalPage">
	        	        <a href="#">下一页</a>
                    </s:if>
                    <s:else>
                    	<a href="javascript:toPage(<s:property value="page+1"/>);">下一页</a>
                    </s:else>
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
