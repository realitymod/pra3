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
				[
					"PRA3_squadsys_eventNotification",
					[
						"NEW SQUAD LEADER",
						"You are now the leader of your squad"
					]
				],
				"BIS_fnc_showNotification",
				_x select 0
			] call PRA3_fnc_MP;
		}
		else
		{
			[
				[
					"PRA3_squadsys_eventNotification",
					[
						"NEW SQUAD LEADER",
						format ["%1 is the new leader of your squad", _unit call PRA3_fnc_getPlayerName]
					]
				],
				"BIS_fnc_showNotification",
				_x select 0
			] call PRA3_fnc_MP;
		};

		[
			_unit call PRA3_fnc_getPlayerUnit,
			"PRA3_fnc_updateVehicleMarker",
			_x select 0
		] call PRA3_fnc_MP;
	} forEach _members;
};

[[_squadId], _squadId call PRA3_fnc_squadGetSide] call PRA3_fnc_squadDlg_server_refresh;
