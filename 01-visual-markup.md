```mermaid 

graph LR 
  subgraph ConfigServer
    subgraph ConfigServerSource
      SRC[application.yml &/OR application.properties]
    end
    subgraph ConfigFolder
      C1[app1profile.properties]
      C2[app2profile.properties]
    end
    subgraph Server Certificates
      SRVCRT[server.crt]
      SRVKEY[server.key]
    end
  end

  subgraph External Applications
    subgraph Application 1
      AY1[application.yml]
      AP1[application.properties]
    end
    subgraph Application 2
      AY2[application.yml]
      AP2[application.properties]
    end
    subgraph Client Certificates
      CLICRT[server.crt]
      CLIKEY[server.key]
    end
  end

  subgraph Mounted Path
    CRT[server.crt]
    KEY[server.key]
  end

C1 <-- "HTTPS" --> AP1 <--> AY1
C2 <-- "HTTPS" --> AP2 <--> AY2

SRVCRT <--> CRT <--> CLICRT
SRVKEY <--> KEY <--> CLIKEY