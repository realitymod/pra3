if (isServer) then //Server only
{
	call compile preprocessFileLineNumbers "pra3\pra3_mp\playerConnected\init.sqf";
	call compile preprocessFileLineNumbers "pra3\pra3_mp\playerInfo\server.sqf";
};
if (!isDedicated) then //Client only
{
	execVM "pra3\pra3_mp\playerInfo\client.sqf";
};

call compile preprocessFileLineNumbers "pra3\pra3_mp\playerRespawned\init.sqf";

if (!isMultiplayer) then
{
	{
		[_x] call compile preprocessFileLineNumbers "pra3\pra3_mp\simulateMultiplayer.sqf";
	} forEach allUnits;
};
