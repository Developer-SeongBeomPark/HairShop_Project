package com.study.designer;

import java.util.List;
import java.util.Map;

import com.study.hairmenu.HairmenuDTO;
import com.study.heart.HeartDTO;
import com.study.reserve.ReserveDTO;

public interface DesignerService {

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

  List<HairmenuDTO> enroll_list(String did); //예약 등록 리스트(hairmenu가 기준인 쿼리)
  
  
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

  int delete(String did);
  
  ReserveDTO reserve_detail(int reserveno);

  List<DesignerDTO> getList(String searchWrd);

  List<DesignerDTO> searchList(Map map);

  int chkReserve(String did);

  void delReserve(String did);

}
