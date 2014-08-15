package com.sy.shopping.util;

import java.sql.Timestamp;

public class Product {

  private int    id;
  private String name;
  private String descr;
  private double normalPrice;
  private double memberPrice;

  public int getId () {
    return id;
  }

  public void setId (int id) {
    this.id = id;
  }

  public String getName () {
    return name;
  }

  public void setName (String name) {
    this.name = name;
  }

  public String getDescr () {
    return descr;
  }

  public void setDescr (String descr) {
    this.descr = descr;
  }

  public double getNormalPrice () {
    return normalPrice;
  }

  public void setNormalPrice (double normalPrice) {
    this.normalPrice = normalPrice;
  }

  public double getMemberPrice () {
    return memberPrice;
  }

  public void setMemberPrice (double memberPrice) {
    this.memberPrice = memberPrice;
  }

  public Timestamp getPdate () {
    return pdate;
  }

  public void setPdate (Timestamp pdate) {
    this.pdate = pdate;
  }

  public int getCategoryid () {
    return categoryid;
  }

  public void setCategoryid (int categoryid) {
    this.categoryid = categoryid;
  }

  private Timestamp pdate;
  private int       categoryid;

}
