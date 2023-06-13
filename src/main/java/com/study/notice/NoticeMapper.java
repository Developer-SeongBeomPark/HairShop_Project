package com.study.notice;

import java.util.List;
import java.util.Map;

public interface NoticeMapper {

  int total(Map map);
  List<NoticeDTO> list(Map map);
  int write(NoticeDTO dto);
  void upCnt(int noticeno);
  NoticeDTO read(int noticeno);
  int edit(NoticeDTO dto);
  int delete(int noticeno);
}
