/**
 *	Logs the error message.
 *
 *		(in)  <ARRAY>:
 *			0 <STRING> Error message
 *		------ OPTIONAL ------
 *			1 <STRING> Script or function name where error was raised
 *			2 <INT> Line
 *		(out) void
 */

#include "scriptDefines.sqh"

var(_message) = _this select 0;
var(_file)    = if (count _this > 1) then {_this select 1} else {_fnc_scriptName};
var(_line)    = if (count _this > 2) then {format[" @%1", _this select 2]} else {""};

if (isNil "_file") then {_file = "?"};

_fnc_scriptName = nil; // Hax to make BIS_fnc_error do our bidding

["<t color='#ff0000'>ERROR</t><br/>%2%3<br/>%1", _message, _file, _line] call BIS_fnc_error;

diag_log text format ["<%1s> ERROR in %3%4: %2",
	diag_ticktime,
	_message,
	_file,
	_line
];
