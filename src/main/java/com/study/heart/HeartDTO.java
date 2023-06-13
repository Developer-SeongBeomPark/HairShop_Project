package com.study.heart;

import lombok.Data;

@Data
public class HeartDTO {
  
  private int heartno;  // 기본키
  private String did;   // 디자이너 아이디 FK
  private String uid;   // 유저아이디 FK
  private int heart_chk;   //default 0
  

}
