#include "scriptDefines.sqh"

PRA3_AAS_respawnTime = 20;
setPlayerRespawnTime 999999;

if (isNil "PRA3_respawn_keyDownHandler") then
{
	waitUntil {!isNull findDisplay 46};
	PRA3_respawn_keyDownHandler = findDisplay 46 displayAddEventHandler ["keyDown", "_this call PRA3_fnc_respawnOnKeyDown"];
};

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
		if (_time >= 0) then
		{
			_time = [_time ,"MM:SS.MS"] call BIS_fnc_secondsToString;
		}
		else
		{
			_time = "00:00.000";
		};
		uiNamespace getVariable "PRA3_respawn_deadScreen" displayCtrl 30 ctrlSetStructuredText parseText _time;

		if ((time > PRA3_AAS_spawnAtTime || {alive player}) && {
			isNull (uiNamespace getVariable "PRA3_dlg_spawnScreen") &&
			{[player, PRA3_selectedSpawn] call PRA3_fnc_isSpawnAvailable}
		}) exitWith
		{
			setPlayerRespawnTime -1;
			waitUntil {alive player};
			[player, PRA3_selectedSpawn] call PRA3_fnc_respawnUnit;
			(["PRA3_respawn_deadScreen"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
			PRA3_selectedSpawn = ""; // Unselect spawn point
		};

		sleep 0.01;
	};
};