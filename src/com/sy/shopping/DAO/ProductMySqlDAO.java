package com.sy.shopping.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.sy.shopping.util.Category;
import com.sy.shopping.util.DB;
import com.sy.shopping.util.Product;

public class ProductMySqlDAO implements ProductDAO {

  @Override
  public List<Product> getProducts () {
    List<Product> ps = new ArrayList<Product> ();
    Connection conn = DB.getConnection ();
    ResultSet rs = null;
    String sql = "select * from product";
    rs = DB.executeQuery (conn, sql);
    try {
      while (rs.next ()) {

        Product p = saveSingleProduct (rs);
        ps.add (p);

      }
    } catch (SQLException e) {
      e.printStackTrace ();
    } finally {
      DB.closeRs (rs);
      DB.closeConn (conn);
    }

    return ps;
  }

  private Product saveSingleProduct (ResultSet rs) {
    Product p = new Product ();
    try {
      p.setId (rs.getInt ("id"));
      p.setName (rs.getString ("name"));
      p.setDescr (rs.getString ("descr"));
      p.setMemberPrice (rs.getDouble ("memberprice"));
      p.setNormalPrice (rs.getDouble ("normalprice"));
      p.setPdate (rs.getTimestamp ("pdate"));
      p.setCategoryid (rs.getInt ("categoryid"));
    } catch (SQLException e) {
      e.printStackTrace ();
    }

    return p;
  }

  @Override
  public List<Product> getProducts (int pageNo,
                                    int pageSize) {

    List<Product> ps = new ArrayList<Product> ();
    Connection conn = DB.getConnection ();
    ResultSet rs = null;
    String sql = "select p.*,c.id ad cid,c.name as cname,c.descr as cdescr,c.pid , c.isleaf,c.grade  " +
                 " from product p join category c on p.categoryid=c.id" + " limit " + (pageNo - 1) * pageSize + "," +
                 pageSize;
    rs = DB.executeQuery (conn, sql);
    try {
      while (rs.next ()) {

        Product p = saveSingleProduct (rs);
        Category c = new Category ();
        c.setId (rs.getInt ("cid"));
        c.setName (rs.getString ("cname"));
        c.setDescr (rs.getString ("cdescr"));
        c.setPid (rs.getInt ("pid"));
        c.setLeaf (rs.getInt ("isleaf") == 0 ? true : false);
        c.setGrade (rs.getInt ("grade"));
        p.setCategory (c);
        ps.add (p);

      }
    } catch (SQLException e) {
      e.printStackTrace ();
    } finally {
      DB.closeRs (rs);
      DB.closeConn (conn);
    }

    return ps;
  }

  @Override
  public boolean deleteProductByCategoryId (int categoryId) {

    return true;
  }

  @Override
  public boolean deleteProductsById (int[] idArray) {

    return true;
  }

  @Override
  public boolean updateProduct (Product p) {

    return true;
  }

  @Override
  public boolean addProduct (Product p) {
    Connection conn = null;
    conn = DB.getConnection ();
    String sql = "insert into product values(null,?,?,?,?,?,?)";
    PreparedStatement pstmt = DB.prepStmt (conn, sql);

    try {
      pstmt.setString (1, p.getName ());
      pstmt.setString (2, p.getDescr ());
      pstmt.setDouble (3, p.getNormalPrice ());
      pstmt.setDouble (4, p.getMemberPrice ());
      pstmt.setTimestamp (5, p.getPdate ());
      pstmt.setInt (6, p.getCategoryid ());
      pstmt.executeUpdate ();

    } catch (SQLException e) {
      e.printStackTrace ();
      return false;
    } finally {
      DB.closeStmt (pstmt);
      DB.closeConn (conn);
    }

    return true;
  }

  @Override
  public int getProducts (List<Product> result,
                          int pageNo,
                          int pageSize) {

    Connection conn = DB.getConnection ();
    ResultSet rs = null;
    int rowCount = 0;
    int pageCount = 0;

    ResultSet allrs = null;
    String allsql = "select count(*) from product";

    String sql = "select p.*,c.id as cid,c.name as cname,c.descr as cdescr,c.pid , c.isleaf,c.grade  " +
                 " from product p join category c on p.categoryid=c.id" + " limit " + (pageNo - 1) * pageSize + "," +
                 pageSize;
    System.out.println (sql);

    rs = DB.executeQuery (conn, sql);
    allrs = DB.executeQuery (conn, allsql);
    try {
      while (rs.next ()) {

        Product p = saveSingleProduct (rs);

        Category c = new Category ();
        c.setId (rs.getInt ("cid"));
        c.setName (rs.getString ("cname"));
        c.setDescr (rs.getString ("cdescr"));
        c.setPid (rs.getInt ("pid"));
        c.setLeaf (rs.getInt ("isleaf") == 0 ? true : false);
        c.setGrade (rs.getInt ("grade"));
        p.setCategory (c);

        result.add (p);

      }
      allrs.next ();
      rowCount = allrs.getInt (1);
      pageCount = (rowCount + pageSize - 1) / pageSize;

    } catch (SQLException e) {
      e.printStackTrace ();
    } finally {
      DB.closeRs (rs);
      DB.closeConn (conn);
    }

    return pageCount;

  }

  @Override
  public int findProducts (List<Product> ps,
                           int[] categoryId,
                           String keyword,
                           double lowNormalPrice,
                           double highNormalPrice,
                           double lowMemberPrice,
                           double highMemberPrice,
                           Date startDate,
                           Date endDate,
                           int pageNo,
                           int pageSize) {

    Connection conn = DB.getConnection ();
    ResultSet rs = null;
    ResultSet rsCount = null;
    int pageCount = 0;
    //where 1=1
    String sql = "select * from product where 1=1";
    if (categoryId != null && categoryId.length > 0) {

      String strId = "(";
      for (int i = 0; i < categoryId.length; i++) {
        if (i < categoryId.length - 1) {
          strId += categoryId[i] + ",";
        } else {
          strId += categoryId[i];
        }
      }
      strId += ")";
      sql += " and categoryid in " + strId;
    }

    if (keyword != null && !keyword.trim ().equals ("")) {
      sql += " and ( name like '*" + keyword + "*' or descr like '*" + keyword + "*' )";
    }

    if (lowNormalPrice >= 0) {
      sql += " and lownormalprice>" + lowNormalPrice;
    }
    if (highNormalPrice > 0) {
      sql += " and highnormalprice<" + highNormalPrice;
    }
    if (lowMemberPrice >= 0) {
      sql += " and lowmemberprice>" + lowMemberPrice;
    }
    if (highMemberPrice > 0) {
      sql += " and highmemberprice<" + highMemberPrice;
    }

    if (startDate != null) {
      sql += " and pdate>='" + new SimpleDateFormat ("yyyy-MM-dd").format (startDate) + "'";
    }

    if (endDate != null) {
      sql += " and pdate<='" + new SimpleDateFormat ("yyyy-MM-dd").format (endDate) + "'";
    }

    String sqlCount = sql.replaceFirst ("select \\*", "select count(*)");
    System.out.println ("sqlcount---" + sqlCount);
    rsCount = DB.executeQuery (conn, sqlCount);

    sql += " limit " + (pageNo - 1) * pageSize + "," + pageSize;
    System.out.println (sql);

    rs = DB.executeQuery (conn, sql);
    try {
      while (rs.next ()) {

        Product p = saveSingleProduct (rs);
        ps.add (p);

      }

      //calculate page size
      if (rsCount.next ()) {
        pageCount = (rsCount.getInt (1) + pageSize - 1) / pageSize;
      }

    } catch (SQLException e) {
      e.printStackTrace ();
    } finally {
      DB.closeRs (rs);
      DB.closeRs (rsCount);
      DB.closeConn (conn);
    }

    return pageCount;
  }
}
