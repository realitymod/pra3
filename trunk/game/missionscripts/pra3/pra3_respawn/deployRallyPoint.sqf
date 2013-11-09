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
var(_nearby) = {alive _x && {_x call PRA3_fnc_unitGetSquad == _squad}} count (getPosATL _caller nearEntities ["CAManBase", REQUIRE_DISTANCE]);/*
if (_nearby < REQUIRE_MEMBERS) exitWith
{
	PRA3_core globalChat format [
		"You require %1 more squad members within %2m",
		REQUIRE_MEMBERS - _nearby,
		REQUIRE_DISTANCE
	];

	false
};
*/

var(_pos) = ATLtoASL(player modelToWorld [0,2,0]);
player groupChat "-----";
while {lineIntersects [_pos, [_pos select 0, _pos select 1, (_pos select 2) + 1]]} do
{
	_pos set [2, (_pos select 2) - 0.1];
	//player groupChat str (_pos select 2);
};

player groupChat format["found non-intersect pos: %1", _pos select 2];

while {!lineIntersects [_pos, [_pos select 0, _pos select 1, (_pos select 2) + 1]] && _pos select 2 > getTerrainHeightASL _pos} do
{
	_pos set [2, (_pos select 2) - 0.1];
	//player groupChat str (_pos select 2);
};

if (_pos select 2 < getTerrainHeightASL _pos) then
{
	_pos set [2, getTerrainHeightASL _pos];
};

player groupChat format["found intersect pos: %1", _pos select 2];

while {lineIntersects [_pos, [_pos select 0, _pos select 1, (_pos select 2) + 1]]} do
{
	_pos set [2, (_pos select 2) + 0.01];
	//player groupChat str (_pos select 2);
};

player groupChat format["found final pos: %1", _pos select 2];

if (lineIntersects [getPosASL player, _pos]/* || {terrainIntersectASL [getPosASL player, _pos]}*/) exitWith
{
	PRA3_core globalChat "No suitable position found";
	false
};

var(_safePos) = ASLtoATL _pos;

//Check if no hostile unit near the RP
var(_safeSpawn) = true;
{
	if (alive _x && {_x call PRA3_fnc_getPlayerTeam != _team}) exitWith {diag_log [_x, _x call PRA3_fnc_getPlayerTeam];_safeSpawn = false};
} forEach (_safePos nearEntities [CHECK_TYPES, CHECK_DISTANCE]);

if !_safeSpawn exitWith
{
	PRA3_core globalChat "Cannot deploy rally point: Hostile forces nearby";

	false
};

[[_squad, _safePos, getDir player, _team call PRA3_fnc_getTeamRallyPoint], "PRA3_fnc_squadCreateRallypoint", false] call PRA3_fnc_MP;

PRA3_core globalChat "Rally point deployed.";

true
