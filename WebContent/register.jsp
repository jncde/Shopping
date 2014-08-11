<%@page import="com.sy.shopping.util.User"%>
<%@ page language="java" contentType="text/html; charset=GB18030" import="com.sy.shopping.*"    pageEncoding="GB18030"%>
    
    
 <%
 request.setCharacterEncoding ("GB18030");
String action=request.getParameter ("action");
//check if it is the first link or a submit
if(action!=null && action.equalsIgnoreCase ("register")){
  String username=request.getParameter ("username");
  String password=request.getParameter ("password");
  String phone=request.getParameter ("phone");
  String addr=request.getParameter ("addr");
  User u=new User();
  u.setUsername (username);
  u.setPassword (password);
  u.setPhone (phone);
  u.setAddr (addr);
  u.setRdate (new java.util.Date(System.currentTimeMillis ()));
  u.save();
  %>
  <center>RegisterOK! Thankyou!</center>
  <%
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

<form name = "form" action = "register.jsp" method = "post"  onSubmit = "return checkdata()">
  <input type="hidden" name="action" value="register"/>
  <table border = 1 align = "center" width="80%">
    <tr>
    <img src="images/table.jpg" width="1065" height="118" />    </tr>
    <tr>
      <th  colspan = 2 align = "center">用户注册</th>
    </tr>
    <tr>
      <td width="30%" height="31" >用户名：</td>
      <td valign="bottom">
        <input name = "username" type="text" onblur = "checkUserName(this.value.toLowerCase())">
        <!--<div id = "usernameErr"></div>-->
        <span id = "usernameErr"></span>
    </td>
    </tr>
    <tr>
      <td width="30%" height="39" >密码： </td>
      <td>
        <input type="password" name = "pwd" >
        <span id = "pwdErr"></span>
    </td>
    </tr>
    <tr>
      <td width = "30%" height = "40" name = "pwd2">确认密码：</td>
      <td>
        <input type = "password" name = "pwd2">
        <span id = "pwdErr2"></span>
      </td>
    <tr>
    <td>电话：</td>
    <td>
    <input type="text" name="phone" size="20" />
      </td>
    </tr>
    <tr>
    <td>地址：</td>
    <td>
      <textarea name = "addr" cols = 50 rows = 12></textarea>
    </td>
    </tr>
    <tr>
    <td>
    <input type = "image" src="images/zhuce.gif" />
    <input type = "reset" value="重新填写"/>
    </td>
    </tr>
  </table>
  </form>

</body>
</html>