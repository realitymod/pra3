#include "defines.sqh"

diag_log "REMOTE FILE";

if (isServer) then
{
	"PRA3_debugConsole_relay" addPublicVariableEventHandler {
		var(_destination) = (_this select 1) select 0;
		var(_data)        = (_this select 1) select 1;
		
		PRA3_debugConsole_return = _data;
		if (!local _destination) then
		{
			(owner _destination) publicVariableClient "PRA3_debugConsole_return";
		};
	};
};
"PRA3_debugConsole_command" addPublicVariableEventHandler {
	(_this select 1) spawn PRA3_fDebugConsole_processCommand;
};

PRA3_fDebugConsole_processCommand =
{
	var(_command)  = PRA3_debugConsole_command select 0;
	var(_param)    = PRA3_debugConsole_command select 1;
	var(_target)   = PRA3_debugConsole_command select 2;
	var(_returnTo) = PRA3_debugConsole_command select 3;
	
	var(_execute) =
	{
		if (isNil "_param") then
		{
			call _command;
		}
		else
		{
			_param call _command;
		}
	};
	
	if (isServer) then
	{
		if (typeName _target == "STRING") then
		{
			if (_target == "") then //Target is everyone
			{
				call _execute;
			}
			else //Target is the server itself
			{
				PRA3_debugConsole_command spawn PRA3_fDebugConsole_executeCommand;
			};
		}
		else
		{
			// Target unit is local here
			if (local _target) then
			{
				PRA3_debugConsole_command spawn PRA3_fDebugConsole_executeCommand;
			}
			else
			{
				var(_id) = -1;
				{
					if (isPlayer _x && _x == _target) exitWith
					{
						_id = owner _x;
					};
				} forEach playableUnits;
				
				if (_id != -1) then
				{
					_id publicVariableClient "PRA3_debugConsole_command";
				};
			};
		};
	}
	else
	{
		PRA3_debugConsole_command spawn PRA3_fDebugConsole_executeCommand;
	};
};

PRA3_fDebugConsole_executeCommand =
{
	var(_command)  = _this select 0;
	var(_param)    = _this select 1;
	var(_target)   = _this select 2;
	var(_returnTo) = _this select 3;
	
	diag_log ["PRA3_fDebugConsole_executeCommand", _this];
	
	if (isNull _returnTo) then //Not interested in return value
	{
		if (isNil "_param") then
		{
			0 call _command;
		}
		else
		{
			_param call _command;
		};
	}
	else
	{
		if (isNil "_param") then
		{
			PRA3_debugConsole_return = [call _command];
		}
		else
		{
			PRA3_debugConsole_return = [_param call _command];
		};

		diag_log [_this];
		
		// Might already be in place
		if (!local _returnTo) then
		{
			// Server can return directly, client has to relay over the server
			if (isServer) then
			{
				(owner _returnTo) publicVariableClient "PRA3_debugConsole_return";
			}
			else
			{
				PRA3_debugConsole_relay = [_returnTo, PRA3_debugConsole_return];
				publicVariableServer "PRA3_debugConsole_relay";
			};
		};
	};
};
