```mermaid 

graph LR 
  subgraph ConfigServer
    subgraph ConfigFolder
      C1[app1profile.properties]
      C2[app2profile.properties]
      C3[app3profile.properties]
      C4[app4profile.properties]
    end
  end

  subgraph External Applications
    subgraph Application 1
      AY1[application.yml]
      AP1[application.properties]
    end
    subgraph Application 1
      AY2[application.yml]
      AP2[application.properties]
    end
    subgraph Application 1
      AY3[application.yml]
      AP3[application.properties]
    end
    subgraph Application 1
      AY4[application.yml]
      AP4[application.properties]
    end
  end


C1 <--> AP1 <--> AY1
C2 <--> AP2 <--> AY2
C3 <--> AP3 <--> AY3
C4 <--> AP4 <--> AY4