#define TYPE_WEAPON		1
#define TYPE_BACKPACK	2

#define TEAM_US	0
#define TEAM_IN	1

#define public 2

#define LIMIT_NO		0
#define LIMIT_SQUAD		1
#define LIMIT_SL		2

#define SPAWN_MAIN    0
#define SPAWN_FORWARD 1

class PRA3_kits
{
	class Kits
	{
		class Rifleman_US
		{
			scope = public;
			team = TEAM_US;

			name = "Rifleman";
			picture = "pra3\pra3_ui\kits\kit_img\rifleman_88.paa";

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
					items[] = {{"FirstAidKit", 2}};
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
		class SquadLeader_US : Rifleman_US
		{
			name = "Squad Leader";
			picture = "pra3\pra3_ui\kits\kit_img\sqleader_88.paa";

			class Requirements
			{
				type = LIMIT_SL;

				minMembers = 3;
			};

			class Clothing : Clothing
			{
				uniform = "U_B_CombatUniform_mcam_tshirt";
				headgear = "H_HelmetB_paint";
				vest     = "V_PlateCarrier1_rgr";
			};

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
					items[] = {{"FirstAidKit", 3}, {"Rangefinder", 1}};
				};
			};
		};
		class Medic_US : Rifleman_US
		{
			name = "Combat Medic";
			picture = "pra3\pra3_ui\kits\kit_img\medic_88.paa";

			class Requirements
			{
				type = LIMIT_SQUAD;

				perEvery    = 3;
				minMembers  = 3;
				maxPerSquad = 1;
			};

			class Clothing : Clothing
			{
				uniform = "U_B_CombatUniform_mcam_vest";
				vest = "V_BandollierB_rgr";
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
						backpack = "B_AssaultPack_mcamo";
						weapons[] = {{"Medikit", 1}, {"FirstAidKit", 10}};
					};

					explosives[] = {{"HandGrenade", 2}, {"SmokeShell", 5}};
					items[] = {};
				};
			};
		};
		class Machinegunner_US : Rifleman_US
		{
			name = "Automatic Rifleman";
			picture = "pra3\pra3_ui\kits\kit_img\autorifleman_88.paa";

			class Requirements
			{
				type = LIMIT_SQUAD;

				perEvery    = 5;
				minMembers  = 5;
				maxPerSquad = 1;
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
		class Grenadier_US : Rifleman_US
		{
			name = "Grenadier";
			picture = "pra3\pra3_ui\kits\kit_img\grenadier_88.paa";

			class Requirements
			{
				type = LIMIT_SQUAD;

				perEvery    = 5;
				minMembers  = 5;
				maxPerSquad = 1;
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
		class Marksman_US : Rifleman_US
		{
			name = "Marksman";
			picture = "pra3\pra3_ui\kits\kit_img\sniper_88.paa";

			class Requirements
			{
				type = LIMIT_SQUAD;

				perEvery    = 6;
				minMembers  = 6;
				maxPerSquad = 1;
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

		class Rifleman_IN : Rifleman_US
		{
			scope = public;
			team = TEAM_IN;

			name = "Rifleman";
			picture = "pra3\pra3_ui\kits\kit_img\rifleman_88.paa";

			class Clothing
			{
				uniform  = "U_I_CombatUniform";
				headgear = "H_HelmetIA_net";
				goggles  = "";
				vest     = "V_PlateCarrierIA2_dgtl";
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
						backpack    = "B_Carryall_oli";
						weapons[]   = {};
						magazines[] = {{"30Rnd_65x39_caseless_green_mag_Tracer", 12}};
					};

					explosives[] = {{"HandGrenade", 2}, {"SmokeShell", 2}};
					items[] = {{"FirstAidKit", 1}};
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
		class SquadLeader_IN : Rifleman_IN
		{
			name = "Squad Leader";
			picture = "pra3\pra3_ui\kits\kit_img\sqleader_88.paa";

			class Requirements
			{
				type = LIMIT_SL;
			};

			class Clothing : Clothing
			{
				uniform = "U_I_CombatUniform_tshirt";
				headgear = "H_HelmetIA";
				vest     = "V_PlateCarrierIA1_dgtl";
			};

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
					};

					explosives[] = {{"HandGrenade", 2}, {"SmokeShell", 4}, {"SmokeShellRed", 2}};
					items[] = {{"FirstAidKit", 3}, {"Rangefinder", 1}};
				};
			};
		};
		class Medic_IN : Rifleman_IN
		{
			name = "Combat Medic";
			picture = "pra3\pra3_ui\kits\kit_img\medic_88.paa";

			class Requirements
			{
				type = LIMIT_SQUAD;

				perEvery    = 3;
				minMembers  = 3;
				maxPerSquad = 1;
			};

			class Clothing : Clothing
			{
				uniform = "U_I_CombatUniform_shortsleeve";
				vest = "V_BandollierB_oli";
				headgear = "H_HelmetIA_camo";
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
						backpack = "B_AssaultPack_khk";
						weapons[] = {{"Medikit", 1}, {"FirstAidKit", 10}};
					};

					explosives[] = {{"HandGrenade", 2}, {"SmokeShell", 5}};
					items[] = {};
				};
			};
		};

		class Machinegunner_IN : Rifleman_IN
		{
			name = "Automatic Rifleman";
			picture = "pra3\pra3_ui\kits\kit_img\autorifleman_88.paa";

			class Requirements
			{
				type = LIMIT_SQUAD;

				perEvery    = 5;
				minMembers  = 5;
				maxPerSquad = 1;
			};

			class Clothing : Clothing
			{
				uniform = "U_I_CombatUniform_shortsleeve";
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
					};
				};
			};
		};
		class Grenadier_IN : Rifleman_IN
		{
			name = "Grenadier";
			picture = "pra3\pra3_ui\kits\kit_img\grenadier_88.paa";

			class Requirements
			{
				type = LIMIT_SQUAD;

				perEvery    = 5;
				minMembers  = 5;
				maxPerSquad = 1;
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
						weapon      = "arifle_Katiba_GL_F";
						magazines[] = {{"30Rnd_65x39_caseless_green_mag_Tracer", 9}, {"1Rnd_HE_Grenade_shell", 8}, {"1Rnd_Smoke_Grenade_shell", 4}};
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
		class Marksman_IN : Rifleman_IN
		{
			name = "Marksman";
			picture = "pra3\pra3_ui\kits\kit_img\sniper_88.paa";

			class Requirements
			{
				type = LIMIT_SQUAD;

				perEvery    = 6;
				minMembers  = 6;
				maxPerSquad = 1;
			};
			availableAt[] = {SPAWN_MAIN};

			class Clothing : Clothing
			{
				vest = "V_ChestrigF_oli";
				headgear = "H_HelmetIA_camo";
			};

			class Variants : Variants
			{
				class Variant1 : Variant1
				{
					class Primary : Primary
					{
						weapon      = "srifle_EBR_F";
						optics      = "optic_Arco";
						magazines[] = {{"20Rnd_762x51_Mag", 8}};
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
	};
};
