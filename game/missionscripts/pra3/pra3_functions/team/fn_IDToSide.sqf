/**
 *	Returns the side for the given side ID.
 *
 *		(in)  <SIDE> Side
 *		(out) <INT> Side ID
 */

#include "scriptDefines.sqh"

var(_id) = _this;

var(_side) = switch _id do
{
	case SIDE_WEST:
	{
		west
	};
	case SIDE_EAST:
	{
		east
	};
	case SIDE_RESISTANCE:
	{
		resistance
	};
	default
	{
		civilian
	};
};

_side
