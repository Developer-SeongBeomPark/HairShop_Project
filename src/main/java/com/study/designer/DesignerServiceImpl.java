package com.study.designer;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.hairmenu.HairmenuDTO;
import com.study.heart.HeartDTO;
import com.study.reserve.ReserveDTO;

@Service("com.study.designer.DesignerServiceImpl")
public class DesignerServiceImpl implements DesignerService {

  @Autowired
  private DesignerMapper mapper;
  
  
  @Override
  public int dcreate(DesignerDTO ddto) {
    // TODO Auto-generated method stub
    return mapper.dcreate(ddto);
  }

  @Override
  public int lcreate1(LicenseDTO ldto) {
    // TODO Auto-generated method stub
    return mapper.lcreate1(ldto);
  }

  @Override
  public int lcreate2(LicenseDTO ldto) {
    // TODO Auto-generated method stub
    return mapper.lcreate2(ldto);
  }

  @Override
  public int duplicatedId(String id) {
    // TODO Auto-generated method stub
    return mapper.duplicatedId(id);
  }

  @Override
  public int duplicatedEmail(String email) {
    // TODO Auto-generated method stub
    return mapper.duplicatedEmail(email);
  }

  @Override
  public int dlogin(Map map) {
    // TODO Auto-generated method stub
    return mapper.dlogin(map);
  }

  @Override
  public DesignerDTO dread(String did) {
    // TODO Auto-generated method stub
    return mapper.dread(did);
  }

  @Override
  public DesignerDTO dmypage(String did) {
    // TODO Auto-generated method stub
    return mapper.dmypage(did);
  }

  @Override
  public int intro_update(Map map) {
    // TODO Auto-generated method stub
    return mapper.intro_update(map);
  }

  @Override
  public LicenseDTO license(String did) {
    // TODO Auto-generated method stub
    return mapper.license(did);
  }

  @Override
  public int dupdate(DesignerDTO ddto) {
    // TODO Auto-generated method stub
    return mapper.dupdate(ddto);
  }

  @Override
  public List<HairmenuDTO> enroll_list(String did) {
    // TODO Auto-generated method stub
    return mapper.enroll_list(did);
  }

  @Override
  public List<ReserveDTO> reserve_list(String did) {
    // TODO Auto-generated method stub
    return mapper.reserve_list(did);
  }

  

  @Override
  public int dupdateFile(Map map) {
    // TODO Auto-generated method stub
    return mapper.dupdateFile(map);
  }

  @Override
  public ReserveDTO read_message(Map map) {
    // TODO Auto-generated method stub
    return mapper.read_message(map);
  }

  @Override
  public int reserve_cnt(int enrollno) {
    // TODO Auto-generated method stub
    return mapper.reserve_cnt(enrollno);
  }

  @Override
  public int delete_enroll(int enrollno) {
    // TODO Auto-generated method stub
    return mapper.delete_enroll(enrollno);
  }
  
  public String findId(Map<String, String> map) {
    // TODO Auto-generated method stub
    return mapper.findId(map);
  }

  @Override
  public String findPw(Map<String, String> map) {
    // TODO Auto-generated method stub
    return mapper.findPw(map);
  }

  @Override
  public int rconfig(int reserveno) {
    // TODO Auto-generated method stub
    return mapper.rconfig(reserveno);
  }

  public int total(Map map) {
    // TODO Auto-generated method stub
    return mapper.total(map);
  }

  @Override
  public List<DesignerDTO> list(Map map) {
    // TODO Auto-generated method stub
    return mapper.list(map);
  }

  @Override
  public int updateValidation(DesignerDTO ddto) {
    // TODO Auto-generated method stub
    return mapper.updateValidation(ddto);
  }

  @Override
  public int lupdate1(LicenseDTO cdto) {
    // TODO Auto-generated method stub
    return mapper.lupdate1(cdto);
  }

  @Override
  public int lupdate2(LicenseDTO cdto) {
    // TODO Auto-generated method stub
    return mapper.lupdate2(cdto);

  }

  @Override
  public int delete(String did) {
    // TODO Auto-generated method stub
    return mapper.delete(did);
  }
  
  @Override
  public ReserveDTO reserve_detail(int reserveno) {
    // TODO Auto-generated method stub
    return mapper.reserve_detail(reserveno);
  }

  @Override
  public List<DesignerDTO> getList(String searchWrd) {
    // TODO Auto-generated method stub
    return mapper.getList(searchWrd);
  }

  @Override
  public List<DesignerDTO> searchList(Map map) {
    // TODO Auto-generated method stub
    return mapper.searchList(map);
  }

  @Override
  public int chkReserve(String did) {
    // TODO Auto-generated method stub
    return mapper.chkReserve(did);
  }

  @Override
  public void delReserve(String did) {
    mapper.delReserve(did);
  }


}
