class Header
{
	gameType = SC;
	minPlayers = 1;
	maxPlayers = __maxPlayers;
	playerCountMultipleOf = 2;
};

author = $STR_PRA3_MISSION_AUTHOR;

/*Adds to screen loading*/
onLoadName 		= __name;
briefingName 	= __name2;
overviewText 	= __description;

loadScreen 		= "pra3\PRloadingLogo.jpg";

disabledAI = 1;

respawn            = 3;
respawnDelay       = 10;
respawnDialog      = 0;
respawnTemplates[] = {"PRA3_Select"};
respawnOnStart     = 1;

class CfgRespawnTemplates
{
	class PRA3_Select
	{
		displayName = "PRA3_Select";
		onPlayerKilled = "PRA3_fnc_onDeath";
		onPlayerRespawn = "PRA3_fnc_onDeath";
	};
};

#include "pra3_ui\ui.hpp"

class CfgDebriefing
{
	class End1
	{
		subtitle = "NATO Forces are victorious";
		backgroundPicture = "";
		picture = "b_inf";
		pictureColor[] = {0.0,0.3,0.6,1};
	};
	class End2
	{
		subtitle = "CSAT Forces are victorious";
		backgroundPicture = "";
		picture = "b_inf";
		pictureColor[] = {0.5,0.0,0.0,1};
	};
	class End3
	{
		subtitle = "AAF Forces are victorious";
		backgroundPicture = "";
		picture = "b_inf";
		pictureColor[] = {0.5,0.0,0.0,1};
	};
	class Draw
	{
		subtitle = "The battle was a stalemate";
		backgroundPicture = "";
		picture = "b_inf";
		pictureColor[] = {0.7,0.7,0.7,1};
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
