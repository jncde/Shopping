package com.sy.shopping;

import java.util.List;

import com.sy.shopping.DAO.OrderDAO;
import com.sy.shopping.DAO.OrderMySqlDAO;

public class OrderMgr {

  private OrderDAO        dao;

  private static OrderMgr om = null;

  private OrderMgr () {

  }

  static {
    if (om == null) {
      om = new OrderMgr ();
      //TODO: get dao from config file
      om.setDao (new OrderMySqlDAO ());
    }
  }

  public OrderDAO getDao () {
    return dao;
  }

  public void setDao (OrderDAO dao) {
    this.dao = dao;
  }

  public static OrderMgr getInstance () {
    return om;
  }

  public void saveOrder (SalesOrder so) {
    dao.saveOrder (so);

  }

  public int getOrders (List<SalesOrder> list,
                        int pageNo,
                        int pageSize) {

    return dao.getOrders (list, pageNo, pageSize);

  }

  public SalesOrder loadById (int id) {
    return dao.loadById (id);
  }

}
