#define public 2

#define TYPE_WEAPON		1
#define TYPE_BACKPACK	2

#define SIDE_EAST		0
#define SIDE_WEST		1
#define SIDE_RESISTANCE	2
#define SIDE_CIVILIAN	3

#define LIMIT_NO		0
#define LIMIT_SQUAD		1
#define LIMIT_SL		2

#define SPAWN_MAIN		0
#define SPAWN_FORWARD	1

class PRA3_teams
{
	class NATO
	{
		side       = SIDE_WEST;
		name       = "NATO";
		flag       = "\A3\Data_F\Flags\Flag_nato_CO.paa";
		rallyPoint = "Land_TentDome_F";
	};
	class CSAT
	{
		side       = SIDE_EAST;
		name       = "CSAT";
		flag       = "\A3\Data_F\Flags\Flag_CSAT_CO.paa";
		rallyPoint = "Land_TentA_F";
	};
	class AAF
	{
		side       = SIDE_RESISTANCE;
		name       = "AAF";
		flag       = "\A3\Data_F\Flags\Flag_AAF_CO.paa";
		rallyPoint = "Land_TentA_F";
	};
};

class PRA3_kits
{
	class RequirementsSL
	{
		type       = LIMIT_SL;
		minMembers = 3;
	};
	class RequirementsMedic
	{
		type        = LIMIT_SQUAD;
		perEvery    = 3;
		minMembers  = 3;
		maxPerSquad = 1;
	};
	class RequirementsMG
	{
		type        = LIMIT_SQUAD;
		perEvery    = 5;
		minMembers  = 5;
		maxPerSquad = 1;
	};
	class RequirementsGrenadier
	{
		type        = LIMIT_SQUAD;
		perEvery    = 5;
		minMembers  = 5;
		maxPerSquad = 1;
	};
	class RequirementsMarksman
	{
		type        = LIMIT_SQUAD;
		perEvery    = 6;
		minMembers  = 6;
		maxPerSquad = 1;
	};

	class Kits
	{
		#include "kits_NATO.hpp"
		#include "kits_CSAT.hpp"
		#include "kits_AAF.hpp"
	};
};
