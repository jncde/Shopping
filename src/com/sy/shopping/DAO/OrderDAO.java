package com.sy.shopping.DAO;

import java.util.List;

import com.sy.shopping.SalesOrder;

public interface OrderDAO {

  void saveOrder (SalesOrder so);

  int getOrders (List<SalesOrder> list,
                 int pageNo,
                 int pageSize);

  SalesOrder loadById (int id);

}
