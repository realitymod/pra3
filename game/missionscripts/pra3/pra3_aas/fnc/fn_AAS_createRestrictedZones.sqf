scriptName "pra3\pra3_functions\zones\fn_AAS_createRestrictedZone.sqf";
/************************************************************
Author:	Shay_gman

Parameters: [_markerName <string>,  _teams<Array>,_time <Integer>,_inside <boolean>,_air <boolean>,_delete<boolean>]

_markerName: Marker Name.
_teams: array containg the teams that will be punished.
_time: time need to ellapsed before punishment
_inside: does the unit should be inside the zone or outside the zone inorder no to be punished
_air: Should air unis be punished
_delete: Should we delete the marker after placment
Create a restriction zone on a marker defined in mission sqf init.sqf

Example:["west_spawn", [east]	,10,false,false,	false], call PRA3_fnc_createRestrictedZone

************************************************************/
private ["_markerName","_markerShape","_teams","_inside","_trg","_time","_air","_delete"];
{
	_markerName = _x select 0;
	_teams      = _x select 1;
	_time       = _x select 2;
	_inside     = _x select 3;
	_air        = _x select 4;
	_delete     = _x select 5;

	_markerShape = if ((markerShape _markerName) == "RECTANGLE") then {true} else {false};

	_trg = createTrigger["EmptyDetector",markerPos _markerName];
	_trg setTriggerArea[(markerSize _markerName) select 0,(markerSize _markerName) select 1,markerDir _markerName,_markerShape];
	_trg setTriggerActivation["ANY","PRESENT",true];
	_trg setTriggerStatements[format ["(vehicle player in thislist) && (PRA3_player_team in %1)",_teams], format ["[thisTrigger,%1,%2,%3] spawn PRA3_fnc_RestrictZoneEffect",_time,_inside,_air], ""];
	if _delete then {_markerName setMarkerAlphaLocal 0};

} forEach PRA3_AAS_restrictionZones;
