_unit = _this select 0;

removeAllWeapons _unit;
for "_i" from 1 to 5 do
{
	_unit addMagazine (if (side _unit == west) then {"30Rnd_45ACP_Mag_SMG_01"} else {"30Rnd_9x21_Mag"});
};
_unit addWeapon (if (side _unit == west) then {"SMG_01_F"} else {"SMG_02_F"});

for "_i" from 1 to 2 do
{
	_unit addMagazine "HandGrenade";
	_unit addMagazine "SmokeShell";
};

for "_i" from 1 to 3 do
{
	_unit addItem "FirstAidKit";
};

_unit addWeapon "ItemGPS";
