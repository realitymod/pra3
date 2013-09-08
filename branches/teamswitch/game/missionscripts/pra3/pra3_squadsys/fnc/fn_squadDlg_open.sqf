#include "defines.sqh"
#include "scriptDefines.sqh"

var(_showSpawnMap) = _this;
if (dialog) then {closedialog 0; player sidechat "dialog closed"};

if _showSpawnMap then
{
	PRA3_respawn_lastOpenTab = "squads";
	createDialog "Rsc_PRA3_squadSys_manageDlgRespawn";
}
else
{
	createDialog "Rsc_PRA3_squadSys_manageDlg";
};
