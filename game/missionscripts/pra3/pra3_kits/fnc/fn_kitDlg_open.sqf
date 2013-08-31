#include "scriptDefines.sqh"

var(_showSpawnMap) = _this;

if _showSpawnMap then
{
	createDialog "Rsc_PRA3_kits_kitDlgRespawn";
}
else
{
	createDialog "Rsc_PRA3_kits_kitDlg";
};
