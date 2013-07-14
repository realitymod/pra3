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

PRA3_kitSys_currentKit = "Rifleman_US";
PRA3_kitSys_curAvailableKits = [
	"Rifleman_US", "SquadLeader_US", "Medic_US", "Machinegunner_US", "Grenadier_US", "Marksman_US",
	"Rifleman_IN", "SquadLeader_IN", "Medic_IN", "Machinegunner_IN", "Grenadier_IN", "Marksman_IN"
];
PRA3_kitSys_kitConfigurations = [];

call PRA3_fnc_parseKits;
