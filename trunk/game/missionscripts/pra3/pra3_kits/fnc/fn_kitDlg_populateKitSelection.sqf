#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

PRA3_shownKits = [];

var(_i) = 1;
{
	var(_kitInfo)    = _x call PRA3_fnc_getKitInfo;

	if (_kitInfo select KIT_TEAM == PRA3_player_team || PRA3_core getVariable ["PRA3_debug_kits_showAllSides", false]) then
	{
		PRA3_shownKits set [count PRA3_shownKits, _x];

		__getCtrl(IDC_KITDLG_SELECTION_KIT + 100*_i) ctrlShow true;
		__getCtrl(IDC_KITDLG_SELECTION_KIT + 100*_i) ctrlSetPosition
			[getNumber(__kitLine(_i) >> "x"), getNumber(__kitLine(_i) >> "y")];
		__getCtrl(IDC_KITDLG_SELECTION_KIT + 100*_i) ctrlCommit 0;

		var(_cfg) = missionConfigFile >> "PRA3_kitSys" >> "Kits" >> _x;

		__getCtrl(IDC_KITDLG_SELECTION_KIT + 100*_i + 2) ctrlSetText (_kitInfo select KIT_PICTURE);

		__getCtrl(IDC_KITDLG_SELECTION_KIT + 100*_i + 3) ctrlSetText (_kitInfo select KIT_NAME);
		_i = _i + 1;
	};
} forEach PRA3_kits;

for "_i" from _i to __maxKits do
{
	__getCtrl(IDC_KITDLG_SELECTION_KIT + 100*_i) ctrlShow false;
	__getCtrl(IDC_KITDLG_SELECTION_KIT + 100*_i) ctrlSetPosition [0,0];
	__getCtrl(IDC_KITDLG_SELECTION_KIT + 100*_i) ctrlCommit 0;
};

"" call PRA3_fnc_kitDlg_updateAvailability;
