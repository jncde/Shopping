<%@page import="com.sy.shopping.util.ProductMgr"%>
<%@page import="com.sy.shopping.util.User"%>
<%@page import="com.sy.shopping.util.Product"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
 <%@ page import="java.sql.*,com.sy.shopping.*,java.util.*" %>
 
 <%@ include file="_sessioncheck.jsp"%>    
 
 <%!
 private static final int PAGE_SIZE=3;
 %>
 
 <%
 
 String strPageNo=request.getParameter ("pageno");
 int pageNo=1;
 
 if(strPageNo!=null){
   pageNo=Integer.parseInt (strPageNo);
 }
 
 if(pageNo<1) pageNo=1;
 
 //get all users
List<Product> ps=new ArrayList<Product>();
int pageSize=ProductMgr.getInstance ().getProducts (ps,pageNo,PAGE_SIZE);
if(pageNo>pageSize) pageNo=pageSize;


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
		<td>name</td>
		<td>description</td>
		<td>normal price</td>
		<td>member price</td>
		<td>pdate</td>
		<td>categoryname</td>
		<td></td>
		<td></td>
	</tr>
	<%
	for(Iterator<Product> it=ps.iterator();it.hasNext ();){
	  Product p=it.next ();
	  %>
	  
	  <tr>
	  	<td id="001"><%=p.getId ()%></td>
	  	<td id="002"><%=p.getName ()%></td>
	  	<td id="003"><%=p.getDescr ()%></td>
	  	<td id="004"><%=p.getNormalPrice ()%></td>
	  	<td id="005"><%=p.getMemberPrice ()%></td>
	  	<td id="006"><%=p.getPdate ()%></td>
	  	<td id="007"><%=p.getCategory ().getName ()%></td>
	  	<td id="008"><a href="productdelete.jsp?id=<%=p.getId() %>" target="detail">Delete</a></td>
	  	<td id="008"><a href="productModify.jsp?id=<%=p.getId() %>" target="detail">Modify</a></td>
	  </tr>  
	  
	  
	  <%
	  
	}
	%>
	
</table>
<center>第<%=pageNo %>页
  &nbsp;
共<%=pageSize%>页
  &nbsp;
  <a href="productlist.jsp?pageno=<%=pageNo-1%>">上一页</a>
    &nbsp;
  <a href="productlist.jsp?pageno=<%=pageNo+1%>">下一页</a>
    &nbsp;
  <a href="productlist.jsp?pageno=<%=pageSize%>">最后一页</a>
</center>

</body>
</html>