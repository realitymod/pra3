#include "scriptDefines.sqh"

/**
 *	Rounds the number to the specified number of decimal places.
 *		(in)  <ARRAY>:
 *			0 <FLOAT> original position
 *			1 <INT> precision
 *		(out) <FLOAT> rounded value
 */

var(_number)    = _this select 0;
var(_precision) = _this select 1;

var(_n) = 10^(_precision);

(round(_number * _n) / _n)
