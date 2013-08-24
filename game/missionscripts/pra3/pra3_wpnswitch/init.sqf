private "_keyDown"; 

0 spawn
{
	waitUntil {!isNull (findDisplay 46)};
	_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if ((_this select 1)==2 || (_this select 1)==3 || (_this select 1)==4 || (_this select 1)==5) then {[_this select 1] call PRA3_fnc_changeWeapon; true}"];
};