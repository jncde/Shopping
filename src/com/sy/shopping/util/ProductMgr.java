package com.sy.shopping.util;

import java.util.Date;
import java.util.List;

import com.sy.shopping.DAO.ProductDAO;
import com.sy.shopping.DAO.ProductMySqlDAO;

public class ProductMgr {

  private static ProductMgr pm = null;

  private ProductMgr () {

  }

  static {
    if (pm == null) {
      pm = new ProductMgr ();
      //TODO: get dao from config file
      pm.setDao (new ProductMySqlDAO ());
    }
  }

  public static ProductMgr getInstance () {
    return pm;
  }

  ProductDAO dao = null;

  public ProductDAO getDao () {
    return dao;
  }

  public void setDao (ProductDAO dao) {
    this.dao = dao;
  }

  public List<Product> getProducts () {

    return dao.getProducts ();
  }

  public List<Product> getProducts (int pageNo,
                                    int pageSize) {

    return dao.getProducts (pageNo, pageSize);
  }

  public int getProducts (List<Product> result,
                          int pageNo,
                          int pageSize) {

    return dao.getProducts (result, pageNo, pageSize);
  }

  public int findProducts (List<Product> ps,
                           int[] categoryId,
                           String keyword,
                           double lowNormalPrice,
                           double highNormalPrice,
                           double lowMemberPrice,
                           double highMemberPrice,
                           Date startDate,
                           Date endDate,
                           int pageNo,
                           int pageSize) {

    int pageCount = dao.findProducts (ps,
                                      categoryId,
                                      keyword,
                                      lowNormalPrice,
                                      highNormalPrice,
                                      lowMemberPrice,
                                      highMemberPrice,
                                      startDate,
                                      endDate,
                                      pageNo,
                                      pageSize);
    return pageCount;
  }

  public List<Product> findProducts (String name) {

    return null;
  }

  public boolean deleteProductByCategoryId (int categoryId) {

    return true;
  }

  public boolean deleteProductsById (int[] idArray) {

    return true;
  }

  public boolean updateProduct (Product p) {

    return true;
  }

  public boolean addProduct (Product p) {

    return dao.addProduct (p);
  }

  public Product loadProductById (int id) {
    return dao.loadProductById (id);
  }

  public List<Product> getLastestProduct (int size) {
    return dao.getLastestProduct (size);
  }
}
