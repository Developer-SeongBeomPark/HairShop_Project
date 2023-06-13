package com.study.user;

import java.util.List;
import java.util.Map;

import com.study.enroll.EnrollDTO;

public interface UserService {

  int create(UserDTO dto);

  int duplicatedId(String id);

  int duplicatedEmail(String email);

  int loginCheck(Map<String, String> map);

  Map getGrade(String id);

  String findId(Map<String, String> map);

  String findPw(Map<String, String> map);

  UserDTO mypage(String id);

  int update(UserDTO dto);

  int total(Map map);

  List<UserDTO> list(Map map);

  UserDTO read(String id);

  List<EnrollDTO> reserveList(String id);

  List<EnrollDTO> historyList(String id);

  int delete(String uid);

  List<EnrollDTO> configList(String id);

  int pwUpdate(Map map);

  int minusLikecnt(String id);

}
