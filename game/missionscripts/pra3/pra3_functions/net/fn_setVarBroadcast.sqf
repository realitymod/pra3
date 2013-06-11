/**
 *	Sets a variable on the object and broadcasts it across the multiplayer clients. Logs the event if PRA3_net_debug is enabled.
 *
 *		(in) <ARRAY>:
 *			0 <OBJECT> Object to set the variable on
 *			1 <STRING> Variable name
 *			2 <ANY> Value
 *		------ OPTIONAL ------
 *			3 <STRING> Script name
 *			4 <INT> Line number
 */

#include "scriptDefines.sqh"

var(_obj) = _this select 0;
var(_var) = _this select 1;
var(_value) = _this select 2;

_obj setVariable [_var, _value, true];
if (PRA3_net_debug) then
{
	var(_script) = if (count _this >= 4) then {_this select 3} else {""};
	var(_line) = if (count _this == 5) then {_this select 4} else {-1};

	[
		"PRA3_fNet_setVarBroadcast",
		format [
			"On <%1> set %2 => |%3|%4",
			_obj,
			_var,
			str _value,
			if (_script != "") then
			{
				format[" (%1%2)",
					_script,
					if (_line != -1) then
					{
						format[" @%1", _line]
					} else {""}
				]
			} else {""}
		]
	] call PRA3_fnc_logInfo;
};
