package com.sy.shopping.DAO;

import java.util.Date;
import java.util.List;

import com.sy.shopping.util.Product;

public interface ProductDAO {

  public List<Product> getProducts ();

  public List<Product> getProducts (int pageNo,
                                    int pageSize);

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
                           int pageSize);

  public boolean deleteProductByCategoryId (int categoryId);

  public boolean deleteProductsById (int[] idArray);

  public boolean updateProduct (Product p);

  public boolean addProduct (Product p);

  public int getProducts (List<Product> result,
                          int pageNo,
                          int pageSize);

  public List<Product> getLastestProduct (int size);

  public Product loadProductById (int id);
}
