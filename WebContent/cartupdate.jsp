<%@page import="com.sy.shopping.CartItem"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>

<%@ page import="com.sy.shopping.util.*" %>
<%@ page import="com.sy.shopping.*" %>





<!-- get attribute from session 2 -->
 
<jsp:useBean id="cart" class="com.sy.shopping.Cart" scope="session"></jsp:useBean>


<%

if(cart == null){
  out.println("没有购物车");
  return;
}

List<CartItem> items=cart.getItems ();
for(int i=0;i<items.size ();i++){
  CartItem ci=items.get(i);
  String strCount=request.getParameter ("p"+ci.getProductId ());
  
  if(strCount!=null && !strCount.trim ().isEmpty ()){
    int count=Integer.parseInt (strCount);
    ci.setCount (count);
  }
  
}


%>
 <center>修改成功</center>
 三秒钟后自动重定向
 
 <div id="number"></div>
 
 <script type="text/javascript">
<!--
var leftTime=3000;
function go(){
  leftTime-=1000;
  document.getElementById("number").innerText=leftTime;
  if(leftTime<=0){
  document.location.href="cart.jsp";
  }
}
setInterval(go,1000);

//-->
</script>
 
