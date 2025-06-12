```mermaid 

graph LR 
  subgraph ConfigServer
    subgraph ConfigServerSource
      SRC1[application.yml]
      SRC2[src/main/java/]
    end
    subgraph ConfigFolder
      C1[app1profile.yml]
      C2[app2profile.yml]
    end
    subgraph Server Certificates
      SRVCRT[server.crt]
      SRVKEY[server.key]
    end
  end

  subgraph External Applications
    subgraph Application 1
      AY1[application.yml]
      CLI1[src/main/java/]
    end
    subgraph Application 2
      AY2[application.yml]
      CLI2[src/main/java/]
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

C1 <-- "HTTPS" -->  AY1
C2 <-- "HTTPS" -->  AY2

SRVCRT <--> CRT <--> CLICRT
SRVKEY <--> KEY <--> CLIKEY