#include "defines.sqh"

PRA3_fDebugConsole_showAddFavorite =
{
	(uiNamespace getVariable "PRA3_RscDebugConsole") createDisplay "PRA3_DisplayDebugConsole_addFavorite";
	diag_log "start";
	waitUntil {!isNull(uiNamespace getVariable ["PRA3_DisplayDebugConsole_addFavorite", []])};
	diag_log "end";

	{
		ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_EXECUTION) lbAdd _x;
	} forEach __executeOptions;
	ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_EXECUTION) lbSetCurSel (lbCurSel ctrl(IDC_DEBUGCONSOLE_MAIN_EXECUTION_CB));
	ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_COMMAND) ctrlSetText (ctrlText ctrl(IDC_DEBUGCONSOLE_MAIN_COMMAND_EDIT));
	ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_PARAM) ctrlSetText (ctrlText ctrl(IDC_DEBUGCONSOLE_MAIN_PARAMS_EDIT));
	ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_CONFIRM) buttonSetAction "call PRA3_fDebugConsole_addFavorite";
};

PRA3_fDebugConsole_addFavorite =
{
	var(_name)    = ctrlText ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_NAME);
	var(_command) = ctrlText ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_COMMAND);

	if (_name != "" && _command != "") then
	{
		var(_favorites) = profileNamespace getVariable ["PRA3_debugConsole_favorites", []];
		_favorites set [
			count _favorites,
			[_name, _command, ctrlText ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_PARAM), lbCurSel ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_EXECUTION)]
		];
		profileNamespace setVariable ["PRA3_debugConsole_favorites", _favorites];
		(uiNamespace getVariable "PRA3_DisplayDebugConsole_addFavorite") closeDisplay 1;
		call PRA3_fDebugConsole_populateFavorites;
	};
};

PRA3_fDebugConsole_showEditFavorite =
{
	var(_idx) = lbCurSel ctrl(IDC_DEBUGCONSOLE_MAIN_FAVORITES_LB);
	if (_idx > -1) then
	{
		(uiNamespace getVariable "PRA3_RscDebugConsole") createDisplay "PRA3_DisplayDebugConsole_addFavorite";
		waitUntil {!isNull(uiNamespace getVariable "PRA3_DisplayDebugConsole_addFavorite")};
		ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_TITLE) ctrlSetText "EDIT FAVORITE ENTRY";
		ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_CONFIRM) ctrlSetText "Edit";

		{
			ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_EXECUTION) lbAdd _x;
		} forEach __executeOptions;
		var(_favorites) = profileNamespace getVariable ["PRA3_debugConsole_favorites", []];
		ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_NAME) ctrlSetText ((_favorites select _idx) select 0);
		ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_COMMAND) ctrlSetText ((_favorites select _idx) select 1);
		ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_PARAM) ctrlSetText ((_favorites select _idx) select 2);
		ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_EXECUTION) lbSetCurSel ((_favorites select _idx) select 3);
		ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_CONFIRM) buttonSetAction "call PRA3_fDebugConsole_editFavorite";
	};
};

PRA3_fDebugConsole_editFavorite =
{
	var(_name)    = ctrlText ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_NAME);
	var(_command) = ctrlText ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_COMMAND);

	if (_name != "" && _command != "") then
	{
		var(_favorites) = profileNamespace getVariable ["PRA3_debugConsole_favorites", []];
		_favorites set [
			lbCurSel ctrl(IDC_DEBUGCONSOLE_MAIN_FAVORITES_LB),
			[_name, _command, ctrlText ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_PARAM), lbCurSel ctrlFav(IDC_DEBUGCONSOLE_FAVORITE_EXECUTION)]
		];
		profileNamespace setVariable ["PRA3_debugConsole_favorites", _favorites];
		(uiNamespace getVariable "PRA3_DisplayDebugConsole_addFavorite") closeDisplay 1;
		call PRA3_fDebugConsole_populateFavorites;
	};
};

PRA3_fDebugConsole_populateFavorites =
{
	lbClear ctrl(IDC_DEBUGCONSOLE_MAIN_FAVORITES_LB);
	{
		ctrl(IDC_DEBUGCONSOLE_MAIN_FAVORITES_LB) lbAdd (_x select 0);
	} forEach (profileNamespace getVariable ["PRA3_debugConsole_favorites", []]);
};

PRA3_fDebugConsole_deleteFavorite =
{
	if (lbCurSel ctrl(IDC_DEBUGCONSOLE_MAIN_FAVORITES_LB) != -1) then
	{
		
		[parseText format['Are you sure you wish to delete the favorite entry "%1"?',
				((profileNamespace getVariable ["PRA3_debugConsole_favorites", []]) select lbCurSel ctrl(IDC_DEBUGCONSOLE_MAIN_FAVORITES_LB)) select 0
			],
			{
				var(_favorites) = profileNamespace getVariable ["PRA3_debugConsole_favorites", []];
				[_favorites, lbCurSel ctrl(IDC_DEBUGCONSOLE_MAIN_FAVORITES_LB)] call PRA3_fDebugConsole_removeIndex;
				profileNamespace setVariable ["PRA3_debugConsole_favorites", _favorites];
				call PRA3_fDebugConsole_populateFavorites
			}
		] spawn PRA3_fDebugConsole_showYesNo;
	};
};

PRA3_fDebugConsole_favoritesSelect =
{
	var(_idx) = _this select 1;
	var(_favorites) = profileNamespace getVariable ["PRA3_debugConsole_favorites", []];
	ctrl(IDC_DEBUGCONSOLE_MAIN_COMMAND_EDIT) ctrlSetText ((_favorites select _idx) select 1);
	ctrl(IDC_DEBUGCONSOLE_MAIN_PARAMS_EDIT) ctrlSetText ((_favorites select _idx) select 2);
	ctrl(IDC_DEBUGCONSOLE_MAIN_EXECUTION_CB) lbSetCurSel ((_favorites select _idx) select 3);
	profileNamespace setVariable ["PRA3_debugConsole_favorites", _favorites];
};
