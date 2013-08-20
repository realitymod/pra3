#include "scriptDefines.sqh"
#include "defines.sqh"

diag_log ["onLoad", _this];
PRA3_kitSys_currentKit call PRA3_fnc_kitDlg_populateKitSelection;
__getCtrl(100) ctrlShow false;
PRA3_kitSys_kitDetailsExpanded = false;

PRA3_showRespawnSelection = true;

if PRA3_showRespawnSelection then
{
	var(_colorOutside) = getArray(configFile >> "CfgWorlds" >> worldName >> "OutsideTerrain" >> "colorOutside");
	_colorOutside call BIS_fnc_colorConfigToRGBA;

	uiNamespace setVariable ["PRA3_respawnMapOutside_R", _colorOutside select 0];
	uiNamespace setVariable ["PRA3_respawnMapOutside_G", _colorOutside select 1];
	uiNamespace setVariable ["PRA3_respawnMapOutside_B", _colorOutside select 2];

	{
		__getCtrl(202) lbAdd (_x select 1);
	} forEach (player call PRA3_fnc_AAS_getAvailableSpawns);
	__getCtrl(202) lbSetCurSel 0;
}
else
{
	__getCtrl(200) ctrlShow false;
};
