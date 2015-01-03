#include "defines.sqh"
#include "scriptDefines.sqh"

var(_squadId) = _this select 0;
var(_unit)    = _this select 1;

if (_squadId == (_unit call PRA3_fnc_unitGetSquad)) then
{
	var(_prevFt) = [_squadId, _unit] call PRA3_fnc_unitGetFt;
	var(_ftLeader) = [_squadId, _prevFt] call PRA3_fnc_squadGetFtLeader;

	[_squadId, _unit, 0] call PRA3_fnc_unitSetFt;

	if (_ftLeader == _unit) then
	{
		var(_newLeader) = [_squadId, _prevFt] call PRA3_fnc_squadGetFtLeader;
		var(_members) = _squadId call PRA3_fnc_squadGetMembers;
		{
			if ((_x select 1) == _prevFt) then
			{
				[
					[
						"PRA3_squadsys_eventNotification",
						[
							"NEW FT LEADER",
							format ["%1 is now the leader of your fireteam", _unit call PRA3_fnc_getPlayerName]
						]
					],
					"BIS_fnc_showNotification",
					_x select 0
				] call PRA3_fnc_MP;
			};
		} forEach _members;
		if (_newLeader != "") then
		{
			[
				[
					"PRA3_squadsys_eventNotification",
					[
						"NEW FT LEADER",
						"You are now the leader of your fireteam"
					]
				],
				"BIS_fnc_showNotification",
				_newLeader
			] call PRA3_fnc_MP;
		};
	}
	else
	{
		[
			[
				"PRA3_squadsys_eventNotification",
				[
					"FT MEMBER UNASSIGNED",
					format ["%1 has been unassigned from your fireteam", _unit call PRA3_fnc_getPlayerName]
				]
			],
			"BIS_fnc_showNotification",
			_ftLeader
		] call PRA3_fnc_MP;
	};

	[
		[
			"PRA3_squadsys_eventNotification",
			[
				"FIRETEAM UNASSIGNED",
				"You have been unassigned from your fireteam"
			]
		],
		"BIS_fnc_showNotification",
		_unit
	] call PRA3_fnc_MP;
};

[[_squadId], _squadId call PRA3_fnc_squadGetSide] call PRA3_fnc_squadDlg_server_refresh;
