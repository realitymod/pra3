#include "defines.sqh"
#include "scriptDefines.sqh"

var(_refreshSquadIds) = _this select 0;
var(_side)            = _this select 1;

[_refreshSquadIds, "PRA3_fnc_squadDlg_refresh", _side] call PRA3_fnc_MP;
