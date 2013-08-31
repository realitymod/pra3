#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Handles mouse click events.
 */
var(_uid)    = _this select 0;
var(_btn)    = (_this select 1) select 1;
var(_offset) = _this select 2;
var(_x)      = (_this select 1) select 2;
var(_y)      = (_this select 1) select 3;

var(_squad) = _uid call PRA3_fnc_unitGetSquad;
var(_playerId) = player call PRA3_fnc_getPlayerUID;

if (_btn == 1 && // Right-click
	!PRAA_squadSys_editingCustomName && // Not editing squad name
	{_uid != ""} && // On valid target
	{_uid != _playerId} && // Player not clicking on himself
	{_playerId call PRA3_fnc_unitGetSquad != -1} && // Player is in a squad
	{(_squad call PRA3_fnc_squadGetLeader) == _playerId} // Player is the SL
) then
{
	PRAA_squadSys_menuPos = [_x + (_offset select 0) + 0.001, _y + (_offset select 1) + 0.001];
	true call PRA3_fnc_squadDlg_showPopupMenu;
	PRAA_squadSys_menuTarget = _uid;
}
else
{
	PRAA_squadSys_menuTarget = "";
	false call PRA3_fnc_squadDlg_showPopupMenu;
};

call PRAA_fSquadSys_highlightLines;
