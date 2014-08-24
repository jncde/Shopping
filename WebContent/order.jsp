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
<jsp:useBean id="user" class="com.sy.shopping.util.User" scope="session"></jsp:useBean>
 
 <%

if(cart==null){
  out.println("没有购物车");
  return;
}
 
 
 if(user==null){
   user=new User();
   user.setId (-1);
 }
 
 %>
 
<%
String addr=request.getParameter ("addr");
SalesOrder so=new SalesOrder();
so.setAddr (addr);
so.setCart (cart);
so.setUser (user);
so.setoDate (new Timestamp(System.currentTimeMillis ()));
//status 0 mean: new order
so.setStatus (0);
so.save ();

session.removeAttribute ("cart");



%>

<center>  your order is processed! welcome again! you will be redirected to hoe page in 3 seconds!</center>

<div id="number"></div>

<script type="text/javascript">
<!--
var leftTime=3000;
function go(){
  leftTime-=1000;
  document.getElementById("number").innerText=leftTime;
  if(leftTime<=0){
  document.location.href="index.jsp";
  }
}
setInterval(go,1000);

//-->
</script>

