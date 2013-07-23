#include "defines.sqh"

PRA3_fDebugConsole_showAddFavorite =
{
	createDialog "PRA3_DebugConsole_addFavorite";
	waitUntil {!isNull(uiNamespace getVariable "PRA3_DebugConsole_addFavorite")};

	{
		ctrlFav(5) lbAdd _x;
	} forEach __executeOptions;
	ctrlFav(5) lbSetCurSel (lbCurSel ctrl(11));
	ctrlFav(3) ctrlSetText (ctrlText ctrl(21));
	ctrlFav(4) ctrlSetText (ctrlText ctrl(22));
	
};

PRA3_fDebugConsole_addFavorite =
{
	var(_name)    = ctrlText ctrlFav(2);
	var(_command) = ctrlText ctrlFav(3);
	
	if (_name != "" && _command != "") then
	{
		PRA3_debugConsole_favorites set [count PRA3_debugConsole_favorites, [_name, _command, ctrlText ctrlFav(4), lbCurSel ctrlFav(5)]];
		closeDialog 0;
		call PRA3_fDebugConsole_populateFavorites;
	};
};

PRA3_fDebugConsole_showEditFavorite =
{
	var(_idx) = lbCurSel ctrl(51);
	if (_idx > -1) then
	{
		createDialog "PRA3_DebugConsole_addFavorite";
		waitUntil {!isNull(uiNamespace getVariable "PRA3_DebugConsole_addFavorite")};
		ctrlFav(1) ctrlSetText "EDIT FAVORITE ENTRY";
		ctrlFav(101) ctrlSetText "Edit";

		{
			ctrlFav(5) lbAdd _x;
		} forEach __executeOptions;
		ctrlFav(2) ctrlSetText ((PRA3_debugConsole_favorites select _idx) select 0);
		ctrlFav(3) ctrlSetText ((PRA3_debugConsole_favorites select _idx) select 1);
		ctrlFav(4) ctrlSetText ((PRA3_debugConsole_favorites select _idx) select 2);
		ctrlFav(5) lbSetCurSel ((PRA3_debugConsole_favorites select _idx) select 3);
		ctrlFav(101) buttonSetAction "call PRA3_fDebugConsole_editFavorite";
	};
};

PRA3_fDebugConsole_editFavorite =
{
	var(_name)    = ctrlText ctrlFav(2);
	var(_command) = ctrlText ctrlFav(3);
	
	if (_name != "" && _command != "") then
	{
		PRA3_debugConsole_favorites set [lbCurSel ctrl(51), [_name, _command, ctrlText ctrlFav(4), lbCurSel ctrlFav(5)]];
		closeDialog 0;
		call PRA3_fDebugConsole_populateFavorites;
	};
};

PRA3_fDebugConsole_populateFavorites =
{
	lbClear ctrl(51);
	{
		ctrl(51) lbAdd (_x select 0);
	} forEach PRA3_debugConsole_favorites;
};

PRA3_fDebugConsole_deleteFavorite =
{
	if (lbCurSel ctrl(51) != -1) then
	{
		[parseText format['Are you sure you wish to delete the favorite entry "%1"?',
				(PRA3_debugConsole_favorites select lbCurSel ctrl(51)) select 0
			],
			{
				[PRA3_debugConsole_favorites, lbCurSel ctrl(51)] call PRA3_fDebugConsole_removeIndex;
				call PRA3_fDebugConsole_populateFavorites
			}
		] spawn PRA3_fDebugConsole_showYesNo;
	};
};

PRA3_fDebugConsole_favoritesSelect =
{
	var(_idx) = _this select 1;
	ctrl(21) ctrlSetText ((PRA3_debugConsole_favorites select _idx) select 1);
	ctrl(22) ctrlSetText ((PRA3_debugConsole_favorites select _idx) select 2);
	ctrl(11) lbSetCurSel ((PRA3_debugConsole_favorites select _idx) select 3);
};
