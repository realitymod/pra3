call compile preprocessFileLineNumbers "pra3\pra3_mp\playerConnected\init.sqf";

if !isMultiplayer then
{
	{
		_x call compile preprocessFileLineNumbers "pra3\pra3_mp\simulateMultiplayer.sqf";
	} forEach allUnits;
};

if isServer then //Server only
{
	call compile preprocessFileLineNumbers "pra3\pra3_mp\playerInfo\server.sqf";
};
if !isDedicated then //Client only
{
	execVM "pra3\pra3_mp\playerInfo\client.sqf";
	0 spawn
	{
		waitUntil {!isNull (findDisplay 46)};
		findDisplay 46 displayAddEventHandler ["keyDown", "if (_this select 1 == 23) then {if dialog then {closeDialog 0} else {false call PRA3_fnc_playerListDlg_open}; true} else {false}"];

	};
};

call compile preprocessFileLineNumbers "pra3\pra3_mp\playerRespawned\init.sqf";
