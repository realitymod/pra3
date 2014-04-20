#include "scriptDefines.sqh"

[
	time + 30,
	{
		[_this, "PRA3_fnc_deleteBody", true] call PRA3_fnc_MP;
	},
	_this
] call PRA3_fnc_scheduleToExecute;
