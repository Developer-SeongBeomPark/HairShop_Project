package com.study.heart;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.designer.DesignerDTO;
import com.study.designer.DesignerService;
import com.study.user.UserDTO;
import com.study.user.UserService;

@Controller
public class HeartController { 
  private static final Logger log = LoggerFactory.getLogger(HeartController.class); // 로그기록
  @Autowired
  @Qualifier("com.study.heart.HeartServiceImpl")
  private HeartService hservice;
  @Autowired
  @Qualifier("com.study.designer.DesignerServiceImpl")
  private DesignerService dservice;
  @Autowired
  @Qualifier("com.study.user.UserServiceImpl")
  private UserService uservice;
  
  @GetMapping("/plusHeart/{uid}/{did}")
  @ResponseBody
  public ResponseEntity<String> plusHeart(Model model, @PathVariable String uid, @PathVariable String did, 
      HttpSession session, HeartDTO hdto) {
    DesignerDTO ddto = dservice.dmypage(did);
    UserDTO udto = uservice.read(uid);
    
    Map map = new HashMap();
    map.put("did", did);
    map.put("uid", uid);
    
    hdto = hservice.read(map);
    System.out.println("HDTOOO : " + hdto);
    
    int flag = hdto.getHeart_chk();
 
    
    if (hdto.getHeart_chk() == 0) {
      hservice.heartPlus(map);  //디자이너에서 likecnt +1
      hservice.checkPlus(map);  // 하트테이블 heart_chk => 1로 바꿈
      flag = 1;
    }  // jsp에서 Heart_chk == 1이면 못움직이게
    
    System.out.println("FLAGGG : " + flag);
    
    model.addAttribute("hdto", hdto);

    return null;
    //log.info("PLUS : " + ddto);

    // else 취소 아까꺼에 -1 check -- 
//    return flag == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
//        : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
// 
  }

  @GetMapping("/minusHeart/{uid}/{did}")
  public ResponseEntity<String> minusHeart(Model model, @PathVariable String uid, @PathVariable String did, 
      HttpSession session, HeartDTO hdto) {
    DesignerDTO ddto = dservice.dmypage(did);
    UserDTO udto = uservice.read(uid);
    
    Map map = new HashMap();
    map.put("did", did);
    map.put("uid", uid);
    
    hdto = hservice.read(map);
    System.out.println("삭제시 HDTO :" + hdto);
    
    if (hdto.getHeart_chk() == 1) {  // heart_chk 가 1이면 likecnt -1 하고 다시 0으로 
      hservice.heartMinus(map);
      hservice.checkMinus(map);
    }  // jsp에서 Heart_chk == 1이면 못움직이게
    
    return null;
 
  }
  
}
  