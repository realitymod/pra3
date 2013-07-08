#include "scriptDefines.sqh"

var(_kit) = _this;

var(_variants) = [];
var(_cfg)      = missionConfigFile >> "PRA3_kitSys" >> "Kits" >> _kit >> "Variants";
for "_i" from 0 to (count _cfg - 1) do
{
	_variants set [count _variants, _cfg select _i];
};

_variants
