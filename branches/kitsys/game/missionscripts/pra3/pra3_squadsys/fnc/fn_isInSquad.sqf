#include "scriptDefines.sqh"

/**
 * Returns true if the unit is in a squad or fales if it is unassigned.
 *		(in)  <OBJECT> Unit
 *			or
 *		(in)  <STRING> Unit UID
 *		(out) <BOOL> Is squad leader
 */

(_this call PRA3_fnc_unitGetSquad) call PRA3_fnc_squadExists
