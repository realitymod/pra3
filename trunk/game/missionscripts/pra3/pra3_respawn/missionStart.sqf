PRA3_selectedSpawn     = [];
PRA3_kitSys_currentKit = "";

#define ctrl(idc) (uiNamespace getVariable "PRA3_respawn_startScreen" displayCtrl idc)

["PRA3_start_black"] call BIS_fnc_rscLayer cutText ["", "BLACK FADED", 30];

_camera = "camera" camCreate getPosATL player;
_camera camPrepareTarget (PRA3_AAS_startCamera select 0);
_camera camPreparePos (PRA3_AAS_startCamera select 1);
_camera camPrepareFOV (PRA3_AAS_startCamera select 2);
_camera camCommitPrepared 0;
_camera cameraEffect ["INTERNAL", "BACK"];
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
["PRA3_start_info"] call BIS_fnc_rscLayer cutRsc ["PRA3_respawn_startScreen", "PLAIN"];

_updateInstructions =
{
	_getImg =
	{
		format 
		[
			"\a3\ui_f\data\map\Diary\Icons\%1",
			if _this then {"tasksucceeded_ca"} else {"tasknone_ca"}
		]
	};

	_text = format 
	[
		"Press <t underline='true'>ENTER</t> and<br/> <img image='%1'/> Select a team<br/> <img image='%2'/> Join a squad<br/> <img image='%3'/> Select a spawn<br/> <img image='%4'/> Choose a kit",
		true call _getImg,
		(player call PRA3_fnc_unitGetSquad != -1) call _getImg,
		(count PRA3_selectedSpawn > 0) call _getImg,
		(PRA3_kitSys_currentKit != "") call _getImg
	];

	ctrl(20) ctrlSetStructuredText parseText _text;
	ctrl(5) ctrlSetStructuredText parseText call PRA3_fnc_missionName;
};

waitUntil
{
	_time = PRA3_AAS_prepareTime - time;
	_timeStr = if (_time >= 0) then	
	{
		[_time ,"MM:SS"] call BIS_fnc_secondsToString;
	} else 
	{
		"00:00";
	};
	ctrl(30) ctrlSetStructuredText parseText _timeStr;

	call _updateInstructions;

	_time <= 0
};

ctrl(10) ctrlSetStructuredText parseText "The mission has started.";
ctrl(30) ctrlShow false;

waitUntil 
{
	call _updateInstructions;

	count PRA3_selectedSpawn > 0 && 
	{
		PRA3_kitSys_currentKit != "" && 
		{
			isNull (uiNamespace getVariable ["Rsc_PRA3_squadSys_manageDlgRespawn", displayNull]) && 
			{
				isNull (uiNamespace getVariable ["Rsc_PRA3_kits_kitDlgRespawn", displayNull])
			}
		}
	}
};

PRA3_joinedGame = true;

[player, PRA3_kitSys_currentKit] call PRA3_fnc_equipWithKit;
[player, PRA3_selectedSpawn] call PRA3_fnc_respawnUnit;

["PRA3_start_info"] call BIS_fnc_rscLayer cutText ["", "PLAIN"];
PRA3_respawn_lastOpenTab = nil;
enableEnvironment true;

_camera cameraEffect ["TERMINATE", "BACK"];
_camera camCommit 0;
camDestroy _camera;
