package com.study.beom;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages= {"com.study.*"})
public class BeomApplication {

	public static void main(String[] args) {
		SpringApplication.run(BeomApplication.class, args);
	}

}
