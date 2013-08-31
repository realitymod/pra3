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
						_x select 0,
						"localizedMessage",
						"str_praa_squadsys_promote_sl",
						_leader call PRA3_fnc_getPlayerName
					] call PRAA_fMp_execClient;
				};
			} forEach _members;

			[
				_leader,
				"localizedMessage",
				"str_praa_squadsys_promote_sl_you"
			] call PRAA_fMp_execClient;
		};

		[
			_leader,
			"localizedMessage",
			"str_PRA3_squadSys_squad_leave",
			_unit call PRA3_fnc_getPlayerName
		] call PRAA_fMp_execClient;

		var(_others) = [];
		_others resize (count _members);
		{

			[
				_x select 0,
				"call",
				"PRAA_fMap_updateVehicleMarker",
				_unit call PRA3_fnc_getPlayerUnit
			] call PRAA_fMp_execClient;

			_others set [_forEachIndex, (_x select 0) call PRA3_fnc_getPlayerUnit];
		} forEach _members;

		[
			_unit,
			"call",
			"PRAA_fMap_updateVehicleMarker",
			_others
		] call PRAA_fMp_execClient;
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
		_leader,
		"localizedMessage",
		"str_PRA3_squadSys_squad_join",
		_unit call PRA3_fnc_getPlayerName
	] call PRAA_fMp_execClient;

	var(_members) = _newSquadId call PRA3_fnc_squadGetMembers;
	var(_others) = [];
	_others resize (count _members);
	{
		[
			_x select 0,
			"call",
			"PRAA_fMap_updateVehicleMarker",
			_unit call PRA3_fnc_getPlayerUnit
		] call PRAA_fMp_execClient;

		_others set [_forEachIndex, (_x select 0) call PRA3_fnc_getPlayerUnit];
	} forEach _members;


	diag_log ["UPDATE CLIENTS:", _others];
	[
		_unit,
		"call",
		"PRAA_fMap_updateVehicleMarker",
		_others
	] call PRAA_fMp_execClient;
	diag_log "///////";

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
