package com.sy.shopping.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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

    return null;
  }

  @Override
  public List<Product> findProducts (int[] categoryId,
                                     String name,
                                     String descr,
                                     double lowNormalPrice,
                                     double highNormalPrice,
                                     double lowMemberPrice,
                                     double highMemberPrice,
                                     Date startDate,
                                     Date endDate,
                                     int pageNo,
                                     int pageSize) {

    return null;
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

}
