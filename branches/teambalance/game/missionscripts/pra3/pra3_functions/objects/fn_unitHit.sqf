/************************************************************
Author:	Shay_gman

Handle damage done to the player as bleeding effect and prevent damage while in a safe zone
************************************************************/

#define var(x) private #x; x

var(_unit) 				= _this select 0;			//Object the event handler is assigned to.
var(_selectionName)  	= _this select 1;			//Name of the selection where the unit was damaged. "" for over-all structural damage, "?" for unknown selections.
var(_damage) 			= _this select 2;			//Resulting level of damage for the selection.
var(_source) 			= _this select 3;			//The source unit that caused the damage.
var(_projectile) 		= _this select 4;			//Classname of the projectile that caused inflicted the damage. ("" for unknown, such as falling damage.)

//if unit in safe zone no damage will be done
if (_unit call PRA3_fnc_unitInSafeZone) then {_damage = 0};

//----TODO: Bleeding/passout effects -----------------
_damage
