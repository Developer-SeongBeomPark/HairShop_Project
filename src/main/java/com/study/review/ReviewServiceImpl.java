package com.study.review;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("com.study.review.ReviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {
  @Autowired
  private ReviewMapper mapper;

  @Override
  public List<ReviewDTO> list(Map map) {
    // TODO Auto-generated method stub
    return mapper.list(map);
  }

  @Override
  public int total(Map map) {
    // TODO Auto-generated method stub
    return mapper.total(map);
  }

  @Override
  public ReviewDTO read(int rno) {
    // TODO Auto-generated method stub
    return mapper.read(rno);
  }


  @Override
  public int create(ReviewDTO vo) {
    // TODO Auto-generated method stub
    return mapper.create(vo);
  }

  @Override
  public int update(ReviewDTO vo) {
    // TODO Auto-generated method stub
    return mapper.update(vo);
  }

  @Override
  public int delete(int rno) {
    // TODO Auto-generated method stub
    return mapper.delete(rno);
  }

  @Override
  public double starAvg(String id) {
    // TODO Auto-generated method stub
    return mapper.starAvg(id);
  }

  @Override
  public int starAvg0(String id) {
    // TODO Auto-generated method stub
    return mapper.starAvg0(id);
  }




}