#include "scriptDefines.sqh"
#include "defines.sqh"

{
	var(_textureAnimPhase) = abs(6 - floor (diag_tickTime * 16) % 12);
	var(_texture) = format ["\A3\Ui_f\data\Map\GroupIcons\badge_rotate_%1_gs.paa", _textureAnimPhase];

	__getCtrl(201) drawIcon [
		_texture,
		[1,1,1,1],
		markerPos (_x select 0),
		30,
		30,
		0,
		" " + (_x select 1),
		2,
		0.08,
		"PuristaBold"
	];
} forEach (player call PRA3_fnc_AAS_getAvailableSpawns);
