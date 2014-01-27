if !isDedicated then
{
	PRA3_player_side = civilian;
	PRA3_player_team = "";

	call compile preprocessFile "pra3\pra3_squadsys\dlg\management.sqf";
	0 spawn
	{
		waitUntil {!isNull (findDisplay 46)};
		findDisplay 46 displayAddEventHandler ["keyDown", "if (_this select 1 == 25) then {if dialog then {closeDialog 0} else {false call PRA3_fnc_squadDlg_open}; true} else {false}"];
	};
};

// Raise teamChanged event upon player disconnecting
{
	private "_uid";
	_uid = _this select 2;
	[
		missionNamespace,
		"teamChanged",
		[_uid, "", _uid call PRA3_fnc_getPlayerTeam] // Set new team as ""
	] call BIS_fnc_callScriptedEventHandler;
} call PRA3_fnc_registerPlayerDisconnectedHandler;
