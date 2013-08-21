#include "scriptDefines.sqh"

uiNamespace setVariable ["PRA3_dlg_spawnScreen", _this];

onMapSingleClick "[_pos, 'onMapSingleClick'] call PRA3_fnc_respawnDlgAction";

call PRA3_fnc_refreshRespawnDlg;

// Animate the selected spawn marker
0 spawn
{
	while {!isNull (uiNamespace getVariable "PRA3_dlg_spawnScreen")} do
	{
		"PRA3_selectedSpawn" setMarkerDirLocal ((markerDir "PRA3_selectedSpawn" + 1) % 360);
		sleep 0.02;
	};
};
