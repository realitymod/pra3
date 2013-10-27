#include "scriptDefines.sqh"
#include "defines.sqh"

/**
 * Creates a squad and returns its unique ID.
 * Returns -1 if a squad cannot be created or the player is already in a squad.
 *
 *		(in)  <STRING> Squad leader UID
 *				or
 *		(in)  <OBJECT> Squad leader
 *		(out) <INT> Squad ID
 */

if (isServer) then
{
	var(_leaderId)   = "";
	var(_leaderUnit) = objNull;

	if (typeName _this == "OBJECT") then
	{
		_leaderUnit = _this;
		_leaderId = _this call PRA3_fnc_getPlayerUID;
	}
	else
	{
		_leaderId = _this;
		_leaderUnit = _this call PRA3_fnc_getPlayerUnit;
	};

	// Already in a squad
	if (_leaderId call PRA3_fnc_unitGetSquad != -1) then
	{
		-1
	}
	else
	{
		var(_side) = _leaderId call PRA3_fnc_getPlayerSide;

		diag_log ["leaderUnit",_leaderUnit];

		var(_id) = _side call PRA3_fnc_getSideID;
		var(_i) = 1;
		while {(_id + _i) call PRA3_fnc_squadExists} do
		{
			_i = _i + 1;
		};
		if (_i > __maxSquads) then
		{
			-1
		}
		else
		{
			_id = _id + _i;

			var(_group) = group _leaderUnit;

			PRA3_core setVariable [
				format["PRA3_squadSys_squad_%1", _id],
				[
					[[_leaderID, 10]],                    //0: Members
					"",                                   //1: Optional name
					8,                                    //2: Squad size limit
					false,                                //3: Squad locked
					_group,                               //4: Arma group
					objNull,                              //5: Rallypoint
					if (time > NO_COOLDOWN_BEFORE) then { //6: Rallypoint available at
						time + RALLYPOINT_COOLDOWN
					} else {
						0
					}
				],
				true
			];

			PRA3_core setVariable [format["PRA3_squadSys_unitSquad_%1", _leaderID], _id, true];

			var(_squads) = PRA3_core getVariable ["PRA3_squadSys_squads", []]; //pointer
			_squads set [count _squads, _id];
			PRA3_core setVariable ["PRA3_squadSys_squads", _squads, true];

			_id
		}
	}
}
else
{
	["PRA3_fnc_createSquad", "Has to be run server-side"] call PRA3_fnc_logError;
	-1
}
