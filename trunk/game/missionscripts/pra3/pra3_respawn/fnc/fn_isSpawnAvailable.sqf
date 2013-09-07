#include "scriptDefines.sqh"

var(_unit)  = _this select 0;
var(_spawn) = _this select 1;

(_spawn != "" && {{_spawn == (_x select 0)} count (_unit call PRA3_fnc_getAvailableSpawns) > 0})
