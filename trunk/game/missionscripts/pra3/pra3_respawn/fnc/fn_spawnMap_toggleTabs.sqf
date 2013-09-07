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

closeDialog 0;

switch _tab do
{
	case 0:
	{
		true call PRA3_fnc_squadDlg_open;
	};
	case 1:
	{
		true call PRA3_fnc_kitDlg_open;
	};
};
