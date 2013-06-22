/**
 *	Removes the first element that matches the value from the array. The array is modified directly.
 *	Returns true if the element was found and removed.
 *
 *		(in)  <ARRAY>:
 *			0 <ARRAY> Array
 *			1 <ANY> Value to remove
 *		(out) <BOOL> Success
 */

#include "scriptDefines.sqh"

var(_array) = _this select 0;
var(_value) = _this select 1;

var(_index) = [_array, _value] call PRA3_fnc_arrayFind;
if (_index == -1) then
{
	false
}
else
{
	[_array, _index] call PRA3_fnc_arrayRemoveAt;
}
