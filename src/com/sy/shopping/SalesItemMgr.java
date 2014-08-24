package com.sy.shopping;

import java.util.List;

import com.sy.shopping.DAO.SalesItemDAO;
import com.sy.shopping.DAO.SalesItemMySqlDAO;

public class SalesItemMgr {

  private static SalesItemMgr si = null;
  private SalesItemDAO        dao;

  static {
    si = new SalesItemMgr ();
    si.setDao (new SalesItemMySqlDAO ());
  }

  public SalesItemDAO getDao () {
    return dao;
  }

  public void setDao (SalesItemDAO dao) {
    this.dao = dao;
  }

  private SalesItemMgr () {

  }

  public static SalesItemMgr getInstance () {
    return si;
  }

  public List<SalesItem> getSalesItemsByOrderID (int id) {
    return dao.getSalesItemsByOrderID (id);
  }

}
