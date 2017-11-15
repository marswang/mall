<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title>用户列表</title>
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
		<meta content="" name="description" />
		<meta content="" name="author" />
		<link href="../media/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
		<link href="../media/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
		<link href="../media/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
		<link href="../media/css/style-metro.css" rel="stylesheet" type="text/css" />
		<link href="../media/css/style.css" rel="stylesheet" type="text/css" />
		<link href="../media/css/style-responsive.css" rel="stylesheet" type="text/css" />
		<link href="../media/css/default.css" rel="stylesheet" type="text/css" id="style_color" />
		<link href="../media/css/uniform.default.css" rel="stylesheet" type="text/css" />
		<link href="../media/css/pagination.css" rel="stylesheet" type="text/css" />
		<link rel="shortcut icon" href="media/image/favicon.ico" />
	</head>

	<body>
		<div class="container-fluid">
			<div class="row-fluid">
				<h3 class="page-title"><i class="fa fa-user-circle"></i>用户管理</h3>
				<ul class="breadcrumb">
					<li>
						<a href="#"><i class="fa fa-home"></i>用户管理</a>
						<i class="fa fa-angle-right"></i>
					</li>
					<li>
						<a href="#">用户列表</a>
					</li>
				</ul>
			</div>
			<div class="row-fluid">
				<div class="portlet box blue">
					<div class="portlet-title">
						<div class="caption">
							<i class="fa fa-reorder"></i>
							用户列表
						</div>
					</div>
					<div class="portlet-body">
						<table id="userTable" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>序号</th>
									<th>用户名</th>
									<th>真实姓名</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
						
								<!-- <tr>
									<td>001</td>
									<td>aaa</td>
									<td>tom</td>
									<td>
										<button class="btn mini green" onclick="edit(001)"><i class="fa fa-edit"></i> 编辑</button>&emsp;
										<button class="btn mini red" onclick="del(002)"><i class="fa fa-trash"></i> 删除</button>
									</td>
								</tr> -->
							</tbody>
						</table>
						<div id="Pagination" class="pagination align_right"><!-- 这里显示分页 --></div>
					</div>
				</div>
			</div>
		</div>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

		<script src="../media/js/jquery-1.10.1.min.js" type="text/javascript"></script>
		<script src="../media/js/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
		<!-- IMPORTANT! Load jquery-ui-1.10.1.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
		<script src="../media/js/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
		<script src="../media/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="../media/js/jquery.slimscroll.min.js" type="text/javascript"></script>
		<script src="../media/js/jquery.blockui.min.js" type="text/javascript"></script>
		<script src="../media/js/jquery.cookie.min.js" type="text/javascript"></script>
		<script src="../media/js/jquery.uniform.min.js" type="text/javascript"></script>
		<script src="../media/js/jquery.pagination.js" type="text/javascript"></script>
		<script src="../media/js/app.js" type="text/javascript"></script>
		<script>
			function edit(id){
				$("#mainFrame",window.parent.document).attr("src","toEdit.do?id="+id);
			}
			
			function del(id,btn){
				if(!confirm("是否删除id为"+id+"的用户？")){
					return;
				}
				$.ajax({
					url:"del.do?id="+id,
					type:"get",
					success:function(result){
						if(result.state==0){
							if(result.data==true){
								alert("删除成功！");
								$(btn).parent().parent().fadeOut();
							}else{
								alert("删除失败！");
							}
						}else{
							alert(result.message);
						}
					}
				});
			}
			var pagetotal;
			$(function(){
				
				$.ajax({
					url:"getTotal.do",
					type:"get",
					success:function(result){
						if(result.state==0){
							pagetotal=result.data;
							$("#Pagination").pagination(pagetotal, {
								num_edge_entries: 1, //边缘页数
								num_display_entries: 5, //主体页数
								callback: pageselectCallback,
								items_per_page: 7, //每页显示1项
								prev_text: "前一页",
								next_text: "后一页"
							});
						}else{
							alert(result.message);
						}
					}
				});
			});
			function pageselectCallback(page_index, jq){
				$.ajax({
					type:"get",
					url:"list.do?pageindex="+page_index,
					success:function(result){
						if(result.state==0){
							showList(result.data);
						}else{
							alert(result.message);
						}
					}
				});
			}
			
			function showList(data){
				//清空表
				var tbody = $("#userTable tbody").eq(0);
				tbody.html("");
				for(var i=0;i<data.length;i++){
					var tr = $("<tr style='display:none;'></tr>");
					tr.append($("<td></td>").text(data[i].uid));
					tr.append($("<td></td>").text(data[i].username));
					tr.append($("<td></td>").text(data[i].name));
					tr.append($("<td></td>")
							.append($('<button style="margin-right:20px;" class="btn mini green" onclick="edit('+data[i].uid+')"><i class="fa fa-edit"></i> 编辑</button>'))
							.append($('<button class="btn mini red" onclick="del('+data[i].uid+',this)"><i class="fa fa-trash"></i> 删除</button>')));
					tbody.append(tr);
					tr.fadeIn();
				}
				
			}
		</script>
	</body>

</html>