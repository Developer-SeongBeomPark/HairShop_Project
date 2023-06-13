package com.study.user;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.enroll.EnrollDTO;

@Service("com.study.user.UserServiceImpl")
public class UserServiceImpl implements UserService {

  @Autowired
  private UserMapper mapper;

  @Override
  public int create(UserDTO dto) {
    return mapper.create(dto);
  }

  @Override
  public int duplicatedId(String id) {
    return mapper.duplicatedId(id);
  }

  @Override
  public int duplicatedEmail(String email) {
    return mapper.duplicatedEmail(email);
  }

  @Override
  public int loginCheck(Map<String, String> map) {
    return mapper.loginCheck(map);
  }

  @Override
  public Map getGrade(String id) {
    return mapper.getGrade(id);
  }

  @Override
  public String findId(Map<String, String> map) {
    return mapper.findId(map);
  }

  @Override
  public String findPw(Map<String, String> map) {
    return mapper.findPw(map);
  }

  @Override
  public UserDTO mypage(String id) {
    return mapper.mypage(id);
  }

  @Override
  public int update(UserDTO dto) {
    return mapper.update(dto);
  }

  @Override
  public int total(Map map) {
    return mapper.total(map);
  }

  @Override
  public List<UserDTO> list(Map map) {
    return mapper.list(map);
  }

  @Override
  public UserDTO read(String id) {
    return mapper.read(id);
  }

  @Override
  public List<EnrollDTO> reserveList(String id) {
    return mapper.reserveList(id);
  }

  @Override
  public List<EnrollDTO> historyList(String id) {
    return mapper.historyList(id);
  }

  @Override
  public int delete(String uid) {
    return mapper.delete(uid);
  }

  @Override
  public List<EnrollDTO> configList(String id) {
    return mapper.configList(id);
  }

  @Override
  public int pwUpdate(Map map) {
    return mapper.pwUpdate(map);
  }

  @Override
  public int minusLikecnt(String id) {
    // TODO Auto-generated method stub
    return mapper.minusLikecnt(id);
  }

}
