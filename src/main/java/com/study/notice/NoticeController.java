package com.study.notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.study.utility.Utility;

@Controller
public class NoticeController {

  @Autowired
  @Qualifier("com.study.notice.NoticeServiceImpl")
  private NoticeService service;
  
  
  @GetMapping("/admin/notice/delete")
  public String delete(int noticeno) {

    Map map = new HashMap();
    map.put("noticeno", noticeno);


    int cnt = 0;
    cnt = service.delete(noticeno);

    if (cnt == 1) {
      return "redirect:/notice/list";
    } else {
      return "error";
    }

  }
  
  @GetMapping("/notice/read")
  public String read(int noticeno, Model model) {
    service.upCnt(noticeno);
    NoticeDTO dto = service.read(noticeno);
    String content = dto.getNcontent().replaceAll("\r\n", "<br>"); // 엔터친거 br태그로 변환
    dto.setNcontent(content);
    model.addAttribute("dto", dto);
    
    return "/notice/read";
  }
  
  @PostMapping("/notice/edit")
  public String edit(NoticeDTO dto) {

    if (service.edit(dto) == 1) {
      return "redirect:list";
    } else {
      return "error";
    }

  }
  
  @GetMapping("/admin/notice/edit")
  public String edit(int noticeno, Model model) {
    model.addAttribute("dto", service.read(noticeno));
    
    return "/notice/edit";
  }
  
  @GetMapping("/admin/notice/write")
  public String create() {
    
    return "/notice/write";
  }
  
  @PostMapping("/notice/write")
  public String write(NoticeDTO dto) {
    if (service.write(dto) == 1) {
      return "redirect:list";
    } else {
      return "error";
    }
  }
  
  @GetMapping("/notice/list")
  public String list(HttpServletRequest request) {
    
    String col = Utility.checkNull(request.getParameter("col"));
    String word = Utility.checkNull(request.getParameter("word"));
 
    if (col.equals("total")) {
        word = "";
    }
    int nowPage = 1;
    if (request.getParameter("nowPage") != null) {
      nowPage = Integer.parseInt(request.getParameter("nowPage"));
    }
    int recordPerPage = 3;// 한페이지당 보여줄 레코드갯수
 
    // DB에서 가져올 순번-----------------
    int sno = ((nowPage - 1) * recordPerPage) ;
    // int eno = nowPage * recordPerPage;
 
    Map map = new HashMap();
    map.put("col", col);
    map.put("word", word);
    map.put("sno", sno);
    map.put("cnt", recordPerPage);
 
    int total = service.total(map);
 
    List<NoticeDTO> list = service.list(map);
 
    String paging = Utility.paging(total, nowPage, recordPerPage, col, word);
 
    request.setAttribute("list", list);
    request.setAttribute("nowPage", nowPage);
    request.setAttribute("col", col);
    request.setAttribute("word", word);
    request.setAttribute("paging", paging);

    return "/notice/list";
  }
}
