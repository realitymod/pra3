#include "defines.sqh"
#include "scriptDefines.sqh"

var(_showSpawnMap) = _this;

if _showSpawnMap then
{
	PRA3_respawn_lastOpenTab = "squads";
	createDialog "Rsc_PRA3_squadSys_manageDlgRespawn";
}
else
{
	createDialog "Rsc_PRA3_squadSys_manageDlg";
};
