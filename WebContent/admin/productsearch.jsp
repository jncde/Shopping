<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=GB18030" pageEncoding="GB18030"%>

<%@ page import="com.sy.shopping.util.*"%>
<%@ include file="_sessioncheck.jsp"%>

<%
  List<Category> cs = Category.getCategories ();
%>

<%
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

  //ch eck if it is the first link or a submit
  if (action != null && action.equalsIgnoreCase ("complexsearch")) {

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

  }

  //处理简单搜索
  if (action != null && action.equalsIgnoreCase ("simplesearch2")) {

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
    
    String[] strCategoryIds = request.getParameterValues ("categoryid");
    int[] idArray = null;
    if (strCategoryIds == null || strCategoryIds.length == 0) {
      idArray = null;
    } else {
      idArray = new int[strCategoryIds.length];
      for (int i = 0; i < strCategoryIds.length; i++) {
        idArray[i] = Integer.parseInt (strCategoryIds[i]);
      }
      
      for (int i = 0; i < strCategoryIds.length; i++) {
        strCategoryIdQuery+="&categoryid="+strCategoryIds[i];
      }
      
      
      
      
     
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

    products = new ArrayList<Product> ();
    pageCount = ProductMgr.getInstance ().findProducts (products,
                                                        idArray,
                                                        keyword,
                                                        -1,
                                                        -1,
                                                        -1,
                                                        -1,
                                                        null,
                                                        null,
                                                        pageNo,
                                                        3);
  }
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

<%
if(action != null && action.equalsIgnoreCase ("complexsearch")){
%>
	<a href="productsearch.jsp?action=<%=action%>&keyword=<%=keyword%>&lownormalprice=<%=lowNormalPrice%>&highnormalprice=<%=highNormalPrice%>&lowmemberprice=<%=lowMemberPrice%>&highmemberprice=<%=highMemberPrice%>&startdate=<%=strStartDate%>&enddate=<%=strEndDate%>&categoryid=<%=categoryId%>&pageno=<%=pageNo - 1%>">上一页</a>
	共<%=pageCount%>页 
	<a href="productsearch.jsp?action=<%=action%>&keyword=<%=keyword%>&lownormalprice=<%=lowNormalPrice%>&highnormalprice=<%=highNormalPrice%>&lowmemberprice=<%=lowMemberPrice%>&highmemberprice=<%=highMemberPrice%>&startdate=<%=strStartDate%>&enddate=<%=strEndDate%>&categoryid=<%=categoryId%>&pageno=<%=pageNo + 1%>">下一页</a>
	<%
}

if(action != null && action.equalsIgnoreCase ("simplesearch2")){
  //TODO:
%>
  <a href="productsearch.jsp?action=<%=action%>&keyword=<%=keyword%>&pageno=<%=pageNo - 1%><%=strCategoryIdQuery%>">上一页</a>
  共<%=pageCount%>页 
  <a href="productsearch.jsp?action=<%=action%>&keyword=<%=keyword%>&pageno=<%=pageNo + 1%><%=strCategoryIdQuery%>">下一页</a>
  <%
}

%>
	
</center>
<!-- 显示处理结果 -->
<%
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>添加根类别</title>
<script>
  function checkdata () {
    with (document.forms["complex"]) {
      if (lownormalprice.value == null || lownormalprice.value == "") {
        lownormalprice.value = -1;
      }
      if (highnormalprice.value == null || highnormalprice.value == "") {
        highnormalprice.value = -1;
      }
      if (lowmemberprice.value == null || lowmemberprice.value == "") {
        lowmemberprice.value = -1;
      }
      if (highmemberprice.value == null || highmemberprice.value == "") {
        highmemberprice.value = -1;
      }
    }

  }
</script>
</head>
<body>
	<center>简单搜索</center>
	<form action="productsearch.jsp" method="post">
		<input type="hidden" name="action" value="simplesearch" /> 类别：<select name="" id=""></select> 关键字：<input type="text" name="name" /> <input
			type="submit" value="搜" />
	</form>

	<center>第二种搜索</center>
	<form action="productsearch.jsp" method="post">
		<input type="hidden" name="action" value="simplesearch2" /> 类别：
		<%
		  for (Iterator<Category> it = cs.iterator (); it.hasNext ();) {
		    Category c = it.next ();
		    if (c.isLeaf ()) {
		%>
		<input type="checkbox" name="categoryid" value="<%=c.getId ()%>"><%=c.getName ()%></input>

		<%
		    }
		  }
		%>
		<br /> 关键字：<input type="text" name="name" /> 
		<input type="submit" value="搜" />
	</form>

	<center>复杂搜索</center>
	<form action="productsearch.jsp" method="post" onsubmit="checkdata()" name="complex">
		<input type="hidden" name="action" value="complexsearch" />


		<table>
			<tr>
				<td>category:</td>
				<td><select name="categoryid">
						<option value="0">所有类别</option>
						<%
						  for (Iterator<Category> it = cs.iterator (); it.hasNext ();) {
						    Category c = it.next ();
						    String preStr = "";
						    for (int i = 1; i < c.getGrade (); i++) {
						      preStr += "--";
						    }
						%>
						<option value="<%=c.getId ()%>"><%=preStr + c.getName ()%></option>
			     <%
              }
            %>
				</select></td>
			</tr>
			<tr>
				<td>关键字：</td>
				<td><input type="text" name="keyword" /></td>
			</tr>
			<tr>
				<td>normal price：</td>
				<td>From:<input type="text" name="lownormalprice" />
				</td>
				<td>To: <input type="text" name="highnormalprice" />
				</td>
			</tr>
			<tr>
				<td>member price：</td>
				<td>From:<input type="text" name="lowmemberprice" />
				</td>
				<td>To: <input type="text" name="highmemberprice" />
				</td>
			</tr>
			<tr>
				<td>Pdate：</td>
				<td>From:<input type="text" name="startdate" />
				</td>
				<td>To: <input type="text" name="enddate" />
				</td>
			</tr>

			<tr>
				<td><input type="submit" value="搜" /></td>
			</tr>

		</table>
	</form>

</body>
</html>