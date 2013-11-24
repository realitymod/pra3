/**
 *	Returns the team for the given side or side ID.
 *
 *		(in)  <SIDE> Side
 *		(out) <INT> Team
 */

#include "scriptDefines.sqh"

var(_side) = _this;

if (typeName _side == "SIDE") then
{
	_side = _side call PRA3_fnc_sideToID;
};

var(_text) = "NONE";

var(_cfg) = missionconfigfile >> "PRA3_teams";
for "_i" from 0 to ((count _cfg) - 1) do 
{
	var(_team) = _cfg select _i;
	if (isclass _team) then
	{
		var(_cfgSide) = getNumber(_team >> "side");
		if (_cfgSide == _side) exitWith {_text = getText(_team >> "name")}; 
	};
};

_text