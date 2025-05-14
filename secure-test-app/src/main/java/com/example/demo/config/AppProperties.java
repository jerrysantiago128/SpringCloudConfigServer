package com.example.demo.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "app")
public class AppProperties {

    private String message;
    private String environment;
    private FeatureToggle featureToggle;
    private User user;

    public static class FeatureToggle {
        private boolean enableBeta;

        public boolean isEnableBeta() {
            return enableBeta;
        }

        public void setEnableBeta(boolean enableBeta) {
            this.enableBeta = enableBeta;
        }
    }

    public static class User {
        private String name;
        private String role;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getRole() {
            return role;
        }

        public void setRole(String role) {
            this.role = role;
        }
    }

    // Getters and Setters for AppProperties fields

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getEnvironment() {
        return environment;
    }

    public void setEnvironment(String environment) {
        this.environment = environment;
    }

    public FeatureToggle getFeatureToggle() {
        return featureToggle;
    }

    public void setFeatureToggle(FeatureToggle featureToggle) {
        this.featureToggle = featureToggle;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
