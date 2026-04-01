package com.n11.sportshop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
// @SpringBootApplication(exclude =
// {org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class
// })
public class SportshopApplication {
	public static void main(String[] args) {
		ApplicationContext beans = SpringApplication.run(SportshopApplication.class, args);
		for (String s : beans.getBeanDefinitionNames()) {
			System.out.println(s);
		}
	}

}
