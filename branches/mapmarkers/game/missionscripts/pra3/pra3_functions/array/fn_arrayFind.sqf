/**
 *	Searches the array and returns the index of the first match or -1 if no match is found.
 *	Performs the same as the find command with the exception of string comparison being case-insensitive.
 *
 *		(in)  <ARRAY>:
 *			0 <ARRAY> Haystack
 *			1 <ANY> Needle
 *		(out) <VOID>
 */

#include "scriptDefines.sqh"

var(_haystack) = _this select 0;
var(_needle)   = _this select 1;

var(_index) = -1;
{
	if ([_x, _needle] call BIS_fnc_areEqual) exitWith
	{
		_index = _forEachIndex;
	};
} forEach _haystack;

_index
