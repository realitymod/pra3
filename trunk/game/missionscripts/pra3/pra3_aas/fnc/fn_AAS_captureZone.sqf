#include "scriptDefines.sqh"
#include "aas_defines.sqh"

var(_zone) = _this select 0;
var(_prevOwner) = _this select 1;

if (isClient) then
{
	if (_prevOwner == __neutral) then
	{
		player globalChat format["%1 captured %2", _zone call PRA3_fnc_AAS_getZoneOwner, _zone call PRA3_fnc_AAS_getZoneName];
		["PRA3_AAS_captureNotification",[str (_zone call PRA3_fnc_AAS_getZoneName) ,((_zone call PRA3_fnc_AAS_getZoneOwner) call PRA3_fnc_sideToTeam) ,"\a3\Ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa",""]] call bis_fnc_showNotification;
	}
	else
	{
		player globalChat format["%1 lost control of %2", _prevOwner, _zone call PRA3_fnc_AAS_getZoneName];
		["PRA3_AAS_neutralizedNotification",[str (_zone call PRA3_fnc_AAS_getZoneName) ,((_zone call PRA3_fnc_AAS_getZoneOwner) call PRA3_fnc_sideToTeam) ,"\a3\Ui_f\data\GUI\Cfg\Notifications\tridentEnemy_ca.paa",""]] call bis_fnc_showNotification;
	};
};

_zone call PRA3_fnc_AAS_updateZoneMarker;
call PRA3_fnc_AAS_calculateFrontline;
call PRA3_fnc_AAS_updateAttackDefendMarkers;
call PRA3_fnc_AAS_calculateTicketBleed;
call PRA3_fnc_updateSpawnLocations;