package com.study.hairmenu;

import java.util.List;
import java.util.Map;

import com.study.designer.DesignerDTO;

public interface HairmenuMapper {

  List<HairmenuDTO> list(Map map);
  
  int hairmenuEnroll(HairmenuDTO dto);
  
  List<HairmenuDTO> itemlist(Map map);

  int delete(int menuno);
  
  List<HairmenuDTO> hlist(String id);
  
  int overHairmenu(Map map);
  
}
