/*
- control de limite de slots, por orden de llegada * 
- te saca si ingresas tarde *
- Maximo de reconexiones por persona ***

*/

_limitReconections =  missionNamespace getVariable ["NSN_VAR_LIMIT_RECONECTIONS",true];
_maxReconections = missionNamespace getVariable ["NSN_VAR_MAX_RECONECTIONS",4];
_allowLateConnections = missionNamespace getVariable ["NSN_VAR_LIMIT_RECONECTIONS",true];
_toolate = missionNamespace getVariable ["NSN_VAR_LATE",(60*20)]; 