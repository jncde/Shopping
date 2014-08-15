<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
    
<%@ page import="com.sy.shopping.util.*" %>
<%@ include file="_sessioncheck.jsp"%>    

 <%
 String id=request.getParameter ("id");
 
 if(id!=null&&!id.equals ("")){
   Category.deleteByid (id);
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