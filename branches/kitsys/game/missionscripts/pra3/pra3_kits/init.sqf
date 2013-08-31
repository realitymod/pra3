if (!isDedicated) then
{
	0 spawn
	{
		// Infinite loop :(
		while {true} do
		{
			waitUntil {sleep 0.1; !isNull (uiNamespace getVariable "RscDisplayInventory")};
			call PRA3_fnc_blockInventory;
		};
	};
};

PRA3_kitSys_currentKit = "";
PRA3_kitSys_kitConfigurations = [];

call PRA3_fnc_parseKits;
