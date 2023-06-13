package com.study.enroll;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.study.category.CategoryDTO;
import com.study.hairmenu.HairmenuDTO;

public interface EnrollMapper {
  List<HairmenuDTO> list(String did);

  Set<CategoryDTO> catenameList(String did);

  List<HairmenuDTO> menuPriceList(String did);

  List<HairmenuDTO> menuInfo(Map map);
  
  int enrollInput(Map map);
  
  int menunoGet(Map map);
  
  Set<EnrollDTO> enrollList(String did);
  
  int enrollDelete(int enrollno);
  
  int userInsert(Map map);
  
  
  
  int checking(String enrollno);
  
  List<EnrollDTO> infoList(String did);
  
  Set<EnrollDTO> asOfEnrollList(String did);
  
}