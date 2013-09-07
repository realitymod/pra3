/**
 *	Returns the ID of the given side.
 *
 *		(in)  <SIDE> Side
 *		(out) <INT> Side ID
 */

#include "scriptDefines.sqh"

var(_side) = _this;

var(_id) = switch _side do
{
	case west:
	{
		SIDE_WEST
	};
	case east:
	{
		SIDE_EAST
	};
	case resistance:
	{
		SIDE_RESISTANCE
	};
	default
	{
		SIDE_CIVILIAN
	};
};

_id
