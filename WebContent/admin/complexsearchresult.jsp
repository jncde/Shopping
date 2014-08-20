<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.sy.shopping.util.*" %>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.*"%>
<%@ include file="_sessioncheck.jsp"%>
<%

List<Category> cs = Category.getCategories ();

request.setCharacterEncoding ("gb2312");
String action = request.getParameter ("action");
List<Product>  products = new ArrayList<Product> ();
int pageCount = 0;
double lowNormalPrice = -1;
double highNormalPrice = -1;
double lowMemberPrice = -1;
double highMemberPrice = -1;
int pageNo = 1;
String keyword = "";
String strStartDate = null;
String strEndDate = null;
int categoryId = 0;
String strCategoryIdQuery="";


String strPageno = request.getParameter ("pageno");
if (strPageno != null && !strPageno.isEmpty ()) {
  pageNo = Integer.parseInt (strPageno);
  if (pageNo < 1) {
    pageNo = 1;
  }
}

keyword = request.getParameter ("keyword");
if(keyword==null){
  keyword="";
}

lowNormalPrice = Double.parseDouble (request.getParameter ("lownormalprice"));
highNormalPrice = Double.parseDouble (request.getParameter ("highnormalprice"));
lowMemberPrice = Double.parseDouble (request.getParameter ("lowmemberprice"));
highMemberPrice = Double.parseDouble (request.getParameter ("highmemberprice"));
categoryId = Integer.parseInt (request.getParameter ("categoryid"));
int[] idArray = null;
if (categoryId == 0) {
  idArray = null;
} else {
  idArray = new int[1];
  idArray[0] = categoryId;
}

strStartDate = request.getParameter ("startdate");
Timestamp startDate = null;
if (strStartDate == null || strStartDate.equals ("")) {
} else {
  startDate = Timestamp.valueOf (strStartDate);
}
strEndDate = request.getParameter ("enddate");
Timestamp endDate = null;
if (strEndDate == null || strEndDate.isEmpty ()) {
} else {
  endDate = Timestamp.valueOf (strEndDate);
}


pageCount = ProductMgr.getInstance ().findProducts (products,
                                                    idArray,
                                                    keyword,
                                                    lowNormalPrice,
                                                    highNormalPrice,
                                                    lowMemberPrice,
                                                    highMemberPrice,
                                                    startDate,
                                                    endDate,
                                                    pageNo,
                                                    3);

%>


<%
if(products!=null&&products.size ()>0){
%>
<!-- 显示处理结果 -->
<center>搜索结果</center>
<table border="1" align="center">
   <tr>
    <td>ID</td>
    <td>name</td>
    <td>description</td>
    <td>normal price</td>
    <td>member price</td>
    <td>pdate</td>
    <td>categoryid</td>
    <td></td>
    <td></td>
  </tr>
  <%
  for(Iterator<Product> it=products.iterator();it.hasNext ();){
    Product p=it.next ();
    %>
    
    <tr>
      <td id="001"><%=p.getId ()%></td>
      <td id="002"><%=p.getName ()%></td>
      <td id="003"><%=p.getDescr ()%></td>
      <td id="004"><%=p.getNormalPrice ()%></td>
      <td id="005"><%=p.getMemberPrice ()%></td>
      <td id="006"><%=p.getPdate ()%></td>
      <td id="007"><%=p.getCategoryid ()%></td>
      <td id="008"><a href="productdelete.jsp?id=<%=p.getId() %>" target="detail">Delete</a></td>
      <td id="008"><a href="productModify.jsp?id=<%=p.getId() %>" target="detail">Modify</a></td>
    </tr>  
    
    
    <%
    
  }
  %>
  
</table>
<center>

  <a href="productsearch.jsp?action=<%=action%>&keyword=<%=keyword%>&lownormalprice=<%=lowNormalPrice%>&highnormalprice=<%=highNormalPrice%>&lowmemberprice=<%=lowMemberPrice%>&highmemberprice=<%=highMemberPrice%>&startdate=<%=strStartDate%>&enddate=<%=strEndDate%>&categoryid=<%=categoryId%>&pageno=<%=pageNo - 1%>">上一页</a>
  共<%=pageCount%>页 
  <a href="productsearch.jsp?action=<%=action%>&keyword=<%=keyword%>&lownormalprice=<%=lowNormalPrice%>&highnormalprice=<%=highNormalPrice%>&lowmemberprice=<%=lowMemberPrice%>&highmemberprice=<%=highMemberPrice%>&startdate=<%=strStartDate%>&enddate=<%=strEndDate%>&categoryid=<%=categoryId%>&pageno=<%=pageNo + 1%>">下一页</a>
</center>
<!-- 显示处理结果 -->
<%
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
</head>
<body>

</body>
</html>