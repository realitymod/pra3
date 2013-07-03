#include "defines.sqh"
#include "scriptDefines.sqh"

var(_squadId) = _this select 0;
var(_unit)    = _this select 1;

if (_squadId == (_unit call PRA3_fnc_unitGetSquad)) then
{
	var(_prevFt) = [_squadId, _unit] call PRA3_fnc_unitGetFt;
	var(_ftLeader) = [_squadId, _prevFt] call PRA3_fnc_squadGetFtLeader;

	[_squadId, _unit, 0] call PRA3_fnc_unitSetFt;

	diag_log ["dump", _this, _prevFt, _ftLeader];

	if (_ftLeader == _unit) then
	{
		diag_log [_ftLeader, _unit];
		var(_newLeader) = [_squadId, _prevFt] call PRA3_fnc_squadGetFtLeader;
		var(_members) = _squadId call PRA3_fnc_squadGetMembers;
		{
			if ((_x select 1) == _prevFt) then
			{
				[
					_x select 0,
					"localizedMessage",
					"str_praa_squadsys_promote_ft",
					_unit call PRA3_fnc_getPlayerName
				] call PRAA_fMp_execClient;
			};
		} forEach _members;
		if (_newLeader != "") then
		{
			[
				_newLeader,
				"localizedMessage",
				"str_praa_squadsys_promote_ft_you"
			] call PRAA_fMp_execClient;
		};
	}
	else
	{
		[
			_ftLeader,
			"localizedMessage",
			"str_praa_squadsys_unassign_ft",
			_unit call PRA3_fnc_getPlayerName
		] call PRAA_fMp_execClient;
	};

	[
		_unit,
		"localizedMessage",
		"str_praa_squadsys_unassign_ft_you"
	] call PRAA_fMp_execClient;
};

[[_squadId], _squadId call PRA3_fnc_squadGetSide] call PRA3_fnc_squadDlg_server_refresh;
