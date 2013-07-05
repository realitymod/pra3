#include "defines.sqh"
#include "scriptDefines.sqh"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"

/**
 *	Handles various action for the custom name.
 */

switch (_this select 0) do
{
	/**
	 *	Opens the custom squad name edit line.
	 */
	case 0:
	{
		PRAA_squadSys_editingCustomName = true;
		PRAA_squadSys_collapsedSquads set [0, false];

		[5, [true, true]] call PRA3_fnc_squadDlg_customName;
	};
	/**
	 *	Handles character input into the squad name edit line.
	 */
	case 1:
	{
		var(_key) = _this select 1 select 1;
		if (PRAA_squadSys_editingCustomName) then
		{
			var(_text) = ctrlText __ctrl(500000 + 3003);
			if (count toArray(_text) >= __customNameCharsMax) then // Name too long
			{
				__ctrl(500000 + 3003) ctrlSetText PRAA_squadSys_customNamePrev;
			}
			else
			{
				PRAA_squadSys_customNamePrev = _text;
			};
		};
	};
	case 2:
	{
		var(_key) = _this select 1 select 1;
		if (_key == DIK_RETURN || {_key == DIK_NUMPADENTER}) then
		{
			[3] call PRA3_fnc_squadDlg_customName;
			true
		}
		else
		{
			if (_key == DIK_ESCAPE) then
			{
				[4] call PRA3_fnc_squadDlg_customName;
				// FIXME: Still closes, even though true is returned...
				true
			}
			else
			{
				false
			}
		}
	};
	/**
	 *	Sets the name of player's squad to whatever was entered in the name edit line.
	 */
	case 3:
	{
		if (PRAA_squadSys_editingCustomName) then
		{
			var(_id) = (player call PRA3_fnc_unitGetSquad);
			var(_newName) = ctrlText __ctrl(500000 + 3003);
			if (_newName != (_id call PRA3_fnc_squadGetName) &&
				(player call PRA3_fnc_getPlayerUID) == (_id call PRA3_fnc_squadGetLeader) &&
				count toArray(_newName) <= __customNameCharsMax) then
			{
				false call PRA3_fnc_squadDlg_enableControls;
				[[_id, _newName], "PRA3_fnc_squadDlg_server_customNameSave", false] call PRA3_fnc_MP;
			};
			[4] call PRA3_fnc_squadDlg_customName;
		};
	};
	/**
	 *	Cancels editing the squad name.
	 */
	case 4:
	{
		if (PRAA_squadSys_editingCustomName) then
		{
			PRAA_squadSys_editingCustomName = false;
			PRAA_squadSys_customNamePrev = "";

			[5, [false, true]] call PRA3_fnc_squadDlg_customName;
		};
	};
	/**
	 *	Show/hide controls for editing of the custom name.
	 *
	 *		(in)  <ARRAY>:
	 *			0: <BOOL> show?
	 *			1: <BOOL> Squad leader?
	 *		(out) <VOID>
	 */
	case 5:
	{
		var(_show) = _this select 1 select 0;
		var(_SL)   = _this select 1 select 1;

		{
			__ctrl(500000 + _x)
				ctrlShow (_show && _SL);
		} forEach [3003, 3004, 3005];

		// Hide/show action text
		__ctrl(500000 + 3002) ctrlShow (!_show && _SL);

		if (_show && _SL) then
		{
			ctrlSetFocus __ctrl(500000 + 3003);
		};
	};
};
