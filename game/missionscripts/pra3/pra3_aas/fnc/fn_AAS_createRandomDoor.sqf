#include "scriptDefines.sqh"
#include "aas_defines.sqh"

/**

 *	Randomly close and open doors in the given marker area

 */
 
if (count PRA3_AAS_randomDoorMarker==0) exitWith {diag_log "PRA3_AAS_randomDoorsMarker contains no marker"};
{
	var(_marker) = _x;
   
	if isServer then
	{
		var(_radius)  = (getMarkerSize _marker) select 0;
		var(_objects) = (getMarkerPos _marker) NearObjects ["House",_radius];
		var(_MaxDoorsInHouse)   = 22;         //<----------------------- Maximal number of doors in da house - current 22 doors - CAN CHANGE!!!!
		var(_MaxHatchesInHouse) = 6;          //<----------------------- Maximal number of hatches in da house - current 6 hatches - CAN CHANGE!!!!
		var(_doorAnimName)  = "Door_%1_rot";  //<----------------------- Animation name for door is now set for all buildings except Airport Hall door to "Door_#DoorNumber_rot"
		var(_hatchAnimName) = "Hatch_%1_rot"; //<----------------------- Animation name for hatches is now set for all buildings to "Hatch_#HatchNumber_rot"
		{
			for "_i" from 1 to _MaxDoorsInHouse do
			{
				if (random 1 > 0.5) then
				{
						_x animate [format [_doorAnimName, _i], 1];
				};
			};
			for "_i" from 1 to _MaxHatchesInHouse do
			{
				if (random 1 > 0.5) then
				{
						_x animate [format [_hatchAnimName, _i], 1];
				};
			};
		} foreach _objects;
	};
 
	deleteMarker _marker;
 
} foreach PRA3_AAS_randomDoorMarker;