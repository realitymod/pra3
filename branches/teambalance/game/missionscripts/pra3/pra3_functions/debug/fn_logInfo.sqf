/**
 *	Logs the message.
 *
 *		(in)  <ARRAY>:
 *			0 <STRING> Message
 *		------ OPTIONAL ------
 *			1 <STRING> Script or function name where message was raised
 *			2 <INT> Line
 *		(out) void
 */

#include "scriptDefines.sqh"

var(_message) = _this select 0;
var(_file)    = if (count _this > 1) then {_this select 1} else {_fnc_scriptName};
var(_line)    = if (count _this > 2) then {format[" @%1", _this select 2]} else {""};

diag_log text format ["<%1s> %3%4: %2",
	diag_ticktime,
	_message,
	_file,
	_line
];
