#include "scriptDefines.sqh"
/**
 * Check ifd the player switched team and make the actual switch 
 *		(in)  <OBJECT> player
 *		(out) nothing
 *
 * Author: Shay_gman
 */
 
 var(_unit) 			= _this select 0;
 var(_unitSideEngine) 	= side _unit; 
 var(_unitSidePRA3) 	= _unit call PRA3_fnc_getPlayerSide;
 
 if (_unitSideEngine != _unitSidePRA3) then {
	//Make the switch
	var(_group) = creategroup _unitSidePRA3;
	[player] join _group;
	_group = grpNull;
	deleteGroup _group;
 }; 