<%@page import="javax.imageio.spi.RegisterableService"%>
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

<%
User u=(User)session.getAttribute ("user");
if(u==null){
  out.println ("你现在没有登录，如果你确认继续购买，按市场价。 <a href=register.jsp>注册</a> 是免费的。会员享有打折优惠！！");
  //out.println ("<a href=confirmusenormal.jsp>继续</a>");
  out.println ("<a href=login.jsp>登录</a>");
}
%>

<!-- get attribute from session 2 -->
  
<jsp:useBean id="cart" class="com.sy.shopping.Cart" scope="session"></jsp:useBean>
 
<table border=1 align="center">
  <tr>
    <td>商品ID</td>
    <td>商品名称</td>
    <td>商品价格<%= (u==null)?"(市场价)":"(会员价)" %></td>
    <td>购买数量</td>
    <td></td>
  </tr>
  
  <%
  List<CartItem> items=cart.getItems ();
  for(int i=0;i<items.size ();i++){
    CartItem ci=items.get (i);
    Product p=ProductMgr.getInstance ().loadProductById (ci.getProductId ());
    %>
        <tr>
          <td><%=ci.getProductId () %></td>
          <td><%=ProductMgr.getInstance ().loadProductById (ci.getProductId ()).getName () %></td>
          <td><%=(u==null)?p.getNormalPrice ():p.getMemberPrice () %></td>
          <td>  <%=ci.getCount () %></td>
          <td>
        
          </td>
        </tr>
    <%
  }
  
  %>
  
</table>
<center>
共<%=Math.round (cart.getTotalPrice ()*100)/100.0 %>元
<%
if(u!=null){
  %>
欢迎你<%=u.getUsername () %>,请确认您的送货信息 <br />
  <%
}
%>
<form action="order.jsp" method="post">
送货信息<br />  
<textarea name="addr" id="" cols="30" rows="5"><%=(u==null)?"":u.getAddr () %></textarea>
<input type="submit" value="下单" />
</form>

</center>


