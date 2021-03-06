#include "scriptDefines.sqh"
#include "defines.sqh"

/**
 *	Equips the unit with the given kit. Also notifies the server about it.
 *		(in)  <ARRAY>:
 *			0 <OBJECT> Unit
 *			1 <STRING> Kit
 *		(out) <VOID>
 */

// Type of items that are assigned (NVGs, watch, map, etc.)
#define ASSIGNED_ITEM_TYPE 131072

var(_unit) = _this select 0;
var(_kit)  = _this select 1;

// Remove all the stuff
removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeAllItems _unit;

// Remove all clothing to make epoch happy
removeAllContainers _unit;
removeHeadgear _unit;

var(_kitInfo) = _kit call PRA3_fnc_getKitInfo;

// Put clothes back on to make epoch sad
var(_clothing) = _kitInfo select KIT_CLOTHING;
// We'll add the uniform last to avoid having anything put into it
_unit addHeadgear (_clothing select CLOTHING_HEADGEAR);
_unit addGoggles (_clothing select CLOTHING_GOGGLES);
_unit addVest (_clothing select CLOTHING_VEST);

var(_variant) = _kitInfo select KIT_VARIANTS select (_kitInfo select KIT_VARIANT_CURR);

var(_giveWeapon) =
{
	var(_wpn) = _variant select _this;
	if (count _wpn != 0) then
	{
		{
			_unit addMagazines _x;
		} forEach (_wpn select 1);

		_unit addWeapon (_wpn select 0);

		{
			if (_x != "") then
			{
				switch (_this) do
				{
					case VARIANT_PRIMARY:
					{
						_unit addPrimaryWeaponItem _x;
					};
					case VARIANT_PISTOL:
					{
						_unit addSecondaryWeaponItem _x;
					};
				};
			};
		} forEach (_wpn select 2);
	};
};

// Give weapons and magazines
VARIANT_PRIMARY call _giveWeapon;

VARIANT_SECONDARY call _giveWeapon;

var(_stuff) = _variant select VARIANT_BACKPACK;
if (count _stuff > 0) then
{
	_unit addBackpack (_stuff select 0);

	var(_backpack) = unitBackpack _unit;

	clearWeaponCargoGlobal _backpack;
	clearMagazineCargoGlobal _backpack;
	{
		if (getNumber(configFile >> "CfgWeapons" >> (_x select 0) >> "type") == ASSIGNED_ITEM_TYPE) then
		{
			for "_i" from 1 to (_x select 1) do
			{
				_unit addItemToBackpack (_x select 0);
			};
		}
		else
		{
			_backpack addWeaponCargoGlobal _x;
		};
	} forEach (_stuff select 1);

	{
		_backpack addMagazineCargoGlobal _x;
	} forEach (_stuff select 2);
};

VARIANT_PISTOL call _giveWeapon;

{
	for "_i" from 1 to (_x select 1) do
	{
		_unit addMagazine (_x select 0);
	};
} forEach (_variant select VARIANT_EXPLOSIVES);

_unit forceAddUniform (_clothing select CLOTHING_UNIFORM);

{
	for "_i" from 1 to (_x select 1) do
	{
		if (isClass(configFile >> "CfgWeapons" >> (_x select 0))) then
		{
			if (getNumber(configFile >> "CfgWeapons" >> (_x select 0) >> "type") == ASSIGNED_ITEM_TYPE) then
			{
				_unit addItem (_x select 0);
				_unit assignItem (_x select 0);
			}
			else
			{
				_unit addWeapon (_x select 0);
			};
		}
		else
		{
			_unit addMagazine (_x select 0);
		};
	};
} forEach (_variant select VARIANT_ITEMS);

[[_unit, _kit], "PRA3_fnc_unitSetKit", false] call PRA3_fnc_MP;
