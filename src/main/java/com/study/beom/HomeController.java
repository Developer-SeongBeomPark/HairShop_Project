package com.study.beom;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;


import com.study.designer.DesignerDTO;
import com.study.designer.DesignerService;
import com.study.utility.Utility;

import net.sf.json.JSONArray;

@Controller
public class HomeController {
  
  @Autowired
  @Qualifier("com.study.designer.DesignerServiceImpl")
  private DesignerService service;
  
  @GetMapping("/")
  public String home(HttpServletRequest request, ModelMap model, DesignerDTO ddto ) throws Exception{
    
    
    try {
      String searchWrd = request.getParameter("searchWrd");
      System.out.println(searchWrd);
      List<DesignerDTO> test = service.getList(searchWrd);
      model.addAttribute("ShopListJson", JSONArray.fromObject(test));
      model.addAttribute("test", test);
     
    }catch(Exception e) {
      System.out.println(e.toString());
    }
    return "/home";
  }
}