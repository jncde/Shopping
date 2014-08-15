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
<script language="javascript" src="script/TV20.js"></script>
<script>
function t(key,parentkey){
  document.forms["form"].pid.value=key;
}


function modify(key,parentkey){
  window.parent.frames["detail"].location.href="categorymodify.jsp?id="+key;
}
</script>

<title>Insert title here</title>

</head>
<body>

<form name="form" action="categoryadd.jsp" method="post">
	<input type="hidden" name="action" value="add" />
<table align="center" border="1">
<tr>
  <td id="show" colspan="2"></td>
</tr>
<tr>
	<td>
	<label for="pid">pid:</label>
 
</td>
	<td>
  <input type="text" name="pid" value="" readonly/> 
</td>
</tr>
<tr>
	<td>
  <label for="name">name:</label>
</td>
	<td>
  <input type="text" name="name" />
</td>
</tr>
<tr>
	<td>
  <label for="descr">Description:</label>
</td>
	<td>
  <input type="text" name="descr" /><br />  
</td>
</tr>
<tr>
	<td>
</td>
	<td>
  <input type="submit" value="提交" />
</td>
</tr>
	
</table>
  </form>


<script language="javascript">
 
addNode(-1,0,"所有类别","images/top.gif");
<%
for(Iterator<Category> it=cs.iterator ();it.hasNext (); ){
  Category c=it.next();
  %>
  addNode(<%=c.getPid ()%>,<%=c.getId ()%>,"<%=c.getName ()%>","images/top.gif");
  <%
}
%>
  
  showTV();
  addListener("click","t");
  addListener("dblclick","modify");
 
</script>

</body>




</html>