/**
 *	Returns the side the team belongs to.
 *
 *		(in)  <STRING> Team
 *		(out) <SIDE> Team's side
 */

#include "scriptDefines.sqh"

var(_team) = _this;

if (typeName _team != "SIDE") then
{
	if (isClass (missionConfigFile >> "PRA3_teams" >> _team)) then
	{
		var(_side) = getNumber(missionConfigFile >> "PRA3_teams" >> _team >> "side");
		_side call PRA3_fnc_IDToSide
	}
	else
	{
		sideLogic
	}
}
else
{
	_team
}
