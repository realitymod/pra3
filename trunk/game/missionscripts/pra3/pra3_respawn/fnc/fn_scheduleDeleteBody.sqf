#include "scriptDefines.sqh"

[
	time + 30,
	{
		[_this, "PRA3_fnc_deleteBody", _this] call PRA3_fnc_MP;
	},
	_body
] call PRA3_fnc_scheduleToExecute;