#include "defines.sqh"
#include "scriptDefines.sqh"

var(_refreshSquadIds) = _this select 0;
var(_side)            = _this select 1;

{
	if (isPlayer _x && ((_x call PRA3_fnc_getPlayerSide) == _side)) then
	{
		[_refreshSquadIds, "PRA3_fnc_squadDlg_refresh", _x] call PRA3_fnc_MP;
	};
} forEach allUnits;
