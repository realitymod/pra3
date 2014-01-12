#include "defines.sqh"
#include "scriptDefines.sqh"

var(_squadId) = _this select 0;
var(_ft)      = _this select 1;
var(_unit)    = _this select 2;

if (_squadId == (_unit call PRA3_fnc_unitGetSquad)) then
{
	var(_prevLeader) = [_squadId, _ft] call PRA3_fnc_squadGetFtLeader;
	if (_prevLeader != "") then // Previous leader being replaced
	{
		[
			[
				"PRA3_squadsys_eventNotification",
				[
					"FT LEADER DEMOTION",
					"You are no longer the fireteam leader"
				]
			],
			"BIS_fnc_showNotification",
			_prevLeader
		] call PRA3_fnc_MP;
	};

	[_squadId, _ft, _unit] call PRA3_fnc_squadSetFtLeader;

	var(_members) = _squadId call PRA3_fnc_squadGetMembers;
	{
		if ((_x select 1) == _ft && (_x select 0) != _prevLeader) then
		{
			[
				[
					"PRA3_squadsys_eventNotification",
					[
						"NEW FT LEADER",
						format ["%1 is the new leader of your fireteam", _unit call PRA3_fnc_getPlayerName]
					]
				],
				"BIS_fnc_showNotification",
				_x select 0
			] call PRA3_fnc_MP;
		};
	} forEach _members;
	[
		[
			"PRA3_squadsys_eventNotification",
			[
				"NEW FT LEADER",
				"You are now the fireteam leader"
			]
		],
		"BIS_fnc_showNotification",
		_newLeader
	] call PRA3_fnc_MP;
};

[[_squadId], _squadId call PRA3_fnc_squadGetSide] call PRA3_fnc_squadDlg_server_refresh;
