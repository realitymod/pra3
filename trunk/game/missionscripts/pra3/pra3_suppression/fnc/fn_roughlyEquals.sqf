#include "scriptDefines.sqh"

var(_num1) = _this select 0;
var(_num2) = _this select 1;
var(_tolerance) = _this select 2;

(abs(_num1 - _num2) <= _tolerance)