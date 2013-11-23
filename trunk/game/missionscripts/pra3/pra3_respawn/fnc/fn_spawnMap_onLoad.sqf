#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

uiNamespace setVariable ["PRA3_spawnMap_display", _this];

//-->Set team Switching
//Flags
(_this displayCtrl 502) ctrlSetText ((PRA3_AAS_teams select 0) call PRA3_fnc_getTeamFlag);
(_this displayCtrl 503) ctrlSetText ((PRA3_AAS_teams select 1) call PRA3_fnc_getTeamFlag);

//Team names
(_this displayCtrl 500) ctrlSetText ((PRA3_AAS_teams select 0) call PRA3_fnc_getTeamName);
(_this displayCtrl 501) ctrlSetText ((PRA3_AAS_teams select 1) call PRA3_fnc_getTeamName);

//Disable switching to the team you in
_this call PRA3_fnc_squadDlg_refreshTeamSwitchBtns;

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

ctrl(IDC_KITDLG_SPAWNMAP_TEAMFLAG) ctrlSetText (player call PRA3_fnc_getPlayerTeam call PRA3_fnc_getTeamFlag);
ctrl(IDC_KITDLG_SPAWNMAP_MISSIONNAME) ctrlSetText call PRA3_fnc_missionName; //Mission name

if (!isNil "PRA3_AAS_spawnAtTime") then
{
	var(_updateControls) =
	{
		var(_time) = PRA3_AAS_spawnAtTime - time;
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

		var(_team) = PRA3_AAS_teams find (player call PRA3_fnc_getPlayerTeam);
		ctrl(IDC_KITDLG_SPAWNMAP_TICKETS) ctrlSetText format [
			"%1 (%2)",
			PRA3_core getVariable "PRA3_AAS_tickets" select _team,
			-(PRA3_AAS_ticketBleed select _team)
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
