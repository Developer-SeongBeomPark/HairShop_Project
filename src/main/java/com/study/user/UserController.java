package com.study.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.designer.DesignerDTO;
import com.study.designer.DesignerService;
import com.study.enroll.EnrollDTO;
import com.study.heart.HeartService;
import com.study.utility.Utility;

@Controller
public class UserController {
  @Autowired
  @Qualifier("com.study.user.UserServiceImpl")
  private UserService service;
 
  @PostMapping("/pwUpdate")
  public String updatePw(HttpSession session, String upw, String newpw, Model model) {
    String id = (String) session.getAttribute("uid");
    UserDTO dto = service.read(id);
    
    Map map = new HashMap();
    map.put("uid", id);
    map.put("newpw", newpw);
    
    if(!dto.getUpw().equals(upw)) {
      model.addAttribute("msg","�쁽�옱 鍮꾨�踰덊샇媛� �씪移섑븯吏��븡�뒿�땲�떎.");
      return "/errorMsg";

    } else {
      int flag = service.pwUpdate(map);
      if(flag == 1) {
        session.invalidate();

        model.addAttribute("msg","鍮꾨�踰덊샇�닔�젙�씠 �셿猷뚮릺�뿀�뒿�땲�떎. �떎�떆 濡쒓렇�씤�빐二쇱꽭�슂");
        return "/newpwMsg";

      }else {
        model.addAttribute("msg", "[�떎�뙣] �젙蹂닿� �닔�젙�릺吏� �븡�븯�뒿�땲�떎.");
        return "/errorMsg";
      }
    }
  }
  
  @GetMapping("/user/updatePwForm")
  public String updatePwForm() {
    return "/user/updatePw";
  }
  
  @GetMapping("/user/delete")
  public String delete(@RequestParam String uid, Model model) {
    model.addAttribute("uid", uid);
    return "/user/delete";
  }
  
  @PostMapping("/user/delete")
  public String delete(String upw, HttpSession session) {
    
    String id = (String)session.getAttribute("uid");
    UserDTO dto = service.read(id);
    
    if(!dto.getUpw().equals(upw)) {
      return "/passwdError";
    }
    service.minusLikecnt(id);
    int flag = service.delete(id);
    if(flag == 1) {
      session.invalidate();
      return "redirect:/";
    }else {
      return "error";
    }
  }
  
  @GetMapping("/admin/udelete/{uid}")
  public String delete(@PathVariable String uid) {
    service.minusLikecnt(uid);
    int flag = service.delete(uid);
    
    if(flag != 1) {
      return "error";
    }else {
      return "redirect:/admin/user/list";
    }
  }
  
  @RequestMapping("/admin/user/list")
  public String list(HttpServletRequest request) {
    //寃��깋
    String col = Utility.checkNull(request.getParameter("col"));
    String word = Utility.checkNull(request.getParameter("word"));
    
    if(col.equals("total")) {
      word = "";
    }
    //�럹�씠吏�
    int nowPage = 1;
    if(request.getParameter("nowPage")!=null) {
      nowPage = Integer.parseInt(request.getParameter("nowPage"));
    }
    int recordPerPage = 5;//�븳�럹�씠吏��떦 蹂댁뿬以� �젅肄붾뱶 �닔
    
    //DB�뿉�꽌 媛��졇�삱 �닚踰�
    int sno = (nowPage-1)*recordPerPage;
    int eno = recordPerPage;
    
    Map map = new HashMap();
    map.put("col", col);
    map.put("word", word);
    map.put("sno", sno);
    map.put("eno", eno);
    
    int total = service.total(map);
    
    List<UserDTO> list = service.list(map);
    
    String paging = Utility.paging(total, nowPage, recordPerPage, col, word);
    
    request.setAttribute("list", list);
    request.setAttribute("nowPage", nowPage);
    request.setAttribute("col", col);
    request.setAttribute("word", word);
    request.setAttribute("paging", paging);
    
    return "/user/list";
  }
  
  @PostMapping("/user/update")
  public String update(UserDTO dto, HttpSession session, Model model) {
    int flag = 0;
    try {
      flag = service.update(dto);
      if(flag>0) {
        if(!dto.getUid().equals((String) session.getAttribute("uid"))) {
          model.addAttribute("id",session.getAttribute("uid"));
          return "redirect:/admin/user/list";
        }else {
          model.addAttribute("id",dto.getUid());
          return "redirect:/user/mypage";
        }
      }else {
        model.addAttribute("msg","[�떎�뙣] �젙蹂닿� �닔�젙�릺吏� �븡�븯�뒿�땲�떎.");
        return "/errorMsg";
      }
    }catch(Exception e) {
      model.addAttribute("msg","[�닔�젙 �떎�뙣] �젙蹂닿� �닔�젙�릺吏� �븡�븯�뒿�땲�떎. 以묐났�맂 �씠硫붿씪�씠 �엳�쓣 �닔 �엳�뒿�땲�떎.");
      return "/errorMsg";
    }
  }
  @GetMapping(value={"/user/update","/admin/user/update"})
  public String update(@RequestParam String uid, HttpSession session, HttpServletRequest request, Model model) {
    String id = null;
    
    if(request.getServletPath().equals("/user/update")) {
      id = (String) session.getAttribute("uid");
    }else if(request.getServletPath().equals("/admin/user/update")){
      id = uid;
    }
    
    if (id == null) {
      return "redirect:/user/login";
    }
    
    UserDTO dto = service.read(id);
    model.addAttribute("dto", dto);
    
    return "/user/update";

  }

  @GetMapping("/user/mypage")
  public String mypage(HttpSession session, Model model) {

    String id = (String) session.getAttribute("uid");
    List<EnrollDTO> list = service.reserveList(id);
    List<EnrollDTO> configList = service.configList(id);
    List<EnrollDTO> historyList = service.historyList(id);
    
    if (id == null) {
      return "redirect:/user/login";
    } else {

      UserDTO dto = service.mypage(id);
      model.addAttribute("dto", dto);
      model.addAttribute("reserveList", list);
      model.addAttribute("configList", configList);
      model.addAttribute("historyList", historyList);

      return "/user/mypage";
    }
  }

  @GetMapping("/user/agree")
  public String agree() {
    return "/user/agree";
  }

  @GetMapping("/user/userchoice")
  public String userchoice() {
    return "/user/userchoice";
  }

  @GetMapping("/user/joinForm")
  public String join() {
    return "/user/join";
  }

  @PostMapping("/user/join")
  public String join(UserDTO dto, HttpServletRequest request) {
    if (service.create(dto) > 0) {
      return "redirect:/";
    } else {
      return "error";
    }
  }

  @GetMapping(value = "/user/idcheck", produces = "application/json;charset=utf-8")
  @ResponseBody
  public Map<String, String> idcheck(String uid) {
    int cnt = service.duplicatedId(uid);
    Map<String, String> map = new HashMap<String, String>();
    if (cnt > 0) {
      map.put("str", uid + "�뒗 以묐났�맂 �븘�씠�뵒�엯�땲�떎.");
    } else {
      map.put("str", uid + "�뒗 �궗�슜媛��뒫�븳 �븘�씠�뵒�엯�땲�떎.");
    }
    return map;
  }

  @GetMapping(value = "/user/emailcheck", produces = "application/json;charset=utf-8")
  @ResponseBody
  public Map<String, String> emailcheck(String uemail) {
    int cnt = service.duplicatedEmail(uemail);
    Map<String, String> map = new HashMap<String, String>();
    if (cnt > 0) {
      map.put("str", uemail + "�뒗 以묐났�맂 �씠硫붿씪�엯�땲�떎.");
    } else {
      map.put("str", uemail + "�뒗 �궗�슜媛��뒫�븳 �씠硫붿씪�엯�땲�떎.");
    }
    return map;
  }

  @GetMapping("/logout")
  public String logout(HttpSession session) {
    session.invalidate();
    return "redirect:/";
  }

  @GetMapping("/user/login")
  public String login(HttpServletRequest request) {
    
    String chk_id = "";
    String cookie_uid_val = "";

    Cookie[] cookies = request.getCookies();
    Cookie cookie = null;

    if (cookies != null) {
      for (int i = 0; i < cookies.length; i++) {
        cookie = cookies[i];

        if (cookie.getName().equals("chk_id")) {
          chk_id = cookie.getValue();
        } else if (cookie.getName().equals("cookie_uid_val")) {
          cookie_uid_val = cookie.getValue();
        }
      }
    }

    request.setAttribute("chk_id", chk_id);
    request.setAttribute("cookie_uid_val", cookie_uid_val);
    
    return "/user/login";
  }

  @PostMapping("/user/login")
  public String login(@RequestParam Map<String, String> map, HttpSession session, HttpServletResponse response,
      HttpServletRequest request, Model model) {

    int cnt = service.loginCheck(map);
    if (cnt > 0) {
      Map gmap = service.getGrade(map.get("uid"));
      session.setAttribute("uid", map.get("uid"));
      session.setAttribute("uname", gmap.get("uname"));
      session.setAttribute("grade", gmap.get("grade"));// �꽭�뀡���옣

      Cookie cookie = null;
      String chk_id = request.getParameter("chk_id");

      if (chk_id != null) {

        cookie = new Cookie("chk_id", chk_id);
        cookie.setMaxAge(60 * 60 * 24 * 90);
        response.addCookie(cookie);

        cookie = new Cookie("cookie_uid_val", map.get("uid"));
        cookie.setMaxAge(60 * 60 * 24 * 90);
        response.addCookie(cookie);

      } else {

        cookie = new Cookie("chk_id", "");
        cookie.setMaxAge(0);
        response.addCookie(cookie);

        cookie = new Cookie("cookie_uid_val", "");
        cookie.setMaxAge(0);
        response.addCookie(cookie);

      }

      return "redirect:/";

    } else {

      model.addAttribute("msg", "�븘�씠�뵒 �삉�뒗 鍮꾨�踰덊샇瑜� �옒紐� �엯�젰�뻽嫄곕굹<br>�쉶�썝�씠 �븘�떃�땲�떎. �쉶�썝媛��엯�븯�꽭�슂");

      return "/errorMsg";
    }
  }

  @GetMapping("/user/findid")
  public String findid() {
    return "/user/findid";
  }

  @GetMapping("/user/findpw")
  public String findpw() {
    return "/user/findpw";
  }

}
