package com.sy.shopping.util;

import java.sql.Connection;
import java.sql.SQLException;

import com.mysql.jdbc.Statement;

public class UserManager {

  public static boolean deleteUser (String uid) {
    Connection conn = null;
    String sql = "delete from user where id=" + uid;

    conn = DB.getConnection ();
    Statement stmt = (Statement) DB.getStmt (conn);
    try {
      stmt.executeUpdate (sql);
    } catch (SQLException e) {
      e.printStackTrace ();
      return false;
    }

    DB.closeConn (conn);
    return true;

  }
}
