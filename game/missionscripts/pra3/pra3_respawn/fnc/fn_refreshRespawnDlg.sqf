#include "scriptDefines.sqh"

#define ctrl(idc) (uiNamespace getVariable "PRA3_dlg_spawnScreen" displayCtrl idc)

PRA3_AAS_selectedSpawn = "";

var(_prev) = ctrl(10) lbData lbCurSel ctrl(10);

lbClear ctrl(10);

{
	var(_idx) = ctrl(10) lbAdd (_x select 1);
	ctrl(10) lbSetData [_idx, _x select 0];
	ctrl(10) lbSetValue [_idx, player distance markerPos (_x select 0)];
} forEach (player call PRA3_fnc_AAS_getAvailableRespawns);

lbSortByValue ctrl(10);

if (_prev == "") then
{
	ctrl(10) lbSetCurSel -1;
}
else
{
	for "_i" from 0 to (lbSize ctrl(10))-1 do
	{
		if (ctrl(10) lbData _i == _prev) exitWith
		{
			ctrl(10) lbSetCurSel _i;
		};
	};
};
