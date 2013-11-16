#include "scriptDefines.sqh"

/**
 *	Returns the number of memebers of the squad.
 *		(in)  <INT> Squad ID
 *		(out) <INT> Number of squad members
 */

count (_this call PRA3_fnc_squadGetMembers)
