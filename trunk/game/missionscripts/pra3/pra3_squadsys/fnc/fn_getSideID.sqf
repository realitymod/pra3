#include "scriptDefines.sqh"

/**
 * Returns the base value of squads of the given side.
 *		(in)  <SIDE> Side
 *		(out) <INT> Base
 */
switch (_this) do
{
	case west:
	{
		1000
	};
	case east:
	{
		2000
	};
	case resistance:
	{
		3000
	};
	case civilian:
	{
		4000
	};
	default
	{
		5000
	};
}
