#include "defines.sqh"
#include "scriptDefines.sqh"

var(_collapse) = _this;

PRAA_squadSys_collapsedSquads set [9, _collapse];

var(_playerIsSL) = ((player call PRA3_fnc_unitGetSquad)
	call PRA3_fnc_squadGetLeader) == (player call PRA3_fnc_getPlayerUID);

var(_h) = (
	if (_collapse) then {
		getNumber(__cfgPathItemHeaderBackground(Unassigned) >> "h")
	} else {
		getNumber(__cfgPathItem(Unassigned) >> (if (_playerIsSL) then {"h"} else {"hNoButton"}))
	}
);

// Set button image
__ctrl(990000 + 7001)
	ctrlSetText (if (_collapse) then {__pic_uncollapse} else {__pic_collapse});

// Resize box
__ctrl(990000)
	ctrlSetPosition [
		(ctrlPosition __ctrl(990000)) select 0,
		(ctrlPosition __ctrl(990000)) select 1,
		(ctrlPosition __ctrl(990000)) select 2,
		_h
	];
__ctrl(990000)
	ctrlCommit 0;

__ctrl(990000 + 1000)
	ctrlSetPosition [
		(ctrlPosition __ctrl(990000 + 1000)) select 0,
		(ctrlPosition __ctrl(990000 + 1000)) select 1,
		(ctrlPosition __ctrl(990000 + 1000)) select 2,
		_h
	];
__ctrl(990000 + 1000)
	ctrlCommit 0;

// Show/hide list boxes
if (_collapse) then
{
	__ctrl(990000 + 8001)
		ctrlShow false;
	__ctrl(990000 + 8002)
		ctrlShow false;
}
else
{
	__ctrl(990000 + 8001)
		ctrlShow !_playerIsSL;
	__ctrl(990000 + 8002)
		ctrlShow _playerIsSL;
};

// Show/hide invite button
__ctrl(990000 + 9000)
	ctrlShow (!_collapse && _playerIsSL);
