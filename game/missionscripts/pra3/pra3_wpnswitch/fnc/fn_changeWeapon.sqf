private ["_key"];

_key = _this select 0;

switch (_key) do
{
	case 2:    
	{ 
		if (primaryweapon player != "") then {player selectWeapon (primaryweapon player)};
	};

	case 3:    
	{ 
		if (handgunWeapon player != "") then {player selectWeapon (handgunWeapon player)};
	};    

	case 4:    
	{ 
		if (secondaryWeapon player != "") then {player selectWeapon (secondaryWeapon  player)};
	};
	
	case 5:	
	{ 
		_muzzles = getArray(configFile>>"cfgWeapons" >> (primaryweapon player) >> "muzzles");
		if (primaryweapon player != "" && (count _muzzles) > 1) then {
			//player selectWeapon (primaryweapon player);
			player selectWeapon (_muzzles select 1);
		};
	};
};
