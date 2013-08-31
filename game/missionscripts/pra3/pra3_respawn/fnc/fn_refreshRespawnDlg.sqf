#include "scriptDefines.sqh"

#define ctrl(idc) (uiNamespace getVariable "PRA3_dlg_spawnScreen" displayCtrl idc)

if !(isNull (uiNamespace getVariable "PRA3_dlg_spawnScreen")) then
{
	PRA3_selectedSpawn = "";

	// Hide all spawn markers
	{
		(_x select 0) setMarkerTypeLocal "EMPTY";
	} forEach PRA3_AAS_respawns;
	
	var(_prev) = ctrl(10) lbData lbCurSel ctrl(10);

	lbClear ctrl(10);

	{
		var(_idx) = ctrl(10) lbAdd (_x select 1);
		ctrl(10) lbSetData [_idx, _x select 0];
		ctrl(10) lbSetValue [_idx, player distance markerPos (_x select 0)];
		
		// Show the spawn
		(_x select 0) setMarkerTypeLocal "mil_start";
	} forEach (player call PRA3_fnc_getAvailableSpawns);

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
};
