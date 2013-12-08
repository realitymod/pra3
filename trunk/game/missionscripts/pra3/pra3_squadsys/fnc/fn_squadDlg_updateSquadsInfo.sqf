#include "defines.sqh"
#include "scriptDefines.sqh"

#define KIT_ABILITIES 9 //TODO: Include \pra3\pra3_kits\fnc\defines.sqh when possible (addon release)

/**
 *	Updates the squads' info based on its _squadId.
 *	NOTE: Pass in an empty array to update all squads.
 *
 *		(in)  <ARRAY> Squad IDs to update, 99 for unassigned
 *		(out) <VOID>
 */

var(_updateSquads) = _this;

if (
	isNull (uiNamespace getVariable ["Rsc_PRA3_squadSys_manageDlgRespawn", displayNull]) && {
	isNull (uiNamespace getVariable ["Rsc_PRA3_squadSys_manageDlg", displayNull])
}) exitWith {};

var(_updateSquadInfo) =
{
	var(_squadId) = _this;

	var(_playerIsMember) = _squadId == (player call PRA3_fnc_unitGetSquad);
	var(_playerIsSL) = (player call PRA3_fnc_getPlayerUID)  == (_squadId call PRA3_fnc_squadGetLeader);
	var(_id) = _squadId - (PRA3_player_side call PRA3_fnc_getSideID);

	var(_customName) = _squadId call PRA3_fnc_squadGetName;
	if (_playerIsMember) then // Player's squad
	{
		_id = 50;
		// Set squad's phonetic name
		ctrl(500000 + 2000)
			ctrlSetText (__phoneticAlphabet select
				(_squadId - 1 - (PRA3_player_side call PRA3_fnc_getSideID)));

		// Display the appropriate custom name control
		ctrl(500000 + 3001)
				ctrlShow !_playerIsSL;
		ctrl(500000 + 3002)
				ctrlShow _playerIsSL;
		// ...and update it
		if (_playerIsSL) then
		{
			// Edit field
			ctrl(500000 + 3003)
				ctrlSetText _customName;

			if (_customName == "") then
			{
				_customName = "(unnamed)";
			};

			// Active text
			ctrl(500000 + 3002)
				ctrlSetText _customName;

			if (PRA3_squadSys_menuTarget != "") then // Pop-up menu open
			{
				// Make sure the menu is interacting with a valid target
				var(_valid) = false;
				{
					if (PRA3_squadSys_menuTarget == (_x select 0)) exitWith
					{
						_valid = true;
					};
				} forEach ((player call PRA3_fnc_unitGetSquad) call PRA3_fnc_squadGetMembers);

				if (!_valid) then // Not valid, hide it
				{
					false call PRA3_fnc_squadDlg_showPopupMenu;
				};
			};
		}
		else
		{
			// Normal text
			ctrl(500000 + 3001)
				ctrlSetText _customName;
		};

		if (!PRA3_squadSys_editingCustomName) then
		{
			[5, [false, _playerIsSL]] call PRA3_fnc_squadDlg_customName;
		};
	}
	else
	{
		// Set custom name
		ctrl(10000*_id + 3001)
			ctrlSetText _customName;
	};

	var(_members) = _squadId call PRA3_fnc_squadGetMembers;
	var(_size)    = _squadId call PRA3_fnc_squadGetSize;

	// Set squad size info
	ctrl(10000*_id + 4000)
		ctrlSetText format ["%1/%2",
			count _members,
			_size
		];

	var(_locked) = _squadId call PRA3_fnc_squadIsLocked;
	// Set lock image
	ctrl(10000*_id + 5001)
		ctrlSetText (if (_playerIsSL) then {
				if (_locked) then {__pic_locked_border} else {__pic_unlocked_border}
			} else {
				if (_locked) then {__pic_locked} else {__pic_unlocked}
			}
		);

	// Show/hide lock button
	if (_playerIsMember) then
	{
		ctrl(500000 + 5002)
			ctrlShow _playerIsSL;
	};

	// Set text of the action button
	if (_playerIsMember) then
	{
		ctrl(500000 + 6000) ctrlSetText "Leave";
	}
	else
	{
		ctrl(10000*_id + 6000)
			ctrlSetText (if (_locked) then {"Request"} else {"Join"});

		ctrl(10000*_id + 6000)
			ctrlEnable (count _members < _size);
	};

	// Collapse/uncollapse the box
	var(_collapsed) = PRA3_squadSys_collapsedSquads select (
		if (_id == 50) then {0} else {_id});

	[if (_id == 50) then {0} else {_id}, _collapsed] call PRA3_fnc_squadDlg_collapseSquad;

	// ------------------------
	// Populate list of members

	var(_sortedMembers) = []; // Members sorted by rank and fireteam
	_sortedMembers resize (count _members);
	var(_i) = 0;
	// Find SL
	{
		if ((_x select 1) == 10) exitWith
		{
			_sortedMembers set [_i, _x];
			_i = _i + 1;
		};
	} forEach _members;
	// Find unassigned
	{
		if ((_x select 1) == 0) then
		{
			_sortedMembers set [_i, _x];
			_i = _i + 1;
		};
	} forEach _members;
	// Find FT Charlie leader
	{
		if ((_x select 1) == 11) exitWith
		{
			_sortedMembers set [_i, _x];
			_i = _i + 1;
		};
	} forEach _members;
	// Find FT Charlie members
	{
		if ((_x select 1) == 1) then
		{
			_sortedMembers set [_i, _x];
			_i = _i + 1;
		};
	} forEach _members;
	// Find FT Delta leader
	{
		if ((_x select 1) == 12) exitWith
		{
			_sortedMembers set [_i, _x];
			_i = _i + 1;
		};
	} forEach _members;
	// Find FT Delta members
	{
		if ((_x select 1) == 2) then
		{
			_sortedMembers set [_i, _x];
			_i = _i + 1;
		};
	} forEach _members;

	var(_i) = 0;
	{
		#define __ctrlLine(num) \
		(ctrl(10000*_id + 8000 + 10*(_forEachIndex + 1) + num))

		var(_unit) = _x select 0;

		if ((player call PRA3_fnc_getPlayerUID) == _unit) then
		{
			PRA3_squadSys_playerOnLine = _forEachIndex + 1;
		};

		// Set kit icon
		__ctrlLine(1)
			ctrlSetText (_unit call PRA3_fnc_unitGetKitIcon);

		// TODO: Implement from marker system
		__ctrlLine(2)
			ctrlSetText "";

		// Set player name
		__ctrlLine(3)
			ctrlSetText (_unit call PRA3_fnc_getPlayerName);

		__ctrlLine(3)
			ctrlSetFont (
				getText(__cfgPathItemListLine(01,"01") >> "Controls" >> "Name" >>
					if (_playerIsMember && {(player call PRA3_fnc_getPlayerUID) == _unit}) then {
						"fontHighlighted"
					} else {
						"font"
					}
				)
			);

		__ctrlLine(3)
			ctrlSetTextColor (__squadListColors select (
				if ((_x select 1) >= 10) then {
					(_x select 1) - 10
				} else {
					_x select 1
				})
			);


		// Role text
		__ctrlLine(5)
			ctrlSetText (
				if ((_x select 1) == 10) then {
					_i = 0; "SL"
				} else {
					if ((_x select 1) > 10) then {
						_i = 0; "FL"
					} else {
						str(_i)
					}
				}
			);
		__ctrlLine(5)
			ctrlSetTextColor (__squadListColors select (
				if ((_x select 1) >= 10) then {
					(_x select 1) - 10
				} else {
					_x select 1
				})
			);


		// Update mouseButtonDown event handler
		__ctrlLine(0)
			ctrlSetEventHandler [
				"mouseButtonDown",
				format["[%1, _this, [safeZoneX + 0.005, safeZoneY + 0.01 + 0.05 + 0.01 + 0.05]] call PRA3_fnc_squadDlg_onMouseClick", str _unit]
			];

		_i = _i + 1;
	} forEach _sortedMembers;

	if (_playerIsMember) then // Mark the line the player is on
	{
		call PRA3_fnc_squadDlg_highlightLines;
	};
};

var(_showSquadBox) =
{
	var(_id)   = _this select 0;
	var(_show) = _this select 1;

	ctrl(10000*_id)
		ctrlShow _show;
};


var(_updateUnassignedInfo) =
{
	var(_collapsed) = PRA3_squadSys_collapsedSquads select 27;

	_collapsed call PRA3_fnc_squadDlg_collapseUnassigned;

	var(_playerIsSL) = ((player call PRA3_fnc_unitGetSquad)
		call PRA3_fnc_squadGetLeader) == (player call PRA3_fnc_getPlayerUID);

	// Populate the correct list box
	var(_lb) = 990000 + (if (_playerIsSL) then {8002} else {8001});
	var(_players) = PRA3_player_side call PRA3_fnc_getUnassignedPlayers;
	lbClear ctrl(_lb);
	{
		var(_index) = (ctrl(_lb) lbAdd (_x call PRA3_fnc_getPlayerName));
		ctrl(_lb) lbSetData [_index, _x];
	} forEach _players;


	// Set number of unassigned players
	ctrl(990000 + 4000)
		ctrlSetText str (count _players);

	if (!_collapsed && {_playerIsSL}) then
	{
		var(_squadId) = player call PRA3_fnc_unitGetSquad;
		ctrl(990000 + 9000) ctrlEnable (
			count (_squadId call PRA3_fnc_squadGetMembers)
			< (_squadId call PRA3_fnc_squadGetSize)
		);
	};
};

var(_base) = PRA3_player_side call PRA3_fnc_getSideID;
var(_playerSquad) = (player call PRA3_fnc_unitGetSquad);

// Hide player's squad if he's not in one
if (_playerSquad == -1) then
{
	[50, false] call _showSquadBox;
	PRA3_squadSys_playerOnLine = -1;
};

if (count _updateSquads == 0) then // Update everything
{
	for "_i" from 1 to __maxSquads do
	{
		var(_squadId) = _base + _i;
		if (_squadId call PRA3_fnc_squadExists) then
		{
			[_i, _squadId != _playerSquad] call _showSquadBox;
			_squadId call _updateSquadInfo;
		}
		else
		{
			[_i, false] call _showSquadBox;
		};
	};

	call _updateUnassignedInfo;
}
else
{
	{
		if (_x == 99) then // Unassigned
		{
			call _updateUnassignedInfo;
		}
		else
		{
			if (_x call PRA3_fnc_squadExists) then
			{
				if (_playerSquad == _x) then // Updating player's squad
				{
					[50, true] call _showSquadBox; // Update player's squad box
					[_x - _base, false] call _showSquadBox; // Hide the squad's "public" box
				}
				else
				{
					[_x - _base, true] call _showSquadBox;
				};
				_x call _updateSquadInfo;
			}
			else
			{
				[_x - _base, false] call _showSquadBox;
			};
		};
	} forEach _updateSquads;
};

call PRA3_fnc_squadDlg_repositionSquadBoxes;

// Here we have a loop that handles the create squad/deploy RP button.
ctrl(999901) ctrlShow false; // Hide the button first, it'll be unhidden within the loop if needed (script lag prevention)

if (!isNil "PRA3_squadSys_rallyMonitor") then
{
	terminate PRA3_squadSys_rallyMonitor;
};

PRA3_squadSys_rallyMonitor = 0 spawn
{
	while {!isNull ctrl(999901)} do
	{
		var(_squad)    = player call PRA3_fnc_unitGetSquad;
		var(_isLeader) = _squad call PRA3_fnc_squadGetLeader == (player call PRA3_fnc_getPlayerUID);
		var(_kit)      = player call PRA3_fnc_unitGetKit call PRA3_fnc_getKitInfo;

		if (_squad == -1) then
		{
			ctrl(999901) ctrlSetText "Create Squad";
			ctrl(999901) ctrlSetTooltip "";
			ctrl(999901) ctrlShow true;
		}
		else
		{
			// Deploy RP available if player is alive, the non-respawn dialog is open, is the squad leader and has a kit with the rallyPoint ability
			if (alive player && !isNull (uiNamespace getVariable ["Rsc_PRA3_squadSys_manageDlg", displayNull]) && _isLeader && !isNil "_kit") then
			{
				if ("rallyPoint" in (_kit select KIT_ABILITIES)) then
				{
					var(_enableTime) = (_squad call PRA3_fnc_squadGetRallypointCooldown) - time;
					if (_enableTime > 0) then
					{
						ctrl(999901) ctrlSetText format["Deploy Rally Point (%1s)", round _enableTime];
						ctrl(999901) ctrlEnable false;
						ctrl(999901) ctrlSetTooltip "The rally point is not yet available for deployment.";
					}
					else
					{
						ctrl(999901) ctrlSetText "Deploy Rally Point";
						ctrl(999901) ctrlEnable true;
						ctrl(999901) ctrlSetTooltip "Deploys a rally point at your position.";
					};
				}
				else
				{
					ctrl(999901) ctrlSetText "Deploy Rally Point";
					ctrl(999901) ctrlEnable false;
					ctrl(999901) ctrlSetTooltip "You must have a Squad Leader kit to deploy a rally point.";
				};

				ctrl(999901) ctrlShow true;
			}
			else
			{
				ctrl(999901) ctrlShow false;
			};
		};

		sleep 1;
	};
};
