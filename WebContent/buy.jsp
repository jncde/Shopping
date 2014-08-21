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
  cart=new Cart();
  session.setAttribute ("cart", cart);
}
 
--%>

<!-- get attribute from session 2 -->
  
<jsp:useBean id="cart" class="com.sy.shopping.Cart" scope="session"></jsp:useBean>
 
<%
request.setCharacterEncoding ("gb2312");
int id=Integer.parseInt (request.getParameter ("id"));
Product p=ProductMgr.getInstance ().loadProductById (id);
CartItem ci=new CartItem();
ci.setProductId (id);
ci.setPrice (p.getNormalPrice ());
ci.setCount(1);
cart.add (ci);
response.sendRedirect ("cart.jsp");


%>
