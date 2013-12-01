#include "scriptDefines.sqh"
#include "defines.sqh"

var(_text) = DEBUG_ITEMS select _this select 0;
var(_var)  = DEBUG_ITEMS select _this select 1;
var(_code) = DEBUG_ITEMS select _this select 2;

var(_enabled) = PRA3_core getVariable [_var, false];

ctrl((_this+1)*10) ctrlSetText format ["%1: %2", if !_enabled then {"ON"} else {"OFF"}, _text];

PRA3_core setVariable [_var, !_enabled, true];

call _code;
