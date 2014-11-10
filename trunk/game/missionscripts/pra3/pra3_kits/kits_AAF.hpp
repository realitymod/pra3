class Rifleman_AAF : Rifleman_CSAT
{
	scope = public;
	team  = AAF;

	class Clothing
	{
		uniform  = "U_I_CombatUniform";
		headgear = "H_HelmetIA";
		goggles  = "";
		vest     = "V_PlateCarrierIA1_dgtl";
	};

	class Variants
	{
		class Variant1
		{
			name = "Standard";
			class Pistol
			{
			};
			class Primary
			{
				weapon      = "arifle_Mk20C_F";
				optics      = "optic_ACO_grn";
				rail        = "";
				muzzle      = "";
				magazines[] = {{"30Rnd_556x45_Stanag_Tracer_Yellow", 9}};
			};
			class Secondary
			{
			};
			class Backpack
			{
				backpack    = "B_Carryall_oli";
				weapons[]   = {};
				magazines[] = {{"30Rnd_65x39_caseless_green_mag_Tracer", 12}, {"20Rnd_762x51_Mag", 9}};
			};

			explosives[] = {{"HandGrenade", 2}, {"SmokeShell", 2}};
			items[]      = {COMMON_ITEMS, {"FirstAidKit", 1}};
		};
		class Variant2 : Variant1
		{
			name = "AR Support";

			class Backpack : Backpack
			{
				backpack    = "B_TacticalPack_oli";
				magazines[] = {{"200Rnd_65x39_belt_Tracer_Green", 5}};
			};
		};
		class Variant3 : Variant1
		{
			name = "Grenadier Support";

			class Backpack : Backpack
			{
				backpack    = "B_Tacticalpack_oli";
				magazines[] = {{"1Rnd_HE_Grenade_shell", 20}, {"1Rnd_Smoke_Grenade_shell", 10}};
			};
		};
	};
};
class SquadLeader_AAF : Rifleman_AAF
{
	name = "Squad Leader";
	picture = "pra3\pra3_ui\kits\kit_img\sqleader_88.paa";
	icon = "pra3\pra3_ui\kits\kit_img\sqleader_small_88.paa";

	class Requirements : RequirementsSL
	{
	};

	class Clothing : Clothing
	{
		uniform  = "U_I_OfficerUniform";
		headgear = "H_MilCap_dgtl";
		vest     = "V_Chestrig_oli";
	};

	abilities[] = {"rallyPoint"};

	class Variants : Variants
	{
		class Variant1 : Variant1
		{
			name = "Standard";
			class Pistol
			{
				weapon      = "hgun_ACPC2_F";
				magazines[] = {{"9Rnd_45ACP_Mag", 3}};
			};
			class Primary : Primary
			{
				optics      = "optic_MRCO";
			};
			class Secondary
			{
			};
			class Backpack
			{
				backpack    = "B_Carryall_oli";
			};

			explosives[] = {{"HandGrenade", 2}, {"SmokeShell", 4}, {"SmokeShellRed", 2}};
			items[]      = {COMMON_ITEMS, {"FirstAidKit", 3}, {"Rangefinder", 1}, {"ItemGPS", 1}};
		};
	};
};
class Medic_AAF : Rifleman_AAF
{
	name = "Combat Medic";
	picture = "pra3\pra3_ui\kits\kit_img\medic_88.paa";
	icon = "pra3\pra3_ui\kits\kit_img\medic_small_88.paa";

	class Requirements : RequirementsMedic
	{
	};

	class Clothing : Clothing
	{
		uniform  = "U_I_CombatUniform_shortsleeve";
		vest     = "V_BandollierB_oli";
		headgear = "H_HelmetIA_camo";
	};

	class Variants : Variants
	{
		class Variant1 : Variant1
		{
			class Primary : Primary
			{
				weapon      = "arifle_Mk20C_F";
			};
			class Secondary
			{
			};
			class Backpack
			{
				backpack  = "I_Fieldpack_oli_Medic";
				weapons[] = {{"Medikit", 1}, {"FirstAidKit", 10}};
			};

			explosives[] = {{"HandGrenade", 2}, {"SmokeShell", 5}};
			items[]      = {COMMON_ITEMS};
		};
	};
};
class Machinegunner_AAF : Rifleman_AAF
{
	name = "Automatic Rifleman";
	picture = "pra3\pra3_ui\kits\kit_img\autorifleman_88.paa";
	icon = "pra3\pra3_ui\kits\kit_img\autorifleman_small_88.paa";

	class Requirements : RequirementsMG
	{
	};

	class Clothing : Clothing
	{
	};

	class Variants : Variants
	{
		class Variant1 : Variant1
		{
			class Primary : Primary
			{
				weapon      = "LMG_Mk200_F";
				optics      = "optic_MRCO";
				magazines[] = {{"200Rnd_65x39_cased_Box_Tracer", 3}};
			};
			class Secondary
			{
			};
			class Backpack
			{
			};
		};
	};
};
class Grenadier_AAF : Rifleman_AAF
{
	name = "Grenadier";
	picture = "pra3\pra3_ui\kits\kit_img\grenadier_88.paa";
	icon = "pra3\pra3_ui\kits\kit_img\grenadier_small_88.paa";

	class Requirements : RequirementsGrenadier
	{
	};

	class Clothing : Clothing
	{
		vest = "V_PlateCarrierIAGL_dgtl";
	};

	class Variants : Variants
	{
		class Variant1 : Variant1
		{
			class Primary : Primary
			{
				weapon      = "arifle_Mk20_GL_F";
				magazines[] = {{"30Rnd_556x45_Stanag_Tracer_Yellow", 9}, {"1Rnd_HE_Grenade_shell", 8}, {"1Rnd_Smoke_Grenade_shell", 4}};
			};
			class Secondary
			{
			};
			class Backpack
			{
			};

			explosives[] = {};
		};
	};
};
class Marksman_AAF : Rifleman_AAF
{
	name = "Marksman";
	picture = "pra3\pra3_ui\kits\kit_img\sniper_88.paa";
	icon = "pra3\pra3_ui\kits\kit_img\sniper_small_88.paa";

	class Requirements : RequirementsMarksman
	{
	};
	availableAt[] = {SPAWN_MAIN};

	class Clothing : Clothing
	{
	};

	class Variants : Variants
	{
		class Variant1 : Variant1
		{
			class Primary : Primary
			{
				weapon      = "srifle_EBR_F";
				optics      = "optic_Arco";
				magazines[] = {{"20Rnd_762x51_Mag", 9}};
			};
			class Secondary
			{
			};
			class Backpack
			{
			};

			explosives[] = {};
		};
	};
};
