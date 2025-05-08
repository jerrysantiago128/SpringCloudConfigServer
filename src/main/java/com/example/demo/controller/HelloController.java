package com.example.demo.controller;

import com.example.demo.config.AppProperties;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    private final AppProperties appProperties;

    public HelloController(AppProperties appProperties) {
        this.appProperties = appProperties;
    }

    @GetMapping("/app/config")
public String getConfig() {
    return String.format(
            "Message: %s<br>" +
            "Environment: %s<br>" +
            "Beta Enabled: %s<br>" +
            "User: %s<br>" +
            "Role: %s",
            appProperties.getMessage(),
            appProperties.getEnvironment(),
            appProperties.getFeatureToggle().isEnableBeta(),
            appProperties.getUser().getName(),
            appProperties.getUser().getRole()
        );  
    }
}
