/**
 *	Returns the side that has an unfairly higher number of players. What is considered unfair is configured by the input parameter.
 *
 *		(in)  <INT> Threshold to consider a side to be unbalanced.
 *		(out) <SIDE> Side that has more players or sideLogic if sides are balanced.
 */

#include "scriptDefines.sqh"

var(_threshold) = _this;
var(_num1) = playersNumber (PRA3_AAS_sides select 0);
var(_num2) = playersNumber (PRA3_AAS_sides select 1);
var(_diff) = _num1 - _num2;

if (abs(_diff) > _threshold) then
{
	if (_diff > 0) then
	{
		PRA3_AAS_sides select 0
	}
	else
	{
		PRA3_AAS_sides select 1
	}
}
else
{
	sideLogic
};
