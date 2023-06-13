package com.study.designer;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.study.heart.HeartController;
import com.study.reserve.ReserveDTO;
import com.study.utility.Utility;

@Controller
public class DesignerController {

  @Autowired
  @Qualifier("com.study.designer.DesignerServiceImpl")
  private DesignerService dservice;

  @GetMapping("/dcreate")
  public String create() {
    return "/dcreate";
  }

  @PostMapping("/dcreate")
  public String create(DesignerDTO ddto, LicenseDTO ldto) {
    int flag1 = dservice.dcreate(ddto);
    int flag2 = 0;
//    System.out.println(ddto.getDid());
    System.out.println(ldto.getUniquecode2());
    if (ldto.getUniquecode2().equals("")) {// 수첩형 자격증
      flag2 = dservice.lcreate1(ldto);
    } else { // 상장형 자격증
      flag2 = dservice.lcreate2(ldto);
    }

    if (flag1 == 1 && flag2 == 1) {
      return "redirect:/";
    } else {
      return "error";
    }
  }

  @GetMapping(value = "/emailcheck", produces = "application/json;charset=utf-8")
  @ResponseBody
  public Map<String, String> emailcheck(String email) {
    int cnt = dservice.duplicatedEmail(email);

    Map<String, String> map = new HashMap<String, String>();
    if (cnt > 0) {
      map.put("str", email + "는 중복되어서 사용할 수 없습니다.");
    } else {
      map.put("str", email + "는 중복아님, 사용가능합니다.");
    }
    return map;
  }

  @GetMapping(value = "/idcheck", produces = "application/json;charset=utf-8")
  @ResponseBody
  public Map<String, String> idcheck(String id) {
    int cnt = dservice.duplicatedId(id);

    Map<String, String> map = new HashMap<String, String>();
    if (cnt > 0) {
      map.put("str", id + "는 중복되어서 사용할 수 없습니다.");
    } else {
      map.put("str", id + "는 중복아님, 사용가능합니다.");
    }
    return map;
  }

  @GetMapping("/dlogin")
  public String dlogin(HttpServletRequest request) {
    String chk_id = "";
    String cookie_did_val = "";

    Cookie[] cookies = request.getCookies();
    Cookie cookie = null;

    if (cookies != null) {
      for (int i = 0; i < cookies.length; i++) {
        cookie = cookies[i];

        if (cookie.getName().equals("chk_id")) {
          chk_id = cookie.getValue();
        } else if (cookie.getName().equals("cookie_did_val")) {
          cookie_did_val = cookie.getValue();
        }
      }
    }

    request.setAttribute("chk_id", chk_id);
    request.setAttribute("cookie_did_val", cookie_did_val);

    return "/dlogin";
  }

  @PostMapping("/dlogin")
  public String dlogin(@RequestParam Map<String, String> map, HttpSession session, Model model,
      HttpServletRequest request, HttpServletResponse response) {
    int flag = dservice.dlogin(map);

    if (flag > 0) {
      DesignerDTO ddto = dservice.dread(String.valueOf(map.get("did")));
      boolean validation = ddto.isValidation();

      if (!validation) {
        model.addAttribute("msg", "관리자의 자격승인이 필요합니다.");
        return "/errorMsg";
      }

      session.setAttribute("did", ddto.getDid());
      session.setAttribute("dname", ddto.getDname());
      session.setAttribute("validation", ddto.isValidation());
      session.setAttribute("dfilename", ddto.getDfilename());

      //System.out.println(ddto.getDfilename());
      model.addAttribute("ddto", ddto);

      Cookie cookie = null;
      String chk_id = request.getParameter("chk_id");

      if (chk_id != null) {

        cookie = new Cookie("chk_id", chk_id);
        cookie.setMaxAge(60 * 60 * 24 * 90);
        response.addCookie(cookie);

        cookie = new Cookie("cookie_did_val", (String) map.get("did"));
        cookie.setMaxAge(60 * 60 * 24 * 90);
        response.addCookie(cookie);

      } else if (chk_id == null || !validation) {

        cookie = new Cookie("chk_id", "");
        cookie.setMaxAge(0);
        response.addCookie(cookie);

        cookie = new Cookie("cookie_did_val", "");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
      }
      return "redirect:/";

    } else {
      model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력했거나<br>회원이 아닙니다. 회원가입하세요");
      return "/errorMsg";
    }
  }

  @GetMapping("/dmypage")
  public String designer_mypage(HttpSession session, Model model) {
    if (session.getAttribute("did") == null) {
      model.addAttribute("msg", "디자이너 권한이 없습니다. 디자이너로 로그인하세요.");

      return "/errorMsg";
    }

    DesignerDTO ddto = dservice.dmypage((String) session.getAttribute("did"));
    // List<EnrollDTO> enrollList2 =
    // dservice.enrollList((String)session.getAttribute("did"));
    // List<ReserveDTO> reserveList =
    // dservice.reserve_list((String)session.getAttribute("did"));
    // System.out.println(ddto.getDfilename());
    model.addAttribute("ddto", ddto);
    model.addAttribute("enrollList", dservice.enroll_list((String) session.getAttribute("did")));
    model.addAttribute("reserveList", dservice.reserve_list((String) session.getAttribute("did")));
    // System.out.println(dservice.reserve_list((String)
    // session.getAttribute("did")));
    // model.addAttribute("enrollList2",dservice.enrollList((String)session.getAttribute("did")));
    // System.out.println(enrollList2);
    return "/dmypage";
  }

  @GetMapping("/dmypage_intro_update")
  public String designer_introduction_update(Model model, HttpSession session) {
    DesignerDTO ddto = dservice.dmypage((String) session.getAttribute("did"));
    if (ddto.getIntroduction() == null)
      ddto.setIntroduction("");
    ddto.setIntroduction(ddto.getIntroduction().replaceAll("<br>", "\r\n"));
    model.addAttribute("ddto", ddto);
    model.addAttribute("enrollList", dservice.enroll_list((String) session.getAttribute("did")));
    model.addAttribute("reserveList", dservice.reserve_list((String) session.getAttribute("did")));
    return "/dmypage_intro_update";
  }

  @PostMapping("/dmypage_intro_update")
  public String designer_introduction_update(HttpServletRequest request, HttpSession session, Model model) {
    String introduction = request.getParameter("introduction").replaceAll("\r\n", "<br>");
    // System.out.println(text);

    Map map = new HashMap();
    map.put("introduction", introduction);
    map.put("did", (String) session.getAttribute("did"));

    int flag = dservice.intro_update(map);
    if (flag > 0) {
      DesignerDTO ddto = dservice.dread(String.valueOf(map.get("did")));
      model.addAttribute("ddto", ddto);

      return "redirect:/dmypage";
    } else {
      return "error";
    }

  }

  @GetMapping(value = { "/dmypage_update", "/admin/dupdate" })
  public String dmypage_update(@RequestParam String did, HttpServletRequest request, HttpSession session, Model model) {
    String id = null;

    if (request.getServletPath().equals("/dmypage_update")) {
      id = (String) session.getAttribute("did");
    } else if (request.getServletPath().equals("/admin/dupdate")) {
      id = did;
    }

    DesignerDTO ddto = dservice.dmypage(id);
    LicenseDTO cdto = dservice.license(id);

    model.addAttribute("ddto", ddto);
    model.addAttribute("cdto", cdto);

    return "/dmypage_update";
  }

  @PostMapping("/dupdate")
  public String dupdate(DesignerDTO ddto, LicenseDTO cdto, Model model, HttpSession session) {

    int flag1 = 0;
    int flag2 = 0;

    cdto.setDid(ddto.getDid());

    if (cdto.getUniquecode1() != null || cdto.getUniquecode2() == null) {
      flag1 = dservice.dupdate(ddto);
      flag2 = dservice.lupdate1(cdto);
    } else{
      flag1 = dservice.dupdate(ddto);
      flag2 = dservice.lupdate2(cdto);
    }

    if (flag1 > 0 && flag2 > 0) {

      if (session.getAttribute("grade") != null) {
        model.addAttribute("did", (String) session.getAttribute("uid"));
        return "redirect:/admin/designer/list";
      } else {
        model.addAttribute("did", (String) session.getAttribute("did"));
        return "redirect:/dmypage";
      }

    } else {
      model.addAttribute("msg", "[실패] 정보가 수정되지 않았습니다.");
      return "/errorMsg";
    }

  }

  @GetMapping("/designer/dupdateFileForm")
  public String dupdateFile(Model model, HttpSession session) {
    model.addAttribute("ddto", dservice.dmypage((String) session.getAttribute("did")));
    return "/designer/dupdateFileForm";
  }

  @PostMapping("/designer/dupdateFile")
  @ResponseBody
  public String updateFile(MultipartFile dfilenameMF, String oldfile, HttpSession session) throws IOException {
      String basePath = UploadDesignerFile.getUploadDir();
//    String basePath = System.getProperty("user.dir")+"\\src\\main\\resources\\static\\designer";
//    String basePath = System.getProperty("user.dir") + "root/deploy/designer";

    if (oldfile != null && !oldfile.equals("default.jpg")) { // 원본파일 삭제
      Utility.deleteFile(basePath, oldfile);
    }

    // pstorage에 변경 파일 저장
    Map map = new HashMap();
    map.put("did", (String) session.getAttribute("did"));
    map.put("dfilename", Utility.saveFileSpring(dfilenameMF, basePath));

    // 디비에 파일명 변경
    int cnt = dservice.dupdateFile(map);
    DesignerDTO ddto = dservice.dread((String) session.getAttribute("did"));
    session.putValue("dfilename", ddto.getDfilename());

    if (cnt == 1) {
      return "<script>"
          + " setTimeout(function(){\r\n"
          + "    location.replace('/dmypage');\r\n"
          + "  },2000);"
          +"</script>";
    } else {
      return "./error";
    }
  }

  @GetMapping("/reserve/{rnum}")
  public ResponseEntity<ReserveDTO> get(@PathVariable("rnum") int rnum, HttpSession session) {

    Map map = new HashMap();
    map.put("rnum", rnum);
    map.put("did", (String) session.getAttribute("did"));
    System.out.println(dservice.read_message(map));
    return new ResponseEntity<>(dservice.read_message(map), HttpStatus.OK);
  }

  @GetMapping("/designer/deleteEnroll/{enrollno}")
  public String deleteEnroll(@PathVariable int enrollno, Model model) {

    if (dservice.reserve_cnt(enrollno) > 0) {// 하나의 예약시간에 대해 하나의 예약신청만 가능하다.
      model.addAttribute("msg", "예약신청내역이 있어 삭제가 불가능합니다.");
      return "/errorMsg";
    } else {
      int flag = dservice.delete_enroll(enrollno);
      if (flag > 0) {
        return "redirect:/dmypage";
      } else {
        model.addAttribute("msg", "삭제 실패");
        return "/errorMsg";
      }
    }
  }

  @GetMapping("/dfindid")
  public String findid() {
    return "/dfindid";
  }

  @GetMapping("/dfindpw")
  public String findpw() {
    return "/dfindpw";
  }

  @GetMapping("/dmypage/rconfig/{reserveno}")
  @ResponseBody
  public String config_reserve(@PathVariable int reserveno, Model model) {
    int flag = dservice.rconfig(reserveno);

    if (flag > 0) {
      return "true";
    } else {
      return "false";
    }
  }

  @RequestMapping("/admin/designer/list")
  public String list(HttpServletRequest request) {
    // 검색
    String col = Utility.checkNull(request.getParameter("col"));
    String word = Utility.checkNull(request.getParameter("word"));

    if (col.equals("total")) {
      word = "";
    }
    // 페이지
    int nowPage = 1;
    if (request.getParameter("nowPage") != null) {
      nowPage = Integer.parseInt(request.getParameter("nowPage"));
    }
    int recordPerPage = 5;// 한페이지당 보여줄 레코드 수

    // DB에서 가져올 순번
    int sno = (nowPage - 1) * recordPerPage;
    int eno = recordPerPage;

    Map map = new HashMap();
    map.put("col", col);
    map.put("word", word);
    map.put("sno", sno);
    map.put("eno", eno);

    int total = dservice.total(map);

    List<DesignerDTO> list = dservice.list(map);

    String paging = Utility.paging(total, nowPage, recordPerPage, col, word);

    request.setAttribute("list", list);
    request.setAttribute("nowPage", nowPage);
    request.setAttribute("col", col);
    request.setAttribute("word", word);
    request.setAttribute("paging", paging);

    return "/dlist";
  }

  @GetMapping("/admin/approve")
  public String approve(@RequestParam String did, Model model) {
    DesignerDTO ddto = dservice.dmypage(did);
    LicenseDTO cdto = dservice.license(did);

    model.addAttribute("ddto", ddto);
    model.addAttribute("cdto", cdto);

    return "/dapprove";
  }

  @PostMapping("/dapprove")
  public String approve(DesignerDTO ddto, Model model) {
    int flag = dservice.updateValidation(ddto);
    if (flag > 0) {
      return "redirect:/admin/designer/list";
    } else {
      model.addAttribute("msg", "[실패] 승인여부가 수정되지 않았습니다.");
      return "/errorMsg";

    }
  }

  @GetMapping("/admin/ddelete/{did}")
  public String deletebyad(@PathVariable String did, Model model) {

      int chkReserve = dservice.chkReserve(did);
      if(chkReserve > 0) {
        dservice.delReserve(did);
      }
      try {
        int flag = dservice.delete(did);
        if(flag == 1) {
          return "redirect:/admin/designer/list";
        }else {
            model.addAttribute("msg","삭제가 되지 않았습니다.일시적 오류가 있을 수 있습니다.");
            return "/errorMsg";
        }
    } catch(Exception e) {
      model.addAttribute("msg","삭제가 되지 않았습니다.일시적 오류가 있을 수 있습니다.");
      return "/errorMsg";
    }
  }

  @GetMapping("/dmypage_delete")
  public String delete(@RequestParam String did, Model model) {
    model.addAttribute("did", did);
    return "/dmypage_delete";
  }

  @PostMapping("/dmypage_delete")
  public String delete(String dpw, HttpSession session, Model model) {

    String id = (String) session.getAttribute("did");

    DesignerDTO ddto = dservice.dmypage(id);

    if (!ddto.getDpw().equals(dpw)) {
      return "/passwdError";
    } else {
      try {
        int flag = dservice.delete(id);

        if (flag == 1) {
          session.invalidate();
          return "redirect:/";
        } else {
          model.addAttribute("msg", "고객예약이 있어 탈퇴가 불가능합니다.");
          return "/errorMsg";
        }
      } catch (Exception e) {
        model.addAttribute("msg", "탈퇴가 불가능합니다. 등록한 예약이나 신청된 내역이 있을 수 있습니다.");
        return "/errorMsg";
      }
    }
  }


  @RequestMapping("/search")
  public String searchList(HttpServletRequest request) {
    // 검색
    String col = Utility.checkNull(request.getParameter("col"));
    String word = Utility.checkNull(request.getParameter("word"));

    if (col.equals("total")) {
      word = "";
    }
    // 페이지
    int nowPage = 1;
    if (request.getParameter("nowPage") != null) {
      nowPage = Integer.parseInt(request.getParameter("nowPage"));
    }
    int recordPerPage = 5;// 한페이지당 보여줄 레코드 수

    // DB에서 가져올 순번
    int sno = (nowPage - 1) * recordPerPage;
    int eno = recordPerPage;

    Map map = new HashMap();
    map.put("col", col);
    map.put("word", word);
    map.put("sno", sno);
    map.put("eno", eno);

    List<DesignerDTO> slist = dservice.searchList(map);

    request.setAttribute("slist", slist);
    request.setAttribute("nowPage", nowPage);
    request.setAttribute("col", col);
    request.setAttribute("word", word);

    return "/search";
  }

}
