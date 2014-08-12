<%@page import="com.sy.shopping.util.User"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
 <%@ page import="java.sql.*,com.sy.shopping.*,java.util.*" %>
 
 <%@ include file="_sessioncheck.jsp"%>    
 
 <%
 //get all users
List<User> users=User.getUsers ();
 
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
		<td>USERNAME</td>
		<td>Password</td>
		<td>Phone</td>
		<td>Addr</td>
		<td>Rdate</td>
		<td>Modify</td>
	</tr>
	<%
	for(Iterator<User> it=users.iterator();it.hasNext ();){
	  User u=it.next ();
	  %>
	  
	  <tr>
	  	<td id="001"><%=u.getId () %></td>
	  	<td id="002"><%=u.getUsername() %></td>
	  	<td id="003"><%=u.getPassword ()%></td>
	  	<td id="004"><%=u.getPhone ()%></td>
	  	<td id="005"><%=u.getAddr ()%></td>
	  	<td id="006"><%=u.getRdate ()%></td>
	  	<td id="007"><a href="userdelete.jsp?id=<%=u.getId() %>" target="detail">Delete</a></td>
	  </tr>  
	  
	  
	  <%
	  
	}
	%>
	
</table>

</body>
</html>