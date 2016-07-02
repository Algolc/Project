/*
 * 资费名称唯一性校验,校验结果返回给nameFlag。
 * 该方法新增、修改可以共用。
 * */
var nameFlag;
function checkCostName() {
	nameFlag = undefined;
	var name = $("#feeName").val();
	var id = $("#feeId").val();
	
	if(name == null || name == "") {
		nameFlag = false;
		$("#nameMsg").text("用户名不能为空！").addClass("error_msg");
		return;
	}
	
	$.post(
		"costNameValidate.action",
		{"name":name,"id":id},
		function(data){
			if(data){
				nameFlag = true;
				$("#nameMsg").text("50长度的字母、数字、汉字和下划线的组合").removeClass("error_msg");
				return;
			} else {
				nameFlag = false;
				$("#nameMsg").text("用户名已存在！").addClass("error_msg");
				return;
			}
		}
	);
}