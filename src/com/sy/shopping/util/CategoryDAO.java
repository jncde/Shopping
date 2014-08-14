package com.sy.shopping.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class CategoryDAO {

  public static void save (Category c) {
    Connection conn = DB.getConnection ();
    String sql = null;
    PreparedStatement pstmt = null;
    try {
      if (c.getId () == -1) {
        sql = "insert into category values(null,?,?,?,?,?)";
      } else {
        sql = "insert into category values(" + c.getId () + ",?,?,?,?,?)";
      }
      pstmt = DB.prepStmt (conn, sql);
      pstmt.setInt (1, c.getPid ());
      pstmt.setString (2, c.getName ());
      pstmt.setString (3, c.getDescr ());
      pstmt.setInt (4, c.isLeaf () ? 0 : 1);
      pstmt.setInt (5, c.getGrade ());
      pstmt.executeUpdate ();
    } catch (SQLException e) {
      e.printStackTrace ();
    } finally {
      DB.closeStmt (pstmt);
      DB.closeConn (conn);
    }

  }

  public static void getCategories (List<Category> list,
                                    int id) {

    Connection conn = null;
    ResultSet rs = null;

    try {
      conn = DB.getConnection ();
      String sql = "select * from category where pid=" + id;
      rs = DB.executeQuery (conn, sql);

      while (rs.next ()) {
        Category c = getCategoryFromrs (rs);
        list.add (c);
        if (!c.isLeaf ()) {
          getCategories (list, c.getId ());
        }

      }

    } catch (SQLException e) {
      e.printStackTrace ();
    } finally {
      DB.closeRs (rs);
      DB.closeConn (conn);
    }

  }

  private static Category getCategoryFromrs (ResultSet rs) throws SQLException {
    Category c = new Category ();
    c.setId (rs.getInt ("id"));
    c.setName (rs.getString ("name"));
    c.setDescr (rs.getString ("descr"));
    c.setPid (rs.getInt ("pid"));
    c.setLeaf (rs.getInt ("isleaf") == 0 ? true : false);
    c.setGrade (rs.getInt ("grade"));
    return c;
  }

  public static void addChildCategory (int pid,
                                       String name,
                                       String descr) {

  }

  public static void saveChild (int pid,
                                Category c) {

    Category parent = getCategoryByID (pid);
    updateParent (parent);
    c.setGrade (parent.getGrade () + 1);
    save (c);

  }

  private static void updateParent (Category parent) {

    Connection conn = null;

    conn = DB.getConnection ();
    String sql = "update category set isleaf=1 where id=" + parent.getId ();
    DB.executeUpdate (conn, sql);

    DB.closeConn (conn);

  }

  public static Category getCategoryByID (int id) {
    Category c = null;

    Connection conn = null;
    ResultSet rs = null;

    try {
      conn = DB.getConnection ();
      String sql = "select * from category where id=" + id;
      rs = DB.executeQuery (conn, sql);

      while (rs.next ()) {
        c = getCategoryFromrs (rs);

      }

    } catch (SQLException e) {
      e.printStackTrace ();
    } finally {
      DB.closeRs (rs);
      DB.closeConn (conn);
    }

    return c;

  }

  public static void delete (int id,
                             int pid) {

    Connection conn = null;
    conn = DB.getConnection ();
    //        deleteRecurseivCategrory (conn, id);
    checkAndUpdateParent (pid);
    DB.closeConn (conn);

  }

  private static void checkAndUpdateParent (int pid) {
    // TODO Auto-generated method stub

  }

  private static void deleteRecurseivCategrory (Connection conn,
                                                int id) throws SQLException {

    String hasChildSql = "select * from Category where pid=" + id;
    ResultSet rs = DB.executeQuery (conn, hasChildSql);

    while (rs.next ()) {
      String childId = rs.getString ("id");
      deleteRecurseivCategrory (conn, Integer.parseInt (childId));
    }

    String deleteSql = "delete from category where id=" + id;

  }
}
