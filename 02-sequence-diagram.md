```mermaid

sequenceDiagram
  participant CLISRC as Client Source
  participant CLICFG as Client Server Connection
  participant SRV as Cloud Config Server
  participant SRVCFG as Cloud Config Server Config Files

  CLISRC ->> CLICFG: Request for Configuration Values
  CLICFG ->> SRV: Request for Configuration Values
  SRV <<->> CLICFG: TLS Handshake
  SRV ->> SRVCFG: Request for Configuration Values
  SRVCFG ->> SRV: Response with Configuration Values
  SRV ->> CLICFG: Response with Configuration Values
  CLICFG ->> CLISRC: Response with Configuration Values


