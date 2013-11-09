#include "scriptDefines.sqh"
#include "defines.sqh"

var(_RPs) = [];

{
	_rally = _x call PRA3_fnc_squadGetRallypoint;
	if (!isNull _rally) then
	{
		_RPs set [count _RPs, _rally];
	};
} forEach call PRA3_fnc_getAllSquads;

_RPs
