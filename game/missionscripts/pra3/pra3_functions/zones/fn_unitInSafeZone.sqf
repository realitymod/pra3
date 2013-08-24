scriptName "pra3\pra3_functions\zones\fn_unitInSafeZone.sqf";
/************************************************************
Author:	Shay_gman

Parameters: [object]

Return if a unit is inside a safe zone as defined in mission init. Returns True or False

Example: [player] call fn_unitInSafeZone

************************************************************/

#define var(x) private #x; x

var(_unit) 				= _this select 0;			
var(_unitInSafeZone)	= false;

var(_side) = _unit call PRA3_fnc_getPlayerSide;

//Check if unit is inside a safe zone
{		//if safe zone		and	the unit distance from zone ceneter is less then its radius									and 	the sapwn zone is controled by the side of the unit
	if ( (_x select 2) &&(_unit distance (markerpos (_x  select 0))) < ((markersize (_x  select 0)) select 0) && ({_x call PRA3_fnc_AAS_getZoneOwner != _side} count (_x select 1) == 0)) then {_unitInSafeZone = true}; 
} foreach PRA3_AAS_respawns;

_unitInSafeZone