package com.study.hairmenu;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.study.designer.DesignerDTO;
import com.study.designer.DesignerService;
import com.study.heart.HeartDTO;
import com.study.heart.HeartService;

@Controller
public class HairmenuController { 
  private static final Logger log = LoggerFactory.getLogger(HairmenuController.class); // 로그기록
  @Autowired
  @Qualifier("com.study.hairmenu.HairmenuServiceImpl")
  private HairmenuService service;
  @Autowired
  @Qualifier("com.study.designer.DesignerServiceImpl")
  private DesignerService dservice;
  @Autowired
  @Qualifier("com.study.heart.HeartServiceImpl")
  private HeartService hservice;
  
  
  @GetMapping("/hairmenu/delete/{menuno}")
  public String delete(@PathVariable("menuno") int menuno, Model model, HttpSession session) {
    
    String did = (String)session.getAttribute("did");
    DesignerDTO ddto = dservice.dmypage(did);
    model.addAttribute("ddto", ddto);
    
      int cnt = 0;
      
      try {   
       cnt =  service.delete(menuno);
       return "redirect:/hairmenu/did"; 
       
      } catch(Exception e) {
        e.printStackTrace();
        model.addAttribute("msg", "예약등록/신청 내역이 있어 삭제가 불가능합니다.");
        return "/errorMsg";
      }

  }
  
  @GetMapping("/hairmenu/{did}/cateno/{cateno}")
  public String itemlist(HttpSession session, Model model, HttpServletRequest request, @PathVariable String did,
      @PathVariable int cateno) {
    
    String id = null;
    
    if(session.getAttribute("did")!=null) {   // 디자이너 로그인했을 때
      id = (String)session.getAttribute("did");
    } else {  // 유저 로그인했을 때
      id = did;
    }
    
    DesignerDTO ddto = dservice.dmypage(id);
    model.addAttribute("ddto", ddto);  // 디자이너 정보 가져오기
    
    Map map = new HashMap();
    map.put("did", did);
    map.put("cateno", cateno);
    List<HairmenuDTO> list = service.itemlist(map);  //카테번호별 리스트 가져오기
    request.setAttribute("list", list);  //담기
    
    if(session.getAttribute("uid") != null) {
      Map map2 = new HashMap();
      map2.put("uid", (String)session.getAttribute("uid"));
      map2.put("did", id);
      
      int flag = hservice.col_chk(map2);//DB에 컬럼이 존재하는지 확인
      if(flag == 0) {
        hservice.addCheck(map2);
      }
      
      int heart_chk = hservice.getheartchk((map2));
      model.addAttribute("heart_chk", heart_chk);  // heart쪽 정보 가져오기
    }
    
    return "/hairmenu";
  }
  
  @GetMapping("/hairmenu/{did}")
  public String list(HttpSession session, Model model, HttpServletRequest request, @PathVariable String did) {
    String id = null;
    
    if(session.getAttribute("did")!=null) {   // 디자이너 로그인했을 때
      id = (String)session.getAttribute("did");
    }else {  // 유저 로그인했을 때
      id = did;
    }
    
    DesignerDTO ddto = dservice.dmypage(id);
    model.addAttribute("ddto", ddto);  // 디자이너 정보 가져오기
    
    if(session.getAttribute("uid") != null) {
      Map map = new HashMap();
      map.put("uid", (String)session.getAttribute("uid"));
      map.put("did", id);
      
      int flag = hservice.col_chk(map);//DB에 컬럼이 존재하는지 확인
      if(flag == 0) {
        hservice.addCheck(map);
      }
      
      int heart_chk = hservice.getheartchk((map));
      model.addAttribute("heart_chk", heart_chk);  // heart쪽 정보 가져오기
    }
    
    List<HairmenuDTO> list = service.hlist(id);
    request.setAttribute("list", list);  //담기
    
    return "/hairmenu";
  }
  
  
  @PostMapping("/hairmenuEnroll")
  public String hairmenuEnroll(HairmenuDTO dto, HttpSession session, Model model, HttpServletRequest request) {
    DesignerDTO ddto = dservice.dmypage((String)session.getAttribute("did"));
    model.addAttribute("ddto", ddto);
    
    dto.setDid(ddto.getDid());
    String did = (String)session.getAttribute("did");
    
    int price = Integer.parseInt(request.getParameter("price"));
    String menu = request.getParameter("menu");
    String hgender = request.getParameter("hgender");
    int cateno = Integer.parseInt(request.getParameter("cateno"));
    
    Map map = new HashMap();
    map.put("did", did);
    map.put("price", price);
    map.put("menu", menu);
    map.put("hgender", hgender);
    map.put("cateno", cateno);
    
    int cnt = service.overHairmenu(map);
    // System.out.println("QQQQQQQQQQQQQQQQ: " + cnt);
    
    if (cnt == 0) {  // 중복값 없을 때 정상 실행
      
        if (service.hairmenuEnroll(dto) == 1) {  // 성공 시
          return "redirect:/hairmenu/did";
        } else {
          return "error";
        } 
        
    } else {  // 중복값이 있으면 등록x
     
      model.addAttribute("msg", "동일한 항목이 등록되어 있습니다.");
      return "/errorMsg";
      
    }
    
  }
  
  @GetMapping("/hairmenuEnroll")
  public String create(HttpSession session, Model model) {
    
    if (session.getAttribute("did") == null) {
      
      model.addAttribute("msg", "디자이너 권한이 없습니다. 디자이너로 로그인하세요.");
      return "/errorMsg";  //디자이너가 로그인 시 디자이너 로그인 페이지로 이동
    }
    
    DesignerDTO ddto = dservice.dmypage((String) session.getAttribute("did")); // 디자이너 정보
    model.addAttribute("ddto", ddto);
    
    return "/hairmenuEnroll";
  }

}
  