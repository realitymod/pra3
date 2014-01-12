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
				[
					"PRA3_squadsys_eventNotification",
					[
						"FIRETEAM ASSIGNED",
						format ["You have been assigned to FT %1", __fireteamNames select (_ft-1)]
					]
				],
				"BIS_fnc_showNotification",
				_unit
			] call PRA3_fnc_MP;
		}
		else
		{
			if ((_x select 1) == (_ft + 10)) then
			{
				[
					[
						"PRA3_squadsys_eventNotification",
						[
							"NEW FT MEMBER",
							format ["%1 has been assigned to your FT", _unit call PRA3_fnc_getPlayerName]
						]
					],
					"BIS_fnc_showNotification",
					_x select 0
				] call PRA3_fnc_MP;
			};
		};
	} forEach _members;

	[_squadId, _unit, _ft] call PRA3_fnc_unitSetFt;
};

[[_squadId], _squadId call PRA3_fnc_squadGetSide] call PRA3_fnc_squadDlg_server_refresh;
