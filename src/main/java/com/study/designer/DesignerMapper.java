package com.study.designer;

import java.util.List;
import java.util.Map;

import com.study.hairmenu.HairmenuDTO;
import com.study.heart.HeartDTO;
import com.study.reserve.ReserveDTO;

public interface DesignerMapper {

  int dcreate(DesignerDTO ddto);

  int lcreate1(LicenseDTO ldto);
  
  int lcreate2(LicenseDTO ldto);

  int duplicatedId(String id);

  int duplicatedEmail(String email);

  int dlogin(Map map);

  DesignerDTO dread(String did);


  DesignerDTO dmypage(String did);

  int intro_update(Map map);

  LicenseDTO license(String did);

  int dupdate(DesignerDTO ddto);

  List<HairmenuDTO> enroll_list(String did);

  List<ReserveDTO> reserve_list(String did);

  

  int dupdateFile(Map map);

  ReserveDTO read_message(Map map);

  int reserve_cnt(int enrollno);

  int delete_enroll(int enrollno);

  String findId(Map<String, String> map);

  String findPw(Map<String, String> map);


  int rconfig(int reserveno);


  int total(Map map);


  List<DesignerDTO> list(Map map);
  
  int updateValidation(DesignerDTO ddto);
  
  int lupdate1(LicenseDTO cdto);
  
  int lupdate2(LicenseDTO cdto);

  ReserveDTO reserve_detail(int reserveno);
  
  int delete(String did);
  
  List<DesignerDTO> getList(DesignerDTO ddto);
  
  List<DesignerDTO> searchList(Map map);

  List<DesignerDTO> getList(String searchWrd);

  int chkReserve(String did);
  
  void delReserve(String did);
}