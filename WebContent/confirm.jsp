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
  out.println ("������û�е�¼�������ȷ�ϼ������򣬰��г��ۡ� <a href=register.jsp>ע��</a> ����ѵġ���Ա���д����Żݣ���");
  //out.println ("<a href=confirmusenormal.jsp>����</a>");
  out.println ("<a href=login.jsp>��¼</a>");
}
%>

<!-- get attribute from session 2 -->
  
<jsp:useBean id="cart" class="com.sy.shopping.Cart" scope="session"></jsp:useBean>
 
<table border=1 align="center">
  <tr>
    <td>��ƷID</td>
    <td>��Ʒ����</td>
    <td>��Ʒ�۸�<%= (u==null)?"(�г���)":"(��Ա��)" %></td>
    <td>��������</td>
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
��<%=Math.round (cart.getTotalPrice ()*100)/100.0 %>Ԫ
<%
if(u!=null){
  %>
��ӭ��<%=u.getUsername () %>,��ȷ�������ͻ���Ϣ <br />
  <%
}
%>
<form action="order.jsp" method="post">
�ͻ���Ϣ<br />  
<textarea name="addr" id="" cols="30" rows="5"><%=(u==null)?"":u.getAddr () %></textarea>
<input type="submit" value="�µ�" />
</form>

</center>


