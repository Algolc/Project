<%@page pageEncoding="utf-8" %>
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
            //排序按钮的点击事件
            function sort(btnObj) {
            	//改变按钮样式
                if (btnObj.className == "sort_desc"){
                    btnObj.className = "sort_asc";
                } else {
                    btnObj.className = "sort_desc";
                }
                toPage(document.getElementById("currPage").value);
            }
            function toPage(page) {
                //提交排序查询
                var baseCost = document.getElementById("baseCost");
                var baseCostType = baseCost.className;
                
                var baseDuration = document.getElementById("baseDuration");
                var baseDurationType = baseDuration.className;
                
                document.getElementById("currPage").value = page;
                window.location.href = "findCost?baseCostSort="+baseCostType+"&baseDurationSort="+baseDurationType+"&page="+page;
            }
            //初始化排序样式
			function init(){
				document.getElementById("baseCost").className = document.getElementById("baseCostSort").value;
				document.getElementById("baseDuration").className = document.getElementById("baseDurationSort").value;
			}
			
            //删除
            function deleteFee(id) {
                var r = window.confirm("确定要删除此资费吗？");
                if(!r){
                	return;
                }
                $.post(
        			"deleteCost.action",
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
            
            // 启用
        	function startFee(id){
        		var r = window.confirm("确定要启用此资费吗？资费启用后将不能修改和删除。");
        		if(!r) return;
        		$.post(
        			"startCost.action",
        			{"id":id},
        			function(data){
        				if(data){
        					$("#operMsg").text("启用成功！");
        				} else {
        					$("#operMsg").text("启用失败！");
        				}
        				$("#operate_result_info").show();
        				setTimeout(function(){
        					toPage(document.getElementById("currPage").value);
        				},1000);
        			}
        		);
        	}
        </script>        
    </head>
    <body onload="init();">
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
                <li><a href="../fee/fee_list.html" class="fee_on"></a></li>
                <li><a href="../account/account_list.html" class="account_off"></a></li>
                <li><a href="../service/service_list.html" class="service_off"></a></li>
                <li><a href="../bill/bill_list.html" class="bill_off"></a></li>
                <li><a href="../report/report_list.html" class="report_off"></a></li>
                <li><a href="../user/user_info.html" class="information_off"></a></li>
                <li><a href="../user/user_modi_pwd.html" class="password_off"></a></li>
            </ul>     -->        
        </div>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">
            <form action="" method="">
                <!--排序-->
                <div class="search_add">
                    <div>
                    	<s:hidden name="page" id="currPage"/>
                    	<s:hidden name="baseCostSort" id="baseCostSort"></s:hidden>
                    	<s:hidden name="baseDurationSort" id="baseDurationSort"></s:hidden>
                    	
                        <!-- <input type="button" value="月租" class="sort_asc" onclick="sort(this);" /> -->
                        <input type="button" id="baseCost" value="基费" onclick="sort(this);" />
                        <input type="button" id="baseDuration" value="时长" onclick="sort(this);" />
                    </div>
                    <input type="button" value="增加" class="btn_add" onclick="location.href='toAddCost.action';" />
                </div> 
                <!--启用操作的操作提示-->
                <div id="operate_result_info" class="operate_success">
                    <img src="../images/close.png" onclick="this.parentNode.style.display='none';" />
                    <span id="operMsg">删除成功，且已删除其下属的业务账号！</span>
                </div>    
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                        <tr>
                            <th>资费ID</th>
                            <th class="width100">资费名称</th>
                            <th>基本时长</th>
                            <th>基本费用</th>
                            <th>单位费用</th>
                            <th>创建时间</th>
                            <th>开通时间</th>
                            <th class="width50">状态</th>
                            <th class="width200"></th>
                        </tr>                      
                        
                       <s:iterator value="feeList">
	                        <tr>
	                            <td><s:property value="id"/></td>
	                            <td><a href="fee_detail.html"><s:property value="name"/></a></td>
	                            <td><s:property value="baseDuration"/></td>
	                            <td><s:property value="baseCost"/></td>
	                            <td><s:property value="unitCost"/></td>
	                            <td>
	                            	<s:date name="createTime" format="yyyy-MM-dd"/>
	                            </td>
	                            <td>
	                            	<s:date name="startTime" format="yyyy-MM-dd"/>
	                            </td>
	                            <td>
	                            	<s:if test='status.equals("0")'>开通</s:if>
	                            	<s:if test='status.equals("1")'>暂停</s:if>
	                            </td>
	                            <td>                                
	                            	<s:if test='status.equals("1")'>
	                            		<input type="button" value="启用" class="btn_start" onclick="startFee(<s:property value="id"/>);" />
		                                <input type="button" value="修改" class="btn_modify" onclick="location.href='toUpdateCost.action?id=${id}&page=${page }';" />
		                                <input type="button" value="删除" class="btn_delete" onclick='deleteFee(<s:property value="id"/>);' />
	                            	</s:if>
	                            </td>
	                        </tr>
                        </s:iterator>
                    </table>
                    <p>业务说明：<br />
                    1、创建资费时，状态为暂停，记载创建时间；<br />
                    2、暂停状态下，可修改，可删除；<br />
                    3、开通后，记载开通时间，且开通后不能修改、不能再停用、也不能删除；<br />
                    4、业务账号修改资费时，在下月底统一触发，修改其关联的资费ID（此触发动作由程序处理）
                    </p>
                </div>
                <!--分页-->
                <div id="pages">
                	<s:if test="page==1">
                		<a href="#">上一页</a>
                	</s:if>
                	<s:else>
                		<a href="javascript:toPage(<s:property value='page-1'/>)">上一页</a>
                	</s:else>
                    
                    <s:iterator begin="1" end="totalPages" var="p">
                    	<s:if test="#p==page">
                    		<a href="javascript:toPage(<s:property value="#p"/>)" class="current_page"><s:property value="#p"/></a>
                    	</s:if>
                    	<s:else>
                    		<a href="javascript:toPage(<s:property value="#p"/>)"><s:property value="#p"/></a>
                    	</s:else>
                    </s:iterator>
                    
                    <s:if test="page==totalPages">
                		<a href="#">下一页</a>
                	</s:if>
                	<s:else>
                		<a href="javascript:toPage(<s:property value='page+1'/>)">下一页</a>
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
