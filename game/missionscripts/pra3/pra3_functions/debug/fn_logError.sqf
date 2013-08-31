/**
 *	Logs the error message and alerts the user via hint.
 *
 *		(in)  <ARRAY>:
 *			0 <STRING> Script or function name where error was raised
 *			1 <STRING> Error message
 *		------ OPTIONAL ------
 *			2 <INT> Line
 *		(out) void
 */

#include "scriptDefines.sqh"

[
	format ["<t color='#ff0000'>ERROR</t><br/>File/function: <t color='#ffff00'>%1</t>%3<br/>%2",
		_this select 0,
		_this select 1,
		if (count _this == 3) then
		{
			format[", line: <t color='#ffff00'>%1</t>", _this select 2]
		}
		else
		{
			""
		}
	]
] call BIS_fnc_error;
diag_log text format ["<%1s> ERROR in %2%4: %3",
	diag_ticktime,
	_this select 0,
	_this select 1,
	if (count _this == 3) then
	{
		format[" @%1", _this select 2]
	}
	else
	{
		""
	}
];
