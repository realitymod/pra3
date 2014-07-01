if (!isDedicated) then
{
	player addEventHandler 
	[
		"InventoryOpened",
		{
			call PRA3_fnc_blockInventory;
		}
	];
};

PRA3_kitSys_currentKit = "";
PRA3_kitSys_kitConfigurations = [];

call PRA3_fnc_parseKits;
