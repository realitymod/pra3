#include "scriptDefines.sqh"

/**
 *	Returns whether the vehicle has any "seats" that can be entered.
 *
 *		(in)  <STRING> Vehicle classname
 *				or
 *		(in)  <OBJECT> Vehicle
 *		(out) <BOOL> Mountable?
 */

var(_vehicle) = _this;

var(_vehicle) = (
	if (typeName _vehicle == "OBJECT") then {
		typeOf _vehicle
	} else {
		_vehicle
	}
);

var(_cfg) = configFile >> "CfgVehicles" >> _vehicle;

(
	_vehicle isKindOf "LandVehicle" ||
	_vehicle isKindOf "Air" ||
	_vehicle isKindOf "Ship"
) && (
	isArray(_cfg >> "typicalCargo") ||
	isClass(_cfg >> "crew") ||
	getNumber(_cfg >> "transportSoldier") > 0
) && (
	!(_vehicle isKindOf "BuoySmall") &&
	!(_vehicle isKindOf "BuoyBig")
)
