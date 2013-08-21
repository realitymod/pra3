#include "defines.sqh"
#include "scriptDefines.sqh"

[_this, !(_this call PRA3_fnc_squadIsLocked)] call PRA3_fnc_squadSetLocked;

[[_this], _this call PRA3_fnc_squadGetSide] call PRA3_fnc_squadDlg_server_refresh;
