#include "scriptDefines.sqh"
#include "defines.sqh"
diag_log _this;
var(_param) = _this select 1;
switch (_this select 0) do
{
	case 0:
	{
		PRA3_spawnMapMousePos = _param select 0 ctrlMapScreenToWorld [_param select 1, _param select 2];
		call PRA3_fnc_kitDlg_hideKitDetails; // Collapse kit details
	};
	case 1:
	{
		if (_param select 1 == 0) then // Left mouse
		{
			PRA3_AAS_selectedSpawn = "";
			var(_pos) = _param select 0 ctrlMapScreenToWorld [_param select 2, _param select 3];
			{
				if (_pos distance markerPos (_x select 0) < 200 * ctrlMapScale (_param select 0)) exitWith
				{
					PRA3_AAS_selectedSpawn = _x select 0;
					ctrlParent (_param select 0) displayCtrl IDC_KITDLG_SPAWNMAP_SELECTION
						lbSetCurSel _forEachIndex;
				};
			} forEach (player call PRA3_fnc_AAS_getAvailableSpawns);
			
			if (PRA3_AAS_selectedSpawn == "") then
			{
				ctrlParent (_param select 0) displayCtrl IDC_KITDLG_SPAWNMAP_SELECTION
					lbSetCurSel -1;
			};
		};
	};
};
