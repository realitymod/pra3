#include "scriptDefines.sqh"

PRA3_AAS_respawnTime = 30;
setPlayerRespawnTime 999999;

if !(alive player) then
{
	var(_body) = _this select 0;

	PRA3_AAS_spawnAtTime = time + PRA3_AAS_respawnTime;

	// Penalize the death
	// TODO: Remove hardcoded value
	[player call PRA3_fnc_getPlayerSide, 1] call PRA3_fnc_AAS_removeTickets;

	sleep 1;
	// Delete any weapons the player dropped
	{
		deleteVehicle _x;
	} forEach nearestObjects [player, ["WeaponHolderSimulated"], 10];
	
	//Delete medkits and FAKs
	{
		if (_x in ["FirstAidKit","Medikit"]) then {player removeItem _x}; 
	} forEach items player;
	

	// Schedule body deletion
	[_body, "PRA3_fnc_scheduleDeleteBody", false] call PRA3_fnc_MP;

	sleep (1 + random 2);

	_updateInstructions =
	{
		_getImg =
		{
			format [
				"\a3\ui_f\data\map\Diary\Icons\%1",
				if _this then {"tasksucceeded_ca"} else {"tasknone_ca"}
			]
		};

		_text = format [
			"Press <t underline='true'><t color='#d5d5d5'>ENTER</t></t> and<br/> <img image='%1'/> Select a spawn<br/> <img image='%2'/> Choose a kit",
			(count PRA3_selectedSpawn > 0) call _getImg,
			(PRA3_kitSys_currentKit != "") call _getImg
		];

		uiNamespace getVariable "PRA3_respawn_deadScreen" displayCtrl 20 ctrlSetStructuredText parseText _text;
	};

	call _updateInstructions;

	// Create black screen
	(["PRA3_respawn_deadScreen"] call BIS_fnc_rscLayer) cutRsc ["PRA3_respawn_deadScreen", "PLAIN"];

	// Mute sound
	1 fadeSound 0;

	// Wait for black screen to fade in
	sleep 1.1;

	// Create a camera in the middle of nowhere to prevent dead player from talking to people in direct
	var(_pos) = [1,1,1000];
	var(_deathCamera) = "camera" camCreate _pos;
	_deathCamera setPosATL _pos;
	_deathCamera switchCamera "INTERNAL";

	// Remove map marker
	[
		player,
		"PRA3_fnc_stopVehicleTracking"
	] call PRA3_fnc_MP;

	waitUntil
	{
		var(_time) = PRA3_AAS_spawnAtTime - time;
		_timeStr = if (_time >= 0) then
		{
			[_time ,"MM:SS.MS"] call BIS_fnc_secondsToString;
		}
		else
		{
			"00:00.000";
		};
		uiNamespace getVariable "PRA3_respawn_deadScreen" displayCtrl 30 ctrlSetStructuredText parseText _timeStr;

		call _updateInstructions;

		(time > PRA3_AAS_spawnAtTime || alive player) &&
		isNull (uiNamespace getVariable "Rsc_PRA3_squadSys_manageDlgRespawn") &&
		isNull (uiNamespace getVariable "Rsc_PRA3_kits_kitDlgRespawn") &&
		count PRA3_selectedSpawn > 0 &&
		PRA3_kitSys_currentKit != "" &&
		{[player, PRA3_selectedSpawn] call PRA3_fnc_isSpawnAvailable}
	};

	setPlayerRespawnTime -1;
	waitUntil {alive player};
	[player] call PRA3_fnc_switchTeamCheck;
	[player, PRA3_selectedSpawn] call PRA3_fnc_respawnUnit;
	[player, PRA3_kitSys_currentKit] call PRA3_fnc_equipWithKit;

	0 fadesound 1;
	player switchCamera "INTERNAL";
	camDestroy _deathCamera;
	(["PRA3_respawn_deadScreen"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
	PRA3_selectedSpawn = []; // Unselect spawn point
	PRA3_AAS_spawnAtTime = nil;

	// Create marker
	[
		player,
		"PRA3_fnc_startVehicleTracking"
	] call PRA3_fnc_MP;
};
