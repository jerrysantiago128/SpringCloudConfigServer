```mermaid

sequenceDiagram
  participant CLISRC as Client Source
  participant CLICFG as Client Server Connection
  participant SRV as Cloud Config Server
  participant SRVCFG as Cloud Config Server Config Files

  CLISRC ->> CLICFG: Do you have my configuration values?
  CLICFG ->> CLISRC: Let me grab them from the Server
  CLICFG ->> SRV: Hey I am looking for my configuration values
  SRV ->> CLICFG: Do you have the proper certificate(s)?
  CLICFG ->> SRV: Yes, here it is
  SRV ->> CLICFG: Good. Now what do you need?
  CLICFG ->> SRV: I need configurations for my 'application'.
  SRV ->> SRVCFG: Do you have a configuration resource for 'application'?
  SRVCFG ->> SRV: Yes, here it is
  SRV ->> CLICFG: Here is you configuration(s).
  CLICFG ->> CLISRC: Thanks


