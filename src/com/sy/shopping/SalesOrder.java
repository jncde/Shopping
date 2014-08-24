package com.sy.shopping;

import java.sql.Timestamp;

import com.sy.shopping.util.User;

public class SalesOrder {

  User      user;
  String    addr;
  Timestamp oDate;
  int       id;
  int       status;

  public int getStatus () {
    return status;
  }

  public void setStatus (int status) {
    this.status = status;
  }

  Cart cart;

  public User getUser () {
    return user;
  }

  public void setUser (User user) {
    this.user = user;
  }

  public String getAddr () {
    return addr;
  }

  public void setAddr (String addr) {
    this.addr = addr;
  }

  public Timestamp getoDate () {
    return oDate;
  }

  public void setoDate (Timestamp oDate) {
    this.oDate = oDate;
  }

  public int getId () {
    return id;
  }

  public void setId (int id) {
    this.id = id;
  }

  public Cart getCart () {
    return cart;
  }

  public void setCart (Cart cart) {
    this.cart = cart;
  }

  public void save () {
    OrderMgr.getInstance ().saveOrder (this);
  }
}
