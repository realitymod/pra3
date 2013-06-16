#include "scriptDefines.sqh"

#define ctrl(idc) (uiNamespace getVariable "PRA3_dlg_spawnScreen" displayCtrl idc)

lbClear ctrl(10);

{
	var(_idx) = ctrl(10) lbAdd (_x select 1);
	ctrl(10) lbSetData [_idx, _x select 0];
	ctrl(10) lbSetValue [_idx, player distance markerPos (_x select 0)];
} forEach (player call PRA3_fnc_AAS_getAvailableRespawns);

lbSortByValue ctrl(10);
