package com.study.review;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ReviewDTO {
                           
 private int rno           ; 
 private String rtitle     ; 
 private String rcontent   ; 
 private String rdate      ; 
 private int star          ; 
 private String rfilename  ; 
 private String uid        ; 
 private String did        ;
 private MultipartFile addfile;
 
}
