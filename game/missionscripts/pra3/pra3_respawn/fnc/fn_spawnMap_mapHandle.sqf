#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

var(_param) = _this select 1;
switch (_this select 0) do
{
	case 0: // Mouse moving on map
	{
		PRA3_spawnMapMousePos = _param select 0 ctrlMapScreenToWorld [_param select 1, _param select 2];
		call PRA3_fnc_kitDlg_hideKitDetails; // Collapse kit details
	};
	case 1: // Mouse click on map
	{
		if (_param select 1 == 0) then // Left mouse
		{
			PRA3_selectedSpawn = "";
			var(_pos) = _param select 0 ctrlMapScreenToWorld [_param select 2, _param select 3];
			{
				if (_pos distance markerPos (_x select 0) < 200 * ctrlMapScale (_param select 0)) exitWith
				{
					PRA3_selectedSpawn = _x select 0;
					call PRA3_fnc_spawnMap_populateSpawnLocations;
					ctrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbSetCurSel _forEachIndex;
				};
			} forEach (player call PRA3_fnc_getAvailableSpawns);

			if (PRA3_selectedSpawn == "") then
			{
				call PRA3_fnc_spawnMap_selectNoSpawn;
			};

			"" call PRA3_fnc_kitDlg_updateAvailability;
		};
	};
	case 2: // Spawn LB selection
	{
		var(_idx) = _param select 1;
		if (isNil "PRA3_selectedSpawn" || {PRA3_selectedSpawn == ""}) then
		{
			call PRA3_fnc_spawnMap_populateSpawnLocations;
			_idx = 0;
		};

		PRA3_selectedSpawn = player call PRA3_fnc_getAvailableSpawns select _idx select 0;
		ctrl(IDC_KITDLG_SPAWNMAP_MAP) ctrlMapAnimAdd [
			0,
			ctrlMapScale ctrl(IDC_KITDLG_SPAWNMAP_MAP),
			markerPos PRA3_selectedSpawn
		];

		ctrlMapAnimCommit ctrl(IDC_KITDLG_SPAWNMAP_MAP);

		"" call PRA3_fnc_kitDlg_updateAvailability;
	};
};
