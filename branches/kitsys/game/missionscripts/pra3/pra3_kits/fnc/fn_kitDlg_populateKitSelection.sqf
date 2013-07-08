#include "scriptDefines.sqh"
#include "defines.sqh"

var(_selected) = _this;

var(_i) = 1;
{
	var(_kitInfo) = _x call PRA3_fnc_getKitInfo;
	
	__getCtrl(10000 + 100*_i) ctrlShow true;
	__getCtrl(10000 + 100*_i) ctrlSetPosition
		[getNumber(__kitLine(_i) >> "x"), getNumber(__kitLine(_i) >> "y")];
	__getCtrl(10000 + 100*_i) ctrlCommit 0;

	var(_isSelected) = _x == _selected;
	var(_cfg) = missionConfigFile >> "PRA3_kitSys" >> "Kits" >> _x;

	__getCtrl(10000 + 100*_i + 1) ctrlSetBackgroundColor
		getArray(__kitLineCtrl(_i,"Background") >> (if (_isSelected) then {"colorBackgroundHighlight"} else {"colorBackground"}));

	__getCtrl(10000 + 100*_i + 3) ctrlSetText (_kitInfo select KIT_NAME);

	_i = _i + 1;
} forEach PRA3_kits; // TODO: Filter bansed on availability

for "_i" from _i to __maxKits do
{
	__getCtrl(10000 + 100*_i) ctrlShow false;
	__getCtrl(10000 + 100*_i) ctrlSetPosition [0,0];
	__getCtrl(10000 + 100*_i) ctrlCommit 0;
};
