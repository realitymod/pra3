call compile preprocessFileLineNumbers "pra3\pra3_mp\playerConnected\init.sqf";

if isServer then //Server only
{
	call compile preprocessFileLineNumbers "pra3\pra3_mp\playerInfo\server.sqf";
};
if !isDedicated then //Client only
{
	execVM "pra3\pra3_mp\playerInfo\client.sqf";
};

if !isMultiplayer then
{
	{
		_x call compile preprocessFileLineNumbers "pra3\pra3_mp\simulateMultiplayer.sqf";
	} forEach allUnits;
};

call compile preprocessFileLineNumbers "pra3\pra3_mp\playerRespawned\init.sqf";
