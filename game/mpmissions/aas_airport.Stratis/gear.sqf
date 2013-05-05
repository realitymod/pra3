_unit = _this select 0;

removeAllWeapons _unit;
for "_i" from 1 to 8 do
{
	_unit addMagazine "16Rnd_9x21_Mag"
};
_unit addWeapon (if (side _unit == west) then {"hgun_P07_F"} else {"hgun_Rook40_F"});

for "_i" from 1 to 2 do
{
	_unit addMagazine "SmokeShell";
	_unit addMagazine "HandGrenade";
};
