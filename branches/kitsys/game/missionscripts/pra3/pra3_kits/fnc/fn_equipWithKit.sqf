#include "scriptDefines.sqh"
#include "defines.sqh"

var(_unit) = _this select 0;
var(_kit)  = _this select 1;

// Remove all the stuff
removeAllWeapons _unit;
removeAllItems _unit;

// Remove all clothing to make epoch happy
removeUniform _unit;
removeHeadgear _unit;
removeGoggles _unit;
removeVest _unit;
removeBackpack _unit;

var(_kitInfo) = _kit call PRA3_fnc_getKitInfo;

// Put clothes back on to make epoch sad
var(_clothing) = _kitInfo select KIT_CLOTHING;
diag_log _clothing;
_unit addUniform (_clothing select CLOTHING_UNIFORM);
_unit addHeadgear (_clothing select CLOTHING_HEADGEAR);
_unit addGoggles (_clothing select CLOTHING_GOGGLES);
_unit addVest (_clothing select CLOTHING_VEST);

var(_variant) = _kitInfo select KIT_VARIANTS select (_kitInfo select KIT_VARIANT_CURR);
var(_giveWeapon) =
{
	{
		_unit addMagazines _x;
	} forEach (_this select 1);
	_unit addWeapon (_this select 0);
};

// Give weapons and magazines
(_variant select VARIANT_PRIMARY) call _giveWeapon;

(_variant select VARIANT_SECONDARY) call _giveWeapon;

var(_stuff) = _variant select VARIANT_BACKPACK;
if (count _stuff > 0) then
{
	_unit addBackpack (_stuff select 0);

	var(_backpack) = unitBackpack _unit;

	clearWeaponCargoGlobal _backpack;
	clearMagazineCargoGlobal _backpack;
	{
		_backpack addWeaponCargoGlobal _x;
	} forEach (_stuff select 1);

	{
		_backpack addMagazineCargoGlobal _x;
	} forEach (_stuff select 2);
}
else
{
	_stuff select 1 call _giveWeapon;
};

(_variant select VARIANT_PISTOL) call _giveWeapon;
