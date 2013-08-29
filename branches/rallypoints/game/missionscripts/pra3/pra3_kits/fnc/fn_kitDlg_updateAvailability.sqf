 #include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

var(_kit) = _this;

if (_kit != "") then // Update an individual kit
{
	var(_nowAvailable) = [player, _kit] call PRA3_fnc_getKitAvailableNum;
	__getCtrl(27000) ctrlEnable (_nowAvailable > 0);
};

var(_i) = 1;
{
	var(_kitInfo)    = _x call PRA3_fnc_getKitInfo;
	var(_playerSide) = if (playerSide == west) then {TEAM_US} else {TEAM_IN};

	if (_kitInfo select KIT_TEAM == _playerSide || {!isNil "PRA3_debug_kits_showAllSides"}) then
	{
		var(_nowAvailable) = 0;
		var(_maxAvailable) = 0;
		switch true do
		{
			case (player call PRA3_fnc_unitGetSquad == -1):
			{
				__getCtrl(IDC_KITDLG_SELECTION_KIT + 100*_i + 4) ctrlSetText "Only for squad members";
			};
			case ([_x, PRA3_selectedSpawn] call PRA3_fnc_kitAvailableAtSpawn):
			{
				__getCtrl(IDC_KITDLG_SELECTION_KIT + 100*_i + 4) ctrlSetText "Unavailable at this location";
			};
			default
			{
				_nowAvailable = [player, _x] call PRA3_fnc_getKitAvailableNum;
				_maxAvailable = [player, _x] call PRA3_fnc_getMaxKitAvailableNum;

				__getCtrl(IDC_KITDLG_SELECTION_KIT + 100*_i + 4) ctrlSetText (
					if (_nowAvailable >= __inf) then {
						"Unlimited"
					} else {
						if (_nowAvailable == 0) then {
							"Unavailable"
						} else {
							format["%1 available", _nowAvailable]
						}
					}
				);
			};
		};

		// Highlight selected, dim unavailable
		__getCtrl(IDC_KITDLG_SELECTION_KIT + 100*_i + 1) ctrlSetBackgroundColor
			getArray(__kitLineCtrl(_i,"Background") >> (if (_x == _kit) then {
				if (_nowAvailable > 0) then {
					"colorBackgroundHighlight"
				} else {
					"colorBackgroundDimHighlight"
				}
			} else {
				if (_nowAvailable > 0) then {
					"colorBackground"
				} else {
					"colorBackgroundDim"
				}
			}));

		_i = _i + 1;
	};
} forEach PRA3_kits;
