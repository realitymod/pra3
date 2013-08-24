changeWeapon =
{
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
	};
};