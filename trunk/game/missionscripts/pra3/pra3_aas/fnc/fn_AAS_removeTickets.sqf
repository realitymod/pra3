#include "scriptDefines.sqh"
#include "aas_defines.sqh"

// Make sure the server does this, it's guaranteed to be up-to-date, clients aren't.
if (isServer) then
{
	var(_team)   = _this select 0;
	var(_amount) = _this select 1;

	var(_idx) = PRA3_AAS_sides find _team;

	var(_tickets) = PRA3_core getVariable "PRA3_AAS_tickets";
	_tickets set [_idx, (_tickets select _idx) - _amount];
	PRA3_core setVariable ["PRA3_AAS_tickets", _tickets, true];
}
else
{
	[_this, "PRA3_fnc_AAS_removeTickets", false] call PRA3_fnc_MP;
};
