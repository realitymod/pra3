/**
 *	Removes the element at the specified index of the input array. The array is modified directly.
 *	Returns false if the index is out of bounds.
 *
 *		(in)  <ARRAY>:
 *			0 <ARRAY> Array
 *			1 <INT> Index to remove
 *		(out) <BOOL> Success
 */

#include "scriptDefines.sqh"

var(_array) = _this select 0;
var(_index) = _this select 1;

if (_index < 0 || {_index >= count _array}) then
{
	false
}
else
{
	for "_i" from _index to ((count _array) - 2) do
	{
		_array set [_i, _array select (_i + 1)];
	};
	_array resize ((count _array) - 1);

	true
}
