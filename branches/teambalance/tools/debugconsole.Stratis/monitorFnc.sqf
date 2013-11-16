#include "defines.sqh"

PRA3_fDebugConsole_populateMonitored =
{
	{
		ctrl(61) lbAdd (_x select 0);
	} forEach PRA3_debugConsole_monitoredValues;
	ctrl(61) lbSetCurSel PRA3_debugConsole_monitoredValuesCurrent;
};

PRA3_fDebugConsole_showAddMonitored =
{
	createDialog "PRA3_DebugConsole_addMonitoredValue";
	waitUntil {!isNull(uiNamespace getVariable "PRA3_DebugConsole_addMonitoredValue")};
	{
		ctrlVal(3) lbAdd (_x select 0);
	} forEach PRA3_debugConsole_monitoredValues;
	ctrlVal(3) lbSetCurSel PRA3_debugConsole_monitoredValuesCurrent;
	ctrlVal(4) ctrlSetText ctrlText ctrl(21);
};

PRA3_fDebugConsole_addMonitored =
{
	var(_name) = ctrlText ctrlVal(2);
	var(_expression) = ctrlText ctrlVal(4);
	if (_name != "" && _expression != "") then
	{
		var(_arr) = (PRA3_debugConsole_monitoredValues select lbCurSel ctrlVal(3)) select 1;
		_arr set [count _arr, [_name, _expression]];
		closeDialog 0;
		call PRA3_fDebugConsole_monitoredEvaluate;
	};
};

PRA3_fDebugConsole_showEditMonitored =
{
	var(_idx) = lbCurSel ctrl(62);
	if (_idx > -1) then
	{
		createDialog "PRA3_DebugConsole_addMonitoredValue";
		waitUntil {!isNull(uiNamespace getVariable "PRA3_DebugConsole_addMonitoredValue")};
		
		{
			ctrlVal(3) lbAdd (_x select 0);
		} forEach PRA3_debugConsole_monitoredValues;
		
		var(_entry) = (((PRA3_debugConsole_monitoredValues select PRA3_debugConsole_monitoredValuesCurrent) select 1) select _idx) select 1;
		
		ctrlVal(1) ctrlSetText "EDIT MONITORED VALUE ENTRY";
		ctrlVal(101) ctrlSetText "Edit";
		
		ctrlVal(2) ctrlSetText _entry select 0;
		ctrlVal(3) lbSetCurSel PRA3_debugConsole_monitoredValuesCurrent;
		ctrlVal(4) ctrlSetText _entry select 1;
		ctrlVal(101) buttonSetAction "call PRA3_fDebugConsole_editMonitored";
	};
};

PRA3_fDebugConsole_editMonitored =
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

PRA3_fDebugConsole_monitoredCategoryChange =
{
	PRA3_debugConsole_monitoredValuesCurrent = _this select 1;
	call PRA3_fDebugConsole_monitoredEvaluate;
};

PRA3_fDebugConsole_monitoredEvaluate =
{
	var(_curSel) = lbSelection ctrl(62);
	lbClear ctrl(62);
	{
		var(_val) = call compile (_x select 1);
		var(_idx) = ctrl(62) lbAdd format["%1: %2", _x select 0, if (isNil "_val") then {">nil<"} else {str _val}];
	} forEach ((PRA3_debugConsole_monitoredValues select PRA3_debugConsole_monitoredValuesCurrent) select 1);
	{
		ctrl(62) lbSetSelected [_x, true];
	} forEach _curSel;
};

PRA3_fDebugConsole_monitorSelect =
{
	var(_entry) = ((PRA3_debugConsole_monitoredValues select PRA3_debugConsole_monitoredValuesCurrent) select 1) select (_this select 1);
	var(_value) = call compile (_entry select 1);
	
	ctrl(21) ctrlSetText (_entry select 1);
	if (isNil "_value") then
	{
		ctrl(26) ctrlSetText ">nil<";
		ctrl(25) ctrlSetText "No value";
	}
	else
	{
		ctrl(26) ctrlSetText typeName _value;
		ctrl(25) ctrlSetText str _value;
	};
};

PRA3_fDebugConsole_deleteMonitor =
{
	if (lbCurSel ctrl(62) != -1) then
	{
		[parseText format['Are you sure you wish to delete the value monitor entry "%1"?',
				(((PRA3_debugConsole_monitoredValues select PRA3_debugConsole_monitoredValuesCurrent) select 1) select lbCurSel ctrl(62)) select 0
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
					[(_entry select 1), lbCurSel ctrl(62)] call PRA3_fDebugConsole_removeIndex;
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
		PRA3_debugConsole_pinnedValues = lbSelection ctrl(62);
		ctrl(63) ctrlSetText "Unpin";
		
		55 cutRsc ["PRA3_debugConsole_pinnedValues", "PLAIN"];
		
		0 spawn
		{
			while {!isNull(uiNamespace getVariable "PRA3_debugConsole_pinnedValues")} do
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
		ctrl(63) ctrlSetText "Pin";
		
		55 cutText ["", "PLAIN"];
	};
};
