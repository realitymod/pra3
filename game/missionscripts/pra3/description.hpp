class Header
{
	gameType              = SC;
	minPlayers            = 1;
	maxPlayers            = __maxPlayers;
	playerCountMultipleOf = 2;
};

author = $STR_PRA3_MISSION_AUTHOR;

/*Adds to screen loading*/
onLoadName   = __name;
briefingName = __name2;
overviewText = __description;

loadScreen   = "pra3\PRloadingLogo.jpg";

disabledAI   = 1;

respawn            = 3;
respawnDelay       = 10;
respawnDialog      = 0;
respawnTemplates[] = {"PRA3_Select"};
respawnOnStart     = 1;

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
