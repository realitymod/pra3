scriptName "pra3\pra3_functions\zones\fn_unitInSafeZone.sqf";
/************************************************************
Author:	Shay_gman

Parameters: object

Return if a unit is inside a safe zone as defined in mission init. Returns frue or false

Example: player call fn_unitInSafeZone

************************************************************/

#define var(x) private #x; x

var(_unit)           = _this;
var(_unitInSafeZone) = false;

var(_side) = _unit call PRA3_fnc_getPlayerSide;

//Check if unit is inside a safe zone
{
	if (
		_x select 2 && // it's a safe zone
		{_unit distance markerPos (_x  select 0) < ((markerSize (_x  select 0)) select 0)} && // unit is inside the zone
		{{_x call PRA3_fnc_AAS_getZoneOwner != _side} count (_x select 1) == 0} // the zone is controlled by the unit's side
	) exitWith
	{
		_unitInSafeZone = true
	};
} foreach PRA3_AAS_respawns;

_unitInSafeZone
