#include "scriptDefines.sqh"

/**
 *	Returns the azimuth for origin and target.
 *		(in)  <ARRAY>:
 *			0 <POSITION> origin
 *				or
 *			0 <OBJECT> origin
 *			1 <POSITION> target
 *				or
 *			1 <OBJECT> target
 *		(out) <FLOAT> azimuth degrees (0-359.9999..)
 */

var(_origin) = _this select 0;
var(_target) = _this select 1;

if (typeName _target == "OBJECT") then {_target = getPosATL _target};
if (typeName _origin == "OBJECT") then {_origin = getPosATL _origin};

var(_dir) = ((_target select 0) - (_origin select 0)) atan2 ((_target select 1) - (_origin select 1));

if (_dir < 0) then
{
	_dir = _dir + 360;
};

_dir
