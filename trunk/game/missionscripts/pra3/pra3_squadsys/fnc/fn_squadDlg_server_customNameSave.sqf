#include "defines.sqh"
#include "scriptDefines.sqh"

var(_squadId) = _this select 0;
var(_newName) = _this select 1;

[_squadId, _newName] call PRA3_fnc_squadSetName;

[[_squadId], _squadId call PRA3_fnc_squadGetSide] call PRA3_fnc_squadDlg_server_refresh;
