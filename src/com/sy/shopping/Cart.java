package com.sy.shopping;

import java.util.ArrayList;
import java.util.List;

public class Cart {

  List<CartItem> items = new ArrayList<CartItem> ();

  public List<CartItem> getItems () {
    return items;
  }

  public void setItems (List<CartItem> items) {
    this.items = items;
  }

  public void add (CartItem item) {
    items.add (item);
  }

}
