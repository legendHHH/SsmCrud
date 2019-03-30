<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <%-- <%
         pageContext.setAttribute("APP_PATH",request.getContextPath());
     %>--%>

    <%--引入jquery--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.12.4.min.js" ></script>
    <%--引入样式--%>
    <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" >
    <script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>



<!-- 员工修改Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabelUpdate">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabelUpdate">员工修改</h4>
            </div>
            <div class="modal-body">

                <!--模态框主要内容开始部分-->
                <form class="form-horizontal">
                    <!--姓名-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <%--修改成静态控件   不可编辑修改--%>
                            <p class="form-control-static" id="empName_update_static">!</p>
                        </div>
                    </div>

                    <!--邮箱-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <!--性别-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <!--部门-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Department</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="dept_update_select" name="dId">
                                <!--动态加载部门-->
                                <%--<option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>--%>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_update">Update changes</button>
            </div>
        </div>
    </div>
</div>



<!-- 员工添加Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">

                <!--模态框主要内容开始部分-->
                <form class="form-horizontal">
                    <!--姓名-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">EmpName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="EmpName">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <!--邮箱-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>

                    <!--性别-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <!--部门-->
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Department</label>
                        <div class="col-sm-4">
                            <select class="form-control" id="dept_add_select" name="dId">
                                <!--动态加载部门-->
                                <%--<option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>--%>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="emp_save">Save changes</button>
            </div>
        </div>
    </div>
</div>


<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>

    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn" >新增</button>
            <button class="btn btn-danger" id="emp_delete_all">删除</button>
        </div>
    </div>
    
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <!--创建批量删除checkbox-->
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>

                <tbody>

                </tbody>
            </table>
            <!-- 显示分页信息 -->
            <div class="row">
                <!--分页文字-->
                <div class="col-md-6" id="page_info_area">
                </div>

                <!--分页条信息-->
                <div class="col-md-6" id="page_nav_area">

                </div>
            </div>

        </div>
    </div>
</div>
<script type="text/javascript">

    //全局保存总记录数,解决模态框保存用户之后到达最后一页的参数选择
    var totalRecord;

    var currentNum;//当前页码


    //1、页面加载完成以后，直接去发送ajax请求,要到分页数据
    $(function () {
        //首页
        to_page(1);
    });
    //转到指定页面
    function to_page(pn) {
        $.ajax({
            url:"${pageContext.request.contextPath}/empsWithJson",
            data:"pn="+pn,
            type:"GET",
            success:function(result){
                console.log(result);
                //1.解析并显示员工数据
                build_emps_table(result);

                //2.解析并显示分页数据
                build_page_info(result);

                //3.解析并显示分页条数据
                build_page_nav(result);
            }
        });
    }


    //2.解析并显示分页条,点击分页
    function build_page_nav(result) {
        //page_nav_area
        $("#page_nav_area").empty();//清空第一页的数据,只出现指定页的数据

        //父元素
        var ul = $("<ul></ul>").addClass("pagination");
        
        //构建分页条元素
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

        //添加前一页和后一页是否有
        if (result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{   //没有被禁用才绑定事件
            //为元素添加点击翻页事件
            firstPageLi.click(function () {
                to_page(1);//首页
            });

            //前一页
            prePageLi.click(function () {
                //当前页码-1
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }



        //组装元素  下一页,最后一页
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

        //没有下一页就不显示/禁用
        if (result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{  //没有被禁用就绑定事件
            //下一页  当前页码+1
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            });

            //末页页码  总页数
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }



        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);

        //index是索引    item当前元素;也可以用this代替
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            
            //遍历的是页面号  1 2 3.....
            var numLi = $("<li></li>").append($("<a></a>").append(item));

            //有当前活动活动页显示
            if (result.extend.pageInfo.pageNum == item){
                numLi.addClass("active")
            }

            //绑定单击事件,跳转到指定的页码
            numLi.click(function () {
                to_page(item);
            });

            //添加到ul节点
            ul.append(numLi);
        });

        //添加下一页和末页的提示
        ul.append(nextPageLi).append(lastPageLi);

        //把ul添加到nav
        var navEle = $("<nav></nav>").append(ul);

        //添加到导航栏
        navEle.appendTo("#page_nav_area");
    }



    //解析显示分页信息
    function build_page_info(result) {
        //清空第一次请求数据
        $("#page_info_area").empty();

        //拼接参数
        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"
            +result.extend.pageInfo.pages+"页,总"
            +result.extend.pageInfo.total+"条记录");

        //赋值总记录数
        totalRecord = result.extend.pageInfo.total;

        //赋值当前页
        currentNum = result.extend.pageInfo.pageNum;
    }
    

    //1.解析并显示员工数据
    function build_emps_table(result) {

        //解决点击第二页把第一页数据也显示了
        $("#emps_table tbody").empty();//做清空处理


        var emps = result.extend.pageInfo.list;

        $.each(emps,function (index,item) {
            //alert(item.empName);

            //删除需要用到checkbox框
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'></td>");

            //做表格数据,拼接数据  添加属性用append
            var empIdTd  = $("<td></td>").append(item.empId);
            var empNameTd  = $("<td></td>").append(item.empName);
            var genderTd  = $("<td></td>").append(item.gender =='M'? "男":"女");
            var emailTd  = $("<td></td>").append(item.email);
            var deptNameTd  = $("<td></td>").append(item.department.deptName);


            /**
             <button class="">
                <span class="" aria-hidden="true"></span>
                    编辑
             </button>
             */
            //编辑按钮  拼接样式和添加属性
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");

            //为编辑按钮添加一个自定义的属性，来表示当前员工id
            editBtn.attr("edit_id",item.empId);

            //构造一个删除按钮
            var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

            //为删除按钮添加一个自定义的属性，来表示当前员工id
            delBtn.attr("del_id",item.empId);

            //两个按钮要定义在一个单元格
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            
            //append 方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(checkBoxTd) //添加复选框
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");//添加到tbody节点处
        });
    }

    //清除表单样式及内容
    function reset_form(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //点击新增弹出员工模态框
    $("#emp_add_modal_btn").click(function () {

        //解决每次点击新增按钮会出现上一次保存的内容
        //清除表单数据(表单完整重置)
        //$("#empAddModal form")[0].reset();//取出DOM对象
        reset_form("#empAddModal form");

        //发送ajax,查出部门信息,显示在下拉列表
        getDepts("#empAddModal select");//动态传入Element添加对象

        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });

    //异步请求获取部门
    function getDepts(ele) {
        //每次部门请求来的时候清空原来的
        //$("#empAddModal select").empty();
        $(ele).empty();

        $.ajax({
            url:"${pageContext.request.contextPath}/getDepts",
            type:"GET",
            success:function (result) {
                console.log(result);
                //显示部门信息在下拉列表中
                //$("#dept_add_select");
                //$("#empAddModal select").append("");

                //this表示遍历的当前对象
                $.each(result.extend.depts,function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo(ele);
                    //optionEle.appendTo("#empAddModal select");
                });
            }
        });

    }

    //校验表单数据
    function validate_add_form() {
        //1、拿到要校验的数据，使用正则表达式
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            //alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
            //做成方法
            /*$("#empName_add_input").parent().addClass("has-error");
            $("#empName_add_input").next("span").text("用户名可以是2-5位中文或者6-16位英文和数字的组合");*/

            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        } else {
           /* $("#empName_add_input").parent().addClass("has-success");
            $("#empName_add_input").next("span").text("");*/

            show_validate_msg("#empName_add_input", "success", "");
        }

        //2.验证邮箱信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式

            //代码抽取出来做成方法
            /*$("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next("span").text("邮箱格式不正确");*/
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        }else{
           /* $("#email_add_input").parent().addClass("has-success");
            $("#email_add_input").next("span").text("");*/
            show_validate_msg("#email_add_input", "success", "");
        }
        return true;

    }

    //显示校验结果的提示信息    ele代表的是正在校验的元素
    function show_validate_msg(ele,status,msg){
        //清除当前元素的校验状态   不然正确之后还是红色提示框
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");

        //判断状态
        if (status =="success"){
            //成功
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if (status == "error") {
            //错误
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }



    //邮箱验证
    $("#email_add_input").change(function () {
        var email = $("#email_add_input").val();
        alert(email)
        $.ajax({
            url:"${pageContext.request.contextPath}/checkEmail",
            type:"GET",
            data:"email="+email,
            success:function (result) {
                console.log(result)
                //alert(result)
                if (result.code ==100){
                    show_validate_msg("#email_add_input","success",result.extend.v_email);

                    $("#emp_save").attr('disabled', false);
                }else if (result.code ==200) {
                    show_validate_msg("#email_add_input","error",result.extend.v_email);

                    //改变按钮的是否可用状态
                    $("#emp_save").attr('disabled', true);
                }
            }
        })

    })

    //校验用户名是否重复可用
    $("#empName_add_input").change(function () {
        //var empName = this.val();

        //发送ajax请求校验用户名是否可用
        $.ajax({
            url:"${pageContext.request.contextPath}/checkUser",
            type:"GET",
            data:"empName="+$("#empName_add_input").val(),
            success:function (result) {
                if (result.code ==100){
                    show_validate_msg("#empName_add_input","success","用户名可用");

                    //当用户名可用才能点击保存
                    $("#emp_save").attr("ajax-validate","success")
                    $("#emp_save").attr('disabled', false);
                }else {
                    show_validate_msg("#empName_add_input","error",result.extend.validate_msg);
                    $("#emp_save").attr("ajax-validate","error");
                    $("#emp_save").attr('disabled', true);
                }
            }
        });
        
    });
    
    
    //找到保存按钮 绑定点击事件 填写回调函数
    $("#emp_save").click(function () {
       //模态框中的填写的数据提交给服务器进行保存

        //1、先对要提交给服务器的数据进行校验
        if(!validate_add_form()){
            return false;
        };


        //判断之前的ajax用户名校验是否成功,如果成功
        if ($(this).attr("ajax-validate")=="error"){
            return false;
        }


        //发送ajax保存员工信息
        //序列化数据:empName=123&email=2222&gender=M&dId=1
       //alert($("#empAddModal form").serialize());//序列化表单中的数据
        $.ajax({
            url:"${pageContext.request.contextPath}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {  //返回的是Message对象
                
                $("#empAddModal").modal('hide');//隐藏后显示
                //弹出处理成功
                alert(result.msg);//信息
                //console.log(result.msg);//信息

                //还要判断result 后台的校验数据的信息,之前是保存成功之后就做下面的事情了
                if (result.code == 100){  //校验成功
                    //员工保存成功后需要做的事情:
                    //1.关闭模态框
                    $("#empAddModal").modal('hide');
                    //2.到最后一页显示刚才插入的数据
                    //发送ajax请求显示最后一页
                    to_page(totalRecord);//MyBatis插件里面总是查询最大记录数
                }else{
                    //提示错误信息
                    console.log(result);
                    alert(result)

                    //有哪个错误字段的信息就显示哪个字段
                    if(undefined != result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if(undefined != result.extend.errorFields.empName){
                        //显示员工名字的错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }
            }
        });
    });



    /*//发现无法绑定点击事件
    $(".edit_btn").click(function () {
        alert("aaaa");
    })*/
    //新版的Jquery不支持Live方法绑定点击事件
    //使用了on方法代替 document是父节点,发放应用于父节点后面的所有元素
    //第一个参数是事件名   第二个参数是要绑定的控件  第三个是回调函数
    $(document).on("click",".edit_btn",function () {
        //alert("编辑按钮");

        //编辑按钮的时候加载部门列表   修改getDepts方法动态传入节点对象
        getDepts("#empUpdateModal select");

        //查询员工信息,显示员工信息
        getEmp($(this).attr("edit_id"));//获取当前对象的id的自定义属性值


        //3.把员工的ID传递给模态框的更新按钮
        $("#emp_update").attr("edit_id",$(this).attr("edit_id"));


        //弹出员工修改模态框
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });


    //获取员工信息
    function getEmp(id) {
        $("#empName_update_static").empty();
        //alert(id)
        $.ajax({
            url:"${pageContext.request.contextPath}/emp",
            type:"GET",
            data:"id="+id,
            success:function (result) {
                console.log(result);

                //添加内容到p标签之间的内容   或者是 .text(data)
                $("#empName_update_static").append(result.extend.emp.empName);

                //填充到input标签里面的内容
                $("#email_update_input").val(result.extend.emp.email);

                //填充单选框按钮的值
                $("#empUpdateModal input[name=gender]").val([result.extend.emp.gender]);
                //填充下拉列表数据
                $("#empUpdateModal select").val([result.extend.emp.department.deptId]);

            }
        });
    }


    //点击更新,更新员工信息
    $("#emp_update").click(function () {
        //验证邮箱是否合法
        //1.验证邮箱信息
        /*var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,9})$/;
        if(!regEmail.test(email)){
            show_validate_msg("#email_update_input", "error", "js邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_update_input", "success", "");
            return true;
        }*/

        //alert(111)

        //2.发送ajax请求,保存员工数据
        $.ajax({
            url:"${pageContext.request.contextPath}/emp/"+$(this).attr("edit_id"),
            data:$("#empUpdateModal form").serialize(),//模态框表格数据序列化
            type:"PUT",
            success:function (result) {
                console.log(result);

                //关闭模态框
                $("#empUpdateModal").modal('hide');

                //回到当前页
                to_page(currentNum);
            }
        });
    });


    //单个删除
    $(document).on("click",".delete_btn",function () {
        //弹出是否删除对话框
        //找到tr下面的第二个td元素下标是1
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        //alert(empName);

        var empId = $(this).attr("del_id");
        if (confirm("确认删除["+empName+"]吗?")) {
            //确认的话发送ajax请求
            $.ajax({
                url:"${pageContext.request.contextPath}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    //回到本页
                    to_page(currentNum);
                }
            });
        }

    });
    
    //完成全选/全不选
    $("#check_all").click(function () {
        //attr获取checked是undefined,这些是dom原生的属性
        //attr一般是获取我们自定义的属性;
        //prop一般是做修改和读取dom原生属性的值
        alert($(this).prop("checked"));//true/false
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    $(document).on("click","check_item",function () {
        //判断当前选中的元素是否是选满
        alert($(".check_item:checked").length);

        //如果check_item 选中的长度等于所有的check_item长度
        var flag = $(".check_item:checked").length == $(".check_item").length;

        $("#check_all").prop("checked",flag);
    });

    //点击全部删除,就批量删除
    $("#emp_delete_all").click(function () {

        var empName="";//员工姓名
        var del_idstr = "";//删除id

        //遍历获取 选中的员工名字
        $.each($(".check_item:checked"),function () {
            empName += $(this).parent("tr").find("td:eq(2)").text()+",";

            //组装员工id字符串
            del_idstr += $(this).parent("tr").find("td:eq(1)").text()+"-";
        });

        //去除empNames多余的,
        empNames = empNames.substr(0,empNames.length-1);

        //去除员工id多余的-
        del_idstr = empNames.substr(0,del_idstr.length-1);

        //弹出确认框
        if (confirm("确认删除["+empNames+"]吗?")){
            //发送ajax请求
            $.ajax({
                url:"${pageContext.request.contextPath}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    //弹出处理信息
                    alert(result.msg);

                    //回到当前页面
                    to_page(currentNum);
                }
            })
        }
    })

</script>
</body>
</html>