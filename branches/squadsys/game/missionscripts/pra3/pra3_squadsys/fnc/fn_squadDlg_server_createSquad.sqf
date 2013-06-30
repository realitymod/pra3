#include "defines.sqh"
#include "scriptDefines.sqh"

var(_unit) = _this;

var(_squadId) = _unit call PRA3_fnc_createSquad;

[[_squadId, 99], _squadId call PRA3_fnc_squadGetSide] call PRA3_fnc_squadDlg_server_refresh;
