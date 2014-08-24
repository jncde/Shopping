<%@page import="com.sy.shopping.util.ProductMgr"%>
<%@page import="com.sy.shopping.util.User"%>
<%@page import="com.sy.shopping.util.Product"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
 <%@ page import="java.sql.*,com.sy.shopping.*,java.util.*" %>
 
 <%@ include file="_sessioncheck.jsp"%>    
 
 <%
        int id=Integer.parseInt(request.getParameter("id"));
       SalesOrder so=OrderMgr.getInstance ().loadById(id);
       List<SalesItem> sis=SalesItemMgr.getInstance ().getSalesItemsByOrderID (id);
%>
 <center> 
 下单人： <%=so.getUser ().getUsername () %> <br /> 
 明细： <br />
 
 
 
 <table border=1 align="center">
  <tr>
    <td>商品名称</td>
    <td>商品价格</td>
    <td>购买数量</td>
    <td></td>
  </tr>
  
  <%
  for(int i=0;i<sis.size ();i++){
    SalesItem  si=sis.get (i);
    %>
        <tr>
          <td><%=si.getProduct ().getName () %></td>
          <td><%=si.getUnitPrice () %></td>
          <td><%=si.getPcount () %></td>
          
        
          </td>
        </tr>
    <%
  }
  
  %>
  
</table>
 
 </center>