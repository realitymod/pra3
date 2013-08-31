/**
 *	Logs the warning message.
 *
 *		(in)  <ARRAY>:
 *			0 <STRING> Script or function name where warning was raised
 *			1 <STRING> Warning message
 *		------ OPTIONAL ------
 *			2 <INT> Line
 *		(out) void
 */

#include "scriptDefines.sqh"

diag_log text format ["<%1s> WARNING in %2%4: %3",
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
