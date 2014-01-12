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
		[
			format [
				"PRA3_AAS_captureNotification%1",
				if (_newOwner == PRA3_player_side) then {"Friendly"} else {"Hostile"}
			],
			[
				str (_zone call PRA3_fnc_AAS_getZoneName),
				_newOwner call PRA3_fnc_sideToTeam call PRA3_fnc_getTeamName,
				"\a3\Ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa"
			]
		] call bis_fnc_showNotification;
	}
	else
	{
		[
			format [
				"PRA3_AAS_neutralizedNotification%1",
				if (_attackSide == PRA3_player_side) then {"Friendly"} else {"Hostile"}
			],
			[
				str (_zone call PRA3_fnc_AAS_getZoneName),
				_attackSide call PRA3_fnc_sideToTeam call PRA3_fnc_getTeamName,
				"\a3\Ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa"
			]
		] call bis_fnc_showNotification;
	};
};

_zone call PRA3_fnc_AAS_updateZoneMarker;
call PRA3_fnc_AAS_calculateFrontline;
call PRA3_fnc_AAS_updateAttackDefendMarkers;
call PRA3_fnc_AAS_calculateTicketBleed;
call PRA3_fnc_updateSpawnLocations;
