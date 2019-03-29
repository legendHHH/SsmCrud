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
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
        <!-- 显示表格数据 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <td>${emp.empId}</td>
                            <td>${emp.empName}</td>
                            <td>${emp.gender=="M"?"男":"女" }</td>
                            <td>${emp.email }</td>
                            <td>${emp.department.deptName }</td>
                            <td>
                                <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
        <!-- 显示分页信息 -->
        <div class="row">
            <!--分页文字-->
            <div class="col-md-6">
                当前${pageInfo.pageNum}页,总${pageInfo.pages}页,总${pageInfo.total}条记录
            </div>

            <!--分页条信息-->
            <div class="col-md-6">
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                        <li> <a href="${pageContext.request.contextPath}/emps?pn=1">首页</a></li>

                        <!--如果有上一页就显示上一页-->
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <!--上一页-->
                            <li><a href="${pageContext.request.contextPath}/emps?pn=${pageInfo.pageNum-1}"
                                   aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
                            </a></li>
                        </c:if>

                        <!--导航页码数navigatepageNums-->
                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                            <%--如果是当前页--%>
                            <c:if test="${page_num ==pageInfo.pageNum}">
                                <li class="active"><a href="#">${page_num}</a></li>
                            </c:if>

                            <c:if test="${page_num !=pageInfo.pageNum}">
                                <li><a href="${pageContext.request.contextPath}/emps?pn=${page_num}">${page_num}</a></li>
                            </c:if>
                        </c:forEach>

                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${pageContext.request.contextPath}/emps?pn=${pageInfo.pageNum+1 }" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <!--pages总页数-->
                        <li><a href="${pageContext.request.contextPath}/emps?pn=${pageInfo.pages}">末页</a> </li>
                    </ul>
                </nav>
            </div>
        </div>
            </div>
        </div>
    </div>


</body>
</html>