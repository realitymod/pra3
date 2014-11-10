class Rifleman_CSAT : Rifleman_NATO
{
	scope = public;
	team = CSAT;

	class Clothing
	{
		uniform  = "U_O_CombatUniform_ocamo";
		headgear = "H_HelmetO_ocamo";
		vest     = "V_HarnessO_brn";
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
				weapon      = "arifle_Katiba_F";
				optics      = "optic_ACO_grn";
				rail        = "";
				muzzle      = "";
				magazines[] = {{"30Rnd_65x39_caseless_green_mag_Tracer", 9}};
			};
			class Secondary
			{
			};
			class Backpack
			{
				backpack    = "B_FieldPack_cbr_LAT";
				weapons[]   = {};
				magazines[] = {{"30Rnd_65x39_caseless_green_mag_Tracer", 12}, {"10Rnd_762x51_Mag", 9}};
			};

			explosives[] = {{"HandGrenade", 2}, {"SmokeShell", 2}};
			items[]      = {COMMON_ITEMS, {"FirstAidKit", 1}};
		};
		class Variant2 : Variant1
		{
			name = "AR Support";

			class Backpack : Backpack
			{
				backpack    = "B_FieldPack_ocamo_AAR";
				magazines[] = {{"200Rnd_65x39_cased_Box_Tracer", 5}};
			};
		};
		class Variant3 : Variant1
		{
			name = "Grenadier Support";

			class Backpack : Backpack
			{
				backpack    = "B_FieldPack_ocamo_AAR";
				magazines[] = {{"1Rnd_HE_Grenade_shell", 20}, {"1Rnd_Smoke_Grenade_shell", 10}};
			};
		};
	};
};
class SquadLeader_CSAT : Rifleman_CSAT
{
	name = "Squad Leader";
	picture = "pra3\pra3_ui\kits\kit_img\sqleader_88.paa";
	icon = "pra3\pra3_ui\kits\kit_img\sqleader_small_88.paa";

	class Requirements : RequirementsSL
	{
	};

	class Clothing : Clothing
	{
		uniform  = "U_O_OfficerUniform_ocamo";
		headgear = "H_Beret_ocamo";
		vest     = "V_BandollierB_khk";
	};

	abilities[] = {"rallyPoint"};

	class Variants : Variants
	{
		class Variant1 : Variant1
		{
			name = "Standard";
			class Pistol
			{
				weapon      = "hgun_Rook40_F";
				magazines[] = {{"16Rnd_9x21_Mag", 3}};
			};
			class Primary : Primary
			{
				optics      = "optic_Arco";
			};
			class Secondary
			{
			};
			class Backpack
			{
				backpack    = "B_FieldPack_ocamo_AAR";
			};

			explosives[] = {{"HandGrenade", 2}, {"SmokeShell", 4}, {"SmokeShellRed", 2}};
			items[]      = {COMMON_ITEMS, {"FirstAidKit", 3}, {"Rangefinder", 1}, {"ItemGPS", 1}};
		};
	};
};
class Medic_CSAT : Rifleman_CSAT
{
	name = "Combat Medic";
	picture = "pra3\pra3_ui\kits\kit_img\medic_88.paa";
	icon = "pra3\pra3_ui\kits\kit_img\medic_small_88.paa";

	class Requirements : RequirementsMedic
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
				weapon      = "arifle_Katiba_C_F";
			};
			class Secondary
			{
			};
			class Backpack
			{
				backpack = "B_FieldPack_ocamo_AAR";
				weapons[] = {{"Medikit", 1}, {"FirstAidKit", 10}};
			};

			explosives[] = {{"HandGrenade", 2}, {"SmokeShell", 5}};
			items[]      = {COMMON_ITEMS};
		};
	};
};
class Machinegunner_CSAT : Rifleman_CSAT
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
				magazines[] = {{"200Rnd_65x39_cased_Box_Tracer", 3}};
			};
			class Secondary
			{
			};
			class Backpack
			{
				backpack    = "B_FieldPack_cbr_LAT";
			};
		};
	};
};
class Grenadier_CSAT : Rifleman_CSAT
{
	name    = "Grenadier";
	picture = "pra3\pra3_ui\kits\kit_img\grenadier_88.paa";
	icon    = "pra3\pra3_ui\kits\kit_img\grenadier_small_88.paa";

	class Requirements : RequirementsGrenadier
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
				weapon      = "arifle_Katiba_GL_F";
				magazines[] = {{"30Rnd_65x39_caseless_green_mag_Tracer", 9}, {"1Rnd_HE_Grenade_shell", 8}, {"1Rnd_Smoke_Grenade_shell", 4}};
			};
			class Secondary
			{
			};
			class Backpack
			{
				backpack    = "B_FieldPack_cbr_LAT";
			};

			explosives[] = {};
		};
	};
};
class Marksman_CSAT : Rifleman_CSAT
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
		vest     = "V_BandollierB_khk";
	};

	class Variants : Variants
	{
		class Variant1 : Variant1
		{
			class Primary : Primary
			{
				weapon      = "srifle_DMR_01_DMS_F";
				optics      = "optic_Arco";
				magazines[] = {{"10Rnd_762x51_Mag", 9}};
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
