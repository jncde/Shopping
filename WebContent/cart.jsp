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
  out.println("û�й��ﳵ");
  return;
}
 
--%>

<!-- get attribute from session 2 -->
 
<jsp:useBean id="cart" class="com.sy.shopping.Cart" scope="session"></jsp:useBean>
 
<center>��һ��������ô�����Ʒ</center>
<form action="cartupdate.jsp" method="post">
<table border=1 align="center">
	<tr>
		<td>��ƷID</td>
		<td>��Ʒ����</td>
		<td>��Ʒ�۸�</td>
		<td>��������</td>
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
<center><input type="submit"  value="�޸�����"/></center>

</form>