#include "fnc\scriptDefines.sqh"
//*******************************
// Deploy a Rally Point define variabls at init.sqf
// _caller - Squad leader - unit
// _index - The Rally point action index (not used atm, might be used later if we don't want the action to stay after building a RP
// Author: Shat_gman
//*******************************
var(_caller) 	= _this select 0;
var(_index) 	= _this select 2;

if (isnil "PRA3_RPTime") then {PRA3_RPTime = time - (PRA3_rallyPoints select 1)};

if (abs(time - PRA3_RPTime) < (PRA3_rallyPoints select 1)) exitWith 
	{
		player sidechat format ["Rally Point will be available in %1 seconds", (PRA3_rallyPoints select 1)- (abs(time - PRA3_RPTime))];
	}; 

var(_side) = _caller call PRA3_fnc_getPlayerSide;
var(_team) = _caller call PRA3_fnc_unitGetSquad;

//find out if there are enough Squad's mates nearby
var(_nearObjects) =  _caller nearObjects ["MAN", (PRA3_rallyPoints select 6)];
var(_counter) = 0;
	{
		if ((_x call PRA3_fnc_unitGetSquad == _team) && (alive _x)) then {_counter = _counter + 1};
	} foreach _nearObjects;
if (_counter < (PRA3_rallyPoints select 5)) exitWith {player sidechat format ["You need %1 more squad mate nearby",(PRA3_rallyPoints select 5)-_counter]};


var(_safepos)     =[[_caller, 2,getdir _caller] call BIS_fnc_relPos ,0.5,2,0.5,0,100,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;	
if (format["%1",_safepos] == "[-500,-500,0]" ) exitWith {player sidechat "No good position found"};

//Check if no hostile unit near the RP
var(_safeSpawn) = true; 
	{
		_nearObjects = _safepos nearObjects [_x, (PRA3_rallyPoints select 0)];
		if (count _nearObjects > 0) then 
			{

				{
					if ((_x call PRA3_fnc_getPlayerSide != _side) && (_x call PRA3_fnc_getPlayerSide != sidelogic) && (alive _x)) exitWith {_safeSpawn = false};
				} foreach _nearObjects;
			};
	} forEach (PRA3_rallyPoints select 2);
if (!_safeSpawn) exitWith {player sidechat "Cannot deploy rally point: Hostile forces nearby "};

//Create the RP and set the variable
if (_side == west) then 
	{
		PRA3_activeRP = ((PRA3_rallyPoints select 4) select 0) createvehicle _safepos;
	} 
	else
	{
		PRA3_activeRP =  ((PRA3_rallyPoints select 4) select 1) createvehicle _safepos;
	}; 

PRA3_RPTime = time;
"rallyPoint" setMarkerPosLocal _safepos;
PRA3_activeRP setvariable ["time",time,true];
PRA3_activeRP setvariable ["side",_side,true]; 
PRA3_activeRP setvariable ["team",_team,true];

PRA3_activeRP spawn 
	{
		private ["_endTime"];
		_endTime = time + (PRA3_rallyPoints select 3);
		while {time < _endTime} do {sleep 1}; 
		deleteVehicle PRA3_activeRP;				
	};