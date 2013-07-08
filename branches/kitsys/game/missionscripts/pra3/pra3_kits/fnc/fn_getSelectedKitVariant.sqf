#include "scriptDefines.sqh"

var(_kit) = _this;

var(_variant) = "";
{
	if (_x select 0 == _kit) exitWith
	{
		_variant = _x select 1;
	};
} forEach PRA3_kitSys_kitConfigurations;

if (_variant == "") then
{
	_variant = configName(_kit call PRA3_fnc_getKitVariants select 0);
};

_variant
