/**
 *	Schedules a piece of code that will be executed at (approximately) the given game time.
 *
 *		(in)  <ARRAY>:
 *			0 <NUMBER> Game time to execute at
 *			1 <CODE> Code to execute
 *			2 <ANY> Parameter for the code
 *		(out) <VOID>
 */

#include "scriptDefines.sqh"

var(_time)  = _this select 0;
var(_code)  = _this select 1;
var(_param) = _this select 2;

var(_index) = 0;
{
	if (_x select 0 > _time) exitWith {};
	_index = _forEachIndex + 1;
} forEach PRA3_executor_events;

PRA3_executor_events resize (count PRA3_executor_events + 1);

for "_i" from _index to (count PRA3_executor_events)-2 do
{
	PRA3_executor_events set [_i + 1, PRA3_executor_events select _i];
};
PRA3_executor_events set [_index, [_time, _code, _param]];
