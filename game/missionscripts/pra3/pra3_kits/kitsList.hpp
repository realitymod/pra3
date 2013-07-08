#define TYPE_WEAPON		1
#define TYPE_BACKPACK	2

#define TEAM_US	1

#define public 2

class PRA3_kits
{
	class Kits
	{
		class Rifleman_US
		{
			scope = public;
			team = TEAM_US;

			name = "Rifleman";
			picture = "pra3\pra3_kits\data\kit_img\rifleman_88.paa";

			class Requirements
			{
				perEvery        = 1;
				minPlayersSquad = -1;
				maxPerSquad     = -1;

				returnTime      = -1;
			};
			class Clothing
			{
				uniform  = "U_B_CombatUniform_mcam";
				headgear = "H_HelmetB";
				goggles  = "";
				vest     = "V_PlateCarrier1_rgr";
			};

			class Variants
			{
				class Variant1
				{
					name = "Standard";
					class Pistol
					{
						weapon      = "hgun_P07_F";
						magazines[] = {{"16Rnd_9x21_Mag", 4}};
					};
					class Primary
					{
						weapon      = "SMG_01_F";
						optics      = "optic_Arco";
						rail        = "";
						muzzle      = "";
						magazines[] = {{"30Rnd_65x39_caseless_mag", 11}};
					};
					class Secondary
					{
						type        = TYPE_WEAPON;
						weapon      = "launch_B_Titan_short_F";
						magazines[] = {{"Titan_AT", 1}, {"Titan_AP", 1}};
					};

					explosives[] = {{"HandGrenade", 4}, {"SmokeShell", 2}};
					items[] = {{"FirstAidKit", 2}};
				};
				class Variant2 : Variant1
				{
					name = "Standard CQB";
					class Primary : Primary
					{
						optics = "optic_Aco";
					};
				};
				class Variant3 : Variant2
				{
					name = "Support";
					class Secondary
					{
						type        = TYPE_BACKPACK;
						backpack    = "B_Kitbag_mcamo_AA";
						weapons[]   = {};
						magazines[] = {{"30Rnd_65x39_caseless_mag", 10}};
					};
				};
			};
		};
		class SquadLeader_US : Rifleman_US
		{
			name = "Squad Leader";
		};
		class Medic_US : Rifleman_US
		{
			name = "Combat Medic";
			picture = "pra3\pra3_kits\data\kit_img\medic_88.paa";

			class Variants
			{
				class Variant1
				{
					class Primary
					{
						weapon      = "arifle_MX_F";
						optics      = "";
						rail        = "";
						muzzle      = "";
						magazines[] = {{"30Rnd_45ACP_Mag_SMG_01", 7}};
					};

					explosives[] = {{"SmokeShell", 6}, {"SmokeShellBlue", 2}};
					items[] = {{"FirstAidKit", 10}, {"MedicKit", 1}};
				};
			};
		};
		class Machinegunner_US : Rifleman_US
		{
			name = "Automatic Rifleman";
		};
		class Grenadier_US : Rifleman_US
		{
			name = "Grenadier";

			class Pistol
			{
			};
			class Primary
			{
				class M16_M203
				{
					weapon = "M16A4_GL";
					magazines[] = {{"30Rnd_556x45_stanag", 11}, {"1Rnd_HE_M203", 10}, {"1Rnd_Smoke_M203", 3}};
				};
			};
			class Secondary
			{
			};
		};
		class LAT_US : Rifleman_US
		{
			name = "Light Anti-Tank";
		};
		class HAT_US : Rifleman_US
		{
			name = "Heavy Anti-Tank";
		};
		class AA_US : Rifleman_US
		{
			name = "Anti-Air";
		};
		class Marksman_US : Rifleman_US
		{
			name = "Marksman";
		};
		class Engineer_US : Rifleman_US
		{
			name = "Combat Engineer";
		};
		class Sniper_US : Rifleman_US
		{
			name = "Sniper";
		};
		class Spotter_US : Rifleman_US
		{
			name = "Spotter";
		};
	};
};
