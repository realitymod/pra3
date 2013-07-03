if (!isDedicated) then
{
	call compile preprocessFile "pra3\pra3_squadsys\dlg\management.sqf";
	0 spawn
	{
		waitUntil {!isNull (findDisplay 46)};
		findDisplay 46 displayAddEventHandler ["keyDown", "if (_this select 1 == 25 && {!dialog}) then {createDialog 'Rsc_PRA3_squadSys_manageDlg'; true} else {false}"];
	};
};
