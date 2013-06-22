#include "defines.sqh"

PRA3_fDebugConsole_removeIndex =
{
	var(_array) = _this select 0;
	var(_index) = _this select 1;
	
	if (_index < count _array) then
	{
		for "_i" from _index to (count _array)-2 do
		{
			_array set [_i, _array select (_i + 1)];
		};
		_array resize (count _array - 1);
	};
	_array
};

PRA3_fDebugConsole_showYesNo =
{
	var(_question) = _this select 0;
	var(_action)   = _this select 1;
	
	createDialog "PRA3_DebugConsole_yesNo";
	waitUntil {!isNull(uiNamespace getVariable "PRA3_DebugConsole_yesNo")};
	((uiNamespace getVariable "PRA3_DebugConsole_yesNo") displayCtrl 2)
		ctrlSetStructuredText _question;
	PRA3_debugConsole_executeOnYes = _action;
};