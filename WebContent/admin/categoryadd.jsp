<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>

<%@ page import="com.sy.shopping.util.*" %>
<%@ include file="_sessioncheck.jsp"%>    

<%

request.setCharacterEncoding ("gb2312");
String action=request.getParameter ("action");
String strPid=request.getParameter("pid");
int pid=0;
if(strPid!=null){
  pid=Integer.parseInt (strPid); 
}

//ch eck if it is the first link or a submit
if(action!=null && action.equalsIgnoreCase ("add")){
String name=request.getParameter ("name");
String descr=request.getParameter ("descr");
if(pid==0){
  Category.addTopCategory (name,descr);
  out.println ("add rooot category success!");
}else{
  Category.addChildCategory(pid,name,descr); 
  out.println ("add Child category to father(id:"+pid+") success!");
}

 
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>添加根类别</title>
</head>
<body>

<form action="categoryadd.jsp" method="post">
<input type="hidden" name="action" value="add" />
<input type="hidden" name="pid" value="<%=pid %>" />
  <table>
  	<tr>
  		<td>类别名称：</td>
  		<td><input type="text" name="name" />
  		</td>
  	</tr>
  	<tr>
  		<td>类别描述：</td>
  		<td><textarea name="descr" cols="40" rows="8"></textarea>
  		</td>
  	</tr>
  	<tr>
  		<td>类别m名称：</td>
  		<td><input type="submit" value="提交"/>
  		</td>
  	</tr>
  	
  </table>
</form>

</body>
</html>