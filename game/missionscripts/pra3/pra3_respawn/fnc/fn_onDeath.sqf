#include "scriptDefines.sqh"

PRA3_AAS_respawnTime = 20;
setPlayerRespawnTime 999999;

if !(alive player) then
{
	PRA3_AAS_spawnAtTime = time + PRA3_AAS_respawnTime;
	
	// Penalize the death
	// TODO: Remove hardcoded value
	[player call PRA3_fnc_getPlayerSide, 1] call PRA3_fnc_AAS_removeTickets;
	
	sleep 1;
	// Delete any weapons the player dropped
	{
		deleteVehicle _x;
	} forEach nearestObjects [player, ["WeaponHolderSimulated"], 10];
	sleep (2 + random 2);
	(["PRA3_respawn_deadScreen"] call BIS_fnc_rscLayer) cutRsc ["PRA3_respawn_deadScreen", "PLAIN"];

	while {true} do
	{
		_time = PRA3_AAS_spawnAtTime - time;
		_timeStr = if (_time >= 0) then
		{
			[_time ,"MM:SS.MS"] call BIS_fnc_secondsToString;
		}
		else
		{
			"00:00.000";
		};
		uiNamespace getVariable "PRA3_respawn_deadScreen" displayCtrl 30 ctrlSetStructuredText parseText _timeStr;

		if ((time > PRA3_AAS_spawnAtTime || {alive player}) && {
			isNull (uiNamespace getVariable "Rsc_PRA3_squadSys_manageDlgRespawn") &&
			{isNull (uiNamespace getVariable "Rsc_PRA3_kits_kitDlgRespawn") &&
			{PRA3_selectedSpawn != "" && {PRA3_kitSys_currentKit != ""}} &&
			{[player, PRA3_selectedSpawn] call PRA3_fnc_isSpawnAvailable}
		}}) exitWith
		{
			setPlayerRespawnTime -1;
			waitUntil {alive player};
			[player] call PRA3_fnc_switchTeamCheck;
			[player, PRA3_selectedSpawn] call PRA3_fnc_respawnUnit;
			[player, PRA3_kitSys_currentKit] call PRA3_fnc_equipWithKit;
			(["PRA3_respawn_deadScreen"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
			PRA3_selectedSpawn = ""; // Unselect spawn point
			PRA3_AAS_spawnAtTime = nil;
		};

		sleep 0.01;
	};
};
