<%@page import="java.util.*"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>

<%@ page import="com.sy.shopping.util.*" %>
<%@ include file="_sessioncheck.jsp"%>    

<%
List<Category> cs=Category.getCategories ();
%>

<%

request.setCharacterEncoding ("gb2312");
String action=request.getParameter ("action");

//ch eck if it is the first link or a submit
if(action!=null && action.equalsIgnoreCase ("add")){
String name=request.getParameter ("name");
String descr=request.getParameter ("descr");
double normalprice=Double.parseDouble (request.getParameter ("normalprice"));
double memberprice=Double.parseDouble (request.getParameter ("memberprice"));
int categoryId=Integer.parseInt (request.getParameter ("categoryid"));

if(!Category.isLeaf (categoryId)){
  out.println ("can only add pruduct under leaf!");
}

Product p=new Product();
p.setId (-1);
p.setName (name);
p.setDescr (descr);
p.setNormalPrice (normalprice);
p.setMemberPrice (memberprice);
p.setCategoryid (categoryId);
p.setPdate (new Timestamp(System.currentTimeMillis ()));


ProductMgr.getInstance ().addProduct (p);
out.println ("add rooot category success!");
 

 
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>添加根类别</title>
</head>
<body>

<form action="productadd.jsp" method="post">
<input type="hidden" name="action" value="add" />
  <table>
  	<tr>
  		<td>name：</td>
  		<td><input type="text" name="name" />
  		</td>
  	</tr>
  	<tr>
  		<td>descr：</td>
  		<td>
  		<textarea  name="descr" > </textarea>
  		</td>
  	</tr>
  	<tr>
  		<td>norml price：</td>
  	<td><input type="text" name="normalprice" />
  		</td>
  	</tr>
  	<tr>
  		<td>member price：</td>
  	<td><input type="text" name="memberprice" />
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
      <option value="<%=c.getId ()%>" <%=String.valueOf (c.getId ()).equals (request.getParameter ("categoryid"))?"selected":"" %> > <%=preStr+c.getName() %> </option>
      
      <%
      
    }
    %>
    </select>
  		</td>
  	</tr>
 
  	<tr>
  		<td></td>
  		<td><input type="submit" value="提交"/>
  		</td>
  	</tr>
  	
  </table>
</form>

</body>
</html>