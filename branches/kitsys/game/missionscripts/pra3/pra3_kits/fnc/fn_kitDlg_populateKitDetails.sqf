#include "scriptDefines.sqh"
#include "defines.sqh"

#define __kitLineSpacing 0.005

var(_populateMags) =
{
	var(_mags)    = _this select 0;
	var(_baseIDC) = _this select 1;
	var(_maxMags) = _this select 2;

	var(_i) = 1;
	{
		var(_mag)   = _x select 0;
		var(_count) = _x select 1;

		__getCtrl(_baseIDC + 10*_i) ctrlShow true;
		// Items are classed as weapons
		if (isClass(configFile >> "CfgMagazines" >> _mag)) then
		{
			__getCtrl(_baseIDC + 10*_i + 1) ctrlSetText getText(configFile >> "CfgMagazines" >> _mag >> "picture");
		}
		else
		{
			__getCtrl(_baseIDC + 10*_i + 1) ctrlSetText getText(configFile >> "CfgWeapons" >> _mag >> "picture");
		};
		__getCtrl(_baseIDC + 10*_i + 2) ctrlSetText str _count;

		_i = _i + 1;
	} forEach _mags;

	for "_i" from _i to _maxMags do
	{
		__getCtrl(_baseIDC + 10*_i) ctrlShow false;
	};
};
var(_populateAttachments) =
{
	var(_attachments) = _this select 0;
	var(_baseIDC)     = _this select 1;
	var(_max)         = _this select 2;

	var(_attached) = 0;
	{
		if (_x != "") then
		{
			__getCtrl(_baseIDC + _attached) ctrlSetText getText(configFile >> "CfgWeapons" >> _x >> "picture");
			__getCtrl(_baseIDC + _attached) ctrlShow true;
			_attached = _attached + 1;
		};
	} forEach _attachments;

	for "_i" from _attached to _max-1 do
	{
		__getCtrl(_baseIDC + _i) ctrlShow false;
	};
};
var(_setPicture) =
{
	var(_idc)     = _this select 0;
	var(_class)   = _this select 1;
	var(_name)    = _this select 2;

	__getCtrl(_idc) ctrlSetText
		getText(configFile >> _class >> _name >> "picture");
};

var(_kit) = PRA3_kitSys_currentKit;

var(_kitInfo) = PRA3_kitSys_currentKit call PRA3_fnc_getKitInfo;
var(_variantInfo) = _kitInfo select KIT_VARIANTS select (_kitInfo select KIT_VARIANT_CURR);

_kit call PRA3_fnc_kitDlg_updateAvailability;

var(_y) = getNumber(__kitDetails("Variant") >> "y");

__getCtrl(20001) ctrlShow (count(_kitInfo select KIT_VARIANTS) > 1);
if (count(_kitInfo select KIT_VARIANTS) > 1) then
{
	_y = _y + getNumber(__kitDetails("Variant") >> "h") + __kitLineSpacing;
};

// ---------- PRIMARY WEAPON ----------
var(_wpnInfo) = _variantInfo select VARIANT_PRIMARY;
if (count _wpnInfo > 0) then
{
	__getCtrl(21000) ctrlShow true;

	[21001, "CfgWeapons", _wpnInfo select 0] call _setPicture;
	[_wpnInfo select 1, 21100, 4] call _populateMags;
	[_wpnInfo select 2, 21011, 3] call _populateAttachments;

	__getCtrl(21000) ctrlSetPosition [ctrlPosition __getCtrl(21000) select 0, _y];
	__getCtrl(21000) ctrlCommit 0;
	_y = _y + getNumber(__kitDetails("PrimaryWeapon") >> "h") + __kitLineSpacing;
}
else
{
	__getCtrl(21000) ctrlShow false;
};

// ---------- SECONDARY WEAPON ----------
var(_wpnInfo) = _variantInfo select VARIANT_SECONDARY;
if (count _wpnInfo > 0) then
{
	__getCtrl(22000) ctrlShow true;

	[22001, "CfgWeapons", _wpnInfo select 0] call _setPicture;
	[_wpnInfo select 1, 22100, 4] call _populateMags;

	__getCtrl(22000) ctrlSetPosition [ctrlPosition __getCtrl(22000) select 0, _y];
	__getCtrl(22000) ctrlCommit 0;
	_y = _y + getNumber(__kitDetails("SecondaryWeapon") >> "h") + __kitLineSpacing;
}
else
{
	__getCtrl(22000) ctrlShow false;
};

// ---------- BACKPACK ----------
var(_wpnInfo) = _variantInfo select VARIANT_BACKPACK;
if (count _wpnInfo > 0) then
{
	__getCtrl(23000) ctrlShow true;

	[23001, "CfgVehicles", _wpnInfo select 0] call _setPicture;
	[(_wpnInfo select 1) + (_wpnInfo select 2), 23100, 6] call _populateMags;

	__getCtrl(23000) ctrlSetPosition [ctrlPosition __getCtrl(23000) select 0, _y];
	__getCtrl(23000) ctrlCommit 0;
	_y = _y + getNumber(__kitDetails("Backpack") >> "h") + __kitLineSpacing;
}
else
{
	__getCtrl(23000) ctrlShow false;
};

// ---------- PISTOL ----------
var(_wpnInfo) = _variantInfo select VARIANT_PISTOL;
if (count _wpnInfo > 0) then
{
	__getCtrl(24000) ctrlShow true;

	[24001, "CfgWeapons", _wpnInfo select 0] call _setPicture;
	[_wpnInfo select 1, 24100, 2] call _populateMags;

	__getCtrl(24000) ctrlSetPosition [ctrlPosition __getCtrl(24000) select 0, _y];
	__getCtrl(24000) ctrlCommit 0;
	_y = _y + getNumber(__kitDetails("Pistol") >> "h") + __kitLineSpacing;
}
else
{
	__getCtrl(24000) ctrlShow false;
};

// ---------- EXPLOSIVES ----------
var(_explosives) = _variantInfo select VARIANT_EXPLOSIVES;
if (count _explosives > 0) then
{
	__getCtrl(25000) ctrlShow true;


	[_explosives, 25100, 4] call _populateMags;

	__getCtrl(25000) ctrlSetPosition [ctrlPosition __getCtrl(25000) select 0, _y];
	__getCtrl(25000) ctrlCommit 0;
	_y = _y + getNumber(__kitDetails("Explosives") >> "h") + __kitLineSpacing;
}
else
{
	__getCtrl(25000) ctrlShow false;
};

// ---------- ITEMS ----------
var(_items) = _variantInfo select VARIANT_ITEMS;
if (count _items > 0) then
{
	__getCtrl(26000) ctrlShow true;


	[_items, 26100, 4] call _populateMags;

	__getCtrl(26000) ctrlSetPosition [ctrlPosition __getCtrl(26000) select 0, _y];
	__getCtrl(26000) ctrlCommit 0;
	_y = _y + getNumber(__kitDetails("Items") >> "h") + __kitLineSpacing;
}
else
{
	__getCtrl(26000) ctrlShow false;
};

__getCtrl(27000) ctrlSetPosition [ctrlPosition __getCtrl(27000) select 0, _y];
__getCtrl(27000) ctrlCommit 0;
