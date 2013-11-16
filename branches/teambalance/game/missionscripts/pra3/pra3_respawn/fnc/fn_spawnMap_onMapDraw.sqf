#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

{
	var(_textureAnimPhase) = 0;
	var(_size) = 25;
	if (!isNil "PRA3_selectedSpawn" && {[_x, PRA3_selectedSpawn] call BIS_fnc_areEqual}) then
	{
		_textureAnimPhase = abs(6 - floor (diag_tickTime * 16) % 12);
		_size = _size + 5;
	};
	if (_x call PRA3_fnc_getSpawnPosition distance PRA3_spawnMapMousePos < 200 * ctrlMapScale ctrl(IDC_KITDLG_SPAWNMAP_MAP)) then
	{
		_size = _size + 5;
	};
	var(_texture) = format [
		"\A3\Ui_f\data\Map\GroupIcons\badge_rotate_%1_gs.paa",
		_textureAnimPhase
	];
	
	ctrl(IDC_KITDLG_SPAWNMAP_MAP) drawIcon [
		_texture,
		[1,1,1,1],
		_x call PRA3_fnc_getSpawnPosition,
		_size,
		_size,
		0,
		" " + (_x call PRA3_fnc_getSpawnName),
		2,
		0.08,
		"PuristaBold"
	];
} forEach (player call PRA3_fnc_getAvailableSpawns);
