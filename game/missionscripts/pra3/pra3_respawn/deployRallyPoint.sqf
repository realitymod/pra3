#include "fnc\scriptDefines.sqh"
//*******************************
// Deploy a Rally Point define variabls at init.sqf
// _caller - Squad leader - unit
// _index - The Rally point action index (not used atm, might be used later if we don't want the action to stay after building a RP
// Author: Shat_gman
//*******************************
var(_caller) = _this;

#define CHECK_TYPES     ["CAManBase"]
#define CHECK_DISTANCE  50
#define REQUIRE_MEMBERS 3
#define REQUIRE_DISTANCE 10

var(_team)  = _caller call PRA3_fnc_getPlayerTeam;
var(_squad) = _caller call PRA3_fnc_unitGetSquad;

//find out if there are enough Squad's mates nearby
var(_nearby) = {alive _x && {_x call PRA3_fnc_unitGetSquad == _squad}} count (getPosATL _caller nearEntities ["CAManBase", REQUIRE_DISTANCE]);
if (_nearby < REQUIRE_MEMBERS) exitWith
{
	PRA3_core globalChat format [
		"You require %1 more squad members within %2m",
		REQUIRE_MEMBERS - _nearby,
		REQUIRE_DISTANCE
	];
};

var(_safePos) = [[_caller, 2, getDir _caller] call BIS_fnc_relPos ,0.5,2,0.5,0,100,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;
if (_safePos distance [-500,-500,0] < 1) exitWith
{
	PRA3_core globalChat "No suitable position found";
};

//Check if no hostile unit near the RP
var(_safeSpawn) = true;
{
	if (alive _x && {_x call PRA3_fnc_getPlayerTeam != _team}) exitWith {diag_log [_x, _x call PRA3_fnc_getPlayerTeam];_safeSpawn = false};
} forEach (_safePos nearEntities [CHECK_TYPES, CHECK_DISTANCE]);

if !_safeSpawn exitWith
{
	PRA3_core globalChat "Cannot deploy rally point: Hostile forces nearby"
};

//Create the RP and set the variable
var(_rp) = _team call PRA3_fnc_getTeamRallyPoint createVehicle _safePos;

PRA3_RPTime = time;
"rallyPoint" setMarkerPosLocal _safePos;
_rp setVariable ["PRA3_rally_deployTime", time, true];
_rp setVariable ["PRA3_rally_squad", _squad, true];
_rp setVariable ["PRA3_rally_tickets", count (_squad call PRA3_fnc_squadGetMembers), true];

[[_squad, _rp], "PRA3_fnc_squadRegisterRallypoint", false] call PRA3_fnc_MP;
