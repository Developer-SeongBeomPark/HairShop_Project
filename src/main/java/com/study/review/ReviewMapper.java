package com.study.review;

import java.util.List;
import java.util.Map;

public interface ReviewMapper {

  List<ReviewDTO> list(Map map);
  int total(Map map);
  ReviewDTO read(int rno);
  int create(ReviewDTO vo);
  int update(ReviewDTO vo);
  int delete(int rno);
  double starAvg(String id);
  int starAvg0(String id);
}