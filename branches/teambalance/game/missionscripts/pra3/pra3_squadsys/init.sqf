if (!isDedicated) then
{
	call compile preprocessFile "pra3\pra3_squadsys\dlg\management.sqf";
	0 spawn
	{
		waitUntil {!isNull (findDisplay 46)};
		findDisplay 46 displayAddEventHandler ["keyDown", "if (_this select 1 == 25) then {if dialog then {closeDialog 0} else {false call PRA3_fnc_squadDlg_open}; true} else {false}"];
		
	};
};
