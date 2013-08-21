/**
 *	Inserts the element at the specified index of the array.
 *
 *		(in)  <ARRAY>:
 *			0 <ARRAY> Array
 *			1 <INT> Insert index
 *			2 <ANY> Inserted element
 *		(out) <BOOL> Success
 */

#include "scriptDefines.sqh"

var(_array)   = _this select 0;
var(_index)   = _this select 1;
var(_element) = _this select 2;

if (_index < 0 || _index > count _array) then
{
	false
}
else
{
	_array resize (count _array + 1);

	// Shift existing elements
	for "_i" from ((count _array) - 2) to _index step -1 do
	{
		_array set [_i + 1, _array select _i];
	};

	// Insert new
	_array set [_index, _element];

	true
}
