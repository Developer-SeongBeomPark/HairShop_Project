package com.study.notice;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Service("com.study.notice.NoticeServiceImpl")
public class NoticeServiceImpl implements NoticeService {
  
  @Autowired
  private NoticeMapper mapper;
  
  @Override
  public int total(Map map) {
    // TODO Auto-generated method stub
    return mapper.total(map);
  }

  @Override
  public List<NoticeDTO> list(Map map) {
    // TODO Auto-generated method stub
    return mapper.list(map);
  }

  @Override
  public int write(NoticeDTO dto) {
    // TODO Auto-generated method stub
    return mapper.write(dto);
  }

  @Override
  public void upCnt(int noticeno) {
    // TODO Auto-generated method stub
    mapper.upCnt(noticeno);
  }

  @Override
  public NoticeDTO read(int noticeno) {
    // TODO Auto-generated method stub
    return mapper.read(noticeno);
  }

  @Override
  public int edit(NoticeDTO dto) {
    // TODO Auto-generated method stub
    return mapper.edit(dto);
  }

  @Override
  public int delete(int noticeno) {
    // TODO Auto-generated method stub
    return mapper.delete(noticeno);
  }
}
