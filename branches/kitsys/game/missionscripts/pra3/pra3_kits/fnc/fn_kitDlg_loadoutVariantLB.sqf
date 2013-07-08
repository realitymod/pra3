#include "scriptDefines.sqh"
#include "defines.sqh"

var(_index) = _this select 1;

var(_kit)      = PRA3_kitSys_currentKit;
var(_variants) = _kit call PRA3_fnc_getKitVariants;
var(_found)    = false;
{
	if (_x select 0 == _kit) exitWith
	{
		_x set [1, configName(_variants select _index)];
		_found = true;
	};
} forEach PRA3_kitSys_kitConfigurations;

if (!_found) then
{
	PRA3_kitSys_kitConfigurations set [count PRA3_kitSys_kitConfigurations, [_kit, configName(_variants select _index)]];
};

call PRA3_fnc_kitDlg_populateKitDetails;
