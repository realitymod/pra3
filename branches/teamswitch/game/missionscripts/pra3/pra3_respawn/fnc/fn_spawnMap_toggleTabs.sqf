#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

var(_tab) = _this;

var(_pos) = ctrlPosition ctrl(IDC_KITDLG_SPAWNMAP_MAP);

PRA3_spawnMapPosition = [
	// We can calculate the map center by using centerX = mapW/2 + mapX, repeat the same for Y
	ctrl(IDC_KITDLG_SPAWNMAP_MAP) ctrlMapScreenToWorld [
		(_pos select 2) * 0.5 + (_pos select 0),
		(_pos select 3) * 0.5 + (_pos select 1)
	],
	ctrlMapScale ctrl(IDC_KITDLG_SPAWNMAP_MAP)
];

// For some reason this doesn't actually cause the dialog to unload so we have to
// clear the variables manually later on...
closeDialog 0;

switch _tab do
{
	case 0:
	{
		uiNamespace setVariable ["Rsc_PRA3_kits_kitDlgRespawn", displayNull];
		true call PRA3_fnc_squadDlg_open;
	};
	case 1:
	{
		uiNamespace setVariable ["Rsc_PRA3_squadSys_manageDlgRespawn", displayNull];
		true call PRA3_fnc_kitDlg_open;
	};
};
