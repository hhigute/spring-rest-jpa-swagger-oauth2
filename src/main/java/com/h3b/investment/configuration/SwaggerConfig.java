package com.h3b.investment.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.google.common.collect.Lists;

import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.service.SecurityScheme;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spi.service.contexts.SecurityContext;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@EnableSwagger2
public class SwaggerConfig {

    @Autowired
    private SecurityScheme securityScheme;

    @Autowired
    private SecurityContext securityContext;

    @Bean
    public Docket companyApi() {
        return new Docket(DocumentationType.SWAGGER_2)
        		.groupName("Investment APIs")
                .apiInfo(apiInfo())
                .select()
                .apis(RequestHandlerSelectors.any())
                .paths(PathSelectors.ant("/api/v1/**"))
                .build()
                .securitySchemes(Lists.newArrayList(securityScheme))
                .securityContexts(Lists.newArrayList(securityContext));
    }

    @Bean
    public Docket authenticationApi() {
        return new Docket(DocumentationType.SWAGGER_2)
                .groupName("OAuth 2.0 API")
                .select()
                .apis(RequestHandlerSelectors.any())
                .paths(PathSelectors.ant("/oauth/**"))
                .build();
    }

    private ApiInfo apiInfo() {
    	return new ApiInfoBuilder().title("Investment APIs")
				.description("Spring Boot Investment - Restfull + JPA + OAuth2")
				.contact(new Contact("Helton Higute", "www.h3b.com.br", "helton.higute@gmail.com"))
				.licenseUrl("http://www.apache.org/licenses/LICENSE-2.0.html")
				.version("1.0")
				.build();
	}
}