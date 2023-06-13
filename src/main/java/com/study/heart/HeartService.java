package com.study.heart;

import java.util.Map;

import com.study.designer.DesignerDTO;

public interface HeartService {

  int addCheck(Map map);

  HeartDTO read(Map map);

  void heartPlus(Map map);

  void checkPlus(Map map);

  void heartMinus(Map map);

  void checkMinus(Map map);

  int getheartchk(Map map);

  int col_chk(Map map);

}
