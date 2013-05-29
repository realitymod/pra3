#include "defines.sqh"

PRA3_fDebugConsole_populateHistory =
{
	var(_history) = uiNamespace getVariable ["PRA3_debugConsole_history", []];

	lbClear ctrl(IDC_DEBUGCONSOLE_MAIN_HISTORY_LB);
	for "_i" from count(_history)-1 to 0 step -1 do
	{
		var(_idx) = ctrl(IDC_DEBUGCONSOLE_MAIN_HISTORY_LB) lbAdd ((_history select _i) select 0);
		ctrl(IDC_DEBUGCONSOLE_MAIN_HISTORY_LB) lbSetData [_idx, (_history select _i) select 1];
	};
};
PRA3_fDebugConsole_historySelect =
{
	var(_idx) = _this select 1;
	ctrl(IDC_DEBUGCONSOLE_MAIN_COMMAND_EDIT) ctrlSetText (ctrl(IDC_DEBUGCONSOLE_MAIN_HISTORY_LB) lbText _idx);
	ctrl(IDC_DEBUGCONSOLE_MAIN_PARAMS_EDIT) ctrlSetText (ctrl(IDC_DEBUGCONSOLE_MAIN_HISTORY_LB) lbData _idx);
};
PRA3_fDebugConsole_historyClear =
{
	/*[parseText "Are you sure you wish to clear the entire history?",
		{
			uiNamespace setVariable ["PRA3_debugConsole_history", []];
			call PRA3_fDebugConsole_populateHistory;
		}
	] spawn PRA3_fDebugConsole_showYesNo;*/
};
