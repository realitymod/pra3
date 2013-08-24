_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "
if ((_this select 1)==2 || (_this select 1)==3 || (_this select 1)==4) then 
{
	_this select 1] call PRA3changeWeapon
}"];