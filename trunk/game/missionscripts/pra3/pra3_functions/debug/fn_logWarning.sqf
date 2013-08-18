/**
 *	Logs the warning message.
 *
 *		(in)  <ARRAY>:
 *			0 <STRING> Warning message
 *		------ OPTIONAL ------
 *			1 <STRING> Script or function name where warning was raised
 *			2 <INT> Line
 *		(out) void
 */

#include "scriptDefines.sqh"

var(_message) = _this select 0;
var(_file)    = if (count _this > 1) then {_this select 1} else {_fnc_scriptName};
var(_line)    = if (count _this > 2) then {format[" @%1", _this select 2]} else {""};

_fnc_scriptName = nil; // Hax to make BIS_fnc_error do our bidding

["<t color='#ff7f00'>WARNING</t><br/>%2%3<br/>%1", _message, _file, _line] call BIS_fnc_error;

diag_log text format ["<%1s> WARNING in %3%4: %2",
	diag_ticktime,
	_message,
	_file,
	_line
];
