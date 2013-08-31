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

	ctrl(IDC_KITDLG_SPAWNMAP_TIME) ctrlShow !isNil "PRA3_AAS_spawnAtTime";

	if (!isNil "PRA3_AAS_spawnAtTime") then
	{
		0 spawn
		{
			while {!isNil "PRA3_AAS_spawnAtTime"} do
			{
				_time = PRA3_AAS_spawnAtTime - time;
				if (_time >= 0) then
				{
					_time = [_time ,"MM:SS.MS"] call BIS_fnc_secondsToString;
				}
				else
				{
					_time = "00:00.000";
				};
				ctrl(IDC_KITDLG_SPAWNMAP_TIME) ctrlSetText _time;
				sleep 0.01;
			};
		};
	};
}
else
{
	{
		ctrl(_x) ctrlShow false;
	} forEach [
		IDC_KITDLG_SPAWNMAP_BG,
		IDC_KITDLG_SPAWNMAP_TITLE,
		IDC_KITDLG_SPAWNMAP_TIME,
		IDC_KITDLG_SPAWNMAP_MAP,
		IDC_KITDLG_SPAWNMAP_SELECTION,
		IDC_KITDLG_SPAWNMAP_CLOSE_BTN
	];
};
