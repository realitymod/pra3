// Load mission-defined settings
if (isServer) then {PRA3_core setVariable ["PRA3_AAS_tickets", _this select 1, true]};
PRA3_AAS_teams            = _this select 0;
PRA3_AAS_zones            = _this select 2;
PRA3_AAS_bases            = _this select 3;
PRA3_AAS_respawns         = _this select 4;
PRA3_AAS_restrictionZones = _this select 5;
PRA3_AAS_startCamera      = _this select 6;
PRA3_AAS_randomDoorMarker = _this select 7;
