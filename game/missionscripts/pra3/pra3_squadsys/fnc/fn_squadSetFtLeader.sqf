#include "scriptDefines.sqh"

//TODO: verify if person exists
/**
 * Sets a new fireteam leader for the squad, demoting the previous leader if need be.
 * Returns false if the squad or the unit does not exist.
 *		(in)  <ARRAY>:
 *			0 <INT> Squad ID
 *			1 <INT> Fireteam ID
 *			2 <STRING> New leader's UID
 *		(out) <BOOL> Success
*/

if (isServer) then
{
	var(_squadId) = _this select 0;
	var(_ft) = _this select 1;
	var(_leader) = _this select 2;

	var(_success) = false;

	if (typeName _leader == "OBJECT") then
	{
		_leader = _leader call PRA3_fnc_getPlayerUID;
	};

	var(_target) = 10 + _ft; //The ID we're aiming for

	if (_squadId call PRA3_fnc_squadExists) then
	{
		var(_squad) = (PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]) select 0;
		{
			if ((_x select 0) == _leader) then
			{
				if ((_x select 1) == _target) exitWith {}; //Ignore in case he's already the leader

				var(_currFt) = _x select 1;
				_x set [1, _target];
				_success = true;
				if (_currFt > 10 && _currFt != (_x select 1)) then //Handle case where we're re-assigning an FT leader from a different squad
				{
					[_squadId, _currFt] call PRA3_fnc_updateFtLeadership;
				};
			}
			else
			{
				if ((_x select 1) == _target) then //Demote previous squad leader
				{
					_x set [1, (_x select 1) - 10];
					if (_leader == "") then
					{
						_success = true;
					};
				};
			};
		} forEach _squad;

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
