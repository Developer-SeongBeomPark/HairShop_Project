package com.study.enroll;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.category.CategoryDTO;
import com.study.designer.DesignerDTO;
import com.study.hairmenu.HairmenuDTO;

@Controller
public class EnrollController {

  @Autowired
  @Qualifier("com.study.enroll.EnrollServiceImpl")
  private EnrollService service;

  @GetMapping("/enroll/designer")
  public String reservation(Model model, HttpSession session) {
    // 아래 id 는 디자이너페이지에서 받을 디자이너아이디
    String id = (String)session.getAttribute("did");

    List<HairmenuDTO> list = service.list(id);
    model.addAttribute("list", list);
    System.out.println("리스트" + list);

    // 디자이너가 등록한 카테고리 list 갖고오기.
    Set<CategoryDTO> catenameList = service.catenameList(id);
    System.out.println(catenameList);
    model.addAttribute("cateNameList", catenameList);

    // 디자이너가 등록한 (menu , pirce) list 갖고오기

    List<HairmenuDTO> menuPriceList = service.menuPriceList(id);
    model.addAttribute("menuPriceList", menuPriceList);

    return "/enroll/designer";
  }

  @GetMapping("/datareq/{gender}/{category}")
  @ResponseBody
  public List<HairmenuDTO> list(@PathVariable("gender") String gender, @PathVariable("category") String category,
      Model model, HttpSession session) {
    //String did = "designer1";
    String did = (String)session.getAttribute("did");
    Map map = new HashMap();
    map.put("id", did);
    map.put("hgender", gender);
    map.put("catename", category);

    List<HairmenuDTO> list = service.menuInfo(map);
    System.out.println(list);
    return list;
  }

  
  // 예약 입력 후 sumbit 버튼 클릭시 입력데이터 를 받는컨트롤러
  @PostMapping("/designerMypage")
  public String reservationList(String category, String gender, String menu, String price, String time, String date, Model model, HttpSession session) {
    Map map = new HashMap();
    map.put("date", date);
    map.put("time", time);
    map.put("emenu", menu);
    map.put("eprice", price);
    map.put("did", (String)session.getAttribute("did"));

    Map map2 = new HashMap();
    map2.put("menu", menu);// 메뉴명 적을 때 띄어쓰기 하면 오류 발생함
    map2.put("did", (String)session.getAttribute("did"));
    System.out.println("map2 : " + map2);
    int menuno = service.menunoGet(map2); 
    
    System.out.println("menuno : " + menuno);
    map.put("menuno", menuno);
    // 예약등록
    int cnt = service.enrollInput(map);
    System.out.println("cnt : " + cnt);
    if (cnt > 0) {
      return "redirect:/dmypage";
    } else {
      model.addAttribute("msg", "등록에 실패했습니다.");
      return "/errorMsg";
    }

  }

  // 고객 예약신청 페이지
  @GetMapping("/reserve")
  public String reserve(@RequestParam String did, HttpSession session, Model model) {
    String userId = (String)session.getAttribute("uid");
    String desId = did;
    // 디자이너 id 를 이용해서 예약 리스트를 불러온다.
    model.addAttribute("list", service.asOfEnrollList(desId));
    return "/reserve";
  }

  // PostMapping 은 insert 만 담당
  @PostMapping("/reserve")
  public String reserveInsert(HttpSession session, String enrollno, String message) {
    Map map = new HashMap<>();
    map.put("enrollno", enrollno);
    map.put("uid", (String)session.getAttribute("uid"));
    map.put("message", message);
    //  insert 하고
    int cnt = service.userInsert(map);
    if (cnt == 1) {
      System.out.println("reserve insert success");
      // PRG 패턴 사용
      return "redirect:/user/mypage";
    }else {
      return "error";
    }
  }
  

  //enrollno 가 reserve 에 있는지 없는지 checking
  @PostMapping("/enrollnoCheck/{enrollno}")
  @ResponseBody
  public String enrollnoChecking(@PathVariable("enrollno") String enrollno) {
    System.out.println(enrollno);
    String no = enrollno;
    int flag = service.checking(no);
    if(flag == 1) {
      System.out.println("체크함");
      String text = "예약불가";
      return text;
    }else {
      return "error";
    }
  }

}
