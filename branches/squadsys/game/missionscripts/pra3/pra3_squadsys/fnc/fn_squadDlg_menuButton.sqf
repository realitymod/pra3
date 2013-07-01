#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Handles one activation of buttons on the pop-up menu.
 */

var(_menu)	= _this select 0;
var(_button)= _this select 1;

var(_unit) = PRAA_squadSys_menuTarget;
var(_squad) = _unit call PRA3_fnc_unitGetSquad;
var(_ft) = [_squad, _unit] call PRA3_fnc_unitGetFt;

var(_common) =
{
	__ctrl(301) ctrlShow false;
	__ctrl(302) ctrlShow false;
	PRAA_squadSys_menuTarget = "";
};
if (_menu == 0) then
{
	switch (_button) do
	{
		case 0:
		{
			var(_h) = 2;

			if (_ft == 0) then // No FT assigned
			{
				__ctrl(30201) ctrlSetText "Assign to Charlie";
				__ctrl(30202) ctrlSetText "Assign to Delta";
				__ctrl(30202) ctrlShow true;
			}
			else
			{
				__ctrl(30201) ctrlSetText "Unassign";
				if ([_squad, _ft] call PRA3_fnc_squadGetFtLeader == _unit) then // FT leader
				{
					__ctrl(30202) ctrlShow false;
					_h = 1;
				}
				else
				{
					__ctrl(30202) ctrlSetText "Set FT leader";
					__ctrl(30202) ctrlShow true;
				};
			};

			__ctrl(302) ctrlSetPosition [(PRAA_squadSys_menuPos select 0) + 0.2, PRAA_squadSys_menuPos select 1, 0.2, _h * 0.04];
			__ctrl(302) ctrlCommit 0;
			__ctrl(302) ctrlShow true;

			ctrlSetFocus __ctrl(302);
		};
		case 1:
		{
			false call PRA3_fnc_squadDlg_enableControls;
			[[_squad, _unit], "PRA3_fnc_squadDlg_server_setNewSL", false] call BIS_fnc_MP;
			call _common;
		};
		case 2:
		{
			false call PRA3_fnc_squadDlg_enableControls;
			[[_unit, _squad], "PRA3_fnc_squadDlg_server_kickOut", false] call BIS_fnc_MP;
			call _common;
		};
	};
}
else
{
	if (_ft == 0) then // No FT assigned
	{
		false call PRA3_fnc_squadDlg_enableControls;
		[[_squad, _unit, _button + 1], "PRA3_fnc_squadDlg_server_setFt", false] call BIS_fnc_MP;
		call _common;
	}
	else
	{
		switch (_button) do
		{
			case 0: // Unassign
			{
				false call PRA3_fnc_squadDlg_enableControls;
				[[_squad, _unit], "PRA3_fnc_squadDlg_server_unsetFt", false] call BIS_fnc_MP;
				call _common;
			};
			case 1: // Set leader
			{
				false call PRA3_fnc_squadDlg_enableControls;
				[[_squad, _ft, _unit], "PRA3_fnc_squadDlg_server_setFtLeader", false] call BIS_fnc_MP;
				call _common;
			};
		};
	};
};
