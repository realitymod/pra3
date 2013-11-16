/**
 *	Returns the side that has an unfairly higher number of players. What is considered unfair is configured by the input parameter.
 *	Empty array is returned if sides are balanced.
 *
 *		(in)  <INT> Threshold to consider a side to be unbalanced.
 *		(out) <ARRAY>:
 *			0: <SIDE> Side with more players
 *			1: <SIDE> Side with less players
 */

#include "scriptDefines.sqh"

var(_threshold) = _this;

var(_numbers) = [0, 0];
{
	var(_side) = _x call PRA3_fnc_getPlayerSide;
	if (_side == sideLogic) then {_side = side _x};

	var(_idx) = PRA3_AAS_sides find _side;
	_numbers set [_idx, (_numbers select _idx) + 1];
} forEach allUnits;

var(_num1) = playersNumber (PRA3_AAS_sides select 0);
var(_num2) = playersNumber (PRA3_AAS_sides select 1);
var(_diff) = (_numbers select 0) - (_numbers select 1);

if (abs(_diff) > _threshold) then
{
	if (_diff > 0) then
	{
		+PRA3_AAS_sides
	}
	else
	{
		[PRA3_AAS_sides select 1, PRA3_AAS_sides select 0]
	}
}
else
{
	[]
};
