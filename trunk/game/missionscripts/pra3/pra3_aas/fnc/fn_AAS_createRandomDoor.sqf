#include "scriptDefines.sqh"
#include "aas_defines.sqh"

/**
 *	Randomlly close and open doors in the given marker area
 */
 
 //Failsafe for empty array
 if (!isServer) exitWith {};
 
 if (count PRA3_AAS_randomDoorsMarkers==0) exitWith {debugLog "PRA3_AAS_randomDoorsMarker contains no markers"}; 
 
 {
	var(_marker) = _x;
	
	var(_radius) = (getMarkerSize _marker) select 0;
	var(_objects) = (getMarkerPos _marker) NearObjects ["House",_radius];

	//debugLog str _objects;

	var(_MaxDoorsInHouse) = 22;  		//<----------------------- Maximal number of doors in da house - current 22 doors - CAN CHANGE!!!!
	var(_MaxHatchesInHouse) = 6;  		//<----------------------- Maximal number of hatches in da house - current 6 hatches - CAN CHANGE!!!!
	var(_doorAnimNameStart)="Door_"; 	//<----------------------- Animation name for door is now set for all buildings except Airport Hall door to "Door_#DoorNumber_rot"
	var(_doorAnimNameEnd)="_rot";
	var(_hatchAnimNameStart)="Hatch_"; 	//<----------------------- Animation name for hatches is now set for all buildings to "Hatch_#HatchNumber_rot"
	var(_hatchAnimNameEnd)="_rot";

	{
		for "_i" from 1 to _MaxDoorsInHouse do
		{
			if ((random 1)> 0.5) then 
				{
					_x animate [(_doorAnimNameStart+str(_i)+_doorAnimNameEnd),1];
				}
		};


		for "_i" from 1 to _MaxHatchesInHouse do
		{
			if ((random 1)> 0.5) then 
				{
					_x animate [(_hatchAnimNameStart+str(_i)+_hatchAnimNameEnd),1];
				}; 
		};
	} foreach _objects;

	deleteMarker _marker;
	
} foreach PRA3_AAS_randomDoorsMarkers;

true;