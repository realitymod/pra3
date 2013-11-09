/**
 *	Returns the rally point model for the given team.
 *
 *		(in)  <STRING> Team
 *		(out) <STRING> Class name of the rally point
 */

#include "scriptDefines.sqh"

var(_team) = _this;

getText(missionConfigFile >> "PRA3_teams" >> _team >> "rallyPoint")
