class Header
{
	gameType = Team;
	minPlayers = 1;
	maxPlayers = __maxPlayers;
	playerCountMultipleOf = 2;
};

author = "Project Reality - www.realitymod.com";

disabledAI = 1;

respawn = 3;
respawnDelay = 10;
respawnDialog = 0;
respawnTemplates[] = {"PRA3_Select"};
respawnOnStart = 1;

class CfgRespawnTemplates
{
	class PRA3_Select
	{
		displayName = "PRA3_Select";
		onPlayerKilled = "PRA3_fnc_onDeath";
		onPlayerRespawn = "PRA3_fnc_onDeath";
	};
};

#include "uiBases.hpp"

class RscTitles
{
	#include "pra3_aas\captureIndicator.hpp"
	#include "pra3_respawn\deadScreen.hpp"
};

#include "pra3_respawn\respawnDialog.hpp"
#include "pra3_squadsys\dlg\management.hpp"
#include "pra3_kits\kitDlg.hpp"

class CfgDebriefing
{
	class End1
	{
		subtitle = "NATO forces are victorious";
		backgroundPicture = "";
		picture = "b_inf";
		pictureColor[] = {0.0,0.3,0.6,1};
	};
	class End2
	{
		subtitle = "Iranian Army are victorious";
		backgroundPicture = "";
		picture = "b_inf";
		pictureColor[] = {0.5,0.0,0.0,1};
	};
	class Draw
	{
		subtitle = "Tha battle was a stalemate";
		backgroundPicture = "";
		picture = "b_inf";
		pictureColor[] = {0.7,0.7,0.7,1};
	};
};

#ifdef PRA3_DEBUG
allowFunctionsRecompile = 1;
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
