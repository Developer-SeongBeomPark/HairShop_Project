package com.study.mail;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.designer.DesignerService;
import com.study.reserve.ReserveDTO;
import com.study.user.UserService;

@Controller
public class MailController {
  @Autowired
  @Qualifier("com.study.user.UserServiceImpl")
  private UserService service;

  @Autowired
  @Qualifier("com.study.designer.DesignerServiceImpl")
  private DesignerService dservice;

  @Autowired
  private JavaMailSender mailSender;

  @Value("${spring.mail.username}")
  private String fromMail;

  
  @GetMapping("/findidmail")
  @ResponseBody
  public String sendIdByMail(@RequestParam Map<String, String> map) {

    String uid = service.findId(map);
    String uname = map.get("uname");
    String uemail = map.get("uemail");

    if (uid != null) {

      SimpleMailMessage message = new SimpleMailMessage();

      message.setTo(uemail);// 받는사람 메일주소
      message.setSubject("[Beom] " + uname + "님의 아이디 안내");// 메일제목
      message.setText("해당 정보와 일치하는\n회원님의 아이디는 " + uid + "입니다.");// 메일내용
      message.setFrom(fromMail);
      mailSender.send(message);

      return "입력하신 이메일로 아이디가 전송되었습니다.";

    } else {

      return "해당 정보로 등록된 아이디는 존재하지 않습니다.";

    }
  }

  @GetMapping("/findpwmail")
  @ResponseBody
  public String sendPwByMail(@RequestParam Map<String, String> map) {

    String upw = service.findPw(map);
    String uid = map.get("uid");
    String uemail = map.get("uemail");

    if (upw != null) {

      SimpleMailMessage message = new SimpleMailMessage();

      message.setTo(uemail);
      message.setSubject("[Beom] " + uid + "님의 비밀번호 안내");
      message.setText("해당 정보와 일치하는\n회원님의 비밀번호는 " + upw + "입니다.");
      message.setFrom(fromMail);
      mailSender.send(message);

      return "입력하신 이메일로 비밀번호가 전송되었습니다.";

    } else {

      return "해당 정보로는 비밀번호를 찾을 수 없습니다. 다시 확인해주세요.";

    }

  }
  
  @GetMapping("/dfindidmail")
  @ResponseBody
  public String dsendIdByMail(@RequestParam Map<String, String> map) {

    String did = dservice.findId(map);
    String dname = map.get("dname");
    String demail = map.get("demail");

    if (did != null) {

      SimpleMailMessage message = new SimpleMailMessage();

      message.setTo(demail);// 받는사람 메일주소
      message.setSubject("[Beom] " + dname + "님의 아이디 안내");// 메일제목
      message.setText("해당 정보와 일치하는\n회원님의 아이디는 " + did + "입니다.");// 메일내용
      message.setFrom(fromMail);
      mailSender.send(message);

      return "입력하신 이메일로 아이디가 전송되었습니다.";

    } else {

      return "해당 정보로 등록된 아이디는 존재하지 않습니다.";

    }
  }

  @GetMapping("/dfindpwmail")
  @ResponseBody
  public String dsendPwByMail(@RequestParam Map<String, String> map) {

    String dpw = dservice.findPw(map);
    String did = map.get("did");
    String demail = map.get("demail");

    if (dpw != null) {

      SimpleMailMessage message = new SimpleMailMessage();

      message.setTo(demail);
      message.setSubject("[Beom] " + did + "님의 비밀번호 안내");
      message.setText("해당 정보와 일치하는\n회원님의 비밀번호는 " + dpw + "입니다.");
      message.setFrom(fromMail);
      mailSender.send(message);

      return "입력하신 이메일로 비밀번호가 전송되었습니다.";

    } else {

      return "해당 정보로는 비밀번호를 찾을 수 없습니다. 다시 확인해주세요.";

    }

  }


  @Async
  @GetMapping("/rconfig/{reserveno}")
  public void rconfig(@PathVariable int reserveno, HttpSession session) {
    ReserveDTO rdto = dservice.reserve_detail(reserveno);


    SimpleMailMessage message = new SimpleMailMessage();

    message.setTo(rdto.getUdto().getUemail());
    message.setSubject("[Beom] " + rdto.getUdto().getUname() + "님의 예약 확정 메일입니다.");
    message.setText("고객명 : " + rdto.getUdto().getUname() + "\n"
        + "예약 날짜 : " + rdto.getEdto().getEnrolldate() + "\n"
        + "예약 시간 : " + rdto.getEdto().getEnrolltime() + "\n"
        + "시술 명 : " + rdto.getEdto().getEmenu() + "\n"
        + "가격 : " + rdto.getEdto().getEprice()
        );
    message.setFrom(fromMail);
    mailSender.send(message);

  }

}