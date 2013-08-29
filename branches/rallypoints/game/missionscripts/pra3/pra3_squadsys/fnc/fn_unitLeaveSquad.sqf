#include "scriptDefines.sqh"

/**
 * Removes the given unit from the squad.
 * Updates leadership within the squad or completely dissolves it if necessary.
 * Returns false if the squad does not exist or the unit is not a memeber.
 *		(in)  <ARRAY>:
 *			0 <OBJECT> Unit
 *				or
 *			0 <STRING> Unit UID
 *			1 <INT> Squad ID
 *		(out) <BOOL> Success
 */

if (isServer) then
{
	var(_unit) = _this select 0;
	var(_squadId) = _this select 1;

	var(_success) = false;
	var(_unitID) = "";
	if (typeName _unit == "OBJECT") then
	{
		_unitID = _unit call PRA3_fnc_getPlayerUID;
	}
	else
	{
		_unitID = _unit;
		_unit = _unitID call PRA3_fnc_getPlayerUnit;
	};

	if (_squadId call PRA3_fnc_squadExists) then
	{
		diag_log ["before", PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]];
		var(_members) = (PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]) select 0;
		var(_idx) = -1; //unit's squad array index
		var(_leader) = 0;
		{
			diag_log ["dump", (_x select 0), _unitID];
			if ((_x select 0) == _unitID) exitWith
			{
				_idx = _forEachIndex;
				_leader = _x select 1;
			};
		} forEach _members;

		if (_idx != -1) then
		{
			PRA3_core setVariable [format["PRA3_squadSys_unitSquad_%1", _unitID], -1, true];

			[_members, _idx] call PRA3_fnc_arrayRemoveAt;
			diag_log ["after", PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]];

			if (count _members == 0) then //Empty squad, dissolve it
			{
				_squadId call PRA3_fnc_destroySquad;
			}
			else
			{
				if (_leader >= 10) then
				{
					if (_leader == 10) then //Removing a squad leader
					{
						_squadId call PRA3_fnc_updateSquadLeadership;
					}
					else //Removing an FT leader
					{
						if (!([_squadId, _leader - 10] call PRA3_fnc_updateFtLeadership)) then //false = no changes made and no variable broadcasted
						{
							_squadId call PRA3_fnc_broadcastSquadVariable;
						};
					};
				}
				else
				{
					//Refresh to clients, updateSquadLeadership and updateFtLeadership do it automatically.
					_squadId call PRA3_fnc_broadcastSquadVariable;
				};
			};

			if (!isNull _unit) then
			{
				[_unit] joinSilent grpNull; //TODO: locality issues (has to be client-side)
			};

			true
		}
		else
		{
			false
		}
	}
	else
	{
		false
	}
}
else
{
	["PRA3_fnc_unitLeaveSquad", "Has to be run server-side"] call PRA3_fnc_logError;
	false
}
