#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

diag_log ["onLoad", _this];
PRA3_kitSys_currentKit call PRA3_fnc_kitDlg_populateKitSelection;
__getCtrl(IDC_KITDLG_DETAILS) ctrlShow false;
PRA3_kitSys_kitDetailsExpanded = false;

PRA3_showRespawnSelection = true;

if PRA3_showRespawnSelection then
{
	var(_colorOutside) = getArray(configFile >> "CfgWorlds" >> worldName >> "OutsideTerrain" >> "colorOutside");
	_colorOutside call BIS_fnc_colorConfigToRGBA;

	uiNamespace setVariable ["PRA3_respawnMapOutside_R", _colorOutside select 0];
	uiNamespace setVariable ["PRA3_respawnMapOutside_G", _colorOutside select 1];
	uiNamespace setVariable ["PRA3_respawnMapOutside_B", _colorOutside select 2];

	PRA3_spawnMapMousePos = [0,0];

	{
		__getCtrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbAdd (_x select 1);
	} forEach (player call PRA3_fnc_AAS_getAvailableSpawns);
	__getCtrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbSetCurSel 0;
}
else
{
	{
		__getCtrl(_x) ctrlShow false;
	} forEach [
		IDC_KITDLG_SPAWNMAP_BG,
		IDC_KITDLG_SPAWNMAP_TITLE,
		IDC_KITDLG_SPAWNMAP_MAP,
		IDC_KITDLG_SPAWNMAP_SELECTION,
		IDC_KITDLG_SPAWNMAP_CLOSE_BTN
	];
};
