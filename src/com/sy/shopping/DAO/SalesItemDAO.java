package com.sy.shopping.DAO;

import java.util.List;

import com.sy.shopping.SalesItem;

public interface SalesItemDAO {

  List<SalesItem> getSalesItemsByOrderID (int id);

}
