package com.study.designer;

import java.util.List;

import com.study.hairmenu.HairmenuDTO;
import com.study.review.ReviewDTO;

import lombok.Data;

@Data
public class DesignerDTO {
  private String did;
  private String dpw;
  private String dname;
  private String birth;
  private String hairshop;
  private String demail;
  private String dphone;
  private String address1;
  private String address2;
  private String dzipcode;
  private String dfilename;
  private boolean validation;
  private int likecnt;
  private String introduction;
  
}
