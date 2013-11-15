class Rifleman_NATO
{
	scope = public;
	team  = NATO;

	name    = "Rifleman";
	picture = "pra3\pra3_ui\kits\kit_img\rifleman_88.paa";
	icon    = "pra3\pra3_ui\kits\kit_img\rifleman_small_88.paa";

	class Requirements
	{
		type = LIMIT_NO;
	};
	availableAt[] = {SPAWN_MAIN, SPAWN_FORWARD};

	class Clothing
	{
		uniform  = "U_B_CombatUniform_mcam";
		headgear = "H_HelmetB";
		goggles  = "";
		vest     = "V_PlateCarrier2_rgr";
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
				weapon      = "arifle_MX_F";
				optics      = "optic_Holosight";
				rail        = "";
				muzzle      = "";
				magazines[] = {{"30Rnd_65x39_caseless_mag_Tracer", 9}};
			};
			class Secondary
			{
			};
			class Backpack
			{
				backpack    = "B_Kitbag_mcamo";
				weapons[]   = {};
				magazines[] = {{"30Rnd_65x39_caseless_mag_Tracer", 12}};
			};

			explosives[] = {{"HandGrenade", 2}, {"SmokeShell", 2}};
			items[]      = {{"FirstAidKit", 2}};
		};
		class Variant2 : Variant1
		{
			name = "AR Support";

			class Backpack
			{
				backpack    = "B_Bergen_mcamo";
				weapons[]   = {};
				magazines[] = {{"100Rnd_65x39_caseless_mag_Tracer", 10}};
			};
		};
		class Variant3 : Variant1
		{
			name = "Grenadier Support";

			class Backpack
			{
				backpack    = "B_TacticalPack_mcamo";
				weapons[]   = {};
				magazines[] = {{"1Rnd_HE_Grenade_shell", 20}, {"1Rnd_Smoke_Grenade_shell", 10}};
			};
		};
	};
};
class SquadLeader_NATO : Rifleman_NATO
{
	name    = "Squad Leader";
	picture = "pra3\pra3_ui\kits\kit_img\sqleader_88.paa";
	icon    = "pra3\pra3_ui\kits\kit_img\sqleader_small_88.paa";

	class Requirements : RequirementsSL
	{
	};

	class Clothing : Clothing
	{
		uniform  = "U_B_CombatUniform_mcam_tshirt";
		headgear = "H_HelmetB_paint";
		vest     = "V_PlateCarrier1_rgr";
	};

	abilities[] = {"rallyPoint"};

	class Variants : Variants
	{
		class Variant1 : Variant1
		{
			name = "Standard";
			class Pistol
			{
				weapon      = "hgun_P07_F";
				magazines[] = {{"16Rnd_9x21_Mag", 3}};
			};
			class Primary : Primary
			{
				optics      = "optic_Hamr";
			};
			class Secondary
			{
			};
			class Backpack
			{
			};

			explosives[] = {{"HandGrenade", 2}, {"SmokeShell", 4}, {"SmokeShellBlue", 2}};
			items[]      = {{"FirstAidKit", 3}, {"Rangefinder", 1}};
		};
	};
};
class Medic_NATO : Rifleman_NATO
{
	name = "Combat Medic";
	picture = "pra3\pra3_ui\kits\kit_img\medic_88.paa";
	icon = "pra3\pra3_ui\kits\kit_img\medic_small_88.paa";

	class Requirements : RequirementsMedic
	{
	};

	class Clothing : Clothing
	{
		uniform  = "U_B_CombatUniform_mcam_vest";
		vest     = "V_BandollierB_rgr";
		headgear = "H_HelmetB_light";
	};

	class Variants : Variants
	{
		class Variant1 : Variant1
		{
			class Primary : Primary
			{
				weapon      = "arifle_MXC_F";
			};
			class Secondary
			{
			};
			class Backpack
			{
				backpack  = "B_AssaultPack_mcamo";
				weapons[] = {{"Medikit", 1}, {"FirstAidKit", 10}};
			};

			explosives[] = {{"HandGrenade", 2}, {"SmokeShell", 5}};
			items[]      = {};
		};
	};
};
class Machinegunner_NATO : Rifleman_NATO
{
	name = "Automatic Rifleman";
	picture = "pra3\pra3_ui\kits\kit_img\autorifleman_88.paa";
	icon = "pra3\pra3_ui\kits\kit_img\autorifleman_small_88.paa";

	class Requirements : RequirementsMG
	{
	};

	class Clothing : Clothing
	{
		uniform = "U_B_CombatUniform_mcam_vest";
	};

	class Variants : Variants
	{
		class Variant1 : Variant1
		{
			class Primary : Primary
			{
				weapon      = "arifle_MX_SW_F";
				magazines[] = {{"100Rnd_65x39_caseless_mag_Tracer", 6}};
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
class Grenadier_NATO : Rifleman_NATO
{
	name = "Grenadier";
	picture = "pra3\pra3_ui\kits\kit_img\grenadier_88.paa";
	icon = "pra3\pra3_ui\kits\kit_img\grenadier_small_88.paa";

	class Requirements : RequirementsGrenadier
	{
	};

	class Clothing : Clothing
	{
		vest = "V_PlateCarrierGL_rgr";
	};

	class Variants : Variants
	{
		class Variant1 : Variant1
		{
			class Primary : Primary
			{
				weapon      = "arifle_MX_GL_F";
				magazines[] = {{"30Rnd_65x39_caseless_mag_Tracer", 9}, {"1Rnd_HE_Grenade_shell", 8}, {"1Rnd_Smoke_Grenade_shell", 4}};
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
class Marksman_NATO : Rifleman_NATO
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
		vest = "V_Chestrig_khk";
		headgear = "H_HelmetB_light";
	};

	class Variants : Variants
	{
		class Variant1 : Variant1
		{
			class Primary : Primary
			{
				weapon      = "arifle_MXM_F";
				optics      = "optic_Hamr";
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
