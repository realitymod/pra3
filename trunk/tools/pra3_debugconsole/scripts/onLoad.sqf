#include "defines.sqh"

uiNamespace setVariable ["PRA3_RscDebugConsole", _this];

if (isNil "PRA3_debugConsole_initialized") then
{
	call compile preprocessFileLineNumbers "\pra3\pra3_debugconsole\scripts\init.sqf";
};

diag_log (uiNamespace getVariable "PRA3_RscDebugConsole");
{
	ctrl(IDC_DEBUGCONSOLE_MAIN_EXECUTION_CB) lbAdd _x;
} forEach __executeOptions;
ctrl(IDC_DEBUGCONSOLE_MAIN_EXECUTION_CB) lbSetCurSel 0;

lbClear ctrl(IDC_DEBUGCONSOLE_MAIN_PLAYER_CB);
PRA3_debugConsole_remoteList = [];
{
	if (isPlayer _x) then
	{
		PRA3_debugConsole_remoteList set [count PRA3_debugConsole_remoteList, _x];
		ctrl(IDC_DEBUGCONSOLE_MAIN_PLAYER_CB) lbAdd format["%1 (%2)", name _x, _x];
	};
} forEach playableUnits;

if (!isMultiplayer) then
{
	ctrl(IDC_DEBUGCONSOLE_MAIN_EXECUTION_CB) ctrlEnable false;
	ctrl(IDC_DEBUGCONSOLE_MAIN_PLAYER_CB) ctrlEnable false;
};

call PRA3_fDebugConsole_populateHistory;
call PRA3_fDebugConsole_populateFavorites;
call PRA3_fDebugConsole_populateMonitored;

0 spawn
{
	while {!isNull(uiNamespace getVariable "PRA3_RscDebugConsole")} do
	{
		call PRA3_fDebugConsole_monitoredEvaluate;
		sleep 0.5;
	};
};
