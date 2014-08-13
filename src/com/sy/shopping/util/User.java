package com.sy.shopping.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class User {

  private int    id;
  private String password;
  private String username;
  private String phone;
  private String addr;
  private Date   rdate;

  public int getId () {
    return id;
  }

  public void setId (int id) {
    this.id = id;
  }

  public String getPassword () {
    return password;
  }

  public void setPassword (String password) {
    this.password = password;
  }

  public String getUsername () {
    return username;
  }

  public void setUsername (String username) {
    this.username = username;
  }

  public String getPhone () {
    return phone;
  }

  public void setPhone (String phone) {
    this.phone = phone;
  }

  public String getAddr () {
    return addr;
  }

  public void setAddr (String addr) {
    this.addr = addr;
  }

  public Date getRdate () {
    return rdate;
  }

  public void setRdate (Date rdate) {
    this.rdate = rdate;
  }

  public void save () {
    Connection conn = DB.getConnection ();
    String sql = "insert into user values(null,?,?,?,?,?)";
    PreparedStatement pstmt = DB.prepStmt (conn, sql);
    try {
      pstmt.setString (1, username);
      pstmt.setString (2, password);
      pstmt.setString (3, phone);
      pstmt.setString (4, addr);
      pstmt.setTimestamp (5, new Timestamp (rdate.getTime ()));
      pstmt.executeUpdate ();
    } catch (SQLException e) {
      e.printStackTrace ();
    } finally {
      DB.closeStmt (pstmt);
      DB.closeConn (conn);
    }

  }

  public static boolean userExists (String username) {

    Connection conn = DB.getConnection ();
    String sql = "select * from user where username='" + username + "'";

    return false;
  }

  public static boolean isPasswordCorrect (String uname,
                                           String pwd) {

    return false;
  }

  public static User validate (String uname,
                               String pwd) throws UserNotFoundException, PasswordNotCorrectException {

    Connection conn = null;
    ResultSet rs = null;
    User u = null;
    conn = DB.getConnection ();
    String sql = "select * from user where username='" + uname + "'";

    try {
      rs = DB.executeQuery (conn, sql);
      if (!rs.next ()) {
        throw new UserNotFoundException ();
      } else if (!rs.getString ("password").equals (pwd)) {
        throw new PasswordNotCorrectException ();
      } else {
        u = new User ();
        setUserDataFromRs (rs, u);
      }
    } catch (SQLException e) {
      e.printStackTrace ();
    } finally {
      DB.closeRs (rs);
      DB.closeConn (conn);
    }

    return u;
  }

  public boolean update () {

    String sql = "update user set username='" + username + "', phone='" + phone + "',addr='" + addr + "' where id=" +
                 id;

    Connection conn = null;

    conn = DB.getConnection ();
    PreparedStatement pStmt = DB.prepStmt (conn, sql);
    try {
      pStmt.executeUpdate ();
    } catch (SQLException e) {
      e.printStackTrace ();
      DB.closeConn (conn);
      return false;
    }

    DB.closeConn (conn);
    return true;
  }

  public static List<User> getUsers () {

    List<User> users = new ArrayList<User> ();
    ResultSet rs = null;
    Connection conn = null;
    String sql = "select * from user";
    try {
      conn = DB.getConnection ();
      rs = DB.executeQuery (conn, sql);
      while (rs.next ()) {
        User u = new User ();
        setUserDataFromRs (rs, u);
        users.add (u);

      }
    } catch (SQLException e) {
      e.printStackTrace ();
    } finally {
      DB.closeRs (rs);
      DB.closeConn (conn);
    }

    return users;

  }

  private static void setUserDataFromRs (ResultSet rs,
                                         User u) throws SQLException {
    u.setId (rs.getInt ("id"));
    u.setUsername (rs.getString ("username"));
    u.setPassword (rs.getString ("password"));
    u.setPhone (rs.getString ("phone"));
    u.setAddr (rs.getString ("addr"));
    u.setRdate (new java.util.Date (rs.getDate ("rdate").getTime ()));
  }
}
