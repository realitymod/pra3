#ifdef MISSION_TYPE_AAS_INF
	#define MISSION_DESCRIPTION   $STR_PRA3_MISSION_DESC_AAS_INF
#endif // MISSION_TYPE_AAS

class Header
{
	gameType              = SC;
	minPlayers            = 1;
	maxPlayers            = 64;
	playerCountMultipleOf = 2;
};

author = $STR_PRA3_MISSION_AUTHOR;

class PRA3_Credits
{
	class Mission
	{
		displayName = "Mission";
		value       = MISSION_AUTHOR;
	};
	class Gameplay
	{
		displayName = "Gameplay";
		value       = "Project Reality: ARMA 3 Team (www.realitymod.com)";
	};
};

/*Adds to screen loading*/
onLoadName   = MISSION_NAME;
briefingName = MISSION_NAME_BRIEFING;
overviewText = MISSION_DESCRIPTION;

loadScreen   = "pra3\PRloadingLogo.jpg";

disabledAI   = 1;

respawn            = 3;
respawnDelay       = 0;
respawnButton      = 0;
respawnDialog      = 0;
respawnOnStart     = 0;
respawnTemplates[] = {"PRA3_Select"};

corpseManagerMode    = 1; // Delete all corpses
corpseLimit          = 32;
corpseRemovalMinTime = 60;
corpseRemovalMaxTime = 300;

class CfgRespawnTemplates
{
	class PRA3_Select
	{
		displayName     = "PRA3_Select";
		onPlayerKilled  = "PRA3_fnc_onDeath";
		onPlayerRespawn = "PRA3_fnc_onDeath";
	};
};

#include "pra3_ui\ui.hpp"

class CfgDebriefing
{
	class End_NATO
	{
		subtitle          = "NATO Forces are victorious";
		backgroundPicture = "";
		picture           = "b_inf";
		pictureColor[]    =
		{
			"profileNamespace getVariable ['Map_BLUFOR_R',0.0]",
			"profileNamespace getVariable ['Map_BLUFOR_G',0.3]",
			"profileNamespace getVariable ['Map_BLUFOR_B',0.6]",
			"profileNamespace getVariable ['Map_BLUFOR_A',1.0]"
		};
	};
	class End_CSAT : End_NATO
	{
		subtitle          = "CSAT Forces are victorious";
		picture           = "o_inf";
		pictureColor[]    =
		{
			"profileNamespace getVariable ['Map_OPFOR_R',0.5]",
			"profileNamespace getVariable ['Map_OPFOR_G',0.0]",
			"profileNamespace getVariable ['Map_OPFOR_B',0.0]",
			"profileNamespace getVariable ['Map_OPFOR_A',1.0]"
		};
	};
	class End_AAF : End_NATO
	{
		subtitle          = "AAF Forces are victorious";
		picture           = "n_inf";
		pictureColor[]    =
		{
			"profileNamespace getVariable ['Map_Independent_R',0.0]",
			"profileNamespace getVariable ['Map_Independent_G',0.5]",
			"profileNamespace getVariable ['Map_Independent_B',0.0]",
			"profileNamespace getVariable ['Map_Independent_A',1.0]"
		};
	};
	class Draw : End_NATO
	{
		subtitle          = "The battle was a stalemate";
		picture           = "n_inf";
		pictureColor[]    = {0.7,0.7,0.7,1};
	};
};

#ifdef PRA3_DEBUG
allowFunctionsRecompile = 1;
enableDebugConsole      = 2; // Enable debug console for everyone
#endif // PRA3_DEBUG

class CfgFunctions
{
	class PRA3
	{
		tag = "PRA3";

		#include "functions.hpp"
	};
};

#include "pra3_kits\kitsList.hpp"


#include "version.hpp"

class CfgPatches
{
	class PRA3_core
	{
		units[]          = {};
		weapons[]        = {};
		requiredAddons[] = {};
		requiredVersion  = 1.07;
		version[]        =
		{
			PRA3_VERSION_MAJOR,
			PRA3_VERSION_MINOR,
			PRA3_VERSION_RELEASE
		};
	};
};

missionVersion[] =
{
	MISSION_VERSION_MAJOR,
	MISSION_VERSION_MINOR,
	MISSION_VERSION_RELEASE
};
