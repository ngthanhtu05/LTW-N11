package com.n11.sportshop.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI sportShopOpenApi() {
        return new OpenAPI()
                .info(new Info()
                        .title("SportShop API")
                        .description("Swagger UI for SportShop endpoints")
                        .version("v1"));
    }
}
