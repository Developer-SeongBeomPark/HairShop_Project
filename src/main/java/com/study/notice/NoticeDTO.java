package com.study.notice;

import lombok.Data;

@Data
public class NoticeDTO {
  private int   noticeno;
  private String uid;
  private String ntitle;
  private int   viewcnt;
  private String ndate;
  private String ncontent;
}
