#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

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

var(_kitInfo) = _kit call PRA3_fnc_getKitInfo;
var(_variantInfo) = _kitInfo select KIT_VARIANTS select (_kitInfo select KIT_VARIANT_CURR);

_kit call PRA3_fnc_kitDlg_updateAvailability;

var(_y) = getNumber(__kitDetailsCtrl("Variant") >> "y");

__getCtrl(IDC_KITDLG_DETAILS_VARIANT) ctrlShow (count(_kitInfo select KIT_VARIANTS) > 1);
if (count(_kitInfo select KIT_VARIANTS) > 1) then
{
	_y = _y + getNumber(__kitDetailsCtrl("Variant") >> "h") + __kitLineSpacing;
};

// ---------- PRIMARY WEAPON ----------
var(_wpnInfo) = _variantInfo select VARIANT_PRIMARY;
if (count _wpnInfo > 0) then
{
	__getCtrl(IDC_KITDLG_DETAILS_PRIMARY) ctrlShow true;

	[IDC_KITDLG_DETAILS_PRIMARY + 1, "CfgWeapons", _wpnInfo select 0] call _setPicture;
	[_wpnInfo select 1, IDC_KITDLG_DETAILS_PRIMARY + 100, 4] call _populateMags;
	[_wpnInfo select 2, IDC_KITDLG_DETAILS_PRIMARY + 11, 3] call _populateAttachments;

	__getCtrl(IDC_KITDLG_DETAILS_PRIMARY) ctrlSetPosition [ctrlPosition __getCtrl(IDC_KITDLG_DETAILS_PRIMARY) select 0, _y];
	_y = _y + getNumber(__kitDetailsCtrl("PrimaryWeapon") >> "h") + __kitLineSpacing;
}
else
{
	__getCtrl(IDC_KITDLG_DETAILS_PRIMARY) ctrlSetPosition [ctrlPosition __getCtrl(IDC_KITDLG_DETAILS_PRIMARY) select 0, 0];
	__getCtrl(IDC_KITDLG_DETAILS_PRIMARY) ctrlShow false;
};
__getCtrl(IDC_KITDLG_DETAILS_PRIMARY) ctrlCommit 0;

// ---------- SECONDARY WEAPON ----------
var(_wpnInfo) = _variantInfo select VARIANT_SECONDARY;
if (count _wpnInfo > 0) then
{
	__getCtrl(IDC_KITDLG_DETAILS_SECONDARY) ctrlShow true;

	[IDC_KITDLG_DETAILS_SECONDARY + 1, "CfgWeapons", _wpnInfo select 0] call _setPicture;
	[_wpnInfo select 1, IDC_KITDLG_DETAILS_SECONDARY + 100, 4] call _populateMags;

	__getCtrl(IDC_KITDLG_DETAILS_SECONDARY) ctrlSetPosition [ctrlPosition __getCtrl(IDC_KITDLG_DETAILS_SECONDARY) select 0, _y];
	_y = _y + getNumber(__kitDetailsCtrl("SecondaryWeapon") >> "h") + __kitLineSpacing;
}
else
{
	__getCtrl(IDC_KITDLG_DETAILS_SECONDARY) ctrlSetPosition [ctrlPosition __getCtrl(IDC_KITDLG_DETAILS_SECONDARY) select 0, 0];
	__getCtrl(IDC_KITDLG_DETAILS_SECONDARY) ctrlShow false;
};
__getCtrl(IDC_KITDLG_DETAILS_SECONDARY) ctrlCommit 0;

// ---------- BACKPACK ----------
var(_wpnInfo) = _variantInfo select VARIANT_BACKPACK;
if (count _wpnInfo > 0) then
{
	__getCtrl(IDC_KITDLG_DETAILS_BACKPACK) ctrlShow true;

	[IDC_KITDLG_DETAILS_BACKPACK + 1, "CfgVehicles", _wpnInfo select 0] call _setPicture;
	[(_wpnInfo select 1) + (_wpnInfo select 2), IDC_KITDLG_DETAILS_BACKPACK + 100, 6] call _populateMags;

	__getCtrl(IDC_KITDLG_DETAILS_BACKPACK) ctrlSetPosition [ctrlPosition __getCtrl(IDC_KITDLG_DETAILS_BACKPACK) select 0, _y];
	_y = _y + getNumber(__kitDetailsCtrl("Backpack") >> "h") + __kitLineSpacing;
}
else
{
	__getCtrl(IDC_KITDLG_DETAILS_BACKPACK) ctrlSetPosition [ctrlPosition __getCtrl(IDC_KITDLG_DETAILS_BACKPACK) select 0, 0];
	__getCtrl(IDC_KITDLG_DETAILS_BACKPACK) ctrlShow false;
};
__getCtrl(IDC_KITDLG_DETAILS_BACKPACK) ctrlCommit 0;

// ---------- PISTOL ----------
var(_wpnInfo) = _variantInfo select VARIANT_PISTOL;
if (count _wpnInfo > 0) then
{
	__getCtrl(IDC_KITDLG_DETAILS_PISTOL) ctrlShow true;

	[IDC_KITDLG_DETAILS_PISTOL + 1, "CfgWeapons", _wpnInfo select 0] call _setPicture;
	[_wpnInfo select 1, IDC_KITDLG_DETAILS_PISTOL + 100, 2] call _populateMags;

	__getCtrl(IDC_KITDLG_DETAILS_PISTOL) ctrlSetPosition [ctrlPosition __getCtrl(IDC_KITDLG_DETAILS_PISTOL) select 0, _y];
	_y = _y + getNumber(__kitDetailsCtrl("Pistol") >> "h") + __kitLineSpacing;
}
else
{
	__getCtrl(IDC_KITDLG_DETAILS_PISTOL) ctrlSetPosition [ctrlPosition __getCtrl(IDC_KITDLG_DETAILS_PISTOL) select 0, 0];
	__getCtrl(IDC_KITDLG_DETAILS_PISTOL) ctrlShow false;
};
__getCtrl(IDC_KITDLG_DETAILS_PISTOL) ctrlCommit 0;

// ---------- EXPLOSIVES ----------
var(_explosives) = _variantInfo select VARIANT_EXPLOSIVES;
if (count _explosives > 0) then
{
	__getCtrl(IDC_KITDLG_DETAILS_EXPLOSIVES) ctrlShow true;


	[_explosives, IDC_KITDLG_DETAILS_EXPLOSIVES + 100, 4] call _populateMags;

	__getCtrl(IDC_KITDLG_DETAILS_EXPLOSIVES) ctrlSetPosition [ctrlPosition __getCtrl(IDC_KITDLG_DETAILS_EXPLOSIVES) select 0, _y];
	_y = _y + getNumber(__kitDetailsCtrl("Explosives") >> "h") + __kitLineSpacing;
}
else
{
	__getCtrl(IDC_KITDLG_DETAILS_EXPLOSIVES) ctrlSetPosition [ctrlPosition __getCtrl(IDC_KITDLG_DETAILS_EXPLOSIVES) select 0, 0];
	__getCtrl(IDC_KITDLG_DETAILS_EXPLOSIVES) ctrlShow false;
};
__getCtrl(IDC_KITDLG_DETAILS_EXPLOSIVES) ctrlCommit 0;

// ---------- ITEMS ----------
var(_items) = _variantInfo select VARIANT_ITEMS;
if (count _items > 0) then
{
	__getCtrl(IDC_KITDLG_DETAILS_ITEMS) ctrlShow true;


	[_items, IDC_KITDLG_DETAILS_ITEMS + 100, 4] call _populateMags;

	__getCtrl(IDC_KITDLG_DETAILS_ITEMS) ctrlSetPosition [ctrlPosition __getCtrl(IDC_KITDLG_DETAILS_ITEMS) select 0, _y];
	_y = _y + getNumber(__kitDetailsCtrl("Items") >> "h") + __kitLineSpacing;
}
else
{
	__getCtrl(IDC_KITDLG_DETAILS_ITEMS) ctrlSetPosition [ctrlPosition __getCtrl(IDC_KITDLG_DETAILS_ITEMS) select 0, 0];
	__getCtrl(IDC_KITDLG_DETAILS_ITEMS) ctrlShow false;
};
__getCtrl(IDC_KITDLG_DETAILS_ITEMS) ctrlCommit 0;

var(_w) = getNumber(__kitDetails >> "w");

{
	var(_pos) = ctrlPosition __getCtrl(_x);
	_pos set [3, _y];
	__getCtrl(_x) ctrlSetPosition _pos;
	__getCtrl(_x) ctrlCommit 0;
} forEach [IDC_KITDLG_DETAILS_BG, IDC_KITDLG_DETAILS_SEP, IDC_KITDLG_DETAILS];
