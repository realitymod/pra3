#include "defines.sqh"
#include "scriptDefines.sqh"

var(_unit)    = _this select 0;
var(_squadId) = _this select 1;

if (_squadId == (_unit call PRA3_fnc_unitGetSquad)) then
{
	[_unit, _squadId] call PRA3_fnc_unitLeaveSquad;

	[
		_unit,
		"localizedMessage",
		"str_praa_squadsys_kicked_you"
	] call PRAA_fMp_execClient;
};

[[_squadId, 99], _squadId call PRA3_fnc_squadGetSide] call PRA3_fnc_squadDlg_server_refresh;
