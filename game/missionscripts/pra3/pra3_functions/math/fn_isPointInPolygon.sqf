/**
 *	Checks if the point is inside of the polygon.
 *	Polygon is defined as an array of points where the first and last element equal.
 *
 *		(in)  <ARRAY>:
 *			0 <POSITION 2D> point
 *			1 <ARRAY> polygon
 *		(out) <BOOL> point in poly
 */

#include "scriptDefines.sqh"

var(_point) = _this select 0;
var(_poly)  = _this select 1;

var(_crossings) = 0;

for "_i" from 0 to (count _poly)-1 do
{
	if ((((_poly select _i) select 1 <= _point select 1) && ((_poly select (_i+1)) select 1 > (_point select 1))) ||
		(((_poly select _i) select 1 > _point select 1) && ((_poly select (_i+1)) select 1 <= (_point select 1)))) then
	{
		_intersect = ((_point select 1) - ((_poly select _i) select 1)) /
						(((_poly select (_i+1)) select 1) - ((_poly select _i) select 1));

		if ((_point select 0) < (((_poly select _i) select 0) + _intersect *
				(((_poly select (_i+1)) select 0) - ((_poly select _i) select 0)))) then
		{
			_crossings = _crossings + 1;
		};
	};
};

(_crossings % 2) > 0 //Odd number when inside, even when outside
