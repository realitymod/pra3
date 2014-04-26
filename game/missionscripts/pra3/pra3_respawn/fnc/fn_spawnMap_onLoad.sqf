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

call PRA3_fnc_updateSpawnLocations;

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

ctrl(IDC_KITDLG_SPAWNMAP_TEAMFLAG) ctrlSetText (PRA3_player_team call PRA3_fnc_getTeamFlag);
ctrl(IDC_KITDLG_SPAWNMAP_MISSIONNAME) ctrlSetText call PRA3_fnc_missionName; //Mission name

if (!isNil "PRA3_AAS_spawnAtTime") then
{
	var(_updateControls) =
	{
		var(_time) = PRA3_AAS_spawnAtTime - time;
		if (_time < 0) then
		{
			_time = 0;
			ctrl(IDC_KITDLG_SPAWNMAP_SPAWNTIME) ctrlShow false;
		};
		ctrl(IDC_KITDLG_SPAWNMAP_SPAWNTIME) ctrlSetText ([_time, "MM:SS"] call BIS_fnc_secondsToString);
		_time = time - PRA3_AAS_prepareTime;
		if (_time < 0) then
		{
			_time = 0;
		};
		ctrl(IDC_KITDLG_SPAWNMAP_MISSIONTIME) ctrlSetText ([_time, "HH:MM:SS"] call BIS_fnc_secondsToString);

		var(_team) = PRA3_AAS_teams find PRA3_player_team;
		ctrl(IDC_KITDLG_SPAWNMAP_TICKETS) ctrlSetText format [
			"%1 (%2)",
			round (PRA3_core getVariable "PRA3_AAS_tickets" select _team),
			- round (PRA3_AAS_ticketBleed select _team)
		];
	};

	call _updateControls;

	_updateControls spawn
	{
		while {!isNull ctrl(IDC_KITDLG_SPAWNMAP_SPAWNTIME)} do
		{
			sleep 0.01;
			call _this;
		};
	};
};

uiNamespace setVariable [
	"PRA3_spawnMap_teamChangedEvent",
	[
		missionNamespace,
		"teamChanged",
		{
			disableSerialization;

			PRA3_selectedSpawn = [];
			call PRA3_fnc_spawnMap_selectNoSpawn;
		}
	] call BIS_fnc_addScriptedEventHandler
];
