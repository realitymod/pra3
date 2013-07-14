if (!isDedicated) then
{
	call compile preprocessFile "pra3\pra3_interactions\doorOpen.sqf";
	0 spawn
	{
		waitUntil {!isNull (findDisplay 46)};
		(findDisplay 46) displayAddEventHandler ["keyDown", "if (_this select 1 == 57) then {execVM 'pra3\pra3_interactions\doorOpen.sqf'}; false"]
		//findDisplay 46 displayAddEventHandler ["keyDown", "if (_this select 1 == 25 && {!dialog}) then {createDialog 'Rsc_PRA3_squadSys_manageDlg'; true} else {false}"];
	};
};

