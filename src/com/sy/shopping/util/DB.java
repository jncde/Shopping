package com.sy.shopping.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DB {

  static {

    try {
      Class.forName ("com.mysql.jdbc.Driver").newInstance ();
    } catch (ClassNotFoundException e) {
      e.printStackTrace ();
    } catch (InstantiationException e) {
      // TODO Auto-generated catch block
      e.printStackTrace ();
    } catch (IllegalAccessException e) {
      // TODO Auto-generated catch block
      e.printStackTrace ();
    }
  }

  public DB () {

  }

  public static Connection getConnection () {
    Connection conn = null;

    try {
      conn = DriverManager.getConnection ("jdbc:mysql://localhost/newshopping?user=root&password=root");

    } catch (Exception e) {
      e.printStackTrace ();
    }
    return conn;

  }

  public static void closeConn (Connection conn) {

    if (conn != null) {
      try {
        conn.close ();
        conn = null;
      } catch (SQLException e) {
        e.printStackTrace ();
      }
    }

  }

  public static Statement getStmt (Connection conn) {
    Statement stmt = null;
    try {
      stmt = conn.createStatement ();
    } catch (SQLException e) {
      e.printStackTrace ();
    }
    return stmt;
  }

  public static void closeStmt (Statement stmt) {

    try {
      stmt.close ();
    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace ();
    }
    stmt = null;

  }

  public static PreparedStatement prepStmt (Connection conn,
                                            String sql) {
    PreparedStatement pStmt = null;
    try {
      pStmt = conn.prepareStatement (sql);
    } catch (SQLException e) {
      e.printStackTrace ();
    }
    return pStmt;

  }

  public static ResultSet executeQuery (Statement stmt,
                                        String sql) {

    ResultSet rs = null;
    try {
      rs = stmt.executeQuery (sql);
    } catch (SQLException e) {
      e.printStackTrace ();
    }

    return rs;
  }

  public static ResultSet executeQuery (Connection conn,
                                        String sql) {

    ResultSet rs = null;
    try {
      rs = conn.createStatement ().executeQuery (sql);
    } catch (SQLException e) {
      e.printStackTrace ();
    }

    return rs;

  }

  public static void closeRs (ResultSet rs) {

    if (rs != null) {
      try {
        rs.close ();
      } catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace ();
      }
      rs = null;

    }

  }

}
