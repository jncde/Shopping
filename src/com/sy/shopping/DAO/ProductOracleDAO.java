package com.sy.shopping.DAO;

import java.util.Date;
import java.util.List;

import com.sy.shopping.util.Product;

/*
 * show the goal of productDAO
 */
public class ProductOracleDAO implements ProductDAO {

  @Override
  public List<Product> getProducts () {
    // TODO Auto-generated method stub
    return null;
  }

  @Override
  public List<Product> getProducts (int pageNo,
                                    int pageSize) {
    // TODO Auto-generated method stub
    return null;
  }

  @Override
  public boolean deleteProductByCategoryId (int categoryId) {
    // TODO Auto-generated method stub
    return false;
  }

  @Override
  public boolean deleteProductsById (int[] idArray) {
    // TODO Auto-generated method stub
    return false;
  }

  @Override
  public boolean updateProduct (Product p) {
    // TODO Auto-generated method stub
    return false;
  }

  @Override
  public boolean addProduct (Product p) {
    // TODO Auto-generated method stub
    return false;
  }

  @Override
  public int getProducts (List<Product> result,
                          int pageNo,
                          int pageSize) {
    // TODO Auto-generated method stub
    return 0;
  }

  @Override
  public List<Product> findProducts (int[] categoryId,
                                     String keyword,
                                     double lowNormalPrice,
                                     double highNormalPrice,
                                     double lowMemberPrice,
                                     double highMemberPrice,
                                     Date startDate,
                                     Date endDate,
                                     int pageNo,
                                     int pageSize) {
    // TODO Auto-generated method stub
    return null;
  }

}
