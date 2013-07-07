#include "defines.sqh"

{
	ctrl(11) lbAdd _x;
} forEach __executeOptions;
ctrl(11) lbSetCurSel 0;

lbClear ctrl(12);
PRA3_debugConsole_remoteList = [];
{
	if (isPlayer _x) then
	{
		PRA3_debugConsole_remoteList set [count PRA3_debugConsole_remoteList, _x];
		ctrl(12) lbAdd format["%1 (%2)", name _x, _x];
	};
} forEach playableUnits;

if (!isMultiplayer) then
{
	ctrl(11) ctrlEnable false;
	ctrl(12) ctrlEnable false;
};

call PRA3_fDebugConsole_populateHistory;
call PRA3_fDebugConsole_populateFavorites;
call PRA3_fDebugConsole_populateMonitored;

0 spawn
{
	while {!isNull(uiNamespace getVariable "PRA3_DebugConsole")} do
	{
		call PRA3_fDebugConsole_monitoredEvaluate;
		sleep 0.5;
	};
};
