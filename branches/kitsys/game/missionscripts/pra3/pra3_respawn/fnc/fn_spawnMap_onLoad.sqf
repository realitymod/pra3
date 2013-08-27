#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

uiNamespace setVariable ["PRA3_spawnMap_display", _this];

if PRA3_showRespawnSelection then
{
	var(_colorOutside) = getArray(configFile >> "CfgWorlds" >> worldName >> "OutsideTerrain" >> "colorOutside");
	_colorOutside call BIS_fnc_colorConfigToRGBA;

	uiNamespace setVariable ["PRA3_respawnMapOutside_R", _colorOutside select 0];
	uiNamespace setVariable ["PRA3_respawnMapOutside_G", _colorOutside select 1];
	uiNamespace setVariable ["PRA3_respawnMapOutside_B", _colorOutside select 2];

	if (isNil "PRA3_spawnMapMousePos") then
	{
		PRA3_spawnMapMousePos = [0,0];
	};

	call PRA3_fnc_spawnMap_selectNoSpawn;
}
else
{
	{
		ctrl(_x) ctrlShow false;
	} forEach [
		IDC_KITDLG_SPAWNMAP_BG,
		IDC_KITDLG_SPAWNMAP_TITLE,
		IDC_KITDLG_SPAWNMAP_MAP,
		IDC_KITDLG_SPAWNMAP_SELECTION,
		IDC_KITDLG_SPAWNMAP_CLOSE_BTN
	];
};
