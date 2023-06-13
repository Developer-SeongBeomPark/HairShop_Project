package com.study.heart;


import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.designer.DesignerDTO;

@Service("com.study.heart.HeartServiceImpl")
public class HeartServiceImpl implements HeartService {
  @Autowired
  private HeartMapper mapper;

  @Override
  public int addCheck(Map map) {
    // TODO Auto-generated method stub
    return mapper.addCheck(map);
  }

  @Override
  public HeartDTO read(Map map) {
    // TODO Auto-generated method stub
    return mapper.read(map);
  }

  @Override
  public void heartPlus(Map map) {
    // TODO Auto-generated method stub
    mapper.heartPlus(map);
  }

  @Override
  public void checkPlus(Map map) {
    // TODO Auto-generated method stub
    mapper.checkPlus(map);
    
  }

  @Override
  public void heartMinus(Map map) {
    // TODO Auto-generated method stub
    mapper.heartMinus(map);
  }

  @Override
  public void checkMinus(Map map) {
    // TODO Auto-generated method stub
    mapper.checkMinus(map);
  }

  @Override
  public int getheartchk(Map map) {
    // TODO Auto-generated method stub
    return mapper.getheartchk(map);
  }

  @Override
  public int col_chk(Map map) {
    // TODO Auto-generated method stub
    return mapper.col_chk(map);
  }



}
