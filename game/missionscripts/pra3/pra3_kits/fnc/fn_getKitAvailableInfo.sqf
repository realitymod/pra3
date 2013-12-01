#include "scriptDefines.sqh"
#include "defines.sqh"

/**
 *	Returns the number of kits the given unit has available.
 *		(in)  <ARRAY>:
 *			0 <OBJECT> Unit
 *				OR
 *			0 <STRING> Unit UID
 *			1 <STRING> Kit
 *		(out) <ARRAY>:
 *			0: <BOOL> Kit available
 *			1: <STRING> Availability message
 */

var(_unit) = _this select 0;
var(_kit)  = _this select 1;

var(_kitInfo) = _kit call PRA3_fnc_getKitInfo;

var(_nowAvailable) = 0;
var(_maxAvailable) = 0;

var(_text) = switch true do
{
	case (PRA3_core getVariable ["PRA3_debug_kits_showAllKits", false]):
	{
		_nowAvailable = 100;
		"Debug-enabled"
	};
	case (isNil "PRA3_selectedSpawn" || {count PRA3_selectedSpawn == 0}):
	{
		"Select a respawn location first";
	};
	case (_kitInfo select KIT_REQUIREMENTS select 0 == LIMIT_SQUAD &&
		{_unit call PRA3_fnc_unitGetSquad == -1}):
	{
		"Only for squad members";
	};
	case (_kitInfo select KIT_REQUIREMENTS select 0 == LIMIT_SL &&
		{_unit call PRA3_fnc_unitGetSquad call PRA3_fnc_squadGetLeader != (_unit call PRA3_fnc_getPlayerUID)}):
	{
		"Must be squad leader";
	};
	case !([_kit, PRA3_selectedSpawn] call PRA3_fnc_kitAvailableAtSpawn):
	{
		"Unavailable at this location";
	};
	default
	{
		_nowAvailable = [_unit, _kit] call PRA3_fnc_getKitAvailableNum;
		_maxAvailable = [_unit, _kit] call PRA3_fnc_getMaxKitAvailableNum;

		if (_nowAvailable >= __inf) then {
			"Unlimited"
		} else {
			if (_nowAvailable == 0) then {
				"Unavailable"
			} else {
				format["%1 available", _nowAvailable]
			}
		}
	};
};

[_nowAvailable > 0, _text]
