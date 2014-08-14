<%@page import="com.sy.shopping.util.*"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
 <%@ page import="java.sql.*,com.sy.shopping.*,java.util.*" %>
 
 <%@ include file="_sessioncheck.jsp"%>    
 
 <%
 //get all users
List<Category> cs=Category.getCategories();
 
 %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>

<table border="1"  align="center">


  <tr>
    <td>ID</td>
    <td>NAME</td>
    <td>pid</td>
    <td>grade</td>
    <td></td>
 
  </tr>
  <%
  for(Iterator<Category> it=cs.iterator();it.hasNext ();){
    Category c=it.next ();
    String preStr="";
    for(int i=1;i<c.getGrade ();i++){
      preStr+="--";
    }
    %>
    
    <tr>
      <td id="001"><%=c.getId () %></td>
      <td id="002"><%=preStr+c.getName() %></td>
      <td id="003"><%=c.getPid ()%></td>
      <td id="004"><%=c.getGrade ()%></td>
      <td>
      <a href="categoryadd.jsp?pid=<%=c.getId()%>">添加子类别</a></td>
    </tr>  
    
    
    <%
    
  }
  %>
  
</table>

</body>
</html>