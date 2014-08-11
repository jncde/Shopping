package com.sy.shopping.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

public class User {

  private String password;
  private String username;
  private String phone;
  private String addr;
  private Date   rdate;

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

}
