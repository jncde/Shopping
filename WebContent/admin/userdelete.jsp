<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>

<%@ page import="com.sy.shopping.util.*" %>
<%
String id=request.getParameter ("id");
Boolean isSuccess=UserManager.deleteUser (id);

if(isSuccess){
  %>
  <div>删除成功！</div>
  <%
}else{
  %>
  <div>删除失败！</div>
  <%
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>

</body>
</html>