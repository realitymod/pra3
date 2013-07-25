#include "scriptDefines.sqh"

if (!isDedicated) then
{
	player addEventHandler ["Fired", {_this execVM "pra3\pra3_suppression\initTrigger.sqf"}];
};