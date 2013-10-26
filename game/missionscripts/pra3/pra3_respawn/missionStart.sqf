PRA3_AAS_prepareTime = 15;

PRA3_selectedSpawn     = [];
PRA3_kitSys_currentKit = "";

#define ctrl(idc) (uiNamespace getVariable "PRA3_respawn_startScreen" displayCtrl idc)

["PRA3_start_black"] call BIS_fnc_rscLayer cutText ["", "BLACK FADED", 30];
["PRA3_start_info"] call BIS_fnc_rscLayer cutRsc ["PRA3_respawn_startScreen", "PLAIN"];

_camera = "camera" camCreate getPosATL player;
_camera camPrepareTarget (PRA3_AAS_startCamera select 0);
_camera camPreparePos (PRA3_AAS_startCamera select 1);
_camera camPrepareFOV (PRA3_AAS_startCamera select 2);
_camera camCommitPrepared 0;
_camera cameraEffect ["INTERNAL", "BACK"];

// Put player in the team with less players
_unfairSide = 1 call PRA3_fnc_getUnbalancedSide;
if (_unfairSide != sideLogic) then // Some unbalance is going on, some side has >1 players more
{
	if (player call PRA3_fnc_getPlayerSide == _unfairSide) then
	{
		call PRA3_fnc_switchTeam;
	};
};

_camera camPreload 10;

waitUntil {time > 1};
showCinemaBorder false;
enableEnvironment false;

if (isNil "PRA3_respawn_keyDownHandler") then
{
	waitUntil {!isNull findDisplay 46};
	PRA3_respawn_keyDownHandler = findDisplay 46 displayAddEventHandler ["keyDown", "_this call PRA3_fnc_respawnOnKeyDown"];
};

["PRA3_start_black"] call BIS_fnc_rscLayer cutText ["", "BLACK IN", 1];

waitUntil
{
	_time = PRA3_AAS_prepareTime - time;
	_timeStr = if (_time >= 0) then	{
			[_time ,"MM:SS.MS"] call BIS_fnc_secondsToString;
		} else {
			"00:00.000";
		};
	ctrl(30) ctrlSetStructuredText parseText _timeStr;

	_time <= 0
};

ctrl(10) ctrlSetStructuredText parseText "The mission has begun...";
ctrl(30) ctrlShow false;

waitUntil {
	count PRA3_selectedSpawn > 0 && {
		PRA3_kitSys_currentKit != "" && {
			isNull (uiNamespace getVariable ["Rsc_PRA3_squadSys_manageDlgRespawn", displayNull]) && {
				isNull (uiNamespace getVariable ["Rsc_PRA3_kits_kitDlgRespawn", displayNull])
			}
		}
	}
};

[player, PRA3_kitSys_currentKit] call PRA3_fnc_equipWithKit;
[player, PRA3_selectedSpawn] call PRA3_fnc_respawnUnit;

["PRA3_start_info"] call BIS_fnc_rscLayer cutText ["", "PLAIN"];
PRA3_respawn_lastOpenTab = nil;
enableEnvironment true;

_camera cameraEffect ["TERMINATE", "BACK"];
_camera camCommit 0;
camDestroy _camera;
