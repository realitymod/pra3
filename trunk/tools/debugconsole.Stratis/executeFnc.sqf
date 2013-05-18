#include "defines.sqh"

PRA3_fDebugConsole_execute =
{
	var(_execute) = lbCurSel ctrl(11);
	var(_command) = ctrlText ctrl(21);
	var(_param) = ctrlText ctrl(22);
	
	terminate PRA3_fDebugConsole_returnFetcher;
	PRA3_debugConsole_return = nil;
	
	if (_command == "") then
	{
		ctrl(25) ctrlSetText "Nothing to do with nothing.";
	}
	else
	{
		ctrl(26) ctrlSetText "";
		var(_paramCode) = "";
		if (_param == "") then
		{
			_paramCode = nil;
		}
		else
		{
			ctrl(25) ctrlSetText "Uh oh. An error happened while trying to compile the parameter. Make sure you have -showScriptErrors on so you can see what it was!";
			_paramCode = call compile _param;
			ctrl(25) ctrlSetText "";
		};

		ctrl(25) ctrlSetText "Uh oh. An error happened while trying to compile the code. Make sure you have -showScriptErrors on so you can see what it was!";
		var(_code) = compile _command;
		ctrl(25) ctrlSetText "";
		
		var(_ok) = true;
		switch (_execute) do
		{
			case 0: //Local
			{
				ctrl(25) ctrlSetText "Uh oh. There is an error in your command. Make sure you have -showScriptErrors on so you can see what it was!";
				[_code, _paramCode, player, player] spawn PRA3_fDebugConsole_executeCommand;
			};
			case 1: //Public
			{
				ctrl(25) ctrlSetText "Public execution does not return a value.";
				_ok = false;
				PRA3_debugConsole_command = [_code, _paramCode, "", objNull];
				PRA3_debugConsole_command spawn PRA3_fDebugConsole_executeCommand; //Execute it locally too
				publicVariable "PRA3_debugConsole_command";
			};
			case 2: //Server
			{
				PRA3_debugConsole_command = [_code, _paramCode, "s", player];
				
				// No need to broadcast if we're already the server
				if (isServer) then
				{
					PRA3_debugConsole_command spawn PRA3_fDebugConsole_processCommand;
				}
				else
				{
					publicVariableServer "PRA3_debugConsole_command";
				};
			};
			case 3: //Specific player
			{
				if (lbCurSel ctrl(12) == -1) then
				{
					ctrl(25) ctrlSetText "No player selected.";
					_ok = false;
				}
				else
				{
					var(_unit) = PRA3_debugConsole_remoteList select (lbCurSel ctrl(12));
					PRA3_debugConsole_command = [_code, _paramCode, _unit, if (_getReturn) then {player} else {objNull}];
					
					// No need to broadcast if the unit is local here or if we're the server
					if (local _unit || isServer) then
					{
						PRA3_debugConsole_command spawn PRA3_fDebugConsole_processCommand;
					}
					else
					{
						publicVariableServer "PRA3_debugConsole_command";
					};
				};
			};
		};
		
		if (_ok) then
		{
			ctrl(25) ctrlSetText "Fetching return value...";
			ctrl(26) ctrlSetText "?";
			PRA3_fDebugConsole_returnFetcher = 0 spawn
			{
				var(_timeout) = diag_tickTime + 5;
				while {true} do
				{
					if (!isNil "PRA3_debugConsole_return") exitWith
					{
						if (isNil {PRA3_debugConsole_return select 0}) then
						{
							ctrl(25) ctrlSetText "The expression didn't return any value.";
							ctrl(26) ctrlSetText "<nil>";
						}
						else
						{
							ctrl(25) ctrlSetText str (PRA3_debugConsole_return select 0);
							ctrl(26) ctrlSetText typeName (PRA3_debugConsole_return select 0);
						};
					};
					if (diag_tickTime > _timeout) then
					{
						ctrl(25) ctrlSetText "Timed out. Perhaps there was a script error?";
					};
					sleep 0.05;
				};
			};
		
			var(_history) = uiNamespace getVariable ["PRA3_debugConsole_history", []];
			var(_placeAt) = count _history;
			{
				if ((_x select 0) == _command) exitWith
				{
					for "_i" from _forEachIndex to (count _history)-2 do
					{
						_history set [_i, _history select (_i + 1)];
					};
					_placeAt = _placeAt - 1;
				};
			} forEach _history;
			_history set [_placeAt, [_command, _param]];
			uiNamespace setVariable ["PRA3_debugConsole_history", _history];
			
			call PRA3_fDebugConsole_populateHistory;
		};
	};
};

PRA3_fDebugConsole_executionSelection =
{
	ctrl(12) ctrlShow (lbCurSel ctrl(11) == 3);
};
