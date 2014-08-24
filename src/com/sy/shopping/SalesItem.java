package com.sy.shopping;

import com.sy.shopping.util.Product;

public class SalesItem {

  int        id;
  Product    product;
  double     unitPrice;
  int        pcount;
  SalesOrder salesOrder;

  public int getId () {
    return id;
  }

  public void setId (int id) {
    this.id = id;
  }

  public Product getProduct () {
    return product;
  }

  public void setProduct (Product product) {
    this.product = product;
  }

  public double getUnitPrice () {
    return unitPrice;
  }

  public void setUnitPrice (double unitPrice) {
    this.unitPrice = unitPrice;
  }

  public int getPcount () {
    return pcount;
  }

  public void setPcount (int pcount) {
    this.pcount = pcount;
  }

  public SalesOrder getSalesOrder () {
    return salesOrder;
  }

  public void setSalesOrder (SalesOrder salesOrder) {
    this.salesOrder = salesOrder;
  }

}
