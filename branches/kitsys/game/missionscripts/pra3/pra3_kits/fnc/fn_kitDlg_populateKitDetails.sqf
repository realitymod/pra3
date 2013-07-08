#include "scriptDefines.sqh"
#include "defines.sqh"

#define __kitLineSpacing 0.005
diag_log ["AAAAAAAAAAAAAAAAAAAAAAAAA", __getCtrl(21000) ];
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
	var(_cfg)     = _this select 0;
	var(_baseIDC) = _this select 1;
	var(_max)     = _this select 2;

	var(_attached) = 0;
	{
		if (getText(_cfg >> _x) != "") then
		{
			__getCtrl(_baseIDC + _attached) ctrlSetText getText(configFile >> "CfgWeapons" >> getText(_cfg >> _x) >> "picture");
			__getCtrl(_baseIDC + _attached) ctrlShow true;
			_attached = _attached + 1;
		};
	} forEach ["optics", "rail", "muzzle"];

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
	diag_log ["meh", _this];

	__getCtrl(_idc) ctrlSetText
		getText(configFile >> _class >> getText _name >> "picture");
};

var(_kit) = PRA3_kitSys_currentKit;


var(_variant) = _kit call PRA3_fnc_getSelectedKitVariant;
var(_cfg) = missionConfigFile >> "PRA3_kitSys" >> "Kits" >> _kit >> "Variants" >> _variant;

var(_y) = getNumber(__kitDetails("PrimaryWeapon") >> "y");

// ---------- PRIMARY WEAPON ----------
if (count (_cfg >> "Primary") > 0) then
{
	var(_info) = _cfg >> "Primary";

	__getCtrl(21000) ctrlShow true;

	[21001, "CfgWeapons", _info >> "weapon"] call _setPicture;
	[_info, 21011, 3] call _populateAttachments;
	[getArray(_info >> "magazines"), 21100, 4] call _populateMags;

	if (_target == -1) then
	{
		_y = _y + getNumber(__kitDetails("PrimaryWeapon") >> "h") + __kitLineSpacing;
	};
}
else
{
	__getCtrl(21000) ctrlShow false;
};

// ---------- SECONDARY WEAPON / BACKPACK ----------
if (count (_cfg >> "Secondary") > 0) then
{
	var(_info) = _cfg >> "Secondary";

	__getCtrl(22000) ctrlShow (getNumber(_info >> "type") == TYPE_WEAPON);
	__getCtrl(23000) ctrlShow (getNumber(_info >> "type") == TYPE_BACKPACK);

	var(_mags) = getArray(_info >> "magazines");

	if (getNumber(_info >> "type") == TYPE_WEAPON) then
	{
		[22001, "CfgWeapons", _info >> "weapon"] call _setPicture;
		[_mags, 22100, 4] call _populateMags;
	}
	else
	{
		[23001, "CfgVehicles", _info >> "backpack"] call _setPicture;
		[_mags, 23100, 6] call _populateMags;
	};

	if (_target == -1) then
	{
		__getCtrl(22000) ctrlSetPosition [ctrlPosition __getCtrl(22000) select 0, _y];
		__getCtrl(22000) ctrlCommit 0;

		__getCtrl(23000) ctrlSetPosition [ctrlPosition __getCtrl(23000) select 0, _y];
		__getCtrl(23000) ctrlCommit 0;

		_y = _y + getNumber(__kitDetails("SecondaryWeapon") >> "h") + __kitLineSpacing;
	};
}
else
{
	__getCtrl(22000) ctrlShow false;
	__getCtrl(23000) ctrlShow false;
};

// ---------- PISTOL ----------
if (count (_cfg >> "Pistol") > 0) then
{
	var(_info) = _cfg >> "Pistol";

	__getCtrl(24000) ctrlShow true;


	[24001, "CfgWeapons", _info >> "weapon"] call _setPicture;
	[getArray(_info >> "magazines"), 24100, 2] call _populateMags;

	if (_target == -1) then
	{
		__getCtrl(24000) ctrlSetPosition [ctrlPosition __getCtrl(24000) select 0, _y];
		__getCtrl(24000) ctrlCommit 0;
		_y = _y + getNumber(__kitDetails("Pistol") >> "h") + __kitLineSpacing;
	};
}
else
{
	__getCtrl(24000) ctrlShow false;
};

// ---------- EXPLOSIVES ----------
var(_explosives) = getArray(_cfg >> "explosives");
if (count _explosives > 0) then
{
	__getCtrl(25000) ctrlShow true;


	[_explosives, 25100, 4] call _populateMags;

	if (_target == -1) then
	{
		__getCtrl(25000) ctrlSetPosition [ctrlPosition __getCtrl(25000) select 0, _y];
		__getCtrl(25000) ctrlCommit 0;
		_y = _y + getNumber(__kitDetails("Explosives") >> "h") + __kitLineSpacing;
	};
}
else
{
	__getCtrl(25000) ctrlShow false;
};

// ---------- MEDICAL ----------
var(_medical) = getArray(_cfg >> "medical");
if (count _medical > 0) then
{
	__getCtrl(26000) ctrlShow true;


	[_medical, 26100, 4] call _populateMags;

	if (_target == -1) then
	{
		__getCtrl(26000) ctrlSetPosition [ctrlPosition __getCtrl(26000) select 0, _y];
		__getCtrl(26000) ctrlCommit 0;
		_y = _y + getNumber(__kitDetails("Medical") >> "h") + __kitLineSpacing;
	};
}
else
{
	__getCtrl(26000) ctrlShow false;
};
