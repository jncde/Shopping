package com.sy.shopping.util;

import java.util.ArrayList;
import java.util.List;

public class Category {

  private int     id;
  private String  name;
  private String  descr;
  private int     pid;
  private boolean leaf;

  public boolean isLeaf () {
    return leaf;
  }

  public void setLeaf (boolean leaf) {
    this.leaf = leaf;
  }

  private int grade;

  public int getGrade () {
    return grade;
  }

  public void setGrade (int grade) {
    this.grade = grade;
  }

  public int getId () {
    return id;
  }

  public void setId (int id) {
    this.id = id;
  }

  public String getName () {
    return name;
  }

  public void setName (String name) {
    this.name = name;
  }

  public String getDescr () {
    return descr;
  }

  public void setDescr (String descr) {
    this.descr = descr;
  }

  public int getPid () {
    return pid;
  }

  public void setPid (int pid) {
    this.pid = pid;
  }

  public static void add (Category c) {
    CategoryDAO.save (c);
  }

  public static void addTopCategory (String name,
                                     String descr) {
    Category c = new Category (-1, name, descr, 0, true, 1);
    add (c);
  }

  public Category (int id,
                   String name,
                   String descr,
                   int pid,
                   boolean leaf,
                   int grade) {
    super ();
    this.id = id;
    this.name = name;
    this.descr = descr;
    this.pid = pid;
    this.leaf = leaf;
    this.grade = grade;
  }

  public Category () {
    // TODO Auto-generated constructor stub
  }

  public static List<Category> getCategories () {

    List<Category> cs = new ArrayList<Category> ();
    CategoryDAO.getCategories (cs, 0);

    return cs;
  }

  public static void addChildCategory (int pid,
                                       String name,
                                       String descr) {
    Category c = new Category (-1, name, descr, pid, true, 1);
    CategoryDAO.saveChild (pid, c);
  }

}
