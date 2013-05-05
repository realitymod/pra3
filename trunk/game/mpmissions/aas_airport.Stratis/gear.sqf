_unit = _this select 0;

removeAllWeapons _unit;

_mag = if (side _unit == west) then {"30Rnd_65x39_case_mag_Tracer"} else {"30Rnd_65x39_caseless_green_mag_Tracer"};

for "_i" from 1 to 8 do
{
	_unit addMagazine _mag;
};
_unit addWeapon (if (side _unit == west) then {"arifle_TRG20_ACO_F"} else {"arifle_Khaybar_C_ACO_F"});

for "_i" from 1 to 2 do
{
	_unit addMagazine "SmokeShell";
	_unit addMagazine "HandGrenade";
};

for "_i" from 1 to 3 do
{
	_unit addItem "FirstAidKit";
};

_unit addWeapon "ItemGPS";

