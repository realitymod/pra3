/**
 *	Checks if the point is inside of the marker.
 *
 *		(in)  <ARRAY>:
 *			0 <POSITION 2D> point
 *			1 <STRING> marker name
 *		(out) <BOOL> point in poly
 */

#include "scriptDefines.sqh"

var(_point)  = _this select 0;
var(_marker) = _this select 1;

var(_pos) = markerPos _marker;
var(_w) = (markerSize _marker) select 0;
var(_h) = (markerSize _marker) select 1;

if (markerShape _marker == "RECTANGLE") then
{
	var(_angle) = markerDir _marker;
	var(_a) = [
		(_pos select 0) - _w * cos _angle + _h * sin _angle,
		(_pos select 1) + _w * sin _angle + _h * cos _angle
	];
	var(_b) = [
		(_pos select 0) + _w * cos _angle + _h * sin _angle,
		(_pos select 1) - _w * sin _angle + _h * cos _angle
	];
	var(_c) = [
		(_pos select 0) + _w * cos _angle - _h * sin _angle,
		(_pos select 1) - _w * sin _angle - _h * cos _angle
	];
	var(_d) = [
		(_pos select 0) - _w * cos _angle - _h * sin _angle,
		(_pos select 1) + _w * sin _angle - _h * cos _angle
	];

	([_point, [_a, _b, _c, _d, _a]] call PRA3_fnc_isPointInPolygon)
}
else
{
	var(_angle) = ([_point, markerPos _marker] call BIS_fnc_dirTo) - 90 - (markerDir _marker);

	var(_r) = (_w*_h) / sqrt((_h * cos _angle)^2 + (_w * sin _angle)^2);

	((_point distance _pos) <= _r)
}
