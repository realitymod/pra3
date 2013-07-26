#include "scriptDefines.sqh"

if (!isDedicated) then
{
	waitUntil {!isNull player};
	[[[],"pra3\pra3_suppression\initTrigger.sqf"],"BIS_fnc_execVM",true,true] call BIS_fnc_MP;
};