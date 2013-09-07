/**
 *	Returns the team's flag.
 *
 *		(in)  <STRING> Team
 *		(out) <STRING> Path to team's flag
 */

#include "scriptDefines.sqh"

var(_team) = _this;

getText(missionConfigFile >> "PRA3_teams" >> _team >> "flag");
