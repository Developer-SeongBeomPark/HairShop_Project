package com.study.enroll;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.category.CategoryDTO;
import com.study.hairmenu.HairmenuDTO;

@Service("com.study.enroll.EnrollServiceImpl")
public class EnrollServiceImpl implements EnrollService {

  @Autowired
  private EnrollMapper mapper;

  @Override
  public List<HairmenuDTO> list(String did) {

    return mapper.list(did);
  }

  // 디자이너별 등록된 카테고리리스트를 가지고옵니다.
  @Override
  public Set<CategoryDTO> catenameList(String did) {
    return mapper.catenameList(did);
  }

  // 디자이너별 등록된 menu,price를 가지고옵니다.
  @Override
  public List<HairmenuDTO> menuPriceList(String did) {

    return mapper.menuPriceList(did);
  }

  @Override
  public List<HairmenuDTO> menuInfo(Map map) {
    return mapper.menuInfo(map);
  }

  // 예약테이블에 예약등록
  @Override
  public int enrollInput(Map map) {
    return mapper.enrollInput(map);
  }

  // enroll 에insert 하기전에 시술명으로 해당 hairmenu 에 menuno 를 갖고온다
  @Override
  public int menunoGet(Map map) {

    return mapper.menunoGet(map);
  }

  @Override
  public Set<EnrollDTO> enrollList(String did) {

    return mapper.enrollList(did);
  }
  //enroll 테이블에 enrollno 로 데이터 삭제
  @Override
  public int enrollDelete(int enrollno) {

    return mapper.enrollDelete(enrollno);
  }
  //유저 reserve 테이블에 insert
  @Override
  public int userInsert(Map map) {
    return mapper.userInsert(map);
  }
  

  @Override
  public List<EnrollDTO> infoList(String did) {
    
    return mapper.infoList(did);
  }
  //reserve 테이블에서 enrollno 로 예약이 있는지 없는지 조회
  @Override
  public int checking(String enrollno) {
    
    return mapper.checking(enrollno);
  }

  @Override
  public Set<EnrollDTO> asOfEnrollList(String did) {
    // TODO Auto-generated method stub
    return mapper.asOfEnrollList(did);
  }
  

}