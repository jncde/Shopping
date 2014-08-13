<%@page import="com.sy.shopping.util.*"%>
<%@ page language="java" contentType="text/html; charset=GB18030" import="com.sy.shopping.*"    pageEncoding="GB18030"%>
    
    
 <%
User u=(User)session.getAttribute ("user");
 
if(u==null){
   out.println ("you haven't logged in");
   return;
 }

request.setCharacterEncoding ("GB18030");
String action=request.getParameter ("action");
//check if it is the first link or a submit
if(action!=null && action.equalsIgnoreCase ("modify")){
 String username=request.getParameter ("username");
 String phone=request.getParameter ("phone");
 String addr=request.getParameter ("addr");
 u.setUsername (username);
 u.setPhone (phone);
 u.setAddr (addr);
 u.update();
 out.println("Modify OK! Thankyou!");
}
 
 %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
<script type="text/javascript" src="script/regcheckdata.js"></script>
</head>
<body>

<form name = "form" action = "usermodify.jsp" method = "post"  onSubmit = "return checkdata()">
  <input type="hidden" name="action" value="modify"/>
  <table border = 1 align = "center" width="80%">
    <tr>
    <img src="images/table.jpg" width="1065" height="118" />    </tr>
    <tr>
      <th  colspan = 2 align = "center">用户修改</th>
    </tr>
    <tr>
      <td width="30%" height="31" >用户名：</td>
      <td valign="bottom">
        <input name = "username" type="text" onblur = "checkUserName(this.value.toLowerCase())" value=<%=u.getUsername () %> />
        <!--<div id = "usernameErr"></div>-->
        <span id = "usernameErr"></span>
    </td>
    </tr>
    <td>电话：</td>
    <td>
    <input type="text" name="phone" size="20" value=<%=u.getPhone () %> />
      </td>
    </tr>
    <tr>
    <td>地址：</td>
    <td>
      <textarea name = "addr" cols = 50 rows = 12><%=u.getAddr () %></textarea>
    </td>
    </tr>
    <tr>
    <td>
    <input type = "image" src="images/zhuce.gif" />
     <input type="submit" value="提交">
    <input type = "reset" value="重新填写"/>
    </td>
    </tr>
  </table>
  </form>

</body>
</html>