#include "scriptDefines.sqh"
#include "aas_defines.sqh"

var(_unit) = _this;

var(_list) = [];
// Find spawns tied to zones...
var(_side) = _unit call PRA3_fnc_getPlayerSide;
var(_team) = _unit call PRA3_fnc_unitGetSquad;

{
	if ((_x select 2 select 0) == 99) then	//Rally Point
		{				
			var(_pos)	= [(getmarkerpos (_x select 0) select 0), (getmarkerpos (_x select 0) select 1), 0];
			var(_safeSpawn) = false; 
			//Check if alive object 
			var(_rallyPointObject) = if (_side == west) then {((PRA3_rallyPoints select 4) select 0)} else {((PRA3_rallyPoints select 4) select 1)}; 
			_nearObjects = _pos nearObjects [_rallyPointObject, 100];
					if (count _nearObjects > 0) then 
						{
							{
								if (_x getvariable "team" == _team) exitWith {_safeSpawn = true};
							} foreach _nearObjects;
						} else {_safeSpawn = false};		 //Cannot spawn if no RP object found
						
			//Check if no hostile unit near the RP
				{
					var(_nearObjects) = _pos nearObjects [_x, (PRA3_rallyPoints select 1)];
					if (count _nearObjects > 0) then {
							{
								if ((_x call PRA3_fnc_getPlayerSide != _side) && (_x call PRA3_fnc_getPlayerSide != sidelogic) && (alive _x)) exitWith {_safeSpawn = false};
							} foreach _nearObjects;
						};
				} forEach (PRA3_rallyPoints select 2);
			
			if (_safeSpawn) then {_list set [count _list,_x]}; 
		} 
		else
		{
			// Make sure all tied zones are owned by this side
			if ({!(_x call PRA3_fnc_AAS_getZoneOwner == _side)} count (_x select 2) == 0)  then
			{
				_list set [
					count _list,
					_x
				];
			};
		};
} forEach call PRA3_fnc_AAS_getAllSpawns;

_list
