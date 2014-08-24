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
List<SalesOrder> orders=new ArrayList<SalesOrder>();
int pageSize=OrderMgr.getInstance ().getOrders (orders,pageNo,PAGE_SIZE);
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
		<td>User name</td>
		<td>address</td>
		<td>order date</td>
		<td>order status</td>
		<td></td>
	</tr>
	<%
	for(Iterator<SalesOrder> it=orders.iterator();it.hasNext ();){
	  SalesOrder so=it.next ();
	  %>
	  
	  <tr>
	  	<td id="001"><%=so.getId ()%></td>
	  	<td id="002"><%=so.getUser ().getUsername ()%></td>
	  	<td id="003"><%=so.getAddr ()%></td>
	  	<td id="004"><%=so.getoDate ()%></td>
	  	<td id="005"><%=so.getStatus ()%></td>
	  	<td id="008"><a href="orderdetailshow.jsp?id=<%=so.getId() %>" target="detail">订单明细</a></td>
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