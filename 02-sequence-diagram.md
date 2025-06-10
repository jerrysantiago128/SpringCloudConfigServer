```mermaid

sequenceDiagram
  participant CLISRC as Client Source
  create participant CLICFG as Client Server Connection
  CLISRC ->> CLICFG: Request for Configuration Values



  create participant SRV as Cloud Config Server
  CLICFG ->> SRV: Request for Configuration Values
  SRV <<->> CLICFG: TLS Handshake

  create participant SRVCFG as Cloud Config Server Config Files
  SRV ->> SRVCFG: Request for Configuration Values
  SRVCFG ->> SRV: Response with Configuration Values
  destroy SRVCFG
  SRV ->> CLICFG: Response with Configuration Values
  destroy SRV
  CLICFG ->> CLISRC: Response with Configuration Values
  destroy CLICFG


