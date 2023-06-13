package com.study.reserve;

import com.study.enroll.EnrollDTO;
import com.study.hairmenu.HairmenuDTO;
import com.study.user.UserDTO;

import lombok.Data;

@Data
public class ReserveDTO {
  private int reserveno;
  private String uid;
  private String message;
  private int enrollno;
  private boolean rconfig;
  
  private EnrollDTO edto;
  private UserDTO udto;
  
}
