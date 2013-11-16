#include "defines.sqh"
#include "scriptDefines.sqh"

var(_respositionSquadBox) =
{
	var(_id) = _this select 0;
	var(_y)  = _this select 1;

	if (ctrlShown ctrl(10000*_id)) then
	{
		ctrl(10000*_id)
			ctrlSetPosition [
				getNumber(__cfgPathItem(01) >> "x"),
				_y,
				getNumber(__cfgPathItem(01) >> "w"),
				ctrlPosition ctrl(10000*_id) select 3
			];

		ctrl(10000*_id)
			ctrlCommit 0;

		(_y + ((ctrlPosition ctrl(10000*_id)) select 3) + 0.01)
	}
	else
	{
		ctrl(10000*_id)
			ctrlSetPosition [0,0,0,0];

		ctrl(10000*_id)
			ctrlCommit 0;

		_y
	}
};

var(_y) = 0;
// Repositon player's squad
_y = [50, _y] call _respositionSquadBox;

// Repositon other squads
for "_i" from 0 to __maxSquads do
{
	_y = [_i, _y] call _respositionSquadBox;
};

// Reposition unassigned
_y = [99, _y] call _respositionSquadBox;
