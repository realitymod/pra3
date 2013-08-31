#include "defines.sqh"
#include "scriptDefines.sqh"

var(_squadId) = _this select 0;
var(_unit)    = _this select 1;
var(_ft)      = _this select 2;

if (_squadId == (_unit call PRA3_fnc_unitGetSquad)) then
{
	var(_prevFt) = [_squadId, _unit] call PRA3_fnc_unitGetFt;
	var(_wasFtl) = false;

	var(_members) = _squadId call PRA3_fnc_squadGetMembers;
	{
		if ((_x select 0) == _unit) then
		{
			[
				_unit,
				"localizedMessage",
				"str_praa_squadsys_assign_ft_you",
				__fireteamNames select (_ft-1)
			] call PRAA_fMp_execClient;
		}
		else
		{
			if ((_x select 1) == (_ft + 10)) then
			{
				[
					_x select 0,
					"localizedMessage",
					"str_praa_squadsys_assign_ft",
					_unit call PRA3_fnc_getPlayerName
				] call PRAA_fMp_execClient;
			};
		};
	} forEach _members;
	diag_log _members;

	[_squadId, _unit, _ft] call PRA3_fnc_unitSetFt;
};

[[_squadId], _squadId call PRA3_fnc_squadGetSide] call PRA3_fnc_squadDlg_server_refresh;
