<%@page import="com.sy.shopping.CartItem"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>

<%@ page import="com.sy.shopping.util.*" %>
<%@ page import="com.sy.shopping.*" %>



<%--
//check session to see if there's a cart in it
//get attribute from session 1
 
Cart cart=(Cart)session.getAttribute ("cart");
if(cart==null){
  out.println("没有购物车");
  return;
}
 
--%>

<!-- get attribute from session 2 -->
 
<jsp:useBean id="cart" class="com.sy.shopping.Cart" scope="session"></jsp:useBean>
 
<center>你一用买了这么多的商品</center>
<form action="cartupdate.jsp" method="post">
<table border=1 align="center">
	<tr>
		<td>商品ID</td>
		<td>商品名称</td>
		<td>商品价格</td>
		<td>购买数量</td>
		<td></td>
	</tr>
	
	<%
	List<CartItem> items=cart.getItems ();
	for(int i=0;i<items.size ();i++){
	  CartItem ci=items.get (i);
	  %>
        <tr>
        	<td><%=ci.getProductId () %></td>
        	<td><%=ProductMgr.getInstance ().loadProductById (ci.getProductId ()).getName () %></td>
        	<td><%=ci.getPrice () %></td>
        	<td> <input type="text" size=4 name="<%="p"+ci.getProductId () %>"  value="<%=ci.getCount () %>"/> </td>
        	<td>
        
        	</td>
        </tr>
	  <%
	}
	
	%>
	
</table>
<center>
共<%=Math.round (cart.getTotalPrice ()*100)/100.0 %>元
<input type="submit"  value="修改数量"/>
<input type="button"  value="确认订单" onclick="document.location.href='confirm.jsp'"/>
</center>

</form>