#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Collapses/uncollapses the squad.
 *
 *		(in)  <ARRAY>:
 *			0 <INT> ID (0 for player's squad)
 *			1 <BOOL> collapse?
 *		(out) <VOID>
 */

var(_id)       = _this select 0;
var(_collapse) = _this select 1;

PRAA_squadSys_collapsedSquads set [_id, _collapse];

var(_squadId) = (if (_id == 0) then {
		(player call PRA3_fnc_unitGetSquad)
	} else {
		(playerSide call PRA3_fnc_getSideID) + _id
	}
);

// Player's squad has IDC base 50
if (_id == 0) then
{
	_id = 50;
};


// Set collapse/uncollapse button image
__ctrl(10000*_id + 7001)
	ctrlSetText (
		if (_collapse) then {__pic_uncollapse} else {__pic_collapse}
	);

// ----------------------------
// Adjust squad box size to fit

var(_count) = (if (_collapse) then {
		0
	} else {
		count (_squadId call PRA3_fnc_squadGetMembers)
	}
);

var(_boxH) = getNumber(__cfgPathItemHeaderBackground(01) >> "h") +
	(getNumber(__cfgPathItemListLine(01,"01") >> "h") * _count);

// Resize squad box
__ctrl(10000*_id)
	ctrlSetPosition [
		(ctrlPosition __ctrl(10000*_id)) select 0,
		(ctrlPosition __ctrl(10000*_id)) select 1,
		(ctrlPosition __ctrl(10000*_id)) select 2,
		_boxH
	];
__ctrl(10000*_id)
	ctrlCommit 0;
