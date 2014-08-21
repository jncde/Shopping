<%@page import="java.util.*"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>

<%@ page import="com.sy.shopping.util.*" %>


<%
request.setCharacterEncoding ("gb2312");
int id=Integer.parseInt (request.getParameter ("id"));
Product p=ProductMgr.getInstance ().loadProductById (id);
List<Category> cs=Category.getCategories ();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>参评展示</title>
</head>
<body>

<form action="buy.jsp" method="post">
  <table>
  	<tr>
  		<td>产品图片：</td>
  		<td> <img src="css/images/big1.jpg" alt="" />
  		</td>
  	</tr>
  	<tr>
  		<td>ID：</td>
  		<td><input type="text" name="id" value="<%=p.getId ()%>"/>
  		</td>
  	</tr>
  	<tr>
  		<td>name：</td>
  		<td><input type="text" name="name" value="<%=p.getName ()%>"/>
  		</td>
  	</tr>
  	<tr>
  		<td>descr：</td>
  		<td>
  		<textarea  name="descr" > <%=p.getDescr()%></textarea>
  		</td>
  	</tr>
  	<tr>
  		<td>norml price：</td>
  	<td><input type="text" name="normalprice" value="<%=p.getNormalPrice ()%>"/>
  		</td>
  	</tr>
  	<tr>
  		<td>member price：</td>
  	<td><input type="text" name="memberprice" value="<%=p.getMemberPrice()%>"/>
  		</td>
  	</tr>
  	<tr>
  		<td>类别ID：</td>
  		<td>
  		<select name="categoryid" >
    <option value="0">所有类别</option>
    <%

    for(Iterator<Category> it=cs.iterator ();it.hasNext ();){
      Category c=it.next ();
      String preStr="";
      for(int i=1;i<c.getGrade ();i++){
        preStr+="--";
      }
      
      %>
      <option value="<%=c.getId ()%>" <%= c.getId ()==p.getCategoryid ()?"selected":"" %> > <%=preStr+c.getName() %> </option>
      <%
      
    }
    %>
    </select>
  		</td>
  	</tr>
 
  	<tr>
  		<td></td>
  		<td><input type="submit" value="买"/>
  		</td>
  	</tr>
  	
  </table>
</form>

</body>
</html>