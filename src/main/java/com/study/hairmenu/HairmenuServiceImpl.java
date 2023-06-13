package com.study.hairmenu;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.designer.DesignerDTO;

@Service("com.study.hairmenu.HairmenuServiceImpl")
public class HairmenuServiceImpl implements HairmenuService {
  @Autowired
  private HairmenuMapper mapper;

  @Override
  public List<HairmenuDTO> list(Map map) {
    // TODO Auto-generated method stub
    return mapper.list(map);
  }

  @Override
  public int hairmenuEnroll(HairmenuDTO dto) {
    // TODO Auto-generated method stub
    return mapper.hairmenuEnroll(dto);
  }


  @Override
  public List<HairmenuDTO> itemlist(Map map) {
    // TODO Auto-generated method stub
    return mapper.itemlist(map);
  }

  @Override
  public int delete(int menuno) {
    // TODO Auto-generated method stub
    return mapper.delete(menuno);
  }

  @Override
  public List<HairmenuDTO> hlist(String id) {
    // TODO Auto-generated method stub
    return mapper.hlist(id);
  }

  @Override
  public int overHairmenu(Map map) {
    // TODO Auto-generated method stub
    return mapper.overHairmenu(map);
  }


}