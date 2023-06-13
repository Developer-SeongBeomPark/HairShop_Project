package com.study.beom;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;
import org.springframework.web.servlet.view.tiles3.TilesViewResolver;

@Configuration
public class TilesConfiguration {
  @Bean
  public TilesConfigurer tilesConfigurer() {
      final TilesConfigurer configurer = new TilesConfigurer();
      //해당 경로에 tiles.xml 파일을 넣음
      configurer.setDefinitions(new String[]{"classpath:/templates/tiles_main.xml",
                                             "classpath:/templates/tiles_user.xml",
                                             "classpath:/templates/tiles_designer.xml",                                      
                                             "classpath:/templates/tiles_notice.xml",
                                             "classpath:/templates/tiles_review.xml",                                            
                                             "classpath:/templates/tiles_faq.xml",
                                             "classpath:/templates/tiles_hairmenu.xml",
                                              "classpath:/templates/tiles_style.xml",
                                              "classpath:/templates/tiles_enroll.xml"
                                             });
      configurer.setCheckRefresh(true);
      return configurer;

  }

  @Bean
  public TilesViewResolver tilesViewResolver() {
    final TilesViewResolver tilesViewResolver = new TilesViewResolver();
    tilesViewResolver.setViewClass(TilesView.class);
    return tilesViewResolver;
  }
}