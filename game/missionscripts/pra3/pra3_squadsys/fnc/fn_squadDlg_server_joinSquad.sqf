#include "defines.sqh"
#include "scriptDefines.sqh"

var(_unit)       = (_this select 0) call PRA3_fnc_getPlayerUID;
var(_newSquadId) = _this select 1;

var(_prevSquadId) = _unit call PRA3_fnc_unitGetSquad;

var(_updates) = [];

if (_prevSquadId != -1) then // Unit already a member of a squad, let's remove him from it
{
	var(_leader) = _prevSquadId call PRA3_fnc_squadGetLeader;

	[_unit, _prevSquadId] call PRA3_fnc_unitLeaveSquad;

	// Check if the squad wasn't dissolved
	if (_prevSquadId call PRA3_fnc_squadExists) then
	{
		var(_members) = _prevSquadId call PRA3_fnc_squadGetMembers;
		if (_leader == _unit) then // SL left
		{
			_leader = _prevSquadId call PRA3_fnc_squadGetLeader;
			{
				if ((_x select 0) != _leader) then
				{
					[
						[
							"PRA3_squadsys_eventNotification",
							[
								"NEW SQUAD LEADER",
								format ["%1 is the new leader of your squad", _leader call PRA3_fnc_getPlayerName]
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
						"NEW SQUAD LEADER",
						"You are now the squad leader"
					]
				],
				"BIS_fnc_showNotification",
				_leader
			] call PRA3_fnc_MP;
		};

		[
			[
				"PRA3_squadsys_eventNotification",
				[
					"PLAYER LEFT",
					format ["%1 has left the squad", _unit call PRA3_fnc_getPlayerName]
				]
			],
			"BIS_fnc_showNotification",
			_leader
		] call PRA3_fnc_MP;

		var(_others) = [];
		_others resize (count _members);
		{

			[
				_unit call PRA3_fnc_getPlayerUnit,
				"PRA3_fnc_updateVehicleMarker",
				_x select 0
			] call PRA3_fnc_MP;

			_others set [_forEachIndex, (_x select 0) call PRA3_fnc_getPlayerUnit];
		} forEach _members;

		[
			_others,
			"PRA3_fnc_updateVehicleMarker",
			_unit
		] call PRA3_fnc_MP;
	};

	_updates set [count _updates, _prevSquadId];
}
else // Previously unassigned
{
	_updates set [count _updates, 99];
};

if (_newSquadId != -1) then // Unit wants to join a new squad, let's add him to it
{
	var(_leader) = _newSquadId call PRA3_fnc_squadGetLeader;

	[_unit, _newSquadId] call PRA3_fnc_unitJoinSquad;

	[
		[
			"PRA3_squadsys_eventNotification",
			[
				"PLAYER JOINED",
				format ["%1 has joined your squad", _unit call PRA3_fnc_getPlayerName]
			]
		],
		"BIS_fnc_showNotification",
		_leader
	] call PRA3_fnc_MP;

	var(_members) = _newSquadId call PRA3_fnc_squadGetMembers;
	var(_others) = [];
	_others resize (count _members);
	{
		[
			_unit call PRA3_fnc_getPlayerUnit,
			"PRA3_fnc_updateVehicleMarker",
			_x select 0
		] call PRA3_fnc_MP;

		_others set [_forEachIndex, (_x select 0) call PRA3_fnc_getPlayerUnit];
	} forEach _members;

	[
		_others,
		"PRA3_fnc_updateVehicleMarker",
		_unit
	] call PRA3_fnc_MP;

	_updates set [count _updates, _newSquadId];
}
else // Going unassigned
{
	if (!(99 in _updates)) then
	{
		_updates set [count _updates, 99];
	};
};

[_updates, _unit call PRA3_fnc_getPlayerSide] call PRA3_fnc_squadDlg_server_refresh;
