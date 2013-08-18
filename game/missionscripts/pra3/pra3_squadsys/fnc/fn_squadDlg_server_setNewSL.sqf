#include "defines.sqh"
#include "scriptDefines.sqh"

var(_squadId) = _this select 0;
var(_unit)    = _this select 1;

if (_squadId == (_unit call PRA3_fnc_unitGetSquad)) then
{
	[_squadId, _unit] call PRA3_fnc_squadSetLeader;

	var(_members) = _squadId call PRA3_fnc_squadGetMembers;
	{
		if ((_x select 0) == _unit) then
		{
			[
				_x select 0,
				"localizedMessage",
				"str_praa_squadsys_promote_sl_you"
			] call PRA3_fMp_execClient;
		}
		else
		{
			[
				_x select 0,
				"localizedMessage",
				"str_praa_squadsys_promote_sl",
				_unit call PRA3_fnc_getPlayerName
			] call PRA3_fMp_execClient;
		};

		[
			_unit call PRA3_fnc_getPlayerUnit,
			"PRA3_fnc_updateVehicleMarker",
			_x select 0
		] call PRA3_fnc_MP;
	} forEach _members;
};

[[_squadId], _squadId call PRA3_fnc_squadGetSide] call PRA3_fnc_squadDlg_server_refresh;
