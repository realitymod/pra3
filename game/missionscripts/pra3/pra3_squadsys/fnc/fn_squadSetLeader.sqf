#include "scriptDefines.sqh"

//TODO: verify if person exists
/**
 * Sets a new squad leader for the squad, demoting the previous leader if need be.
 * Returns false if the squad or the unit does not exist.
 *		(in)  <ARRAY>:
 *			0 <INT> Squad ID
 *			1 <STRING> New leader's UID
 *		(out) <BOOL> Success
 */

if (isServer) then
{
	var(_squadId) = _this select 0;
	var(_leader) = _this select 1;

	var(_success) = false;

	if (typeName _leader == "OBJECT") then
	{
		_leader = _leader call PRA3_fnc_getPlayerUID;
	};

	if (_squadId call PRA3_fnc_squadExists) then
	{
		var(_squad) = PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId];
		{
			if ((_x select 0) == _leader) then
			{
				if ((_x select 1) == 10) exitWith {}; //Ignore in case he's already the leader

				var(_curFt) = _x select 1;
				_x set [1, 10];
				_success = true;
				if (_curFt > 10) then //Handle case where we're promoting an FT leader
				{
					[_squadId, _curFt] call PRA3_fnc_updateFtLeadership;
				};
			}
			else
			{
				if ((_x select 1) == 10) then //Demote previous squad leader
				{
					_x set [1, 0];
					if (_leader == "") then
					{
						_success = true;
					};
				};
			};
		} forEach (_squad select 0);
		
		if (_success) then
		{
			_squadId call PRA3_fnc_broadcastSquadVariable;
		};
	};

	_success
}
else
{
	["Has to be run server-side"] call PRA3_fnc_logError;
	false
}
