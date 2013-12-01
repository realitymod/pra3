#include "scriptDefines.sqh"
#include "defines.sqh"

{
	var(_enabled) = PRA3_core getVariable [_x select 1, false];
	ctrl((_forEachIndex+1)*10) ctrlSetText format ["%1: %2", if _enabled then {"ON"} else {"OFF"}, _x select 0];
} forEach DEBUG_ITEMS;
