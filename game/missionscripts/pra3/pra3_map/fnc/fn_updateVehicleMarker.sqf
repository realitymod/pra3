#include "scriptDefines.sqh"
#include "defines.sqh"

if (typeName _this == "ARRAY") then
{
	{
		_x call PRA3_fnc_updateVehicleMarker;
	} forEach _this;
}
else
{
	var(_vehicle) = _this;
	var(_marker)  = _vehicle getVariable ["PRA3_map_marker", ""];
	var(_playerSquad) = player call PRA3_fnc_unitGetSquad;

	[format["Updating %1 - %2", _vehicle, _marker]] call PRA3_fnc_logInfo;

	if (_vehicle isKindOf "CAManBase") then //Human
	{
		if (_vehicle == vehicle _vehicle) then //On foot
		{
			_marker setMarkerColorLocal (
				if (_vehicle == player) then {
					__color_player
				} else {
					if (_playerSquad != -1 && {(_vehicle call PRA3_fnc_unitGetSquad) == _playerSquad}) then {
						__color_squad
					} else {
						__color_friendly
					}
				}
			);
			_marker setMarkerAlphaLocal 1;
		}
		else //In vehicle
		{
			_marker setMarkerAlphaLocal 0; //Hide

			// Update vehicle's marker
			(vehicle _vehicle) call PRA3_fnc_updateVehicleMarker;
		};
	}
	else //Vehicle
	{
		_marker setMarkerColorLocal (
			if ((count crew _vehicle) == 0) then {
				__color_empty
			} else {
				if (player in _vehicle) then {
					__color_player
				} else {
					if (_playerSquad != -1 &&
						{({(_x call PRA3_fnc_unitGetSquad) == _playerSquad}
							count (crew _vehicle)) > 0}) then {
						__color_squad
					} else {
						__color_friendly
					}
				}
			}
		);
	};
};
