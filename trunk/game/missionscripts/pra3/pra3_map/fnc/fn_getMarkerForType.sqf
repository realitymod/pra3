#include "scriptDefines.sqh"

/**
 *	Returns name of the marker used for the vehicle type.
 *	"" is returned if the vehicle has no marker assigned.
 *
 *		(in)  <OBJECT> Vehicle
 *				or
 *		(in)  <STRING> Vehicle classname
 *		(out) <STRING> Marker name
 */

var(_vehicle) = _this;
if (typeName _vehicle == "OBJECT") then
{
	_vehicle = typeOf _vehicle;
};

/*
var(_cfg) = configFile >> "CfgVehicles" >> _vehicle >> "PRA3_marker";

getText(_cfg)
*/

if (_vehicle isKindOf "CAManBase") then
{
	"mil_dot"
}
else
{
	""
}
