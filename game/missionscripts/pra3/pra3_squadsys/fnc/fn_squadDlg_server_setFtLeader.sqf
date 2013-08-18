#include "defines.sqh"
#include "scriptDefines.sqh"

var(_squadId) = _this select 0;
var(_ft)      = _this select 1;
var(_unit)    = _this select 2;

if (_squadId == (_unit call PRA3_fnc_unitGetSquad)) then
{
	var(_prevLeader) = [_squadId, _ft] call PRA3_fnc_squadGetFtLeader;
	if (_prevLeader != "") then // Previous leader being replaced
	{
		[
			_prevLeader,
			"localizedMessage",
			"str_praa_squadsys_demote_ft"
		] call PRA3_fMp_execClient;
	};

	[_squadId, _ft, _unit] call PRA3_fnc_squadSetFtLeader;

	var(_members) = _squadId call PRA3_fnc_squadGetMembers;
	{
		if ((_x select 1) == _ft && (_x select 0) != _prevLeader) then
		{
			[
				_x select 0,
				"localizedMessage",
				"str_praa_squadsys_promote_ft",
				_unit call PRA3_fnc_getPlayerName
			] call PRA3_fMp_execClient;
		};
	} forEach _members;
	[
		_newLeader,
		"localizedMessage",
		"str_praa_squadsys_promote_ft_you"
	] call PRA3_fMp_execClient;
};

[[_squadId], _squadId call PRA3_fnc_squadGetSide] call PRA3_fnc_squadDlg_server_refresh;
