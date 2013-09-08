#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 * Switch player team to the opposite team and vice versa
 *		(in)  nothing
 *		(out) nothing
 *
 * Author: Shay_gman
 */
 
var(_currentTeam) 		= PRA3_core getVariable [format["PRA3_player_team_%1", player call PRA3_fnc_getPlayerUID],""];
var(_newTeam)			= if ((PRA3_AAS_teams select 0) == _currentTeam) then {PRA3_AAS_teams select 1} else {PRA3_AAS_teams select 0};
var(_maxPlayers)		= call PRA3_fnc_getMaxPlayers;
var(_newTeamSide)		= (_newTeam call PRA3_fnc_getTeamSide);
var(_currentTeamSide)	= (_currentTeam call PRA3_fnc_getTeamSide);

//check if there is room in the other side and if the other team isn't bigger by more then 4 players
if (((playersNumber _newTeamSide) >= _maxPlayers/2) || ((playersNumber _newTeamSide) > (playersNumber _currentTeamSide) + 4)) exitWith {
	player sidechat format ["Cannot switch team at the moment, %1 team is full!",_newTeam]; 
	};
	
//If player in a squad
if ((leader player) call PRA3_fnc_unitGetSquad != -1) then	{
		[[player, -1], "PRA3_fnc_squadDlg_server_joinSquad", false] call PRA3_fnc_MP;
	};
	
//Make the switch
var(_group) = creategroup _newTeamSide;
[player] join _group;
_group = grpNull;
deleteGroup _group;

//Change the new team and side in PRA3_core
PRA3_core setVariable [format["PRA3_player_team_%1", player call PRA3_fnc_getPlayerUID], _newTeam, true];
PRA3_core setVariable [format["PRA3_player_side_%1", player call PRA3_fnc_getPlayerUID], _newTeamSide, true];

//Remove current kit
PRA3_kitSys_currentKit = "";

if (alive player) then {player setdamage 1};

//Restart Dialog
true call PRA3_fnc_squadDlg_open;