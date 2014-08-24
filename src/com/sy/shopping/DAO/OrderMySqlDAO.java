package com.sy.shopping.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.sy.shopping.Cart;
import com.sy.shopping.CartItem;
import com.sy.shopping.SalesOrder;
import com.sy.shopping.util.DB;
import com.sy.shopping.util.User;

public class OrderMySqlDAO implements OrderDAO {

  @Override
  public void saveOrder (SalesOrder so) {

    Connection conn = null;
    conn = DB.getConnection ();
    String sql = "insert into salesorder values(null,?,?,?,?)";
    PreparedStatement pstmt = DB.prepStmt (conn, sql, true);
    ResultSet rskey = null;

    try {
      conn.setAutoCommit (false);
      pstmt.setInt (1, so.getUser ().getId ());
      pstmt.setString (2, so.getAddr ());
      pstmt.setTimestamp (3, so.getoDate ());
      pstmt.setInt (4, so.getStatus ());
      pstmt.executeUpdate ();
      rskey = pstmt.getGeneratedKeys ();
      rskey.next ();
      int key = rskey.getInt (1);

      String sqlitem = "insert into salesitem values(null,?,?,?,?)";
      pstmt = DB.prepStmt (conn, sqlitem);
      Cart c = so.getCart ();
      List<CartItem> items = c.getItems ();
      for (int i = 0; i < items.size (); i++) {
        CartItem ci = items.get (i);
        pstmt.setInt (1, ci.getProductId ());
        pstmt.setDouble (2, ci.getPrice ());
        pstmt.setInt (3, ci.getCount ());
        pstmt.setInt (4, key);
        pstmt.addBatch ();
      }
      pstmt.executeBatch ();

      conn.commit ();
      conn.setAutoCommit (true);

    } catch (SQLException e) {
      e.printStackTrace ();
      try {
        conn.setAutoCommit (true);
        conn.rollback ();
      } catch (SQLException e1) {
        e1.printStackTrace ();
      }
    } finally {
      DB.closeStmt (pstmt);
      DB.closeRs (rskey);
      DB.closeConn (conn);
    }

  }

  @Override
  public int getOrders (List<SalesOrder> list,
                        int pageNo,
                        int pageSize) {

    Connection conn = DB.getConnection ();
    ResultSet rs = null;
    int rowCount = 0;
    int pageCount = 0;

    ResultSet allrs = null;
    String allsql = "select count(*) from salesorder";

    String sql = "select s.*,u.id as uid, u.username,u.password,u.phone,u.rdate,u.addr  from salesorder s left join user u on s.userid=u.id  limit " +
                 (pageNo - 1) * pageSize + "," + pageSize;

    System.out.println (sql);

    rs = DB.executeQuery (conn, sql);
    allrs = DB.executeQuery (conn, allsql);
    try {
      while (rs.next ()) {

        SalesOrder so = saveSalesOrderFromRs (rs);

        list.add (so);

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

  private SalesOrder saveSalesOrderFromRs (ResultSet rs) throws SQLException {
    User u = new User ();
    u.setId (rs.getInt ("uid"));
    u.setUsername (rs.getString ("username"));
    u.setPassword (rs.getString ("password"));
    u.setPhone (rs.getString ("phone"));
    u.setRdate (rs.getDate ("rdate"));
    u.setAddr (rs.getString ("addr"));

    SalesOrder so = new SalesOrder ();
    so.setId (rs.getInt ("id"));
    so.setAddr (rs.getString ("addr"));
    so.setoDate (rs.getTimestamp ("odate"));
    so.setStatus (rs.getInt ("status"));
    so.setUser (u);
    return so;
  }

  @Override
  public SalesOrder loadById (int id) {

    SalesOrder so = null;
    Connection conn = DB.getConnection ();
    ResultSet rs = null;
    String sql = "select s.*,u.id as uid, u.username,u.password,u.phone,u.rdate,u.addr  from salesorder s left join user u on s.userid=u.id where s.id=" +
                 id;
    rs = DB.executeQuery (conn, sql);
    try {
      while (rs.next ()) {

        so = saveSalesOrderFromRs (rs);

      }
    } catch (SQLException e) {
      e.printStackTrace ();
    } finally {
      DB.closeRs (rs);
      DB.closeConn (conn);
    }

    return so;

  }
}
