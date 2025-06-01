# Details about innerworkings of Spring Cloud Config Server and Client

The details listed below describe the WHAT, WHY AND HOW both the Server and Client implementations work together for external configurations of Spring Applications

Traditional Spring Configuration Goals:
    
1) **Externalized** --> property files

2) **Environment Specifc** --> spring profiles

3) **Consistent** --> none; configuration changes on one service/microservice only affects that service, not the entire set of services

4) **Version History** --> none; every new deployment and configuration is "unique"

5) **Real Time Management** --> none; have to rebuild the jar and restart the service in order to deploy the new configuration

To solve these issues we can use a Spring Cloud Config Server:

Spring Cloud Config Server itself is a microservice that can be used to configure other microservices in an environment.

This can be the **Config Server** itself or a **Git Repository** as the source of this configuration as well.

By consolidating the configurations used for the microservice(s), we can keep consistent, version controlled, configurations for our microservice(s)

that can be deployed in Real time or Near Real time. 

Using this style of configuration ensure that we do not have to restart, rebuild, and redeploy one or many services in a microservice environment.

In an instance of having one service running, this is not a big issue. When you have multiple instance of the same service or an environment where

you have different services relying on different but similar conifgurations, have to restart, rebuild and redeploy such an environment a risky and costly task.

This is especially costly for services or applications that require high uptime and availability.
