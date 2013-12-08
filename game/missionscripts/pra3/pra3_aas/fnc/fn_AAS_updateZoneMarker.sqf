#include "scriptDefines.sqh"
#include "aas_defines.sqh"

var(_side) = _this call PRA3_fnc_AAS_getZoneOwner;
var(_color) = (
	if (_side == PRA3_player_side) then {
		"ColorBLUFOR"
	} else {
		if (_side == __neutral) then {
			"ColorBlack"
		} else {
			"ColorOPFOR"
		}
	}
);

(PRA3_core getVariable format["PRA3_AAS_%1_marker_1", _this]) setMarkerColorLocal _color;
(PRA3_core getVariable format["PRA3_AAS_%1_marker_2", _this]) setMarkerColorLocal _color;
