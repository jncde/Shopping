package com.sy.shopping.DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.sy.shopping.OrderMgr;
import com.sy.shopping.SalesItem;
import com.sy.shopping.SalesOrder;
import com.sy.shopping.util.DB;
import com.sy.shopping.util.Product;

public class SalesItemMySqlDAO implements SalesItemDAO {

  @Override
  public List<SalesItem> getSalesItemsByOrderID (int orderid) {

    List<SalesItem> is = new ArrayList<SalesItem> ();
    Connection conn = DB.getConnection ();
    ResultSet rs = null;
    String sql = "select s.*,p.id as pid,p.name,p.descr,p.normalprice,p.memberprice,p.pdate,p.categoryid from salesitem s join salesorder o on s.orderid=o.id left join Product p on s.productid=p.id  where o.id=" +
                 orderid;
    rs = DB.executeQuery (conn, sql);
    try {
      while (rs.next ()) {

        Product p = new Product ();
        p.setId (rs.getInt ("pid"));
        p.setName (rs.getString ("name"));
        p.setDescr (rs.getString ("descr"));
        p.setMemberPrice (rs.getDouble ("memberprice"));
        p.setNormalPrice (rs.getDouble ("normalprice"));
        p.setPdate (rs.getTimestamp ("pdate"));
        p.setCategoryid (rs.getInt ("categoryid"));

        SalesOrder so = OrderMgr.getInstance ().loadById (orderid);

        SalesItem i = new SalesItem ();
        i.setId (rs.getInt ("id"));
        i.setProduct (p);
        i.setPcount (rs.getInt ("pcount"));
        i.setUnitPrice (rs.getDouble ("unitprice"));
        i.setSalesOrder (so);

        is.add (i);

      }
    } catch (SQLException e) {
      e.printStackTrace ();
    } finally {
      DB.closeRs (rs);
      DB.closeConn (conn);
    }

    return is;

  }
}
