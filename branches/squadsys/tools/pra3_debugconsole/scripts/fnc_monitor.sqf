#include "defines.sqh"

PRA3_fDebugConsole_populateMonitored =
{
	{
		ctrl(IDC_DEBUGCONSOLE_MAIN_MONITOR_CAT_CB) lbAdd (_x select 0);
	} forEach PRA3_debugConsole_monitoredValues;
	ctrl(IDC_DEBUGCONSOLE_MAIN_MONITOR_CAT_CB) lbSetCurSel PRA3_debugConsole_monitoredValuesCurrent;
};

PRA3_fDebugConsole_showAddMonitored =
{
	(uiNamespace getVariable "PRA3_RscDebugConsole") createDisplay "PRA3_DisplayDebugConsole_addMonitoredValue";
	waitUntil {!isNull(uiNamespace getVariable "PRA3_DisplayDebugConsole_addMonitoredValue")};
	{
		ctrlMon(IDC_DEBUGCONSOLE_MONITOR_CATEGORY) lbAdd (_x select 0);
	} forEach PRA3_debugConsole_monitoredValues;
	ctrlMon(IDC_DEBUGCONSOLE_MONITOR_CATEGORY) lbSetCurSel PRA3_debugConsole_monitoredValuesCurrent;
	ctrlMon(IDC_DEBUGCONSOLE_MONITOR_COMMAND) ctrlSetText ctrlText ctrl(IDC_DEBUGCONSOLE_MAIN_COMMAND_EDIT);
	ctrlMon(IDC_DEBUGCONSOLE_MONITOR_CONFIRM) buttonSetAction "call PRA3_fDebugConsole_addMonitored";
};

PRA3_fDebugConsole_addMonitored =
{
	var(_name)       = ctrlText ctrlMon(IDC_DEBUGCONSOLE_MONITOR_NAME);
	var(_expression) = ctrlText ctrlMon(IDC_DEBUGCONSOLE_MONITOR_COMMAND);
	if (_name != "" && _expression != "") then
	{
		var(_arr) = (PRA3_debugConsole_monitoredValues select lbCurSel ctrlMon(IDC_DEBUGCONSOLE_MONITOR_CATEGORY)) select 1;
		_arr set [count _arr, [_name, _expression]];
		(uiNamespace getVariable "PRA3_DisplayDebugConsole_addMonitoredValue") closeDisplay 1;
		call PRA3_fDebugConsole_monitoredEvaluate;
	};
};

PRA3_fDebugConsole_showEditMonitored =
{
	var(_idx) = lbCurSel ctrl(IDC_DEBUGCONSOLE_MAIN_MONITOR_LIST_LB);
	if (_idx > -1) then
	{
		(uiNamespace getVariable "PRA3_RscDebugConsole") createDisplay "PRA3_DisplayDebugConsole_addMonitoredValue";
		waitUntil {!isNull(uiNamespace getVariable "PRA3_DisplayDebugConsole_addMonitoredValue")};

		{
			ctrlMon(IDC_DEBUGCONSOLE_MONITOR_CATEGORY) lbAdd (_x select 0);
		} forEach PRA3_debugConsole_monitoredValues;

		var(_entry) = ((PRA3_debugConsole_monitoredValues select PRA3_debugConsole_monitoredValuesCurrent) select 1) select _idx;
		diag_log text format["=> %1", _entry];

		ctrlMon(IDC_DEBUGCONSOLE_MONITOR_TITLE) ctrlSetText "EDIT MONITORED VALUE ENTRY";
		ctrlMon(IDC_DEBUGCONSOLE_MONITOR_CONFIRM) ctrlSetText "Edit";

		ctrlMon(IDC_DEBUGCONSOLE_MONITOR_NAME) ctrlSetText (_entry select 0);
		ctrlMon(IDC_DEBUGCONSOLE_MONITOR_CATEGORY) lbSetCurSel PRA3_debugConsole_monitoredValuesCurrent;
		ctrlMon(IDC_DEBUGCONSOLE_MONITOR_COMMAND) ctrlSetText (_entry select 1);
		ctrlMon(IDC_DEBUGCONSOLE_MONITOR_CONFIRM) buttonSetAction "call PRA3_fDebugConsole_editMonitored";
	};
};

PRA3_fDebugConsole_editMonitored =
{
	var(_name)       = ctrlText ctrlMon(IDC_DEBUGCONSOLE_MONITOR_NAME);
	var(_expression) = ctrlText ctrlMon(IDC_DEBUGCONSOLE_MONITOR_COMMAND);

	if (_name != "" && _expression != "") then
	{
		var(_arr) = (PRA3_debugConsole_monitoredValues select PRA3_debugConsole_monitoredValuesCurrent) select 1;
		_arr set [lbCurSel ctrl(IDC_DEBUGCONSOLE_MAIN_MONITOR_LIST_LB), [_name, _expression]];
		(uiNamespace getVariable "PRA3_DisplayDebugConsole_addMonitoredValue") closeDisplay 1;
		call PRA3_fDebugConsole_populateMonitored;
	};
};

PRA3_fDebugConsole_monitoredCategoryChange =
{
	PRA3_debugConsole_monitoredValuesCurrent = _this select 1;
	call PRA3_fDebugConsole_monitoredEvaluate;
};

PRA3_fDebugConsole_monitoredEvaluate =
{
	var(_curSel) = lbSelection ctrl(IDC_DEBUGCONSOLE_MAIN_MONITOR_LIST_LB);
	lbClear ctrl(IDC_DEBUGCONSOLE_MAIN_MONITOR_LIST_LB);
	if (count PRA3_debugConsole_monitoredValues > 0) then
	{
		{
			var(_val) = call compile (_x select 1);
			var(_idx) = ctrl(IDC_DEBUGCONSOLE_MAIN_MONITOR_LIST_LB) lbAdd format["%1: %2", _x select 0, if (isNil "_val") then {">nil<"} else {str _val}];
		} forEach ((PRA3_debugConsole_monitoredValues select PRA3_debugConsole_monitoredValuesCurrent) select 1);
		{
			ctrl(IDC_DEBUGCONSOLE_MAIN_MONITOR_LIST_LB) lbSetSelected [_x, true];
		} forEach _curSel;
	};
};

PRA3_fDebugConsole_monitorSelect =
{
	var(_entry) = ((PRA3_debugConsole_monitoredValues select PRA3_debugConsole_monitoredValuesCurrent) select 1) select (_this select 1);
	var(_value) = call compile (_entry select 1);

	ctrl(IDC_DEBUGCONSOLE_MAIN_COMMAND_EDIT) ctrlSetText (_entry select 1);
	if (isNil "_value") then
	{
		ctrl(IDC_DEBUGCONSOLE_MAIN_RETURN_TYPE) ctrlSetText ">nil<";
		ctrl(IDC_DEBUGCONSOLE_MAIN_RETURN_EDIT) ctrlSetText "No value";
	}
	else
	{
		ctrl(IDC_DEBUGCONSOLE_MAIN_RETURN_TYPE) ctrlSetText typeName _value;
		ctrl(IDC_DEBUGCONSOLE_MAIN_RETURN_EDIT) ctrlSetText str _value;
	};
};

PRA3_fDebugConsole_deleteMonitor =
{
	if (lbCurSel ctrl(IDC_DEBUGCONSOLE_MAIN_MONITOR_LIST_LB) != -1) then
	{
		[parseText format['Are you sure you wish to delete the value monitor entry "%1"?',
				(((PRA3_debugConsole_monitoredValues select PRA3_debugConsole_monitoredValuesCurrent) select 1) select lbCurSel ctrl(IDC_DEBUGCONSOLE_MAIN_MONITOR_LIST_LB)) select 0
			],
			{
				var(_entry) = PRA3_debugConsole_monitoredValues select PRA3_debugConsole_monitoredValuesCurrent;
				// If this is the last item remove the whole category
				if (count(_entry select 1) == 1 && PRA3_debugConsole_monitoredValuesCurrent != 0) then
				{
					[PRA3_debugConsole_monitoredValues, PRA3_debugConsole_monitoredValuesCurrent] call PRA3_fDebugConsole_removeIndex;
				}
				else
				{
					[(_entry select 1), lbCurSel ctrl(IDC_DEBUGCONSOLE_MAIN_MONITOR_LIST_LB)] call PRA3_fDebugConsole_removeIndex;
				};

				call PRA3_fDebugConsole_monitoredEvaluate;
			}
		] spawn PRA3_fDebugConsole_showYesNo;
	};
};

PRA3_fDebugConsole_pinMonitor =
{
	if (count PRA3_debugConsole_pinnedValues == 0) then
	{
		PRA3_debugConsole_pinnedValues = lbSelection ctrl(IDC_DEBUGCONSOLE_MAIN_MONITOR_LIST_LB);
		ctrl(IDC_DEBUGCONSOLE_MAIN_MONITOR_PIN) ctrlSetText "Unpin";

		55 cutRsc ["PRA3_RscDebugConsole_pinnedValues", "PLAIN"];

		0 spawn
		{
			while {!isNull(uiNamespace getVariable "PRA3_RscDebugConsole_pinnedValues")} do
			{
				// Show values
				{
					var(_value) = ((PRA3_debugConsole_monitoredValues select PRA3_debugConsole_monitoredValuesCurrent) select 1) select _x;
					ctrlPin(100 * (_forEachIndex + 1) + 1) ctrlSetText (_value select 0);
					var(_result) = call compile (_value select 1);
					ctrlPin(100 * (_forEachIndex + 1) + 2) ctrlSetText (if (isNil "_result") then {">nil<"} else {str _result});
				} forEach PRA3_debugConsole_pinnedValues;

				// Hide the rest
				for "_i" from count PRA3_debugConsole_pinnedValues + 1 to 30 do
				{
					ctrlPin(100 * _i + 1) ctrlSetText "";
					ctrlPin(100 * _i + 2) ctrlSetText "";
				};

				sleep 0.1;
			};
		};
	}
	else
	{
		PRA3_debugConsole_pinnedValues = [];
		ctrl(IDC_DEBUGCONSOLE_MAIN_MONITOR_PIN) ctrlSetText "Pin";

		55 cutText ["", "PLAIN"];
	};
};
