/**
 *	Returns the team's name.
 *
 *		(in)  <STRING> Team
 *		(out) <STRING> Team's display name
 */

#include "scriptDefines.sqh"

var(_team) = _this;

getText(missionConfigFile >> "PRA3_teams" >> _team >> "name");
