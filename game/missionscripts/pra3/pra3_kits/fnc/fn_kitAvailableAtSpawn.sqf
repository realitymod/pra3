#include "scriptDefines.sqh"
#include "defines.sqh"

var(_kit)   = _this select 0;
var(_spawn) = _this select 1;

// _spawn might be just the marker name, if so, gotta look up the full spawn info
if (typeName _spawn == "STRING") then
{
	{
		if (_x select 0 == _spawn) exitWith
		{
			_spawn = _x;
		};
	} forEach call PRA3_fnc_AAS_getAllSpawns;
};

_spawn select 3 in (_kit call PRA3_fnc_getKitInfo select KIT_AVAILABLEAT)
