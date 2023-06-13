package com.study.hairmenu;



import java.util.List;

import com.study.category.CategoryDTO;
import com.study.enroll.EnrollDTO;

import lombok.Data;

@Data
public class HairmenuDTO {
  private int menuno;
  private int price;
  private String menu;
  private String did;
  private int cateno;
  private String hgender;
  
  private List<EnrollDTO> edto;
  private List<CategoryDTO> category;
  
  
  
}
