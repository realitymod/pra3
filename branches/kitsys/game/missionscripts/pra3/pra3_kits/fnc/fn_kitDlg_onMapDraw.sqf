#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

{
	var(_textureAnimPhase) = 0;
	var(_size) = 25;
	if (!isNil "PRA3_AAS_selectedSpawn" && {_x select 0 == PRA3_AAS_selectedSpawn}) then
	{
		_textureAnimPhase = abs(6 - floor (diag_tickTime * 16) % 12);
		_size = _size + 5;
	};
	if (markerPos (_x select 0) distance PRA3_spawnMapMousePos < 200 * ctrlMapScale __getCtrl(IDC_KITDLG_SPAWNMAP_MAP)) then
	{
		_size = _size + 5;
	};
	var(_texture) = format [
		"\A3\Ui_f\data\Map\GroupIcons\badge_rotate_%1_gs.paa",
		_textureAnimPhase
	];
	
	__getCtrl(IDC_KITDLG_SPAWNMAP_MAP) drawIcon [
		_texture,
		[1,1,1,1],
		markerPos (_x select 0),
		_size,
		_size,
		0,
		" " + (_x select 1),
		2,
		0.08,
		"PuristaBold"
	];
} forEach (player call PRA3_fnc_AAS_getAvailableSpawns);
