package com.study.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.study.designer.DesignerDTO;
import com.study.designer.DesignerService;
import com.study.heart.HeartService;
import com.study.utility.Utility;

@Controller
public class ReviewController { 
  private static final Logger log = LoggerFactory.getLogger(ReviewController.class); // 로그기록
  @Autowired
  @Qualifier("com.study.review.ReviewServiceImpl")
  private ReviewService service;
  @Autowired
  @Qualifier("com.study.designer.DesignerServiceImpl")
  private DesignerService dservice;
  @Autowired
  @Qualifier("com.study.heart.HeartServiceImpl")
  private HeartService hservice;

  
  @DeleteMapping("/review/{rno}/{oldfile}")
  public ResponseEntity<String> delete(@PathVariable("rno") int rno, @PathVariable String oldfile) {
    log.info("remove: " + rno);
    log.info("oldfile: " + oldfile);
    
    String upDir = UploadReview.getUploadDir();
//  String basePath = System.getProperty("user.dir")+"\\src\\main\\resources\\static\\review";
    
      if (oldfile != null && !oldfile.equals("no.jpg")) { // 원본파일 삭제
//      Utility.deleteFile(basePath, oldfile);
      Utility.deleteFile(upDir, oldfile);
      
    }
    
    return service.delete(rno) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
        : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
  }
  
  @PutMapping("/review/")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
  public ResponseEntity<String> update(ReviewDTO dto, String oldfile, HttpSession session, MultipartFile addfile) {
    System.out.println("modify: " + dto);

    
    // 기존 업데이트 코드
//    String basePath = System.getProperty("user.dir")+"\\src\\main\\resources\\static\\review";
    String upDir = UploadReview.getUploadDir();
    
    if (dto.getAddfile() != null && !dto.getAddfile().equals("")) {   // 파일을 올리면 새로 업로드
        if (oldfile != null && !oldfile.equals("no.jpg")) { // 원본파일 삭제
//        Utility.deleteFile(basePath, oldfile);
        Utility.deleteFile(upDir, oldfile);
      }
//        String fname = Utility.saveFileSpring(dto.getAddfile(), basePath);
        String fname = Utility.saveFileSpring(dto.getAddfile(), upDir);
        dto.setRfilename(fname);

    }
    else  {
      if (oldfile != null && oldfile.equals("no.jpg")) { // 원본파일 삭제
        dto.setRfilename("no.jpg");
      }else if(oldfile != null && !oldfile.equals("no.jpg")){
        dto.setRfilename(oldfile);
      }
      
    }
    
    //기존 수정만
    return service.update(dto) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
        : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
 
  }
  
  @PostMapping("/review/create")
  @ResponseBody
  public ResponseEntity<String> create(ReviewDTO dto) {
    log.info("title: " + dto);
    //System.out.println("create: " + vo);
    
//  String basePath = System.getProperty("user.dir")+"\\src\\main\\resources\\static\\review";
    String upDir = UploadReview.getUploadDir();
    if (dto.getAddfile() != null) {
      String fname = Utility.saveFileSpring(dto.getAddfile(), upDir);
      dto.setRfilename(fname);
    } 
    else {
      dto.setRfilename("no.jpg");   // 파일 업로드 안하면 no.jpg 파일로 들어감
    }
    
    dto.setRcontent(dto.getRcontent().replaceAll("/n/r", "<br>"));  // 모달등록
 
    int flag = service.create(dto);
 
    //log.info("Review INSERT flag: " + flag);
 
    return flag == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
        : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    
  }
  
  
  @GetMapping("/review/list/{rno}")
  public ResponseEntity<ReviewDTO> read (@PathVariable("rno") int rno) {  //조회
 
    //log.info("get: " + rno);
 
    return new ResponseEntity<>(service.read(rno), HttpStatus.OK);
  }
  
  
  @RequestMapping("/review/{did}/list")
  private String list (HttpSession session, HttpServletRequest request, Model model, @PathVariable String did) {  //리스트 페이지
    String id = did;
    
    DesignerDTO ddto = dservice.dmypage(id);
    model.addAttribute("ddto", ddto);
     //log.info("star: "+ service.starAvg());
    
    // 검색관련------------------------
    String col = Utility.checkNull(request.getParameter("col"));
    String word = Utility.checkNull(request.getParameter("word"));
 
    if (col.equals("total")) {
      word = "";
    }
 
    // 페이지관련-----------------------
    int nowPage = 1;// 현재 보고있는 페이지
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
    map.put("did", id);
 
    int total = service.total(map);
    
    if(session.getAttribute("uid") != null) {
      Map map2 = new HashMap();
      map2.put("uid", (String)session.getAttribute("uid"));
      map2.put("did", id);
      
      int flag = hservice.col_chk(map2);//DB에 컬럼이 존재하는지 확인
      if(flag == 0) {
        hservice.addCheck(map2);  //컬럼 추가
      }
      
      int heart_chk = hservice.getheartchk((map2));
      model.addAttribute("heart_chk", heart_chk);  // heart쪽 정보 가져오기
    }
 
    List<ReviewDTO> list = service.list(map);
 
    String paging = Utility.paging(total, nowPage, recordPerPage, col, word);
    
    // request에 Model사용 결과 담는다
    request.setAttribute("list", list);
    request.setAttribute("nowPage", nowPage);
    request.setAttribute("col", col);
    request.setAttribute("word", word);
    request.setAttribute("paging", paging);
    request.setAttribute("did", id);
    
    int cnt = service.starAvg0(id);
    if(cnt == 0) {
      request.setAttribute("starAvg", 0);
    } else {
      request.setAttribute("starAvg", String.format("%.2f",service.starAvg(id)));  //평균 별점 소수점 2번째자리까지
    }
    
    
    return "/review/list";
  }
}
  