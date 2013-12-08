#include "scriptDefines.sqh"
#include "aas_defines.sqh"

var(_zone)       = _this select 0;
var(_newOwner)   = _this select 1;
var(_prevOwner)  = _this select 2;
var(_attackSide) = _this select 3;

if isClient then
{
	if (_prevOwner == __neutral) then
	{
		var(_text) = if (PRA3_player_side == _newOwner) then {"Hostile"} else {"Friendly"};

		player globalChat format["%1 captured %2", _zone call PRA3_fnc_AAS_getZoneOwner, _zone call PRA3_fnc_AAS_getZoneName];
		[
			format [
				"PRA3_AAS_captureNotification%1",
				if (_newOwner == PRA3_player_side) then {"Friendly"} else {"Hostile"}
			],
			[
				str (_zone call PRA3_fnc_AAS_getZoneName),
				_newOwner call PRA3_fnc_sideToTeam call PRA3_fnc_getTeamName,
				"\a3\Ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa",
				""
			]
		] call bis_fnc_showNotification;
	}
	else
	{
		player globalChat format["%1 lost control of %2", _prevOwner, _zone call PRA3_fnc_AAS_getZoneName];
		[
			format [
				"PRA3_AAS_neutralizedNotification%1",
				if (_attackSide == PRA3_player_side) then {"Friendly"} else {"Hostile"}
			],
			[
				str (_zone call PRA3_fnc_AAS_getZoneName),
				_attackSide call PRA3_fnc_sideToTeam call PRA3_fnc_getTeamName,
				"\a3\Ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa",
				""
			]
		] call bis_fnc_showNotification;
	};
};

_zone call PRA3_fnc_AAS_updateZoneMarker;
call PRA3_fnc_AAS_calculateFrontline;
call PRA3_fnc_AAS_updateAttackDefendMarkers;
call PRA3_fnc_AAS_calculateTicketBleed;
call PRA3_fnc_updateSpawnLocations;
