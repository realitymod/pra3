#include "scriptDefines.sqh"
#include "defines.sqh"

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
diag_log _x;
	if (_kitInfo select KIT_TEAM == _playerSide || {!isNil "PRA3_debug_kits_showAllSides"}) then
	{
		var(_nowAvailable) = [player, _x] call PRA3_fnc_getKitAvailableNum;
		var(_maxAvailable) = [player, _x] call PRA3_fnc_getMaxKitAvailableNum;
diag_log format["=> %1", _maxAvailable];
		__getCtrl(10000 + 100*_i + 4) ctrlSetText (
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

		// Highlight selected, dim unavailable
		__getCtrl(10000 + 100*_i + 1) ctrlSetBackgroundColor
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
