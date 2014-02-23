#include "scriptDefines.sqh"
#include "defines.sqh"

// Update team names and flags
var(_teamCount) = (PRA3_AAS_teams select 0) call PRA3_fnc_count_PlayersTeam;

ctrl(51) ctrlSetText format["%1 [%2]",((PRA3_AAS_teams select 0) call PRA3_fnc_getTeamName),_teamCount select 0];
ctrl(52) ctrlSetText format["%1 [%2]",((PRA3_AAS_teams select 1) call PRA3_fnc_getTeamName),_teamCount select 1];

ctrl(61) ctrlSetText ((PRA3_AAS_teams select 0) call PRA3_fnc_getTeamFlag);
ctrl(62) ctrlSetText ((PRA3_AAS_teams select 1) call PRA3_fnc_getTeamFlag);

var(_num1) = 0;
var(_num2) = 0;

// Update players list
{
	var(_idx) = PRA3_AAS_teams find (_x call PRA3_fnc_getPlayerTeam);

	var(_idc) = 0;
	if (_idx == 0) then
	{
		_num1 = _num1 + 1;
		_idc = 100 * _num1 + 1;
	}
	else
	{
		_num2 = _num2 + 1;
		_idc = 100 * _num2 + 2;
	};

	ctrl(_idc) ctrlSetText (_x call PRA3_fnc_getPlayerName);
} forEach call PRA3_fnc_getConnectedPlayers;

for "_i" from 1 to 50 do
{
	ctrl(100 * _i) ctrlShow (_i <= _num1 || _i <= _num2);
	ctrl(100 * _i + 1) ctrlShow (_i <= _num1);
	ctrl(100 * _i + 2) ctrlShow (_i <= _num2);
};
