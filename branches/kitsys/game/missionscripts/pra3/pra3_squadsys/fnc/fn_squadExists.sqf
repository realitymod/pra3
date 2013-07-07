#include "scriptDefines.sqh"

/**
 * Checks if a squad with the given ID exists
 *		(in)  <INT> Squad ID
 *		(out) <BOOL> Squad exists
*/

var(_squadId) = _this;

(!isNil{PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]})
