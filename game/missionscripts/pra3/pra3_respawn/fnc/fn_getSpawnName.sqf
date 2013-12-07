#include "scriptDefines.sqh"
#include "defines.sqh"

if (_this select 0 == SPAWN_RALLYPOINT) then
{
	format ["%1 (%2)", _this select 1, _this select 2 select 0 getVariable "PRA3_rally_tickets"]
}
else
{
	_this select 1
}
