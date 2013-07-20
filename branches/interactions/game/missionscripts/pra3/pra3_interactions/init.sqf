if (!isDedicated) then
{
	call compile preprocessFile "pra3\pra3_interactions\interactions.sqf";
	0 spawn
	{
		waitUntil {!isNull (findDisplay 46)};
		(findDisplay 46) displayAddEventHandler ["keyDown", "if (_this select 1 == 57) then {execVM 'pra3\pra3_interactions\interactions.sqf'}; false"]
	};
};

