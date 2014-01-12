#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 * Switch player team to the opposite team and vice versa.
 * Has to be run where the unit is local.
 *		(in)  <OBJECT> Unit to switch
 *		(out) <BOOL> true when switch was performed, false otherwise
 *
 * Author: Shay_gman
 */

disableSerialization;

var(_unit) = objNull;
var(_team) = "";
var(_side) = sideLogic;

if (typeName _this == "OBJECT") then
{
	_unit = _this;
	_team = if (PRA3_AAS_teams select 0 == _unit call PRA3_fnc_getPlayerTeam) then
	{
		PRA3_AAS_teams select 1
	}
	else
	{
		PRA3_AAS_teams select 0
	};
	_side = _team call PRA3_fnc_getTeamSide;
}
else
{
	_unit = _this select 0;
	_side = _this select 1;
	_team = PRA3_AAS_teams select (PRA3_AAS_sides find _side);
};

diag_log ["SWITCH TEAM", _this,  _unit, _side, _team];

if false then/*
var(_maxPlayers)      = call PRA3_fnc_getMaxPlayers;
var(_newTeamSide)     = (_newTeam call PRA3_fnc_getTeamSide);
var(_currentTeamSide) = (_currentTeam call PRA3_fnc_getTeamSide);

//check if there is room in the other side and if the other team isn't bigger by more then 4 players
if (playersNumber _newTeamSide >= _maxPlayers/2 || {playersNumber _newTeamSide > (playersNumber _currentTeamSide) + 4}) then*/
{
	_unit sidechat format ["Cannot switch team at the moment, %1 team is full!",_newTeam];
	false
}
else
{
	//If player in a squad
	if (_unit call PRA3_fnc_unitGetSquad != -1) then
	{
		[[_unit, -1], "PRA3_fnc_squadDlg_server_joinSquad", false] call PRA3_fnc_MP;
	};

	//Change the new team and side in PRA3_core to make sure all the functions work
	if (_unit == player) then
	{
		PRA3_player_team = _team;
		PRA3_player_side = _side;
	};
	[PRA3_core, format["PRA3_player_team_%1", _unit call PRA3_fnc_getPlayerUID], _team, __FILE__, __LINE__] call PRA3_fnc_setVarBroadcast;
	[PRA3_core, format["PRA3_player_side_%1", _unit call PRA3_fnc_getPlayerUID], _side, __FILE__, __LINE__] call PRA3_fnc_setVarBroadcast;

	// Refresh dialog
	[[[], _side], "PRA3_fnc_squadDlg_server_refresh", false] call PRA3_fnc_MP;
	var(_display) = displayNull;
	{
		if (!isNull (uiNamespace getVariable [_x, displayNull])) exitWith
		{
			_display = uiNamespace getVariable _x;
		};
	} forEach [
		"Rsc_PRA3_squadSys_manageDlg", "Rsc_PRA3_squadSys_manageDlgRespawn",
		"Rsc_PRA3_kits_kitDlg", "Rsc_PRA3_kits_kitDlgRespawn"
	];

	if (!isNil "_display") then
	{
		_display call PRA3_fnc_squadDlg_refreshTeamSwitchBtns;
	};

	//Remove current kit
	PRA3_kitSys_currentKit = "";

	[nil, "PRA3_fnc_refreshVehicleMarkers"] call PRA3_fnc_MP;

	if (alive _unit) then
	{
		//Make the switch if
		var(_group) = createGroup _side;
		[_unit] join _group;
		if (!isNil "PRA3_joinedGame") then // Don't kill the player unless the game has started
		{
			_unit setDamage 1;
			closeDialog 0;
		};
	};

	// Update map markers to reflect the new side
	call PRA3_fnc_AAS_updateEverything;
}
