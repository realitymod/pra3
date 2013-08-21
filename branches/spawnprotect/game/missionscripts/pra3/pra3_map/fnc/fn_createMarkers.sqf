#include "scriptDefines.sqh"

/**
 *	Creates markers for all vehicles.
 */

var(_vehicle) = _this;

{
	_x call PRA3_fnc_startVehicleTracking;
} forEach allUnits;
