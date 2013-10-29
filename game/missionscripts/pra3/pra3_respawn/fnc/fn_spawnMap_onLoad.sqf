#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

uiNamespace setVariable ["PRA3_spawnMap_display", _this];

var(_colorOutside) = getArray(configFile >> "CfgWorlds" >> worldName >> "OutsideTerrain" >> "colorOutside");
_colorOutside call BIS_fnc_colorConfigToRGBA;

uiNamespace setVariable ["PRA3_respawnMapOutside_R", _colorOutside select 0];
uiNamespace setVariable ["PRA3_respawnMapOutside_G", _colorOutside select 1];
uiNamespace setVariable ["PRA3_respawnMapOutside_B", _colorOutside select 2];

if (isNil "PRA3_spawnMapMousePos") then
{
	PRA3_spawnMapMousePos = [0,0];
};

if (count PRA3_selectedSpawn == 0) then
{
	call PRA3_fnc_spawnMap_selectNoSpawn;
}
else
{
	{
		if ([_x, PRA3_selectedSpawn] call PRA3_fnc_areEqual) exitWith
		{
			call PRA3_fnc_spawnMap_populateSpawnLocations;
			ctrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbSetCurSel _forEachIndex;
		};
	} forEach (player call PRA3_fnc_getAvailableSpawns);
};

ctrl(IDC_KITDLG_SPAWNMAP_SPAWNTIME) ctrlShow !isNil "PRA3_AAS_spawnAtTime";

// If we're switching from a different tab we want to restore the map position
if (!isNil "PRA3_spawnMapPosition") then
{
	ctrl(IDC_KITDLG_SPAWNMAP_MAP) ctrlMapAnimAdd [
		0,
		PRA3_spawnMapPosition select 1,
		PRA3_spawnMapPosition select 0
	];
	ctrlMapAnimCommit ctrl(IDC_KITDLG_SPAWNMAP_MAP);

	PRA3_spawnMapPosition = nil;
};

0 spawn
{
	while {!isNull ctrl(IDC_KITDLG_SPAWNMAP_SPAWNTIME)} do
	{
		_time = PRA3_AAS_spawnAtTime - time;
		if (_time < 0) then
		{
			_time = 0;
		};
		ctrl(IDC_KITDLG_SPAWNMAP_SPAWNTIME) ctrlSetText ([_time, "MM:SS.MS"] call BIS_fnc_secondsToString);
		_time = time - PRA3_AAS_prepareTime;
		if (_time < 0) then
		{
			_time = 0;
		};
		ctrl(IDC_KITDLG_SPAWNMAP_MISSIONTIME) ctrlSetText ([_time, "HH:MM:SS"] call BIS_fnc_secondsToString);

		sleep 0.01;
	};
};
