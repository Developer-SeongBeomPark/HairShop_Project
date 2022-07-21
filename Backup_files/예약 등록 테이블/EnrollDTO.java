package com.study.enroll;

import com.study.hairmenu.HairmenuDTO;

import lombok.Data;

@Data
public class EnrollDTO {
  private int enrollno;
  private String enrolldate;
  private String enrolltime;
  private int menuno;
  private String did;
  private String emenu;
  private String eprice;
}
