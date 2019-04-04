<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%--<jsp:forward page="/emps"></jsp:forward>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%--引入jquery--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.12.4.min.js"></script>
<%--引入样式--%>
<link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<button class="btn btn-success">按钮</button>
<br><br>
<a href="${pageContext.request.contextPath}/emps">获取所有员工</a><br>

<a href="${pageContext.request.contextPath}/empsWithJson">获取所有员工JSON数据</a><br><br>

<a href="${pageContext.request.contextPath}/emp">获取1个EmpJson数据</a><br><br>

<a href="${pageContext.request.contextPath}/index_json.jsp">Json数据页面</a><br><br>
<a href="${pageContext.request.contextPath}/index_json_KendoUI.jsp">KendoUIJson数据页面</a><br><br>


</body>
</html>